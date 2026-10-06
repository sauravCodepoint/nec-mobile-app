import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme_ext.dart';

/// Full-screen "updating" indicator: accent rings ripple outward from a central
/// people badge over a soft frosted veil, evoking a live sync of a list. Use in
/// place of a plain spinner when refreshing content that's already on screen.
///
/// Returns a [Positioned.fill], so add it directly as a child of a [Stack]
/// (do not wrap it in another widget such as [AnimatedSwitcher]).
class UpdatingOverlay extends HookWidget {
  final String message;

  const UpdatingOverlay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 2000),
    );
    useEffect(() {
      controller.repeat();
      return null;
    }, const []);

    final accent = context.colorScheme.tertiary;
    final cs = Theme.of(context).colorScheme;

    return Positioned.fill(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        builder: (_, fade, child) => Opacity(opacity: fade, child: child),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: ColoredBox(
            color: cs.scrim.withValues(alpha: 0.22),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 150.w,
                    height: 150.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: controller,
                          builder: (context, _) => CustomPaint(
                            size: Size(150.w, 150.w),
                            painter: _PingPainter(
                              progress: controller.value,
                              color: accent,
                            ),
                          ),
                        ),
                        // Central people badge with a gentle breathing pulse.
                        AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            // 0→1→0 triangle wave → a soft 1.0↔1.06 breathe.
                            final wave = 1 - (controller.value * 2 - 1).abs();
                            return Transform.scale(
                              scale: 1 + 0.06 * wave,
                              child: child,
                            );
                          },
                          child: Container(
                            width: 56.w,
                            height: 56.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.appColors.containerBackground
                                  .withValues(alpha: 0.95),
                              border: Border.all(
                                color: accent.withValues(alpha: 0.35),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: accent.withValues(alpha: 0.25),
                                  blurRadius: 16.r,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.people_alt_rounded,
                              color: accent,
                              size: 26.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints accent rings, each expanding from just outside the central badge and
/// fading as it grows, evenly phase-offset so a new ripple starts as one fades.
class _PingPainter extends CustomPainter {
  final double progress;
  final Color color;

  _PingPainter({required this.progress, required this.color});

  static const _ringCount = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.width / 2;
    final minRadius = size.width * 0.22;

    for (var i = 0; i < _ringCount; i++) {
      final t = (progress + i / _ringCount) % 1.0;
      final e = Curves.easeOut.transform(t);
      final alpha = (1 - e) * 0.8;
      if (alpha <= 0.01) continue;
      canvas.drawCircle(
        center,
        minRadius + (maxRadius - minRadius) * e,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..color = color.withValues(alpha: alpha)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.6),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}