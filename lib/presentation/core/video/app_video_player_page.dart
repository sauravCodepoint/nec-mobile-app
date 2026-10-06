import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

// Full-screen camera/video overlay: renders on a black surface in both themes,
// so it deliberately uses the fixed brand palette instead of theme tokens.
import '../colors/app_colors.dart';

class AppVideoPlayerPage extends HookWidget {
  final String videoPath;
  const AppVideoPlayerPage({super.key, required this.videoPath});

  static Future<void> show(BuildContext context, String videoPath) =>
      Navigator.of(context).push<void>(
        PageRouteBuilder(
          fullscreenDialog: true,
          pageBuilder: (_, __, ___) =>
              AppVideoPlayerPage(videoPath: videoPath),
          transitionsBuilder: (_, anim, __, child) => FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 250),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => VideoPlayerController.file(File(videoPath)),
    );
    final isInitialized = useState(false);
    final isPlaying = useState(false);
    final position = useState(Duration.zero);
    final duration = useState(Duration.zero);
    final showControls = useState(true);
    final hideControlsTimer = useRef<DateTime?>(null);

    useEffect(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      controller.initialize().then((_) {
        if (context.mounted) {
          isInitialized.value = true;
          duration.value = controller.value.duration;
          controller.play();
          isPlaying.value = true;
        }
      });

      void listener() {
        if (!context.mounted) return;
        position.value = controller.value.position;
        isPlaying.value = controller.value.isPlaying;

        // Loop when finished
        if (controller.value.position >= controller.value.duration &&
            controller.value.duration > Duration.zero) {
          controller.seekTo(Duration.zero);
          controller.pause();
          isPlaying.value = false;
          showControls.value = true;
        }
      }

      controller.addListener(listener);

      return () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        controller.removeListener(listener);
        controller.dispose();
      };
    }, const []);

    void togglePlayPause() {
      if (controller.value.isPlaying) {
        controller.pause();
        showControls.value = true;
      } else {
        controller.play();
        showControls.value = true;
        // Auto-hide controls after 2s
        final now = DateTime.now();
        hideControlsTimer.value = now;
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted &&
              hideControlsTimer.value == now &&
              controller.value.isPlaying) {
            showControls.value = false;
          }
        });
      }
    }

    void onTapScreen() {
      showControls.value = !showControls.value;
      if (showControls.value && controller.value.isPlaying) {
        final now = DateTime.now();
        hideControlsTimer.value = now;
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted &&
              hideControlsTimer.value == now &&
              controller.value.isPlaying) {
            showControls.value = false;
          }
        });
      }
    }

    String formatDuration(Duration d) {
      final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
      final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$m:$s';
    }

    final safeTop = MediaQuery.of(context).padding.top;
    final safeBottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTapScreen,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Video ─────────────────────────────────────────────────────
            if (isInitialized.value)
              Center(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: AppColors.brandYellow),
              ),

            // ── Controls overlay ──────────────────────────────────────────
            AnimatedOpacity(
              opacity: showControls.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                    stops: const [0.0, 0.2, 0.75, 1.0],
                  ),
                ),
              ),
            ),

            // ── Top bar ───────────────────────────────────────────────────
            if (showControls.value)
              Positioned(
                top: safeTop + 8.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close_rounded,
                            color: Colors.white, size: 20.sp),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'core.videoPlayer.selfieTitle'.tr(),
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

            // ── Centre play/pause button ──────────────────────────────────
            if (showControls.value && isInitialized.value)
              Center(
                child: GestureDetector(
                  onTap: togglePlayPause,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 68.w,
                    height: 68.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.55),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.8),
                          width: 2.w),
                    ),
                    child: Icon(
                      isPlaying.value
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 34.sp,
                    ),
                  ),
                ),
              ),

            // ── Bottom progress bar ───────────────────────────────────────
            if (showControls.value && isInitialized.value)
              Positioned(
                bottom: safeBottom + 24.h,
                left: 20.w,
                right: 20.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Seek bar
                    GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        final box = context.findRenderObject() as RenderBox;
                        final dx =
                            details.localPosition.dx.clamp(0, box.size.width);
                        final ratio = dx / box.size.width;
                        final seek = Duration(
                          milliseconds:
                              (duration.value.inMilliseconds * ratio).round(),
                        );
                        controller.seekTo(seek);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3.r),
                        child: VideoProgressIndicator(
                          controller,
                          allowScrubbing: true,
                          padding: EdgeInsets.zero,
                          colors: VideoProgressColors(
                            playedColor: AppColors.brandYellow,
                            bufferedColor: Colors.white24,
                            backgroundColor: Colors.white12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(position.value),
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          formatDuration(duration.value),
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}