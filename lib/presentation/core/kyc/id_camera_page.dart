import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image/image.dart' as img;

import 'package:permission_handler/permission_handler.dart';

import '../../../domain/core/di/injection.dart';
import '../../../domain/core/permission_handler/app_permission_handler.dart';
import '../../../domain/kyc/kyc_ocr_result.dart';
import '../../../domain/core/ocr/ocr_service.dart';
import '../camera/camera_init_error_view.dart';
// Full-screen camera/video overlay: renders on a black surface in both themes,
// so it deliberately uses the fixed brand palette instead of theme tokens.
import '../colors/app_colors.dart';

const _ocrChannel = MethodChannel('general.ocr');

// ── Public result type ─────────────────────────────────────────────────────────

class KycCaptureResult {
  final String imagePath;
  final KycOcrResult ocr;

  const KycCaptureResult({required this.imagePath, required this.ocr});
}

// ── Page entry-point ───────────────────────────────────────────────────────────

class KycIdCameraPage extends HookWidget {
  final bool isFront;

  const KycIdCameraPage({super.key, required this.isFront});

  static Future<KycCaptureResult?> show(
    BuildContext context, {
    required bool isFront,
  }) {
    return Navigator.of(context).push<KycCaptureResult?>(
      PageRouteBuilder(
        fullscreenDialog: true,
        pageBuilder: (context, animation, secondaryAnimation) =>
            KycIdCameraPage(isFront: isFront),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 220),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ── Animation ───────────────────────────────────────────────────────────
    final pulseCtrl = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );
    final pulseAnim = useMemoized(
      () => CurvedAnimation(parent: pulseCtrl, curve: Curves.easeInOut),
    );
    useEffect(() => pulseAnim.dispose, const []);

    // ── Camera state ────────────────────────────────────────────────────────
    final ctrl = useState<CameraController?>(null);
    final cameras = useState<List<CameraDescription>>([]);
    final flashMode = useState<FlashMode>(FlashMode.off);
    final isInitialized = useState<bool>(false);
    final initError = useState<String?>(null);

    // ── Detection state ─────────────────────────────────────────────────────
    final phase = useState<_ScanPhase>(_ScanPhase.scanning);
    final consecutiveHits = useState<int>(0);
    final detectionScore = useState<double>(0.0);

    // ── Mutable refs (no rebuild) ────────────────────────────────────────────
    final frameCountRef = useRef<int>(0);
    final isInitializingRef = useRef<bool>(false);
    final isDetectingRef = useRef<bool>(false);
    final isCapturingRef = useRef<bool>(false);

    // ── Guide rect ───────────────────────────────────────────────────────────
    final screenSize = MediaQuery.of(context).size;
    const cardAspect = 85.6 / 54.0;
    final guideW = screenSize.width * 0.86;
    final guideH = guideW / cardAspect;
    final guideL = (screenSize.width - guideW) / 2;
    final guideT = (screenSize.height - guideH) / 2 - 32.h;
    final guideRect = Rect.fromLTWH(guideL, guideT, guideW, guideH);

    // ── Functions ────────────────────────────────────────────────────────────

    Uint8List yuv420ToNv21(CameraImage image) {
      final w = image.width;
      final h = image.height;
      final yPlane = image.planes[0];
      final uPlane = image.planes[1];
      final vPlane = image.planes[2];
      final nv21 = Uint8List(w * h * 3 ~/ 2);
      var outIdx = 0;
      for (var row = 0; row < h; row++) {
        nv21.setRange(outIdx, outIdx + w, yPlane.bytes, row * yPlane.bytesPerRow);
        outIdx += w;
      }
      final uStride = uPlane.bytesPerPixel ?? 1;
      final vStride = vPlane.bytesPerPixel ?? 1;
      for (var row = 0; row < h ~/ 2; row++) {
        final uBase = row * uPlane.bytesPerRow;
        final vBase = row * vPlane.bytesPerRow;
        for (var col = 0; col < w ~/ 2; col++) {
          nv21[outIdx++] = vPlane.bytes[vBase + col * vStride];
          nv21[outIdx++] = uPlane.bytes[uBase + col * uStride];
        }
      }
      return nv21;
    }

    Future<bool> detectCard(CameraImage image) async {
      try {
        if (Platform.isIOS) {
          final tempPath = await compute(
            _saveIosFrameJpeg,
            _FrameIosArgs(
              bytes: Uint8List.fromList(image.planes[0].bytes),
              width: image.width,
              height: image.height,
              bytesPerRow: image.planes[0].bytesPerRow,
              outputDir: Directory.systemTemp.path,
            ),
          );
          if (tempPath == null) return false;
          final has = await _ocrChannel.invokeMethod<bool>(
                'detectText', {'imagePath': tempPath}) ??
              false;
          try {
            File(tempPath).deleteSync();
          } catch (_) {}
          return has;
        } else {
          final nv21 = yuv420ToNv21(image);
          return await _ocrChannel.invokeMethod<bool>('detectFromBytes', {
                'bytes': nv21,
                'width': image.width,
                'height': image.height,
              }) ??
              false;
        }
      } catch (_) {
        return false;
      }
    }

    void onFrame(CameraImage image) {
      frameCountRef.value++;
      if (frameCountRef.value % 30 != 0) return;
      if (phase.value == _ScanPhase.capturing ||
          phase.value == _ScanPhase.processing) return;
      if (isDetectingRef.value) return;

      isDetectingRef.value = true;
      detectCard(image).then((hasText) {
        if (!context.mounted) {
          isDetectingRef.value = false;
          return;
        }
        isDetectingRef.value = false;
        detectionScore.value = hasText ? 1.0 : 0.0;

        final hits = hasText
            ? math.min(consecutiveHits.value + 1, 10)
            : math.max(consecutiveHits.value - 1, 0);
        consecutiveHits.value = hits;

        if (hits >= 2 && phase.value == _ScanPhase.scanning) {
          phase.value = _ScanPhase.aligned;
        } else if (hits == 0 && phase.value == _ScanPhase.aligned) {
          phase.value = _ScanPhase.scanning;
        }
      });
    }

    Future<void> initCamera() async {
      if (isInitializingRef.value) return;
      isInitializingRef.value = true;

      isInitialized.value = false;
      initError.value = null;

      try {
        final granted = await getIt<AppPermissionHandler>().requestPermission(
          Permission.camera,
          title: 'core.permission.camera.title'.tr(),
          message: 'core.permission.camera.message'.tr(),
          restrictedMessage: 'core.permission.camera.restricted'.tr(),
        );
        if (!context.mounted) return;
        if (!granted) {
          initError.value = 'core.permission.camera.deniedBody'.tr();
          return;
        }

        final cams = await availableCameras();
        if (!context.mounted) return;
        if (cams.isEmpty) {
          initError.value = 'kyc.camera.error.noCamera'.tr();
          return;
        }
        cameras.value = cams;

        final desc = cams.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.back,
          orElse: () => cams.first,
        );

        final controller = CameraController(
          desc,
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: Platform.isIOS
              ? ImageFormatGroup.bgra8888
              : ImageFormatGroup.yuv420,
        );

        await controller.initialize();
        if (!context.mounted) {
          controller.dispose();
          return;
        }
        await controller.setFlashMode(flashMode.value);
        await controller.startImageStream(onFrame);

        ctrl.value = controller;
        isInitialized.value = true;
      } catch (e) {
        if (context.mounted) initError.value = e.toString();
      } finally {
        isInitializingRef.value = false;
      }
    }

    Future<void> captureAndProcess() async {
      if (isCapturingRef.value) return;
      final controller = ctrl.value;
      if (controller == null || !controller.value.isInitialized) return;
      final navigator = Navigator.of(context);

      isCapturingRef.value = true;
      phase.value = _ScanPhase.capturing;

      XFile? file;
      try {
        try {
          await controller.stopImageStream();
        } catch (_) {}
        file = await controller.takePicture();
      } catch (_) {
        isCapturingRef.value = false;
        if (context.mounted) {
          phase.value = _ScanPhase.scanning;
          consecutiveHits.value = 0;
        }
        return;
      }

      if (!context.mounted) {
        isCapturingRef.value = false;
        return;
      }
      phase.value = _ScanPhase.processing;
      isDetectingRef.value = false;

      var finalPath = file.path;
      var ocr = const KycOcrResult();

      try {
        final croppedPath = await compute(
          _cropInIsolate,
          _CropArgs(
            sourcePath: file.path,
            outputDir: File(file.path).parent.path,
            screenW: screenSize.width,
            screenH: screenSize.height,
            guideLeft: guideRect.left,
            guideTop: guideRect.top,
            guideWidth: guideRect.width,
            guideHeight: guideRect.height,
          ),
        );
        if (croppedPath != null) finalPath = croppedPath;
      } catch (_) {}

      final ocrService = OcrService();
      try {
        ocr = await ocrService.extract(finalPath);
      } catch (_) {}

      if (!ocr.hasAnyData && finalPath != file.path) {
        try {
          final fullOcr = await ocrService.extract(file.path);
          if (fullOcr.hasAnyData) ocr = fullOcr;
        } catch (_) {}
      }

      isCapturingRef.value = false;
      if (context.mounted) {
        navigator.pop(KycCaptureResult(imagePath: finalPath, ocr: ocr));
      }
    }

    Future<void> cycleFlash() async {
      final modes = [FlashMode.off, FlashMode.torch];
      flashMode.value = modes[(modes.indexOf(flashMode.value) + 1) % modes.length];
      await ctrl.value?.setFlashMode(flashMode.value);
    }

    // ── Effects ──────────────────────────────────────────────────────────────

    useEffect(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      pulseCtrl.repeat(reverse: true);
      initCamera();
      return () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        ctrl.value?.dispose();
      };
    }, const []);

    useEffect(() {
      final observer = _LifecycleObserver((state) {
        if (state == AppLifecycleState.inactive) {
          ctrl.value?.dispose();
          ctrl.value = null;
          isInitialized.value = false;
        } else if (state == AppLifecycleState.resumed) {
          initCamera();
        }
      });
      WidgetsBinding.instance.addObserver(observer);
      return () => WidgetsBinding.instance.removeObserver(observer);
    }, const []);

    // ── UI ────────────────────────────────────────────────────────────────────

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (isInitialized.value && ctrl.value != null)
            _CameraFill(controller: ctrl.value!)
          else if (initError.value != null)
            CameraInitErrorView(
              message: initError.value!,
              onRetry: initCamera,
            )
          else
            const Center(
              child: CircularProgressIndicator(color: AppColors.brandYellow),
            ),

          if (isInitialized.value)
            AnimatedBuilder(
              animation: pulseAnim,
              builder: (context, child) => CustomPaint(
                painter: _CardOverlayPainter(
                  guideRect: guideRect,
                  phase: phase.value,
                  score: detectionScore.value,
                  pulse: pulseAnim.value,
                ),
              ),
            ),

          if (phase.value == _ScanPhase.processing)
            Container(
              color: Colors.black87,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.brandYellow,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'kyc.camera.processing'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _TopBar(
              isFront: isFront,
              flashMode: flashMode.value,
              canFlash: isInitialized.value,
              onClose: () => Navigator.of(context).pop(null),
              onFlash: cycleFlash,
            ),
          ),

          if (isInitialized.value && phase.value != _ScanPhase.processing)
            Positioned(
              top: guideRect.top - 52.h,
              left: 0,
              right: 0,
              child: Center(child: _GuideLabel(phase: phase.value)),
            ),

          if (isInitialized.value && phase.value != _ScanPhase.processing)
            Positioned(
              top: guideRect.bottom + 16.h,
              left: 24.w,
              right: 24.w,
              child: _StatusBar(phase: phase.value),
            ),

          if (isInitialized.value &&
              phase.value != _ScanPhase.capturing &&
              phase.value != _ScanPhase.processing)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 36.h,
              left: 0,
              right: 0,
              child: Center(
                child: _CaptureButton(
                  phase: phase.value,
                  onTap: captureAndProcess,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Lifecycle observer helper ──────────────────────────────────────────────────

class _LifecycleObserver extends WidgetsBindingObserver {
  final void Function(AppLifecycleState) onStateChange;

  _LifecycleObserver(this.onStateChange);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) =>
      onStateChange(state);
}

// ── Scan phase ─────────────────────────────────────────────────────────────────

enum _ScanPhase { scanning, aligned, capturing, processing }

// ── iOS frame detection isolate ───────────────────────────────────────────────

class _FrameIosArgs {
  final Uint8List bytes;
  final int width;
  final int height;
  final int bytesPerRow;
  final String outputDir;

  const _FrameIosArgs({
    required this.bytes,
    required this.width,
    required this.height,
    required this.bytesPerRow,
    required this.outputDir,
  });
}

Future<String?> _saveIosFrameJpeg(_FrameIosArgs a) async {
  try {
    final Uint8List packed;
    if (a.bytesPerRow == a.width * 4) {
      packed = a.bytes;
    } else {
      packed = Uint8List(a.width * a.height * 4);
      for (var row = 0; row < a.height; row++) {
        packed.setRange(
          row * a.width * 4,
          (row + 1) * a.width * 4,
          a.bytes,
          row * a.bytesPerRow,
        );
      }
    }
    final frame = img.Image.fromBytes(
      width: a.width,
      height: a.height,
      bytes: packed.buffer,
      format: img.Format.uint8,
      order: img.ChannelOrder.bgra,
    );
    // 320px was too small for Vision to reliably read card text. 960 keeps the
    // (throttled, ~1/sec) per-frame OCR affordable while giving the recognizer
    // enough detail to read the glossy EID front, whose smaller/glare-washed
    // text was getting lost at lower resolutions.
    final small = img.copyResize(frame, width: 960);
    final jpeg = img.encodeJpg(small, quality: 85);
    final path =
        '${a.outputDir}/det_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(path).writeAsBytes(jpeg);
    return path;
  } catch (_) {
    return null;
  }
}

// ── Crop isolate ──────────────────────────────────────────────────────────────

class _CropArgs {
  final String sourcePath;
  final String outputDir;
  final double screenW;
  final double screenH;
  final double guideLeft;
  final double guideTop;
  final double guideWidth;
  final double guideHeight;

  const _CropArgs({
    required this.sourcePath,
    required this.outputDir,
    required this.screenW,
    required this.screenH,
    required this.guideLeft,
    required this.guideTop,
    required this.guideWidth,
    required this.guideHeight,
  });
}

Future<String?> _cropInIsolate(_CropArgs a) async {
  try {
    final bytes = await File(a.sourcePath).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return null;

    final captureW = decoded.width.toDouble();
    final captureH = decoded.height.toDouble();

    final scale = math.max(a.screenW / captureW, a.screenH / captureH);
    final offsetX = (captureW * scale - a.screenW) / 2;
    final offsetY = (captureH * scale - a.screenH) / 2;

    int x = ((a.guideLeft + offsetX) / scale).round();
    int y = ((a.guideTop + offsetY) / scale).round();
    int w = (a.guideWidth / scale).round();
    int h = (a.guideHeight / scale).round();

    x = x.clamp(0, decoded.width - 1);
    y = y.clamp(0, decoded.height - 1);
    w = w.clamp(1, decoded.width - x);
    h = h.clamp(1, decoded.height - y);

    final cropped = img.copyCrop(decoded, x: x, y: y, width: w, height: h);
    final outBytes = img.encodeJpg(cropped, quality: 92);
    final outPath =
        '${a.outputDir}/kyc_card_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(outPath).writeAsBytes(outBytes);
    return outPath;
  } catch (_) {
    return null;
  }
}

// ── Camera fill ────────────────────────────────────────────────────────────────

class _CameraFill extends StatelessWidget {
  final CameraController controller;

  const _CameraFill({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: 1,
            height: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );
  }
}

// ── Card overlay painter ───────────────────────────────────────────────────────

class _CardOverlayPainter extends CustomPainter {
  final Rect guideRect;
  final _ScanPhase phase;
  final double score;
  final double pulse;

  const _CardOverlayPainter({
    required this.guideRect,
    required this.phase,
    required this.score,
    required this.pulse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xBB000000),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(guideRect, Radius.circular(12)),
      Paint()..blendMode = BlendMode.clear,
    );
    canvas.restore();

    final Color baseColor;
    if (phase == _ScanPhase.aligned || phase == _ScanPhase.capturing) {
      baseColor = AppColors.success;
    } else {
      baseColor = Color.lerp(
        AppColors.brandYellow,
        AppColors.brandYellow.withValues(alpha: 0.5),
        pulse,
      )!;
    }

    final strokeWidth =
        phase == _ScanPhase.aligned ? 3.0 + pulse * 1.5 : 2.5;
    final paint = Paint()
      ..color = baseColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const len = 22.0;
    _corner(canvas, paint, guideRect.topLeft, 1, 1, len);
    _corner(canvas, paint, guideRect.topRight, -1, 1, len);
    _corner(canvas, paint, guideRect.bottomLeft, 1, -1, len);
    _corner(canvas, paint, guideRect.bottomRight, -1, -1, len);

    if (phase == _ScanPhase.aligned || phase == _ScanPhase.capturing) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(guideRect, Radius.circular(12)),
        Paint()
          ..color = AppColors.success.withValues(alpha: 0.25 + pulse * 0.15)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
      );
    }
  }

  void _corner(Canvas c, Paint p, Offset o, double dx, double dy, double l) {
    c.drawLine(o, o + Offset(dx * l, 0), p);
    c.drawLine(o, o + Offset(0, dy * l), p);
  }

  @override
  bool shouldRepaint(_CardOverlayPainter old) =>
      old.phase != phase || old.score != score || old.pulse != pulse;
}

// ── Top bar ────────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final bool isFront;
  final FlashMode flashMode;
  final bool canFlash;
  final VoidCallback onClose;
  final VoidCallback onFlash;

  const _TopBar({
    required this.isFront,
    required this.flashMode,
    required this.canFlash,
    required this.onClose,
    required this.onFlash,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black87, Colors.transparent],
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 6.h,
        left: 8.w,
        right: 8.w,
        bottom: 14.h,
      ),
      child: Row(
        children: [
          _Btn(icon: Icons.close_rounded, onTap: onClose),
          const Spacer(),
          Text(
            isFront
                ? 'kyc.camera.title.front'.tr()
                : 'kyc.camera.title.back'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const Spacer(),
          if (canFlash)
            _Btn(
              icon: flashMode == FlashMode.off
                  ? Icons.flash_off_rounded
                  : Icons.flashlight_on_rounded,
              onTap: onFlash,
              active: flashMode != FlashMode.off,
            )
          else
            SizedBox(width: 44.w),
        ],
      ),
    );
  }
}

// ── Guide label ───────────────────────────────────────────────────────────────

class _GuideLabel extends StatelessWidget {
  final _ScanPhase phase;

  const _GuideLabel({required this.phase});

  @override
  Widget build(BuildContext context) {
    final text = switch (phase) {
      _ScanPhase.scanning => 'kyc.camera.guide.scanning'.tr(),
      _ScanPhase.aligned => 'kyc.camera.guide.aligned'.tr(),
      _ScanPhase.capturing => 'kyc.camera.guide.capturing'.tr(),
      _ScanPhase.processing => '',
    };

    final color = phase == _ScanPhase.aligned ? AppColors.success : Colors.white;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(phase),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 13.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ── Status bar ─────────────────────────────────────────────────────────────────

class _StatusBar extends StatelessWidget {
  final _ScanPhase phase;

  const _StatusBar({required this.phase});

  @override
  Widget build(BuildContext context) {
    if (phase == _ScanPhase.scanning) {
      return Text(
        'kyc.camera.status.scanning'.tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white54,
          fontSize: 12.sp,
          fontFamily: 'Inter',
        ),
      );
    }
    if (phase == _ScanPhase.aligned) {
      return Text(
        'kyc.camera.status.aligned'.tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.success,
          fontSize: 12.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

// ── Capture button ─────────────────────────────────────────────────────────────

class _CaptureButton extends StatelessWidget {
  final _ScanPhase phase;
  final VoidCallback onTap;

  const _CaptureButton({required this.phase, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isAligned = phase == _ScanPhase.aligned;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isAligned ? AppColors.success : AppColors.brandYellow,
                width: 2.5,
              ),
            ),
          ),
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAligned ? AppColors.success : Colors.white,
            ),
            child: isAligned
                ? Icon(Icons.check_rounded, color: Colors.white, size: 24.sp)
                : null,
          ),
        ],
      ),
    );
  }
}

// ── Generic icon button ────────────────────────────────────────────────────────

class _Btn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool active;

  const _Btn({required this.icon, required this.onTap, this.active = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black45,
        ),
        child: Icon(
          icon,
          color: active ? AppColors.brandYellow : Colors.white,
          size: 22.sp,
        ),
      ),
    );
  }
}