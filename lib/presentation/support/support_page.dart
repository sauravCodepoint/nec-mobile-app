import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../application/support/support_bloc.dart';
import '../../domain/support/support_contact_dto.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/app_states/app_state_view.dart';
import '../core/bottom_sheet/app_action_sheet.dart';
import '../core/theme/app_theme_ext.dart';
import '../core/scaffold/app_scaffold.dart';
import 'widgets/support_shimmer_view.dart';

@RoutePage()
class SupportPage extends HookWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the server-authored contact details via the support feature's own
    // bloc; re-fetches on language change. Read the locale in build — an
    // inherited-widget lookup inside useEffect would throw.
    final languageCode = context.locale.languageCode;
    useEffect(() {
      context.read<SupportBloc>().add(
        SupportEvent.getContactDetails(languageCode: languageCode),
      );
      return null;
    }, [languageCode]);

    return AppScaffold(
      appBar: AppAppBar(title: 'support.title'.tr(), showSupport: false),
      // Drive the body off the one-shot option (same pattern as branches_page /
      // login_contact_us_view): none() → loading, some(left) → error,
      // some(right) → content.
      body: BlocBuilder<SupportBloc, SupportState>(
        buildWhen: (previous, current) =>
        previous.contactFailureOrSuccessOption !=
            current.contactFailureOrSuccessOption,
        builder: (context, state) {
          return state.contactFailureOrSuccessOption.fold(
            // Skeleton of the real layout rather than a spinner, so the payload
            // swaps in without the page shifting.
                () => const SupportShimmerView(),
                (either) => either.fold(
                  (failure) => AppErrorView(
                title: 'support.loadError'.tr(),
                subtitle: 'support.loadErrorSubtitle'.tr(),
                retryLabel: 'buttons.retry'.tr(),
                onRetry: () => context.read<SupportBloc>().add(
                  SupportEvent.getContactDetails(languageCode: languageCode),
                ),
              ),
                  (dto) => _SupportContent(data: dto.data),
            ),
          );
        },
      ),
    );
  }
}

// ─── Content ─────────────────────────────────────────────────────────────────

/// The animated support layout. Split out from the bloc-consuming [SupportPage]
/// so the entrance-animation hooks live only on the success path (built once
/// the payload lands).
class _SupportContent extends HookWidget {
  final SupportContactData? data;
  const _SupportContent({required this.data});

  // No hardcoded contact details: every phone/WhatsApp/email target — and the
  // WhatsApp prefilled message / email subject — comes from the API payload.
  // A channel the backend doesn't send (or disables, or sends without a value)
  // simply isn't rendered.

  Future<void> _launchCall(String number) async {
    await launchUrl(Uri(scheme: 'tel', path: number));
  }

  Future<void> _launchWhatsApp(String number, String? message) async {
    final digits = number.replaceAll(RegExp(r'[^0-9]'), '');
    final text = message?.trim();
    final Uri url = Uri.parse(
      'https://wa.me/$digits'
      '${(text == null || text.isEmpty) ? '' : '?text=${Uri.encodeComponent(text)}'}',
    );

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchEmail(String email, String? subject) async {
    final trimmed = subject?.trim();
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: (trimmed == null || trimmed.isEmpty) ? null : 'subject=$trimmed',
    );

    await launchUrl(emailUri, mode: LaunchMode.externalApplication);
  }

  /// Launches [channel]'s single value directly; when it carries more than one
  /// value, opens a picker sheet so the user chooses which to use. Does nothing
  /// when the channel carries no usable value — there is no local fallback.
  void _onChannelTap(
    BuildContext context, {
    required SupportContactChannel? channel,
    required String title,
    required IconData icon,
    required Color color,
    required Future<void> Function(String value) launch,
  }) {
    final values = _valuesOf(channel);
    if (values.isEmpty) return;
    if (values.length == 1) {
      launch(values.first);
      return;
    }
    HapticFeedback.selectionClick();
    final displays = channel?.displayValue;
    AppActionSheet.show(
      context,
      title: title,
      items: [
        for (var i = 0; i < values.length; i++)
          AppActionSheetItem(
            title:
                (displays != null &&
                    i < displays.length &&
                    displays[i].trim().isNotEmpty)
                ? displays[i]
                : values[i],
            icon: icon,
            color: color,
            onTap: () => launch(values[i]),
          ),
      ],
    );
  }

  /// First enabled channel of [type] from the API payload, or null.
  static SupportContactChannel? _channelOf(
      List<SupportContactChannel>? channels,
      String type,
      ) {
    if (channels == null) return null;
    for (final channel in channels) {
      if (channel.type == type && (channel.isEnabled ?? true)) return channel;
    }
    return null;
  }

  /// The channel's usable targets from the API, blanks dropped. Empty when the
  /// backend sent no value — the caller then hides/ignores the channel.
  static List<String> _valuesOf(SupportContactChannel? channel) => [
    for (final value in channel?.value ?? const <String>[])
      if (value.trim().isNotEmpty) value.trim(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Launch targets come exclusively from the API — a channel without a usable
    // value is not rendered at all. Titles/subtitles keep using the existing
    // support.* strings.
    final channels = data?.channels;
    final phoneChannel = _channelOf(channels, 'phone');
    final whatsappChannel = _channelOf(channels, 'whatsapp');
    final emailChannel = _channelOf(channels, 'email');
    final whatsappMessage = whatsappChannel?.prefilledMessage;
    final emailSubject = emailChannel?.emailSubject;
    final hasPhone = _valuesOf(phoneChannel).isNotEmpty;
    final hasWhatsapp = _valuesOf(whatsappChannel).isNotEmpty;
    final hasEmail = _valuesOf(emailChannel).isNotEmpty;

    final pageController = useAnimationController(
      duration: const Duration(milliseconds: 1400),
    );
    final floatController = useAnimationController(
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    useEffect(() {
      pageController.forward();
      return null;
    }, []);

    final heroOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: pageController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );

    final heroSlide =
    Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
      CurvedAnimation(
        parent: pageController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
      ),
    );

    final titleOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: pageController,
        curve: const Interval(0.2, 0.45, curve: Curves.easeOut),
      ),
    );

    // Entrance intervals are derived from the card index so the cascade keeps
    // its rhythm however many of the three channels the backend enables.
    CurvedAnimation cardAnimation(int index) {
      final start = (0.28 + index * 0.09).clamp(0.0, 1.0);
      return CurvedAnimation(
        parent: pageController,
        curve: Interval(
          start,
          (start + 0.30).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        ),
      );
    }

    final footerOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: pageController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          FadeTransition(
            opacity: heroOpacity,
            child: SlideTransition(
              position: heroSlide,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.appColors.containerBackground,
                      colorScheme.surfaceContainerHighest,
                      context.appColors.containerBackground,
                    ],
                    stops: const [0.0, 0.55, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: colorScheme.tertiary.withValues(alpha: 0.22),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.tertiary.withValues(alpha: 0.08),
                      blurRadius: 24,
                      spreadRadius: -4,
                      offset: Offset(0, 8.h),
                    ),
                    BoxShadow(
                      color: context.appColors.shadowInk.withValues(
                        alpha: 0.30,
                      ),
                      blurRadius: 20,
                      offset: Offset(0, 8.h),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: floatController,
                      builder: (_, child) {
                        final dy =
                            math.sin(floatController.value * math.pi * 2) * 6;

                        return Transform.translate(
                          offset: Offset(0, dy),
                          child: child,
                        );
                      },
                      child: Container(
                        height: 66.w,
                        width: 66.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.appColors.brandFill,
                              Color.lerp(
                                context.appColors.brandFill,
                                Colors.black,
                                0.12,
                              )!,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(22.r),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.tertiary.withValues(
                                alpha: 0.38,
                              ),
                              blurRadius: 16,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.support_agent_rounded,
                          size: 34.sp,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'support.subtitle'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'support.description'.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 34.h),
          FadeTransition(
            opacity: titleOpacity,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-0.08, 0),
                end: Offset.zero,
              ).animate(titleOpacity),
              child: Text(
                'support.contactUs.title'.tr(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 18.h),
          if (hasPhone) ...[
            _AnimatedSupportCard(
              animation: cardAnimation(0),
              icon: Icons.phone_in_talk_rounded,
              title: 'support.contactUs.call.title'.tr(),
              subtitle: 'support.contactUs.call.message'.tr(),
              iconColor: context.appColors.infoBright,
              onTap: () => _onChannelTap(
                context,
                channel: phoneChannel,
                title: 'support.contactUs.call.title'.tr(),
                icon: Icons.phone_in_talk_rounded,
                color: context.appColors.infoBright,
                launch: _launchCall,
              ),
            ),
            SizedBox(height: 16.h),
          ],
          if (hasWhatsapp) ...[
            _AnimatedSupportCard(
              animation: cardAnimation(1),
              icon: Icons.chat_rounded,
              title: 'support.contactUs.whatsapp.title'.tr(),
              subtitle: 'support.contactUs.whatsapp.message'.tr(),
              iconColor: context.appColors.success,
              onTap: () => _onChannelTap(
                context,
                channel: whatsappChannel,
                title: 'support.contactUs.whatsapp.title'.tr(),
                icon: Icons.chat_rounded,
                color: context.appColors.success,
                launch: (value) => _launchWhatsApp(value, whatsappMessage),
              ),
            ),
            SizedBox(height: 16.h),
          ],
          if (hasEmail) ...[
            _AnimatedSupportCard(
              animation: cardAnimation(2),
              icon: Icons.email_rounded,
              title: 'support.contactUs.email.title'.tr(),
              subtitle: 'support.contactUs.email.message'.tr(),
              iconColor: context.appColors.info,
              onTap: () => _onChannelTap(
                context,
                channel: emailChannel,
                title: 'support.contactUs.email.title'.tr(),
                icon: Icons.email_rounded,
                color: context.appColors.info,
                launch: (value) => _launchEmail(value, emailSubject),
              ),
            ),
            SizedBox(height: 16.h),
          ],
          SizedBox(height: 26.h),
          FadeTransition(
            opacity: footerOpacity,
            child: Center(
              child: Text(
                'support.instruction'.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class _AnimatedSupportCard extends HookWidget {
  final Animation<double> animation;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const _AnimatedSupportCard({
    required this.animation,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final pressed = useState(false);

    final pulseController = useAnimationController(
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    final pulseScale = Tween<double>(begin: 1, end: 1.08).animate(
      CurvedAnimation(parent: pulseController, curve: Curves.easeInOut),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.18),
          end: Offset.zero,
        ).animate(animation),
        child: AnimatedScale(
          scale: pressed.value ? 0.97 : 1,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          child: Container(
            decoration: context.glassPanel(
              borderRadius: BorderRadius.circular(12.r),
              shadowAlpha: 0.12,
              shadowBlur: 12,
              shadowOffset: Offset(0, 4.h),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: onTap,
                onTapDown: (_) => pressed.value = true,
                onTapUp: (_) => pressed.value = false,
                onTapCancel: () => pressed.value = false,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      ScaleTransition(
                        scale: pulseScale,
                        child: Container(
                          height: 46.w,
                          width: 46.w,
                          decoration: BoxDecoration(
                            color: iconColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: iconColor.withValues(alpha: 0.25),
                              width: 0.8,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: iconColor.withValues(alpha: 0.15),
                                blurRadius: 8,
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                          child: Icon(icon, color: iconColor, size: 22.sp),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              subtitle,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 12.sp,
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 20.sp,
                        color: context.appColors.glassBorder.withValues(
                          alpha: 0.30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
