import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/home/home_bloc.dart';
import '../../../domain/home/home_recent_beneficiaries_dto.dart';
import '../../core/global/app_global.dart';
import '../../core/svg/app_svg.dart';
import 'home_inline_notice.dart';
import '../../core/theme/app_theme_ext.dart';

class HomeRecentBeneficiaryView extends StatelessWidget {
  final HomeState state;
  const HomeRecentBeneficiaryView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // A failed fetch used to null the list, which rendered exactly like a
    // first-time user with no recent transfers: the strip vanished, and there
    // was no way to tell an outage from an empty history — let alone retry it.
    // The section is best-effort (it never blocks a transaction), so it owns its
    // own error state instead of escalating to the full-screen retry.
    if (state.isRecentBeneficiariesLoadFailed) {
      return const _RecentBeneficiariesError();
    }
    final beneficiaries =
        state.homeRecentBeneficiariesDto?.data?.beneficiaryList ?? [];
    final count = beneficiaries.length > 3 ? 3 : beneficiaries.length;
    return beneficiaries.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                child: Row(
                  children: [
                    Container(
                      width: 3.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: context.appColors.brandFill,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'home.sendAgain.title'.tr(),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                // Don't clip: the light theme's glassPanel shadow extends well
                // past the 6.h vertical padding and gets sliced into a hard
                // band by the scroll view's default Clip.hardEdge.
                clipBehavior: Clip.none,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < count; i++) ...[
                      if (i > 0) SizedBox(width: 10.w),
                      BeneficiaryCard(beneficiary: beneficiaries[i]),
                    ],
                  ],
                ),
              ),
            ],
          );
  }
}

/// Inline failure card standing in for the "Send Again" strip when its fetch
/// failed, with a retry that re-runs only that one endpoint. Reuses the shared
/// [HomeInlineNotice] so the message reads as the same kind of section notice
/// the Send Money group uses below it.
class _RecentBeneficiariesError extends StatelessWidget {
  const _RecentBeneficiariesError();

  @override
  Widget build(BuildContext context) {
    return HomeInlineNotice(
      type: HomeNoticeType.error,
      icon: Icons.history_rounded,
      label: 'home.sendAgain.title'.tr(),
      message: 'home.sendAgain.loadFailed'.tr(),
      actionLabel: 'buttons.retry'.tr(),
      onAction: () => context.read<HomeBloc>().add(
        const HomeEvent.getHomeRecentBeneficiaries(),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
    );
  }
}

class BeneficiaryCard extends StatelessWidget {
  final RecentBeneficiaryList? beneficiary;
  final double? width;
  const BeneficiaryCard({super.key, this.beneficiary, this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final beneficiaryCountryCode = beneficiary?.beneficiaryCountryCode ?? '';
    final firstName = beneficiary?.beneficiaryFirstName ?? '';
    final lastName = beneficiary?.beneficiaryLastName ?? '';

    final name = ('$firstName $lastName').trim();
    final hasName = name.isNotEmpty;

    final initials =
        ((firstName.isNotEmpty ? firstName[0] : '') +
                (lastName.isNotEmpty ? lastName[0] : ''))
            .toUpperCase();

    final displayInitials = initials.isEmpty ? '?' : initials;

    final maskedAccountNumber =
        beneficiary?.beneficiaryBankAccountNumber?.replaceAll(
          RegExp(r'\d(?=\d{4})'),
          '•',
        ) ??
        '';

    final hasAccount = maskedAccountNumber.isNotEmpty;
    final transferType = beneficiary?.disbursalMode ?? '';
    final hasTransferType = transferType.trim().isNotEmpty;
    final amount = beneficiary?.tranList?.firstOrNull?.destinationAmount ?? 0.0;
    final decimalPlaces =
        beneficiary?.tranList?.firstOrNull?.decimalPlaces ?? 3;
    final currency =
        beneficiary?.tranList?.firstOrNull?.destinationCurrencyCode ?? '';
    final hasAmount = currency.isNotEmpty && amount > 0;

    return _PressableCard(
      onTap: () {
        HapticFeedback.lightImpact();
        final tappedBeneficiary = beneficiary;
        if (tappedBeneficiary == null) return;
        // Navigation to the summary happens in home_page.dart once the
        // mandatory-field check succeeds (one-shot listener).
        context.read<HomeBloc>().add(
          HomeEvent.recentBeneficiaryTapped(beneficiary: tappedBeneficiary),
        );
      },
      child: Container(
        width: width ?? 280.w,
        padding: EdgeInsets.all(12.w),
        decoration: context.glassPanel(
          borderRadius: BorderRadius.circular(12.r),
          fillTop: 0.11,
          fillBottom: 0.04,
          hairline: 0.22,
          shadowAlpha: 0.20,
          shadowBlur: 16,
          shadowOffset: Offset(0, 6.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Identity row ───────────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _InitialsAvatar(
                  initials: displayInitials,
                  colorScheme: cs,
                  theme: theme,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hasName)
                        Text(
                          name.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: cs.onPrimary,
                            letterSpacing: 0.4,
                          ),
                        ),
                      if (hasAccount || hasTransferType) ...[
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            if (hasAccount)
                              Flexible(
                                child: Text(
                                  maskedAccountNumber,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: cs.onPrimary.withValues(alpha: 0.62),
                                    fontSize: 10.sp,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                            if (hasAccount && hasTransferType) ...[
                              SizedBox(width: 5.w),
                              Container(
                                width: 2.5.w,
                                height: 2.5.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: cs.onPrimary.withValues(alpha: 0.35),
                                ),
                              ),
                              SizedBox(width: 5.w),
                            ],
                            if (hasTransferType)
                              Flexible(
                                child: Text(
                                  transferType.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: cs.onPrimary.withValues(alpha: 0.62),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            if (hasAmount) ...[
              SizedBox(height: 8.h),
              Container(
                height: 0.5,
                color: context.appColors.glassBorder.withValues(alpha: 0.16),
              ),
              SizedBox(height: 7.h),

              // ── Amount + send action ─────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3.r),
                    child: AppSvg(
                      asset: AppGlobal.getFlagAsset(beneficiaryCountryCode),
                      width: 20.w,
                      height: 14.w,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: currency.toUpperCase(),
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: cs.tertiary,
                              letterSpacing: 0.6,
                            ),
                          ),
                          const TextSpan(text: '  '),
                          TextSpan(
                            text: amount.toStringAsFixed(decimalPlaces),
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: cs.onPrimary,
                              fontSize: 13.sp,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  _SendButton(colorScheme: cs),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Avatar with subtle accent shadow ──────────────────────────────────────────

class _InitialsAvatar extends StatelessWidget {
  final String initials;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _InitialsAvatar({
    required this.initials,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.appColors.brandFill,
            Color.lerp(context.appColors.brandFill, Colors.black, 0.12)!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(9.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.tertiary.withValues(alpha: 0.28),
            blurRadius: 8,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Text(
        initials,
        style: theme.textTheme.titleSmall?.copyWith(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ── Send-arrow action chip ────────────────────────────────────────────────────

class _SendButton extends StatelessWidget {
  final ColorScheme colorScheme;

  const _SendButton({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.appColors.brandFill,
            Color.lerp(context.appColors.brandFill, Colors.black, 0.12)!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.tertiary.withValues(alpha: 0.30),
            blurRadius: 9,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Icon(
        Icons.arrow_outward_rounded,
        color: colorScheme.primary,
        size: 14.sp,
      ),
    );
  }
}

// ── Tap feedback wrapper ──────────────────────────────────────────────────────
//
// Light scale-down on press so each card feels tactile when tapped in the
// horizontal scroll list.

class _PressableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _PressableCard({required this.child, required this.onTap});

  @override
  State<_PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<_PressableCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
