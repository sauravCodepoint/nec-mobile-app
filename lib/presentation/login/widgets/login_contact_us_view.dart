import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/login/login_bloc.dart';
import '../../../domain/login/login_contact_us_dto.dart';
import '../../core/app_bar/app_app_bar.dart';
import '../../core/bottom_sheet/app_action_sheet.dart';
import '../../core/app_states/app_state_view.dart';
import '../../core/notify/app_notify.dart';
import '../../core/overlay_loading/app_overlay_loading.dart';
import '../../core/scaffold/app_scaffold.dart';
import '../../core/theme/app_theme_ext.dart';

@RoutePage()
class LoginContactUsView extends HookWidget {
  const LoginContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Read the locale during build (an inherited-widget lookup) — doing it
    // inside useEffect throws, since that runs in an initState-like phase.
    final languageCode = context.locale.languageCode;
    // Fetch the server-authored, localized contact details; re-fetches if the
    // language changes.
    useEffect(() {
      context.read<LoginBloc>().add(
        LoginEvent.getContactUs(languageCode: languageCode),
      );
      return null;
    }, [languageCode]);

    return AppScaffold(
      appBar: AppAppBar(title: 'contactUs.title'.tr()),
      // Drive the body off the one-shot option (same pattern as branches_page):
      // none() → loading, some(left) → error, some(right) → content.
      body: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) =>
            previous.contactUsFailureOrSuccessOption !=
            current.contactUsFailureOrSuccessOption,
        builder: (context, state) {
          return state.contactUsFailureOrSuccessOption.fold(
            // AppOverlayLoading is a Positioned.fill — it needs a sized Stack
            // ancestor, otherwise it collapses to 0x0 and nothing shows.
            () => const SizedBox.expand(
              child: Stack(children: [AppOverlayLoading()]),
            ),
            (either) => either.fold(
              (failure) => AppErrorView(
                title: 'contactUs.loadError'.tr(),
                subtitle: 'contactUs.loadErrorSubtitle'.tr(),
                retryLabel: 'buttons.retry'.tr(),
                onRetry: () => context.read<LoginBloc>().add(
                  LoginEvent.getContactUs(languageCode: languageCode),
                ),
              ),
              (dto) => _ContactUsContent(data: dto.data),
            ),
          );
        },
      ),
    );
  }
}

// ─── Content ─────────────────────────────────────────────────────────────────

/// The animated, scrollable contact details. Split out from the bloc-consuming
/// [LoginContactUsView] so the entrance-animation hooks live only on the
/// success path (built once the payload lands).
class _ContactUsContent extends HookWidget {
  final ContactUsData? data;
  const _ContactUsContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final header = data?.header;

    // ── One-shot entrance controller ──────────────────────────────────────────
    final ctrl = useAnimationController(
      duration: const Duration(milliseconds: 950),
    );

    // ── Continuous pulse controller (drives only the live indicator) ──────────
    final pulseCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );

    useEffect(() {
      ctrl.forward();
      pulseCtrl.repeat(reverse: true);
      return null;
    }, const []);

    // Channels are driven purely by the API — filtered by is_enabled, dropped
    // when they carry no usable value (there is no local fallback number or
    // address), and ordered by `order`. Memoized so the filter/sort don't
    // re-run on every rebuild.
    final channels = useMemoized(() {
      final backendChannels = data?.channels ?? const <ContactChannel>[];
      return backendChannels
          .where(
            (c) =>
                (c.isEnabled ?? true) &&
                (c.value?.any((v) => v.trim().isNotEmpty) ?? false),
          )
          .toList()
        ..sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
    }, [data]);

    // useMemoized prevents new CurvedAnimation instances on every rebuild.
    final aHero = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.00, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    final aSection = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.22, 0.66, curve: Curves.easeOutCubic),
      ),
    );
    // Card entrances are staggered by index so a variable channel count from
    // the backend keeps the cascade instead of hard-coding three intervals.
    final cardAnims = useMemoized(() {
      return List.generate(channels.length, (i) {
        final start = (0.32 + i * 0.12).clamp(0.0, 1.0);
        final end = (start + 0.42).clamp(0.0, 1.0);
        return CurvedAnimation(
          parent: ctrl,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        );
      });
    }, [channels.length]);
    final aFooter = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.70, 1.00, curve: Curves.easeOut),
      ),
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          // ── Header hero card ──────────────────────────────────────────────
          _FadeSlideUp(
            animation: aHero,
            child: _HeaderCard(
              pulse: pulseCtrl,
              title: header?.title ?? '',
              subtitle: header?.subtitle ?? '',
              onlineLabel: header?.onlineLabel ?? '',
              isOnline: header?.isOnline ?? false,
            ),
          ),

          SizedBox(height: 28.h),

          // ── Section header ────────────────────────────────────────────────
          _FadeSlideUp(
            animation: aSection,
            child: Padding(
              padding: EdgeInsets.only(left: 4.w, bottom: 14.h),
              child: Row(
                children: [
                  Container(
                    width: 4.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: context.appColors.brandFill,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    data?.sectionTitle ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Contact cards ─────────────────────────────────────────────────
          for (var i = 0; i < channels.length; i++) ...[
            if (i > 0) SizedBox(height: 12.h),
            _ChannelCard(channel: channels[i], animation: cardAnims[i]),
          ],

          SizedBox(height: 36.h),

          // ── Footer ────────────────────────────────────────────────────────
          FadeTransition(
            opacity: aFooter,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 40.w,
                    height: 1,
                    color: context.appColors.glassBorder.withValues(
                      alpha: 0.12,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    data?.footer ?? '',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.5),
                      height: 1.6,
                      fontSize: 11.5.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

// ─── Header hero card ────────────────────────────────────────────────────────

class _HeaderCard extends StatelessWidget {
  final Animation<double> pulse;
  final String title;
  final String subtitle;
  final String onlineLabel;
  final bool isOnline;
  const _HeaderCard({
    required this.pulse,
    required this.title,
    required this.subtitle,
    required this.onlineLabel,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final accent = context.appColors.brandFill;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 22.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.appColors.glass.withValues(alpha: 0.14),
            context.appColors.glass.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: accent.withValues(alpha: 0.50), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.30),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: accent.withValues(alpha: 0.18),
            blurRadius: 32,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon with pulsing glow — isolated in RepaintBoundary so the
          // continuous repaint never escapes this subtree.
          RepaintBoundary(
            child: _PulsingIcon(pulse: pulse, accent: accent),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 16.sp,
                    letterSpacing: 0.1,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    height: 1.5,
                    color: cs.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                if (isOnline) ...[
                  SizedBox(height: 10.h),
                  RepaintBoundary(
                    child: _LiveBadge(pulse: pulse, label: onlineLabel),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingIcon extends StatelessWidget {
  final Animation<double> pulse;
  final Color accent;
  const _PulsingIcon({required this.pulse, required this.accent});

  @override
  Widget build(BuildContext context) {
    final child = Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Icon(Icons.support_agent_rounded, size: 28.sp, color: accent),
    );

    return AnimatedBuilder(
      animation: pulse,
      child: child,
      builder: (_, child) {
        // pulse runs 0→1→0 (reverse:true), map to a subtle glow strength.
        final t = pulse.value;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.10 + 0.18 * t),
                blurRadius: 14 + 12 * t,
                spreadRadius: 0.5 + 1.5 * t,
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}

class _LiveBadge extends StatelessWidget {
  final Animation<double> pulse;
  final String label;
  const _LiveBadge({required this.pulse, required this.label});

  @override
  Widget build(BuildContext context) {
    final success = context.appColors.success;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: success.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: success.withValues(alpha: 0.32)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: pulse,
            builder: (_, _) {
              final t = pulse.value;
              return Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: success,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: success.withValues(alpha: 0.4 + 0.4 * t),
                      blurRadius: 4 + 6 * t,
                      spreadRadius: 0.5 + 1.5 * t,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              color: success,
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Channel card (single API-driven contact) ────────────────────────────────

/// One contact channel from the backend — resolves its client-owned icon/accent
/// from `type`, and launches (`tel`/`whatsapp`/`mailto`) or copies its value.
class _ChannelCard extends StatelessWidget {
  final ContactChannel channel;
  final Animation<double> animation;
  const _ChannelCard({required this.channel, required this.animation});

  // Icon + accent stay client-owned (theme-correct per channel), keyed off the
  // backend `type` so a new channel never has to ship a raw hex / icon name.
  static (IconData, Color) _visualFor(String? type, BuildContext context) {
    switch (type) {
      case 'phone':
        return (Icons.phone_in_talk_rounded, context.appColors.infoBright);
      case 'whatsapp':
        return (Icons.chat_bubble_rounded, context.appColors.success);
      case 'email':
        return (Icons.alternate_email_rounded, context.appColors.brandFill);
      default:
        return (Icons.support_agent_rounded, context.appColors.brandFill);
    }
  }

  // value / display_value are lists from the API. The badge shows the first
  // entry (a joined multi-value string gets shrunk to near-invisible by the
  // FittedBox); additional values are reachable via the picker on tap.
  String get _value =>
      (channel.value?.isNotEmpty ?? false) ? channel.value!.first : '';
  String get _displayValue => (channel.displayValue?.isNotEmpty ?? false)
      ? channel.displayValue!.first
      : _value;

  Future<void> _launchValue(String value) async {
    if (value.isEmpty) return;
    HapticFeedback.lightImpact();
    switch (channel.actionType) {
      case 'tel':
        await launchUrl(Uri(scheme: 'tel', path: value));
        break;
      case 'whatsapp':
        // Prefilled message comes only from the API; omit ?text= when absent.
        final message = channel.prefilledMessage?.trim();
        final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
        await launchUrl(
          Uri.parse(
            'https://wa.me/$digits'
            '${(message == null || message.isEmpty) ? '' : '?text=${Uri.encodeComponent(message)}'}',
          ),
          mode: LaunchMode.externalApplication,
        );
        break;
      case 'mailto':
        // Subject comes only from the API; omit ?subject= when absent.
        final subject = channel.emailSubject?.trim();
        await launchUrl(
          Uri(
            scheme: 'mailto',
            path: value,
            query: (subject == null || subject.isEmpty)
                ? null
                : 'subject=$subject',
          ),
          mode: LaunchMode.externalApplication,
        );
        break;
    }
  }

  // A single value launches directly; multiple values open a picker sheet so
  // the user chooses which number/email to call/message.
  void _onTap(BuildContext context) {
    final values = channel.value ?? const <String>[];
    if (values.length <= 1) {
      _launchValue(_value);
      return;
    }
    HapticFeedback.selectionClick();
    final displays = channel.displayValue;
    final visual = _visualFor(channel.type, context);
    AppActionSheet.show(
      context,
      title: channel.title,
      description: channel.subtitle,
      items: [
        for (var i = 0; i < values.length; i++)
          AppActionSheetItem(
            title:
                (displays != null &&
                    i < displays.length &&
                    displays[i].trim().isNotEmpty)
                ? displays[i]
                : values[i],
            icon: visual.$1,
            color: visual.$2,
            onTap: () => _launchValue(values[i]),
          ),
      ],
    );
  }

  Future<void> _copy(String value) async {
    HapticFeedback.selectionClick();
    await Clipboard.setData(ClipboardData(text: value));
    AppNotify.toast('core.copiedToClipboard'.tr());
  }

  @override
  Widget build(BuildContext context) {
    final visual = _visualFor(channel.type, context);
    final badge = _displayValue;
    return _FadeSlideUp(
      animation: animation,
      child: _ContactCard(
        icon: visual.$1,
        iconColor: visual.$2,
        title: channel.title ?? '',
        subtitle: channel.subtitle ?? '',
        badge: badge,
        onTap: () => _onTap(context),
        onLongPress: () => _copy(_value.isNotEmpty ? _value : badge),
      ),
    );
  }
}

// ─── Contact card ────────────────────────────────────────────────────────────

class _ContactCard extends HookWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String badge;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _ContactCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final pressed = useState(false);

    return AnimatedScale(
      scale: pressed.value ? 0.975 : 1.0,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withValues(alpha: pressed.value ? 0.06 : 0.14),
              blurRadius: pressed.value ? 8 : 18,
              offset: Offset(0, pressed.value ? 3 : 8),
            ),
          ],
        ),
        child: Material(
          color: context.appColors.glass.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(16.r),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            onTapDown: (_) => pressed.value = true,
            onTapUp: (_) => pressed.value = false,
            onTapCancel: () => pressed.value = false,
            splashColor: iconColor.withValues(alpha: 0.10),
            highlightColor: iconColor.withValues(alpha: 0.05),
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(
                  color: pressed.value
                      ? iconColor.withValues(alpha: 0.55)
                      : context.appColors.glassBorder.withValues(alpha: 0.18),
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 14.w, 16.h),
                child: Row(
                  children: [
                    // Icon bubble
                    Container(
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            iconColor.withValues(alpha: 0.40),
                            iconColor.withValues(alpha: 0.22),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: iconColor.withValues(alpha: 0.60),
                          width: 1,
                        ),
                      ),
                      child: Icon(icon, color: iconColor, size: 24.sp),
                    ),
                    SizedBox(width: 14.w),

                    // Text column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              letterSpacing: 0.1,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            subtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 11.5.sp,
                              color: context.appColors.muted,
                              height: 1.35,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              badge,
                              textDirection: ui.TextDirection.ltr,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.visible,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: iconColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.sp,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 8.w),

                    // Arrow — slides forward slightly on press for affordance.
                    AnimatedSlide(
                      offset: Offset(
                        (pressed.value ? 0.15 : 0) *
                            (Directionality.of(context) == ui.TextDirection.rtl
                                ? -1
                                : 1),
                        0,
                      ),
                      duration: const Duration(milliseconds: 160),
                      curve: Curves.easeOut,
                      child: Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.28),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: iconColor.withValues(alpha: 0.45),
                            width: 0.5,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 16.sp,
                          color: iconColor,
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
}

// ─── Fade + slide-up entrance (performant) ───────────────────────────────────
//
// Built on FadeTransition + SlideTransition (both `Listenable`-driven and
// optimized by Flutter) — significantly cheaper than wrapping in Opacity +
// Transform.translate inside AnimatedBuilder.

class _FadeSlideUp extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _FadeSlideUp({required this.animation, required this.child});

  static final _slideTween = Tween<Offset>(
    begin: const Offset(0, 0.08),
    end: Offset.zero,
  );

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: _slideTween.animate(animation),
        child: child,
      ),
    );
  }
}
