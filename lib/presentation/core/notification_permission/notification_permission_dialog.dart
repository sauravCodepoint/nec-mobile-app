import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/core/di/injection.dart';
import '../../routes/app_routes.dart';
import '../button/app_button.dart';
import '../theme/app_theme_ext.dart';

/// Branded, animated notification-permission dialog.
///
/// Two variants driven by [openSettings]:
///  - false → the pre-permission primer ("Enable" / "Not Now")
///  - true  → the post-denial recovery ("Open Settings" / "Not Now")
///
/// Presented context-free via the global navigator key. Returns `true` when
/// the user accepts (Enable / Open Settings), `false` otherwise.
class NotificationPermissionDialog extends HookWidget {
  const NotificationPermissionDialog({
    super.key,
    required this.openSettings,
    this.messageKey,
  });

  final bool openSettings;

  /// Overrides the default primer message (ignored by the settings variant),
  /// e.g. the approval-specific wording on the member-approval screen.
  final String? messageKey;

  static Future<bool> show({
    required bool openSettings,
    String? messageKey,
  }) async {
    final navigator = getIt<AppRouter>().navigatorKey.currentState;
    if (navigator == null) return false;

    final result = await navigator.push<bool>(
      RawDialogRoute<bool>(
        barrierDismissible: true,
        barrierLabel: 'NotificationPermission',
        barrierColor: Colors.black.withValues(alpha: 0.45),
        transitionDuration: const Duration(milliseconds: 460),
        pageBuilder: (_, _, _) => NotificationPermissionDialog(
          openSettings: openSettings,
          messageKey: messageKey,
        ),
        transitionBuilder: (_, animation, _, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
            reverseCurve: Curves.easeIn,
          );
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.82, end: 1.0).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final accent = cs.tertiary;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(
              decoration: BoxDecoration(
                color: context.appColors.containerBackground.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: accent.withValues(alpha: 0.20),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.appColors.shadowInk.withValues(alpha: 0.45,),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _AnimatedBell(accent: accent),
                    SizedBox(height: 24.h),
                    Text(
                      'notifications.permission.title'.tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      openSettings
                          ? 'notifications.permission.settingsMessage'.tr()
                          : (messageKey ?? 'notifications.permission.message')
                                .tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                        height: 1.5,
                        fontSize: 13.5.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _FeatureRow(
                      accent: accent,
                      icon: Icons.swap_horiz_rounded,
                      label: 'notifications.permission.featureTransfers'.tr(),
                    ),
                    SizedBox(height: 12.h),
                    _FeatureRow(
                      accent: accent,
                      icon: Icons.shield_outlined,
                      label: 'notifications.permission.featureSecurity'.tr(),
                    ),
                    SizedBox(height: 28.h),
                    AppButton(
                      text: openSettings
                          ? 'notifications.permission.openSettingsButton'.tr()
                          : 'notifications.permission.enableButton'.tr(),
                      onTap: () => _close(context, true),
                    ),
                    SizedBox(height: 8.h),
                    TextButton(
                      onPressed: () => _close(context, false),
                      style: TextButton.styleFrom(
                        minimumSize: Size(double.infinity, 44.h),
                        foregroundColor: cs.onSurface.withValues(alpha: 0.55),
                      ),
                      child: Text(
                        'notifications.permission.notNowButton'.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _close(BuildContext context, bool accepted) {
    final navigator = getIt<AppRouter>().navigatorKey.currentState;
    (navigator ?? Navigator.of(context)).pop(accepted);
  }
}

/// A bell haloed by two continuously-expanding ripple rings, with a subtle
/// recurring swing — evokes an incoming notification.
class _AnimatedBell extends HookWidget {
  const _AnimatedBell({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    final ripple = useAnimationController(
      duration: const Duration(milliseconds: 2600),
    );
    final swing = useAnimationController(
      duration: const Duration(milliseconds: 2600),
    );

    useEffect(() {
      ripple.repeat();
      swing.repeat();
      return null;
    }, const []);

    // Two ripples 180° out of phase for a steady pulse.
    final ripPrimary = ripple;
    final ripSecondary = useAnimation(
      Tween<double>(begin: 0, end: 1).animate(ripple),
    );

    // Bell tilts left-right briefly near the start of each cycle, then rests.
    final tilt = useAnimation(
      TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.22), weight: 8),
        TweenSequenceItem(tween: Tween(begin: -0.22, end: 0.22), weight: 10),
        TweenSequenceItem(tween: Tween(begin: 0.22, end: 0.0), weight: 8),
        TweenSequenceItem(tween: ConstantTween(0.0), weight: 74),
      ]).animate(CurvedAnimation(parent: swing, curve: Curves.easeInOut)),
    );

    return SizedBox(
      width: 108.w,
      height: 108.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: ripPrimary,
            builder: (_, _) => CustomPaint(
              size: Size(108.w, 108.w),
              painter: _RipplePainter(
                progresses: [ripPrimary.value, (ripSecondary + 0.5) % 1.0],
                color: accent,
              ),
            ),
          ),
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  accent.withValues(alpha: 0.28),
                  accent.withValues(alpha: 0.10),
                ],
              ),
              border: Border.all(
                color: accent.withValues(alpha: 0.35),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.35),
                  blurRadius: 24,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Transform.rotate(
              angle: tilt,
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.notifications_active_rounded,
                color: accent,
                size: 34.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RipplePainter extends CustomPainter {
  _RipplePainter({required this.progresses, required this.color});

  final List<double> progresses;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final minRadius = size.width * 0.34;
    final maxRadius = size.width * 0.5;

    for (final p in progresses) {
      final radius = lerpDouble(minRadius, maxRadius, p)!;
      final opacity = (1.0 - p) * 0.5;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = color.withValues(alpha: opacity);
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(_RipplePainter oldDelegate) =>
      oldDelegate.progresses != progresses;
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.accent,
    required this.icon,
    required this.label,
  });

  final Color accent;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 34.w,
          height: 34.w,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: accent, size: 18.w),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
            ),
          ),
        ),
      ],
    );
  }
}
