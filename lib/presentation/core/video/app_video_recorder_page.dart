import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/core/di/injection.dart';
import '../../../domain/core/permission_handler/app_permission_handler.dart';
import '../../../domain/core/native/face_detection_service.dart';
import '../../../domain/core/native/video_frame_service.dart';
import '../camera/camera_init_error_view.dart';
// Full-screen camera/video overlay: renders on a black surface in both themes,
// so it deliberately uses the fixed brand palette instead of theme tokens.
import '../colors/app_colors.dart';
import '../theme/app_theme_ext.dart';

// ── Public result type ─────────────────────────────────────────────────────────

class AppVideoResult {
  final String videoPath;
  final String? thumbnailPath;
  const AppVideoResult({required this.videoPath, this.thumbnailPath});
}

// ── Phase ──────────────────────────────────────────────────────────────────────

enum _Phase { idle, countdown, recording, recorded }

// ── Constants ──────────────────────────────────────────────────────────────────

const _kRecordSeconds = 5;
const _kCountdownFrom = 3;

// Extracts 3 frames from the recorded video and checks whether any contain a face.
// Uses the native FaceDetectionChannel (Vision on iOS, ML Kit on Android).
Future<bool> _validateFaceInVideo(String videoPath) async {
  final framePaths = <String>[];
  try {
    for (final timeMs in [500, 2000, 4000]) {
      try {
        final framePath = await VideoFrameService.extractFrame(
          videoPath,
          timeMs: timeMs,
          maxHeight: 480,
          quality: 75,
        );
        if (framePath == null) continue;
        framePaths.add(framePath);
        if (await FaceDetectionService.detectFaceInFile(framePath)) return true;
      } catch (_) {}
    }
  } finally {
    for (final p in framePaths) {
      try {
        await File(p).delete();
      } catch (_) {}
    }
  }
  return false;
}

// Returns correctly-packed bytes for the native face detector.
// iOS BGRA8888: single plane, returned as-is (zero-copy).
// Android NV21: two planes with possible row-stride padding — strips padding so
// YuvImage on the Kotlin side gets a clean width×height NV21 buffer.
Uint8List _extractCameraBytes(CameraImage image) {
  if (image.planes.length == 1) return image.planes.first.bytes;
  final y = image.planes[0];
  final uv = image.planes[1];
  final w = image.width;
  final h = image.height;
  final buf = Uint8List(w * h + w * (h ~/ 2));
  if (y.bytesPerRow == w && uv.bytesPerRow == w) {
    buf.setAll(0, y.bytes.sublist(0, w * h));
    buf.setAll(w * h, uv.bytes.sublist(0, w * (h ~/ 2)));
  } else {
    int dst = 0;
    for (int r = 0; r < h; r++) {
      buf.setRange(dst, dst + w, y.bytes, r * y.bytesPerRow);
      dst += w;
    }
    for (int r = 0; r < h ~/ 2; r++) {
      buf.setRange(dst, dst + w, uv.bytes, r * uv.bytesPerRow);
      dst += w;
    }
  }
  return buf;
}

// Stops any active recording before disposing to prevent camera state corruption
// on the next session (Android camera2 leaves stale state when disposed mid-record).
void _safeDisposeCamera(CameraController c) {
  if (c.value.isRecordingVideo) {
    c
        .stopVideoRecording()
        .catchError((_) => XFile(''))
        .whenComplete(() => c.dispose());
  } else {
    c.dispose();
  }
}

// ── Entry-point ────────────────────────────────────────────────────────────────

class AppVideoRecorderPage extends HookWidget {
  const AppVideoRecorderPage({super.key});

  static Future<AppVideoResult?> show(BuildContext context) =>
      Navigator.of(context).push<AppVideoResult?>(
        PageRouteBuilder(
          fullscreenDialog: true,
          pageBuilder: (_, __, ___) => const AppVideoRecorderPage(),
          transitionsBuilder: (_, anim, __, child) => FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 280),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // ── Animation controllers ─────────────────────────────────────────────
    final pulseCtrl = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );
    final countdownCtrl = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final recordingProgressCtrl = useAnimationController(
      duration: const Duration(seconds: _kRecordSeconds),
    );
    // Used to animate the oval when face first detected
    final faceDetectedCtrl = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final pulseAnim = useMemoized(
      () => CurvedAnimation(parent: pulseCtrl, curve: Curves.easeInOut),
    );
    final countdownScale = useMemoized(
      () => Tween<double>(begin: 1.5, end: 1.0).animate(
        CurvedAnimation(parent: countdownCtrl, curve: Curves.easeOutBack),
      ),
    );
    final countdownFade = useMemoized(
      () => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: countdownCtrl, curve: Curves.easeOut)),
    );

    // ── Camera ────────────────────────────────────────────────────────────
    final ctrl = useState<CameraController?>(null);
    final isInitialized = useState(false);
    final initError = useState<String?>(null);

    // ── Face detection ────────────────────────────────────────────────────
    final faceDetected = useState(false);
    final isProcessingFrame = useRef(false);

    // ── Recording state ───────────────────────────────────────────────────
    final phase = useState(_Phase.idle);
    final countdown = useState(_kCountdownFrom);
    final elapsed = useState(0);
    final recordedPath = useState<String?>(null);
    final thumbnailPath = useState<String?>(null);
    final isValidatingFace = useState(false);
    final faceValidationFailed = useState(false);

    // ── Timer refs ────────────────────────────────────────────────────────
    final countdownTimerRef = useRef<Timer?>(null);
    final recordingTimerRef = useRef<Timer?>(null);

    // ── Perf guards ───────────────────────────────────────────────────────
    // Prevents running face detection more often than every 400 ms.
    final lastDetectionMs = useRef<int>(0);
    // Prevents overlapping initCamera() calls (e.g. rapid resume events).
    final isInitializing = useRef(false);

    // ── Stable listenable for the face guide painter ──────────────────────
    // Created once so AnimatedBuilder never re-registers listeners on rebuild.
    final faceGuideListenable = useMemoized(
      () => Listenable.merge([pulseAnim, faceDetectedCtrl]),
    );

    // ── Face detection: start & stop image stream ─────────────────────────
    void startDetectionStream() {
      final c = ctrl.value;
      if (c == null || !c.value.isInitialized) return;
      if (c.value.isStreamingImages) return;

      final format = Platform.isAndroid ? 'nv21' : 'bgra8888';

      c.startImageStream((image) async {
        if (isProcessingFrame.value) return;
        // Throttle: run detection at most every 400 ms to spare low-end CPUs.
        final nowMs = DateTime.now().millisecondsSinceEpoch;
        if (nowMs - lastDetectionMs.value < 400) return;
        if (!context.mounted) return;
        lastDetectionMs.value = nowMs;
        isProcessingFrame.value = true;

        try {
          final bytes = _extractCameraBytes(image);

          final detected = await FaceDetectionService.detectFaceInBytes(
            bytes: bytes,
            width: image.width,
            height: image.height,
            format: format,
          );

          if (context.mounted) {
            final wasDetected = faceDetected.value;
            faceDetected.value = detected;
            if (!wasDetected && detected) {
              faceDetectedCtrl.forward(from: 0);
            } else if (wasDetected && !detected) {
              faceDetectedCtrl.reverse();
            }
          }
        } catch (_) {
        } finally {
          isProcessingFrame.value = false;
        }
      });
    }

    Future<void> stopDetectionStream() async {
      final c = ctrl.value;
      if (c == null || !c.value.isStreamingImages) return;
      try {
        await c.stopImageStream();
      } catch (_) {}
      faceDetected.value = false;
    }

    // ── Camera init ───────────────────────────────────────────────────────
    Future<void> initCamera() async {
      if (isInitializing.value) return;
      isInitializing.value = true;
      // Null out first so stale references see null, not a mid-dispose ctrl.
      final old = ctrl.value;
      ctrl.value = null;
      isInitialized.value = false;
      initError.value = null;
      try {
        old?.dispose();
      } catch (_) {}

      final granted = await getIt<AppPermissionHandler>().requestPermissions(
        [Permission.camera, Permission.microphone],
        title: 'core.permission.cameraAndMic.title'.tr(),
        message: 'core.permission.cameraAndMic.message'.tr(),
        restrictedMessage: 'core.permission.cameraAndMic.restricted'.tr(),
      );
      if (!context.mounted) {
        isInitializing.value = false;
        return;
      }
      if (!granted) {
        initError.value = 'core.permission.cameraAndMic.deniedBody'.tr();
        isInitializing.value = false;
        return;
      }

      try {
        final cams = await availableCameras();
        if (!context.mounted) return;
        if (cams.isEmpty) {
          initError.value = 'kyc.video.recorder.error.noCamera'.tr();
          return;
        }
        final front = cams.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.front,
          orElse: () => cams.first,
        );

        final controller = CameraController(
          front,
          ResolutionPreset.high,
          enableAudio: true,
          imageFormatGroup: Platform.isAndroid
              ? ImageFormatGroup.nv21
              : ImageFormatGroup.bgra8888,
        );
        await controller.initialize();
        if (!context.mounted) {
          controller.dispose();
          return;
        }

        ctrl.value = controller;
        isInitialized.value = true;
        startDetectionStream();
      } catch (e) {
        if (context.mounted) initError.value = e.toString();
      } finally {
        isInitializing.value = false;
      }
    }

    // ── Thumbnail generation ──────────────────────────────────────────────
    Future<String?> generateThumbnail(String videoPath) =>
        VideoFrameService.generateThumbnail(
          videoPath,
          maxHeight: 600,
          quality: 85,
        );

    // ── Stop recording ────────────────────────────────────────────────────
    Future<void> stopRecording() async {
      recordingTimerRef.value?.cancel();
      recordingTimerRef.value = null;
      recordingProgressCtrl.stop();
      final c = ctrl.value;
      if (c == null || !c.value.isRecordingVideo) {
        // Camera not actually recording (e.g. disposed mid-session on a previous
        // back-press). Reset to idle so the user can try again rather than
        // staying frozen on the recording screen at 0:00.
        if (context.mounted) {
          phase.value = _Phase.idle;
          pulseCtrl.repeat(reverse: true);
          startDetectionStream();
        }
        return;
      }
      try {
        final file = await c.stopVideoRecording();
        if (!context.mounted) return;
        recordedPath.value = file.path;
        phase.value = _Phase.recorded;
        pulseCtrl.stop();
        isValidatingFace.value = true;
        faceValidationFailed.value = false;

        // Generate thumbnail and validate face in parallel
        String? thumb;
        bool hasFace = true;
        await Future.wait<void>([
          generateThumbnail(file.path).then((p) => thumb = p),
          _validateFaceInVideo(file.path).then((ok) => hasFace = ok),
        ]);

        if (!context.mounted) return;
        thumbnailPath.value = thumb;
        faceValidationFailed.value = !hasFace;
        isValidatingFace.value = false;
      } catch (_) {
        if (context.mounted) {
          phase.value = _Phase.idle;
          isValidatingFace.value = false;
        }
      }
    }

    // ── Start recording ───────────────────────────────────────────────────
    Future<void> startRecording() async {
      final c = ctrl.value;
      if (c == null || !c.value.isInitialized) return;
      try {
        await c.startVideoRecording();
        if (!context.mounted) return;
        phase.value = _Phase.recording;
        elapsed.value = 0;
        pulseCtrl.repeat(reverse: true);
        recordingProgressCtrl.forward(from: 0);

        recordingTimerRef.value = Timer.periodic(const Duration(seconds: 1), (
          t,
        ) {
          if (!context.mounted) {
            t.cancel();
            return;
          }
          final next = elapsed.value + 1;
          elapsed.value = next;
          if (next >= _kRecordSeconds) {
            t.cancel();
            stopRecording();
          }
        });
      } catch (_) {
        if (context.mounted) phase.value = _Phase.idle;
      }
    }

    // ── Start countdown ───────────────────────────────────────────────────
    Future<void> startCountdown() async {
      // Must stop stream before recording
      await stopDetectionStream();

      phase.value = _Phase.countdown;
      countdown.value = _kCountdownFrom;
      countdownCtrl.forward(from: 0);

      countdownTimerRef.value = Timer.periodic(const Duration(seconds: 1), (t) {
        if (!context.mounted) {
          t.cancel();
          return;
        }
        final next = countdown.value - 1;
        if (next <= 0) {
          t.cancel();
          startRecording();
        } else {
          countdown.value = next;
          countdownCtrl.forward(from: 0);
        }
      });
    }

    // ── Retake ────────────────────────────────────────────────────────────
    void retake() {
      recordedPath.value = null;
      thumbnailPath.value = null;
      elapsed.value = 0;
      recordingProgressCtrl.reset();
      phase.value = _Phase.idle;
      isValidatingFace.value = false;
      faceValidationFailed.value = false;
      lastDetectionMs.value = 0; // fire detection immediately on retake
      pulseCtrl.repeat(reverse: true);
      startDetectionStream();
    }

    // ── Effects ───────────────────────────────────────────────────────────
    useEffect(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      pulseCtrl.repeat(reverse: true);
      initCamera();
      return () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        countdownTimerRef.value?.cancel();
        recordingTimerRef.value?.cancel();
        // Do NOT set ctrl.value = null here. Setting a useState (ValueNotifier)
        // during unmount fires notifyListeners() on a defunct element → assertion crash.
        final c = ctrl.value;
        if (c != null) _safeDisposeCamera(c);
      };
    }, const []);

    useEffect(() {
      final observer = _LifecycleObserver((state) {
        if (state == AppLifecycleState.inactive) {
          countdownTimerRef.value?.cancel();
          recordingTimerRef.value?.cancel();
          // Null first — concurrent image-stream callbacks see null, not
          // a mid-dispose controller.
          final c = ctrl.value;
          ctrl.value = null;
          isInitialized.value = false;
          faceDetected.value = false;
          if (c != null) _safeDisposeCamera(c);
        } else if (state == AppLifecycleState.resumed) {
          initCamera();
        }
      });
      WidgetsBinding.instance.addObserver(observer);
      return () => WidgetsBinding.instance.removeObserver(observer);
    }, const []);

    // ── Build ─────────────────────────────────────────────────────────────
    final safeBottom = MediaQuery.of(context).padding.bottom;
    final safeTop = MediaQuery.of(context).padding.top;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Camera preview ─────────────────────────────────────────────
          if (isInitialized.value && ctrl.value != null)
            RepaintBoundary(child: _CameraFill(controller: ctrl.value!))
          else if (initError.value != null)
            CameraInitErrorView(
              message: initError.value!,
              onRetry: initCamera,
            )
          else
            const _LoadingState(),

          // ── Face oval guide ────────────────────────────────────────────
          // RepaintBoundary isolates the 60-fps CustomPaint from the page.
          // faceGuideListenable is memoized — AnimatedBuilder never
          // re-registers its listeners on every parent rebuild.
          if (isInitialized.value && phase.value != _Phase.recorded)
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: faceGuideListenable,
                builder: (_, __) => CustomPaint(
                  size: screenSize,
                  painter: _FaceGuidePainter(
                    phase: phase.value,
                    pulse: pulseAnim.value,
                    faceDetected: faceDetected.value,
                    faceDetectedProgress: faceDetectedCtrl.value,
                  ),
                ),
              ),
            ),

          // ── Top bar ────────────────────────────────────────────────────
          if (phase.value != _Phase.recording)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _TopBar(
                phase: phase.value,
                onClose: () => Navigator.of(context).pop(null),
              ),
            ),

          // ── IDLE: floating bottom card ─────────────────────────────────
          if (isInitialized.value && phase.value == _Phase.idle)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _BottomCard(
                safeBottom: safeBottom,
                onRecord: startCountdown,
                pulseAnim: pulseAnim,
                faceDetected: faceDetected.value,
              ),
            ),

          // ── IDLE: face detection status hint (above the oval) ──────────
          if (isInitialized.value && phase.value == _Phase.idle)
            Positioned(
              top: safeTop + 68.h,
              left: 0,
              right: 0,
              child: _FaceStatusBadge(faceDetected: faceDetected.value),
            ),

          // ── COUNTDOWN ─────────────────────────────────────────────────
          if (phase.value == _Phase.countdown)
            _CountdownDisplay(
              countdown: countdown.value,
              total: _kCountdownFrom,
              scaleAnim: countdownScale,
              fadeAnim: countdownFade,
            ),

          // ── RECORDING ─────────────────────────────────────────────────
          if (phase.value == _Phase.recording) ...[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _RecordingTopBar(
                safeTop: safeTop,
                elapsed: elapsed.value,
                total: _kRecordSeconds,
                progressCtrl: recordingProgressCtrl,
                pulseAnim: pulseAnim,
              ),
            ),
          ],

          // ── RECORDED ──────────────────────────────────────────────────
          if (phase.value == _Phase.recorded)
            _RecordedOverlay(
              videoPath: recordedPath.value,
              thumbnailPath: thumbnailPath.value,
              isValidating: isValidatingFace.value,
              faceValidationFailed: faceValidationFailed.value,
              onRetake: retake,
              onUse: () => Navigator.of(context).pop(
                AppVideoResult(
                  videoPath: recordedPath.value!,
                  thumbnailPath: thumbnailPath.value,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Camera full-screen fill ───────────────────────────────────────────────────

class _CameraFill extends StatelessWidget {
  final CameraController controller;
  const _CameraFill({required this.controller});

  @override
  Widget build(BuildContext context) {
    // previewSize is always in landscape orientation (the sensor's native frame).
    // Swap shortest/longest so FittedBox.cover works with portrait dimensions.
    final previewSize = controller.value.previewSize;
    if (previewSize == null) return const SizedBox.expand();
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: previewSize.shortestSide,
          height: previewSize.longestSide,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}

// ── Loading & error states ────────────────────────────────────────────────────

class _LoadingState extends StatelessWidget {
  const _LoadingState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 44.w,
            height: 44.w,
            child: CircularProgressIndicator(
              color: AppColors.brandYellow,
              strokeWidth: 2.5,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'kyc.video.recorder.loading'.tr(),
            style: TextStyle(color: Colors.white38, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}

// ── Face detection status badge ───────────────────────────────────────────────

class _FaceStatusBadge extends StatelessWidget {
  final bool faceDetected;
  const _FaceStatusBadge({required this.faceDetected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: faceDetected
              ? const Color(0xFF1B5E20).withValues(alpha: 0.82)
              : Colors.black.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(99.r),
          border: Border.all(
            color: faceDetected
                ? Colors.green.shade400.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: Icon(
                faceDetected
                    ? Icons.check_circle_rounded
                    : Icons.face_retouching_natural_rounded,
                key: ValueKey(faceDetected),
                color: faceDetected ? Colors.green.shade300 : Colors.white54,
                size: 15.sp,
              ),
            ),
            SizedBox(width: 7.w),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: Text(
                faceDetected
                    ? 'kyc.video.recorder.faceStatus.detected'.tr()
                    : 'kyc.video.recorder.faceStatus.notDetected'.tr(),
                key: ValueKey(faceDetected),
                style: TextStyle(
                  color: faceDetected ? Colors.green.shade200 : Colors.white60,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Face guide painter ────────────────────────────────────────────────────────

class _FaceGuidePainter extends CustomPainter {
  final _Phase phase;
  final double pulse;
  final bool faceDetected;
  final double faceDetectedProgress; // 0→1 on first detection

  const _FaceGuidePainter({
    required this.phase,
    required this.pulse,
    required this.faceDetected,
    required this.faceDetectedProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final ovalW = size.width * 0.62;
    final ovalH = ovalW * 1.32;
    final center = Offset(size.width / 2, size.height * 0.43);
    final ovalRect = Rect.fromCenter(
      center: center,
      width: ovalW,
      height: ovalH,
    );

    // Gradient scrim
    canvas.drawPath(
      Path()
        ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
        ..addOval(ovalRect)
        ..fillType = PathFillType.evenOdd,
      Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 0.75,
          colors: [
            Colors.black.withValues(alpha: 0.30),
            Colors.black.withValues(alpha: 0.65),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // Base oval ring
    canvas.drawOval(
      ovalRect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = Colors.white.withValues(alpha: 0.12),
    );

    // Corner arc color: green when face detected, yellow idle, red recording
    final Color cornerColor;
    final double strokeW;

    if (phase == _Phase.recording) {
      cornerColor = Color.lerp(
        const Color(0xFFFF4444),
        const Color(0xFFFF8888),
        pulse,
      )!;
      strokeW = 2.5 + pulse * 1.0;
    } else if (faceDetected) {
      // Blend from yellow to green as detection animates in
      cornerColor = Color.lerp(
        AppColors.brandYellow,
        Colors.green.shade400,
        faceDetectedProgress,
      )!;
      strokeW = 2.8;
    } else if (phase == _Phase.countdown) {
      cornerColor = Color.lerp(
        AppColors.brandYellow,
        Colors.white,
        pulse * 0.3,
      )!;
      strokeW = 2.5;
    } else {
      // Idle, no face: dim white pulsing
      cornerColor = Color.lerp(Colors.white24, Colors.white38, pulse)!;
      strokeW = 2.0;
    }

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..color = cornerColor;

    // 4 corner arc segments (~28° each)
    const sweepAngle = 0.50;
    const halfSweep = sweepAngle / 2;
    for (final angle in [
      -3 * math.pi / 4,
      -math.pi / 4,
      math.pi / 4,
      3 * math.pi / 4,
    ]) {
      canvas.drawArc(ovalRect, angle - halfSweep, sweepAngle, false, arcPaint);
    }

    // When face detected: draw a subtle full-oval green outline
    if (faceDetected && faceDetectedProgress > 0) {
      canvas.drawOval(
        ovalRect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = Colors.green.shade400.withValues(
            alpha: 0.35 * faceDetectedProgress,
          ),
      );
    }

    // Recording: pulsing outer glow
    if (phase == _Phase.recording) {
      canvas.drawOval(
        ovalRect.inflate(3 + pulse * 4),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = const Color(0xFFFF4444).withValues(alpha: 0.3 * pulse),
      );
    }
  }

  @override
  bool shouldRepaint(_FaceGuidePainter old) =>
      old.phase != phase ||
      old.pulse != pulse ||
      old.faceDetected != faceDetected ||
      old.faceDetectedProgress != faceDetectedProgress;
}

// ── Top bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final _Phase phase;
  final VoidCallback onClose;
  const _TopBar({required this.phase, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final canClose = phase == _Phase.idle || phase == _Phase.recorded;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
        child: Row(
          children: [
            AnimatedOpacity(
              opacity: canClose ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: canClose ? onClose : null,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'kyc.video.recorder.topBarTitle'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            SizedBox(width: 36.w),
          ],
        ),
      ),
    );
  }
}

// ── Bottom instruction card (idle) ────────────────────────────────────────────

class _BottomCard extends HookWidget {
  final double safeBottom;
  final VoidCallback onRecord;
  final Animation<double> pulseAnim;
  final bool faceDetected;

  const _BottomCard({
    required this.safeBottom,
    required this.onRecord,
    required this.pulseAnim,
    required this.faceDetected,
  });

  static List<(IconData, String)> _buildSteps() => [
    (Icons.credit_card_outlined, 'kyc.video.recorder.instruction1'.tr()),
    (Icons.remove_red_eye_outlined, 'kyc.video.recorder.instruction2'.tr()),
    (Icons.wb_sunny_outlined, 'kyc.video.recorder.instruction4'.tr()),
  ];

  @override
  Widget build(BuildContext context) {
    final steps = _buildSteps();
    final staggerCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );
    final activeStep = useState(0);
    final timerRef = useRef<Timer?>(null);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (context.mounted) staggerCtrl.forward();
      });
      timerRef.value = Timer.periodic(const Duration(milliseconds: 2400), (_) {
        if (context.mounted) {
          activeStep.value = (activeStep.value + 1) % steps.length;
        }
      });
      return () => timerRef.value?.cancel();
    }, const []);

    final cardSlide =
        Tween<Offset>(begin: const Offset(0, 0.8), end: Offset.zero).animate(
          CurvedAnimation(
            parent: staggerCtrl,
            curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
          ),
        );

    final cardFade = CurvedAnimation(
      parent: staggerCtrl,
      curve: const Interval(0.0, 0.40),
    );

    Animation<double> itemFade(int i) => CurvedAnimation(
      parent: staggerCtrl,
      curve: Interval(0.28 + i * 0.09, 0.56 + i * 0.09),
    );

    Animation<Offset> itemSlide(int i) =>
        Tween<Offset>(begin: const Offset(0, 0.6), end: Offset.zero).animate(
          CurvedAnimation(
            parent: staggerCtrl,
            curve: Interval(
              0.28 + i * 0.09,
              0.62 + i * 0.09,
              curve: Curves.easeOutCubic,
            ),
          ),
        );

    final btnFade = CurvedAnimation(
      parent: staggerCtrl,
      curve: const Interval(0.72, 1.0),
    );

    return FadeTransition(
      opacity: cardFade,
      child: SlideTransition(
        position: cardSlide,
        child: Container(
          margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, safeBottom + 14.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.86),
            borderRadius: BorderRadius.circular(26.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.09),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: context.appColors.shadowInk.withValues(alpha: 0.55,),
                blurRadius: 24,
                offset: const Offset(0, 8),
                spreadRadius: 4,
              ),
              BoxShadow(
                color: AppColors.brandYellow.withValues(alpha: 0.07),
                blurRadius: 32,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 18.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 38.w,
                height: 3.5.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(99.r),
                ),
              ),
              SizedBox(height: 14.h),

              // Step dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(steps.length, (i) {
                  final isActive = i == activeStep.value;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeInOut,
                    width: isActive ? 24.w : 7.w,
                    height: 7.w,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.brandYellow
                          : Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                  );
                }),
              ),
              SizedBox(height: 14.h),

              // Instruction rows with staggered entrance
              ...List.generate(steps.length, (i) {
                return AnimatedBuilder(
                  animation: staggerCtrl,
                  builder: (_, child) => FadeTransition(
                    opacity: itemFade(i),
                    child: SlideTransition(
                      position: itemSlide(i),
                      child: child,
                    ),
                  ),
                  child: _InstructionRow(
                    index: i,
                    icon: steps[i].$1,
                    text: steps[i].$2,
                    isActive: activeStep.value == i,
                  ),
                );
              }),

              SizedBox(height: 14.h),

              // Record button (fades in last)
              FadeTransition(
                opacity: btnFade,
                child: AnimatedBuilder(
                  animation: pulseAnim,
                  builder: (_, __) => _RecordButton(
                    onTap: faceDetected ? onRecord : null,
                    pulse: faceDetected ? pulseAnim.value : 0.0,
                    isEnabled: faceDetected,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Instruction row ───────────────────────────────────────────────────────────

class _InstructionRow extends StatelessWidget {
  final int index;
  final IconData icon;
  final String text;
  final bool isActive;

  const _InstructionRow({
    required this.index,
    required this.icon,
    required this.text,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.brandYellow.withValues(alpha: 0.11)
            : Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isActive
              ? AppColors.brandYellow.withValues(alpha: 0.28)
              : Colors.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 380),
            width: 26.w,
            height: 26.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.brandYellow.withValues(alpha: 0.22)
                  : Colors.white.withValues(alpha: 0.07),
              border: Border.all(
                color: isActive
                    ? AppColors.brandYellow.withValues(alpha: 0.55)
                    : Colors.white.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: isActive ? AppColors.brandYellow : Colors.white30,
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w700,
                ),
                child: Text('${index + 1}'),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              icon,
              key: ValueKey(isActive),
              color: isActive
                  ? AppColors.brandYellow
                  : Colors.white.withValues(alpha: 0.28),
              size: 15.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 320),
              style: TextStyle(
                color: isActive
                    ? Colors.white.withValues(alpha: 0.92)
                    : Colors.white.withValues(alpha: 0.40),
                fontSize: 12.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                height: 1.3,
              ),
              child: Text(text),
            ),
          ),
          AnimatedOpacity(
            opacity: isActive ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              margin: EdgeInsets.only(left: 8.w),
              width: 5.w,
              height: 5.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.brandYellow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Record button ─────────────────────────────────────────────────────────────

class _RecordButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double pulse;
  final bool isEnabled;

  const _RecordButton({
    required this.onTap,
    required this.pulse,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedOpacity(
        opacity: isEnabled ? 1.0 : 0.38,
        duration: const Duration(milliseconds: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 88.w,
              height: 88.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer pulse ring (only when enabled)
                  if (isEnabled)
                    Container(
                      width: 88.w - (1 - pulse) * 4,
                      height: 88.w - (1 - pulse) * 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.brandYellow.withValues(
                            alpha: 0.3 + pulse * 0.3,
                          ),
                          width: 1.5,
                        ),
                      ),
                    ),
                  // White ring
                  Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3.w),
                    ),
                  ),
                  // Inner circle: red when enabled, gray when not
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: 52.w,
                    height: 52.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isEnabled
                          ? const Color(0xFFE53935)
                          : Colors.white24,
                      boxShadow: isEnabled
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xFFE53935,
                                ).withValues(alpha: 0.4),
                                blurRadius: 12 + pulse * 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : [],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 400),
              style: TextStyle(
                color: isEnabled
                    ? Colors.white.withValues(alpha: 0.55)
                    : Colors.white24,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
              child: Text(
                isEnabled
                    ? 'kyc.video.recorder.tapToRecord'.tr()
                    : 'kyc.video.recorder.faceRequired'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Countdown display ─────────────────────────────────────────────────────────

class _CountdownDisplay extends StatelessWidget {
  final int countdown;
  final int total;
  final Animation<double> scaleAnim;
  final Animation<double> fadeAnim;

  const _CountdownDisplay({
    required this.countdown,
    required this.total,
    required this.scaleAnim,
    required this.fadeAnim,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.55),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'kyc.video.recorder.countdown.label'.tr(),
              style: TextStyle(
                color: AppColors.brandYellow,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: 130.w,
              height: 130.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 4,
                      color: Colors.white10,
                    ),
                  ),
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: countdown / total,
                      strokeWidth: 4,
                      color: AppColors.brandYellow,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: scaleAnim,
                    builder: (_, __) => ScaleTransition(
                      scale: scaleAnim,
                      child: FadeTransition(
                        opacity: fadeAnim,
                        child: Text(
                          '$countdown',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 68.sp,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'kyc.video.recorder.countdown.holdId'.tr(),
              style: TextStyle(
                color: Colors.white60,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Recording top bar ─────────────────────────────────────────────────────────

class _RecordingTopBar extends StatelessWidget {
  final double safeTop;
  final int elapsed;
  final int total;
  final AnimationController progressCtrl;
  final Animation<double> pulseAnim;

  const _RecordingTopBar({
    required this.safeTop,
    required this.elapsed,
    required this.total,
    required this.progressCtrl,
    required this.pulseAnim,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = total - elapsed;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withValues(alpha: 0.65), Colors.transparent],
        ),
      ),
      padding: EdgeInsets.fromLTRB(16.w, safeTop + 12.h, 16.w, 16.h),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: pulseAnim,
            builder: (_, __) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(99.r),
                border: Border.all(
                  color: const Color(0xFFFF4444).withValues(alpha: 0.7),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.lerp(
                        const Color(0xFFFF4444),
                        const Color(0xFFFF8888),
                        pulseAnim.value,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFFFF4444,
                          ).withValues(alpha: 0.4 + pulseAnim.value * 0.4),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'kyc.video.recorder.recBadge'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: AnimatedBuilder(
              animation: progressCtrl,
              builder: (_, __) => ClipRRect(
                borderRadius: BorderRadius.circular(99.r),
                child: LinearProgressIndicator(
                  value: progressCtrl.value,
                  minHeight: 4.h,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFFFF4444)),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            '0:0$remaining',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              fontFeatures: [const FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recorded overlay ──────────────────────────────────────────────────────────

class _RecordedOverlay extends StatelessWidget {
  final String? videoPath;
  final String? thumbnailPath;
  final bool isValidating;
  final bool faceValidationFailed;
  final VoidCallback onRetake;
  final VoidCallback onUse;

  const _RecordedOverlay({
    required this.onRetake,
    required this.onUse,
    required this.isValidating,
    required this.faceValidationFailed,
    this.videoPath,
    this.thumbnailPath,
  });

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.of(context).padding.bottom;
    final safeTop = MediaQuery.of(context).padding.top;

    return Container(
      color: Colors.black.withValues(alpha: 0.90),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, safeTop + 8.h, 16.w, 8.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onRetake,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'kyc.video.recorder.preview.title'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 36.w),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: _ThumbnailPreview(
                thumbnailPath: thumbnailPath,
                videoPath: videoPath,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.07),
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.fromLTRB(22.w, 16.h, 22.w, safeBottom + 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Status row: validating / failed / success ────────────
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: isValidating
                      ? _StatusRow(
                          key: const ValueKey('validating'),
                          icon: SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.brandYellow,
                            ),
                          ),
                          label: 'kyc.video.recorder.status.validating'.tr(),
                          sublabel:
                              'kyc.video.recorder.status.validatingSubtitle'
                                  .tr(),
                          labelColor: Colors.white70,
                        )
                      : faceValidationFailed
                      ? _StatusRow(
                          key: const ValueKey('failed'),
                          icon: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange.withValues(alpha: 0.15),
                              border: Border.all(
                                color: Colors.orange.shade400,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.face_retouching_off_rounded,
                              color: Colors.orange.shade400,
                              size: 13.sp,
                            ),
                          ),
                          label: 'kyc.video.recorder.status.failed'.tr(),
                          sublabel: 'kyc.video.recorder.status.failedSubtitle'
                              .tr(),
                          labelColor: Colors.orange.shade300,
                        )
                      : _StatusRow(
                          key: const ValueKey('success'),
                          icon: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green.withValues(alpha: 0.15),
                              border: Border.all(
                                color: Colors.green.shade400,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.green.shade400,
                              size: 13.sp,
                            ),
                          ),
                          label: 'kyc.video.recorder.status.success'.tr(),
                          sublabel: 'kyc.video.recorder.status.successSubtitle'
                              .tr(namedArgs: {'seconds': '$_kRecordSeconds'}),
                          labelColor: Colors.white,
                        ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: isValidating ? null : onRetake,
                        icon: Icon(
                          Icons.replay_rounded,
                          size: 15.sp,
                          color: faceValidationFailed
                              ? AppColors.brandYellow
                              : Colors.white70,
                        ),
                        label: Text(
                          'kyc.video.recorder.retakeButton'.tr(),
                          style: TextStyle(
                            color: faceValidationFailed
                                ? AppColors.brandYellow
                                : Colors.white70,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: faceValidationFailed
                                ? AppColors.brandYellow.withValues(alpha: 0.6)
                                : Colors.white.withValues(alpha: 0.2),
                            width: 1,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: isValidating || faceValidationFailed
                            ? null
                            : onUse,
                        icon: Icon(
                          Icons.check_circle_outline_rounded,
                          size: 16.sp,
                          color: Colors.black,
                        ),
                        label: Text(
                          'kyc.video.recorder.useButton'.tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandYellow,
                          disabledBackgroundColor: AppColors.brandYellow
                              .withValues(alpha: 0.25),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Status row (inside recorded overlay) ─────────────────────────────────────

class _StatusRow extends StatelessWidget {
  final Widget icon;
  final String label;
  final String sublabel;
  final Color labelColor;

  const _StatusRow({
    super.key,
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Text(
          sublabel,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white38, fontSize: 11.sp),
        ),
      ],
    );
  }
}

// ── Thumbnail preview card ────────────────────────────────────────────────────

class _ThumbnailPreview extends HookWidget {
  final String? thumbnailPath;
  final String? videoPath;
  const _ThumbnailPreview({this.thumbnailPath, this.videoPath});

  @override
  Widget build(BuildContext context) {
    final ctrl = useState<VideoPlayerController?>(null);
    final isLoading = useState(false);

    // Dispose controller on unmount
    useEffect(
      () => () {
        ctrl.value?.dispose();
      },
      const [],
    );

    // Auto-reset to start when playback reaches the end.
    // Guard prevents rapid repeated seeks during the async gap.
    final isSeeking = useRef(false);
    useEffect(() {
      final c = ctrl.value;
      if (c == null) return null;
      void listener() {
        final v = c.value;
        if (v.duration > Duration.zero &&
            v.position >= v.duration &&
            !v.isPlaying &&
            !isSeeking.value) {
          isSeeking.value = true;
          c.seekTo(Duration.zero).whenComplete(() => isSeeking.value = false);
        }
      }

      c.addListener(listener);
      return () => c.removeListener(listener);
    }, [ctrl.value]);

    // Pause video when app goes to background.
    useEffect(() {
      final c = ctrl.value;
      if (c == null) return null;
      final obs = _LifecycleObserver((state) {
        if (state == AppLifecycleState.inactive ||
            state == AppLifecycleState.paused) {
          c.pause();
        }
      });
      WidgetsBinding.instance.addObserver(obs);
      return () => WidgetsBinding.instance.removeObserver(obs);
    }, [ctrl.value]);

    Future<void> onTap() async {
      final c = ctrl.value;
      if (c != null && c.value.isInitialized) {
        c.value.isPlaying ? await c.pause() : await c.play();
        return;
      }
      if (videoPath == null) return;
      isLoading.value = true;
      final newCtrl = VideoPlayerController.file(File(videoPath!));
      try {
        await newCtrl.initialize();
        if (!context.mounted) {
          await newCtrl.dispose();
          return;
        }
        ctrl.value = newCtrl;
        await newCtrl.play();
      } catch (_) {
        // If ctrl was already pointed at newCtrl, null it out before disposing.
        if (ctrl.value == newCtrl) ctrl.value = null;
        await newCtrl.dispose();
      } finally {
        if (context.mounted) isLoading.value = false;
      }
    }

    final c = ctrl.value;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(
          color: AppColors.brandYellow.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandYellow.withValues(alpha: 0.1),
            blurRadius: 28,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background: video or thumbnail ──────────────────────────────
            if (c != null)
              ValueListenableBuilder(
                valueListenable: c,
                builder: (context, val, _) => val.isInitialized
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: val.size.width,
                          height: val.size.height,
                          child: VideoPlayer(c),
                        ),
                      )
                    : const SizedBox.expand(),
              )
            else if (thumbnailPath != null)
              Image.file(File(thumbnailPath!), fit: BoxFit.cover)
            else
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey.shade900, Colors.black],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.videocam_rounded,
                        color: Colors.white12,
                        size: 48.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'kyc.video.recorder.preview.processing'.tr(),
                        style: TextStyle(
                          color: Colors.white24,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // ── Bottom gradient scrim ───────────────────────────────────────
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.65),
                    ],
                  ),
                ),
              ),
            ),

            // ── Duration badge (top-right) ──────────────────────────────────
            Positioned(
              top: 12.h,
              right: 12.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(99.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFF4444),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '0:0$_kRecordSeconds',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Full-area tap to play / pause ───────────────────────────────
            Positioned.fill(
              child: GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.opaque,
              ),
            ),

            // ── Center play / pause icon ────────────────────────────────────
            IgnorePointer(
              child: Center(
                child: c != null
                    ? ValueListenableBuilder(
                        valueListenable: c,
                        builder: (context, val, _) => AnimatedOpacity(
                          opacity: val.isPlaying ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 220),
                          child: _PlayIcon(isLoading: false),
                        ),
                      )
                    : _PlayIcon(isLoading: isLoading.value),
              ),
            ),

            // ── Progress bar (shown once video is loaded) ───────────────────
            if (c != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ValueListenableBuilder(
                  valueListenable: c,
                  builder: (context, val, _) {
                    final total = val.duration.inMilliseconds.toDouble();
                    final pos = val.position.inMilliseconds.toDouble();
                    return LinearProgressIndicator(
                      value: total > 0 ? (pos / total).clamp(0.0, 1.0) : 0.0,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.brandYellow,
                      ),
                      minHeight: 3.5,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PlayIcon extends StatelessWidget {
  final bool isLoading;
  const _PlayIcon({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withValues(alpha: 0.45),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.85),
          width: 2.w,
        ),
      ),
      child: isLoading
          ? Padding(
              padding: EdgeInsets.all(16.w),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30.sp),
    );
  }
}

// ── Lifecycle observer ────────────────────────────────────────────────────────

class _LifecycleObserver extends WidgetsBindingObserver {
  final void Function(AppLifecycleState) onStateChange;
  _LifecycleObserver(this.onStateChange);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) =>
      onStateChange(state);
}