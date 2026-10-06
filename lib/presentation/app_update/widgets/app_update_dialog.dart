import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/app_update/app_update_dto.dart';
import '../../../domain/core/di/injection.dart';
import '../../core/button/app_button.dart';
import '../../core/theme/app_theme_ext.dart';
import '../../routes/app_routes.dart';
import '../app_update_gate.dart';

/// Dedicated "new version available" prompt. For a force update the dialog
/// cannot be dismissed — the only way forward is the store link.
///
/// Motion design: the card lands with the shared fade + spring scale, then the
/// content staggers in (badge → title → message → version → actions) while the
/// badge keeps a gentle looping pulse so the dialog feels alive without being
/// noisy.
class AppUpdateDialog extends HookWidget {
  final AppUpdateDataDto data;
  final String currentVersion;

  const AppUpdateDialog({
    super.key,
    required this.data,
    required this.currentVersion,
  });

  /// Context-free entry point (same navigator-key pattern as [AppNotify]) so
  /// the dialog can be shown from a top-level BlocListener regardless of
  /// which screen the splash routed to.
  static Future<void> show(AppUpdateDataDto data) async {
    final navigatorState = getIt<AppRouter>().navigatorKey.currentState;
    if (navigatorState == null) return;

    final packageInfo = await PackageInfo.fromPlatform();

    // Flip the global gate *before* the dialog is on screen so the MPIN auth
    // flow can't slip past a mandatory update via an in-flight biometric
    // prompt (see [AppUpdateGate]). Stays set for the session.
    if (data.isForceUpdate) AppUpdateGate.forceUpdateActive = true;

    await navigatorState.push(
      RawDialogRoute<void>(
        barrierDismissible: false,
        barrierLabel: 'App update',
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 440),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Stack(
            children: [
              IgnorePointer(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: ColoredBox(
                    color: Colors.black.withValues(alpha: 0.31),
                  ),
                ),
              ),
              Center(
                child: AppUpdateDialog(
                  data: data,
                  currentVersion: packageInfo.version,
                ),
              ),
            ],
          );
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: ScaleTransition(
              scale: Tween(begin: 0.86, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.elasticOut),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchStore() async {
    final url = data.updateUrl;
    if (url == null || url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final appColors = context.appColors;

    // One pass over the content sections; each _Stagger below picks a slice.
    final stagger = useAnimationController(
      duration: const Duration(milliseconds: 1100),
    );
    // Continuous, slow loop shared by the badge pulse, the icon bob and the
    // version-arrow nudge so all idle motion stays in phase.
    final pulse = useAnimationController(
      duration: const Duration(milliseconds: 2200),
    );
    useEffect(() {
      stagger.forward();
      pulse.repeat();
      return null;
    }, const []);

    final title = (data.title?.trim().isNotEmpty ?? false)
        ? data.title!
        : 'appUpdate.title'.tr();
    final message = (data.message?.trim().isNotEmpty ?? false)
        ? data.message!
        : 'appUpdate.message'.tr();

    return PopScope(
      canPop: !data.isForceUpdate,
      child: Dialog(
        elevation: 0,
        backgroundColor: context.appColors.containerBackground,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            color: context.appColors.glassBorder.withValues(alpha: 0.24),
            width: 0.8,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              // Ambient brand glow bleeding in from behind the badge.
              Positioned(
                top: -70.h,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Center(
                    child: Container(
                      width: 240.w,
                      height: 240.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            cs.tertiary.withValues(alpha: 0.10),
                            cs.tertiary.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _Stagger(
                      controller: stagger,
                      from: 0.0,
                      child: _PulsingBadge(pulse: pulse, color: cs.tertiary),
                    ),
                    SizedBox(height: 20.h),
                    _Stagger(
                      controller: stagger,
                      from: 0.18,
                      child: Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _Stagger(
                      controller: stagger,
                      from: 0.28,
                      child: Text(
                        message,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _Stagger(
                      controller: stagger,
                      from: 0.40,
                      child: _VersionRow(
                        pulse: pulse,
                        currentVersion: currentVersion,
                        latestVersion: data.latestVersion,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _Stagger(
                      controller: stagger,
                      from: 0.52,
                      child: AppButton(
                        text: 'appUpdate.updateNow'.tr(),
                        onTap: _launchStore,
                      ),
                    ),
                    if (!data.isForceUpdate) ...[
                      SizedBox(height: 12.h),
                      _Stagger(
                        controller: stagger,
                        from: 0.64,
                        child: _LaterButton(
                          onTap: () => Navigator.of(context).pop(),
                          muted: appColors.muted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

/// Fade + slide-up entrance for one content section, sliced out of the shared
/// stagger controller via an Interval starting at [from].
class _Stagger extends StatelessWidget {
  final AnimationController controller;
  final double from;
  final Widget child;

  const _Stagger({
    required this.controller,
    required this.from,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(
        from,
        math.min(from + 0.42, 1.0),
        curve: Curves.easeOutCubic,
      ),
    );
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.22),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

/// Brand-yellow badge with a looping halo pulse and a gently bobbing update
/// arrow.
class _PulsingBadge extends StatelessWidget {
  final Animation<double> pulse;
  final Color color;

  const _PulsingBadge({required this.pulse, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.w,
      child: AnimatedBuilder(
        animation: pulse,
        builder: (context, _) {
          final t = pulse.value;
          // Full sine cycle so the loop has no visible restart seam.
          final bob = math.sin(t * 2 * math.pi) * 2.5.h;
          return Stack(
            alignment: Alignment.center,
            children: [
              // Expanding halo ring that fades as it grows.
              Transform.scale(
                scale: 0.9 + 0.35 * t,
                child: Container(
                  width: 76.w,
                  height: 76.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color.withValues(alpha: 0.30 * (1 - t)),
                      width: 1.2.w,
                    ),
                  ),
                ),
              ),
              Container(
                width: 76.w,
                height: 76.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 58.w,
                height: 58.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: 0.22),
                    width: 1.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.24),
                      blurRadius: 18,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Transform.translate(
                  offset: Offset(0, bob),
                  child: Icon(
                    Icons.system_update_alt_rounded,
                    color: color,
                    size: 26.w,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

/// "current → latest" version pill with a softly nudging arrow.
class _VersionRow extends StatelessWidget {
  final Animation<double> pulse;
  final String currentVersion;
  final String? latestVersion;

  const _VersionRow({
    required this.pulse,
    required this.currentVersion,
    this.latestVersion,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final muted = context.appColors.muted;
    // easy_localization re-exports intl's TextDirection, so qualify Flutter's.
    final isRtl = Directionality.of(context) == ui.TextDirection.rtl;

    final hasLatest = latestVersion?.trim().isNotEmpty ?? false;

    final versionStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: cs.outline, width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('v$currentVersion', style: versionStyle?.copyWith(color: muted)),
          if (hasLatest) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: AnimatedBuilder(
                animation: pulse,
                builder: (context, child) {
                  // Nudge towards the newer version; mirrored under RTL.
                  final nudge = math.sin(pulse.value * 2 * math.pi) * 1.8.w;
                  return Transform.translate(
                    offset: Offset(isRtl ? -nudge : nudge, 0),
                    child: child,
                  );
                },
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 16.w,
                  color: muted,
                ),
              ),
            ),
            Text(
              'v${latestVersion!.trim()}',
              style: versionStyle?.copyWith(color: cs.tertiary),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

/// Low-emphasis dismiss action — deliberately quieter than the CTA so the
/// store link stays the primary path.
class _LaterButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color muted;

  const _LaterButton({required this.onTap, required this.muted});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 44.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        'appUpdate.later'.tr(),
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: muted,
        ),
      ),
    );
  }
}
