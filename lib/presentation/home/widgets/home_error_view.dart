import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/button/app_button.dart';
import '../../core/theme/app_theme_ext.dart';

/// Full-screen error state for the home screen when a mandatory first-load API
/// fails. Rendered over the brand gradient supplied by [AppScaffold].
///
/// Richer than the shared [AppErrorView]: a custom, softly-pulsing connection
/// badge (a "cloud off" glyph — signalling a data-load issue, not a rejected
/// transaction), headline + supportive copy, a prominent retry CTA, and a
/// bank-grade-security reassurance line to keep trust intact during an outage.
class HomeErrorView extends HookWidget {
  final VoidCallback onRetry;

  const HomeErrorView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final appColors = context.appColors;

    // Gentle continuous "breathing" pulse for the halo ring — keeps the screen
    // feeling alive without the alarm of a hard error animation.
    final pulseController = useAnimationController(
      duration: const Duration(milliseconds: 2200),
    );
    useEffect(() {
      pulseController.repeat();
      return null;
    }, const []);
    final pulse = useAnimation(
      CurvedAnimation(parent: pulseController, curve: Curves.easeOut),
    );

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 440),
      curve: Curves.easeOutCubic,
      builder: (_, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, 20.h * (1 - t)),
          child: child,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ErrorBadge(pulse: pulse),
              SizedBox(height: 20.h),
              Text(
                'network.error.dataLoadTitle'.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'network.error.dataLoadDescription'.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: appColors.muted,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              AppButton(
                text: 'network.error.retryButton'.tr(),
                onTap: onRetry,
                width: 220.w,
                height: 50.h,
                backgroundColor: appColors.brandFill,
                sideWidget: Icon(
                  Icons.refresh_rounded,
                  size: 20.sp,
                  color: appColors.onAccent,
                ),
                textStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: appColors.onAccent,
                ),
              ),
              SizedBox(height: 14.h),
              // Trust reassurance — an outage must not read as a security issue.
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 14.sp,
                    color: appColors.muted,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'home.trust.secure.subtitle'.tr(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 11.sp,
                      color: appColors.muted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Branded connection-failure badge: an expanding pulse ring, a soft tonal
/// disc, and a rounded "cloud off" glyph — deliberately calmer than a red X.
class _ErrorBadge extends StatelessWidget {
  final double pulse; // 0 → 1, repeating

  const _ErrorBadge({required this.pulse});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      width: 132.w,
      height: 132.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Expanding, fading pulse ring.
          Transform.scale(
            scale: 0.7 + 0.5 * pulse,
            child: Container(
              width: 132.w,
              height: 132.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: appColors.error.withValues(alpha: 0.28 * (1 - pulse)),
                  width: 1.4,
                ),
              ),
            ),
          ),
          // Static soft halo.
          Container(
            width: 108.w,
            height: 108.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  appColors.error.withValues(alpha: 0.14),
                  appColors.error.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          // Tonal disc holding the glyph.
          Container(
            width: 84.w,
            height: 84.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  appColors.error.withValues(alpha: 0.22),
                  appColors.error.withValues(alpha: 0.10),
                ],
              ),
              border: Border.all(
                color: appColors.error.withValues(alpha: 0.35),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: appColors.error.withValues(alpha: 0.18),
                  blurRadius: 20,
                  spreadRadius: -4,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              Icons.cloud_off_rounded,
              size: 40.sp,
              color: Color.lerp(appColors.error, cs.onSurface, 0.15),
            ),
          ),
        ],
      ),
    );
  }
}