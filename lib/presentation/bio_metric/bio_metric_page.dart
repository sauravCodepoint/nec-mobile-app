import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/bio_metric/bio_metric_bloc.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/button/app_button.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/theme/app_theme_ext.dart';
import '../routes/app_routes.gr.dart';

@RoutePage()
class BioMetricPage extends HookWidget {
  const BioMetricPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hasChecked = useState(false);

    final entranceCtrl = useAnimationController(
      duration: const Duration(milliseconds: 950),
    );

    useEffect(() {
      context.read<BioMetricBloc>().add(const BioMetricEvent.checkSupport());
      entranceCtrl.forward();
      return null;
    }, const []);

    return BlocConsumer<BioMetricBloc, BioMetricState>(
      listener: (context, state) {
        if (!hasChecked.value) hasChecked.value = true;
        if (state.isBiometricEnabled) {
          context.router.replaceAll([const MainRoute()]);
        }
      },
      builder: (context, state) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final isUnavailable = hasChecked.value && !state.isBiometricAvailable;

        return AppScaffold(
          appBar: AppAppBar(title: 'bioMetric.title'.tr()),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          SizedBox(height: 32.h),
                          _Reveal(
                            parent: entranceCtrl,
                            interval: const Interval(
                              0.00,
                              0.50,
                              curve: Curves.easeOutCubic,
                            ),
                            child: _BiometricHero(dimmed: isUnavailable),
                          ),
                          SizedBox(height: 40.h),
                          _Reveal(
                            parent: entranceCtrl,
                            interval: const Interval(
                              0.15,
                              0.65,
                              curve: Curves.easeOutCubic,
                            ),
                            child: Text(
                              'bioMetric.heading'.tr(),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _Reveal(
                            parent: entranceCtrl,
                            interval: const Interval(
                              0.25,
                              0.75,
                              curve: Curves.easeOutCubic,
                            ),
                            child: Text(
                              'bioMetric.description'.tr(),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 14.sp,
                                height: 1.5,
                                color: context.appColors.muted,
                              ),
                            ),
                          ),
                          if (isUnavailable) ...[
                            SizedBox(height: 12.h),
                            Text(
                              'bioMetric.unavailable'.tr(),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 12.sp,
                                color: context.appColors.error,
                              ),
                            ),
                          ],
                          const Spacer(),
                          _Reveal(
                            parent: entranceCtrl,
                            interval: const Interval(
                              0.45,
                              1.00,
                              curve: Curves.easeOutCubic,
                            ),
                            child: Column(
                              children: [
                                AppButton(
                                  onTap: isUnavailable || state.isAuthenticating
                                      ? null
                                      : () => context.read<BioMetricBloc>().add(
                                          const BioMetricEvent.enable(),
                                        ),
                                  isLoading: state.isAuthenticating,
                                  text: 'bioMetric.enableNow'.tr(),
                                  useSpaceBetween: true,
                                  sideWidgetPosition: SideWidgetPosition.right,
                                  sideWidget: state.isAuthenticating
                                      ? null
                                      : Icon(
                                          Icons.fingerprint_rounded,
                                          size: 26.sp,
                                          color: colorScheme.primary,
                                        ),
                                  textStyle: theme.textTheme.bodyMedium
                                      ?.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.primary,
                                      ),
                                ),
                                SizedBox(height: 16.h),
                                AppButton(
                                  onTap: () {
                                    context.router.replaceAll([
                                      const MainRoute(),
                                    ]);
                                  },
                                  backgroundColor:
                                      context.appColors.containerBackground,
                                  border: Border.all(
                                    color: colorScheme.tertiary,
                                    width: .75.w,
                                  ),
                                  text: 'bioMetric.maybeLater'.tr(),
                                  textStyle: theme.textTheme.bodyMedium
                                      ?.copyWith(
                                        color: colorScheme.tertiary,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Entrance reveal (fade + slide, one shared controller with intervals)
// ─────────────────────────────────────────────────────────────────────────────

class _Reveal extends StatelessWidget {
  final AnimationController parent;
  final Interval interval;
  final Widget child;

  const _Reveal({
    required this.parent,
    required this.interval,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final drive = CurvedAnimation(parent: parent, curve: interval);
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(drive);

    return FadeTransition(
      opacity: drive,
      child: SlideTransition(position: slide, child: child),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Biometric hero — ripple rings + scanning arc around a breathing fingerprint.
//
// Performance notes:
//  - The rings/arc live in one CustomPainter that repaints via the controller's
//    `repaint` listenable — no widget rebuilds per frame.
//  - The icon breathes through a ScaleTransition (render-object level).
//  - The whole hero sits behind a RepaintBoundary so its 60-fps repaints never
//    invalidate the rest of the page.
// ─────────────────────────────────────────────────────────────────────────────

class _BiometricHero extends HookWidget {
  /// True when biometrics are unavailable — the hero renders muted and still.
  final bool dimmed;

  const _BiometricHero({required this.dimmed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accent = dimmed ? context.appColors.muted : colorScheme.tertiary;

    final rippleCtrl = useAnimationController(
      duration: const Duration(milliseconds: 2600),
    );
    final breatheCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1900),
    );

    useEffect(() {
      rippleCtrl.repeat();
      breatheCtrl.repeat(reverse: true);
      return null;
    }, const []);

    // Freeze the ambient motion when the feature is unavailable.
    useEffect(() {
      if (dimmed) {
        rippleCtrl.stop();
        breatheCtrl.stop();
      } else {
        rippleCtrl.repeat();
        breatheCtrl.repeat(reverse: true);
      }
      return null;
    }, [dimmed]);

    final breathe = useMemoized(
      () => Tween<double>(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: breatheCtrl, curve: Curves.easeInOut),
      ),
      [breatheCtrl],
    );

    return RepaintBoundary(
      child: SizedBox(
        width: 220.r,
        height: 220.r,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _RippleScanPainter(ripple: rippleCtrl, color: accent),
              ),
            ),
            ScaleTransition(
              scale: breathe,
              child: Container(
                width: 132.r,
                height: 132.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      accent.withValues(alpha: 0.18),
                      accent.withValues(alpha: 0.05),
                    ],
                  ),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.3),
                    width: 1.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: dimmed ? 0.0 : 0.14),
                      blurRadius: 34,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.fingerprint_rounded,
                  size: 68.sp,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RippleScanPainter extends CustomPainter {
  final Animation<double> ripple;
  final Color color;

  _RippleScanPainter({required this.ripple, required this.color})
      : super(repaint: ripple);

  static const _ringCount = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.shortestSide / 2;
    // Edge of the icon circle (132/220 of the hero) — rings are born here.
    final baseRadius = maxRadius * 0.60;

    // ── Expanding ripple rings, staggered thirds of the loop ───────────────
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (var i = 0; i < _ringCount; i++) {
      final t = (ripple.value + i / _ringCount) % 1.0;
      final radius = baseRadius + (maxRadius - baseRadius) * t;
      ringPaint.color = color.withValues(alpha: (1 - t) * 0.30);
      canvas.drawCircle(center, radius, ringPaint);
    }

    // ── Scanner orbit: faint track + two rotating arcs ──────────────────────
    final orbitRadius = baseRadius * 1.18;
    final orbitRect = Rect.fromCircle(center: center, radius: orbitRadius);

    canvas.drawCircle(
      center,
      orbitRadius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = color.withValues(alpha: 0.08),
    );

    final angle = ripple.value * 2 * math.pi;
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    arcPaint.color = color.withValues(alpha: 0.55);
    canvas.drawArc(orbitRect, angle, 1.1, false, arcPaint);

    arcPaint.color = color.withValues(alpha: 0.22);
    canvas.drawArc(orbitRect, angle + math.pi, 0.7, false, arcPaint);
  }

  @override
  bool shouldRepaint(_RippleScanPainter old) => old.color != color;
}