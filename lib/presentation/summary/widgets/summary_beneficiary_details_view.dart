import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/beneficiary/beneficiary_bloc.dart';
import '../../../application/summary/summary_bloc.dart';
import '../../core/theme/app_theme_ext.dart';
import '../../../domain/summary/summary_beneficiary_by_id_dto.dart';
import '../../core/button/edit_stack_button.dart';
import '../../core/dotted_border/app_dotted_border.dart';
import '../../core/global/app_global.dart';
import '../../core/shimmer/app_shimmer.dart';
import '../../core/svg/app_svg.dart';
import '../../routes/app_routes.gr.dart';
import 'summary_section_error_view.dart';

class SummaryBeneficiaryDetailsView extends StatelessWidget {
  final SummaryState state;
  const SummaryBeneficiaryDetailsView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final beneficiary = state.summaryBeneficiaryByIdDto?.data?.beneficiaryById;

    final fullName = [
      beneficiary?.beneficiaryFirstName,
      beneficiary?.beneficiaryMiddleName,
      beneficiary?.beneficiaryLastName,
    ].where((e) => (e ?? '').trim().isNotEmpty).join(' ').toUpperCase();

    final unicodeName = [
      beneficiary?.beneficiaryFirstNameUnicode,
      beneficiary?.beneficiaryMiddleNameUnicode,
      beneficiary?.beneficiaryLastNameUnicode,
    ].where((e) => (e ?? '').trim().isNotEmpty).join(' ');

    return state.summaryBeneficiaryByIdFailureOrSuccessOption.fold(
      // none() → section is loading; show per-section shimmer
      () => AppShimmer(
        height: 90.h,
        width: double.infinity,
        borderRadius: BorderRadius.circular(12.r),
      ),
      (either) => either.fold(
        // Left → isolated section error; user can retry without affecting other sections
        (failure) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'summary.beneficiaryDetails.title'.tr(),
              style: context.typography.subheading.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            SummarySectionErrorView(
              message: 'errors.networkError'.tr(),
              onRetry: () => context.read<SummaryBloc>().add(
                const SummaryEvent.retryBeneficiary(),
              ),
            ),
          ],
        ),
        // Right → render content
        (beneficiaryById) {
          final hasPurpose = (beneficiary?.purposeName ?? '').trim().isNotEmpty;
          final hasSourceOfFunds = (beneficiary?.incomeSourceName ?? '')
              .trim()
              .isNotEmpty;
          final hasBottomSection = hasPurpose || hasSourceOfFunds;

          // In-place refresh after the user edits this beneficiary: the record
          // is already on screen, so keep it fully legible and trace an accent
          // glow orbiting the card border to signal the live refresh — no
          // shimmer, no chip, nothing covering the content.
          final isUpdating = state.isBeneficiaryLoading;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'summary.beneficiaryDetails.title'.tr(),
                style: context.typography.subheading.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              _OrbitingGlowBorder(
                active: isUpdating,
                borderRadius: BorderRadius.circular(12.r),
                child: IgnorePointer(
                  ignoring: isUpdating,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          _TopCard(
                            beneficiary: beneficiary,
                            fullName: fullName,
                            unicodeName: unicodeName,
                            hasBottomSection: hasBottomSection,
                          ),
                          if (hasBottomSection)
                            _BottomCard(
                              beneficiary: beneficiary,
                              hasPurpose: hasPurpose,
                              hasSourceOfFunds: hasSourceOfFunds,
                            ),
                        ],
                      ),
                      EditStackButton(
                        onEditTap: () {
                          final eId = beneficiary?.eId;
                          context.read<BeneficiaryBloc>().add(
                            BeneficiaryEvent.getBeneficiaryById(eId),
                          );
                          context.router.push(const BeneficiaryEditForm());
                        },
                      ),
                    ],
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

// Wraps the beneficiary card and, while [active], traces an accent "comet"
// that orbits the card border — a soft blurred glow under a crisp core stroke.
// The content underneath stays fully visible; this only paints the rim.
class _OrbitingGlowBorder extends HookWidget {
  final Widget child;
  final bool active;
  final BorderRadius borderRadius;

  const _OrbitingGlowBorder({
    required this.child,
    required this.active,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );

    useEffect(() {
      if (active) {
        controller.repeat();
      } else {
        controller
          ..stop()
          ..value = 0;
      }
      return null;
    }, [active]);

    final accent = context.colorScheme.tertiary;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOut,
              opacity: active ? 1 : 0,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, _) => CustomPaint(
                  painter: _OrbitGlowPainter(
                    progress: controller.value,
                    color: accent,
                    borderRadius: borderRadius,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OrbitGlowPainter extends CustomPainter {
  final double progress;
  final Color color;
  final BorderRadius borderRadius;

  _OrbitGlowPainter({
    required this.progress,
    required this.color,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    // Faint continuous rim so the travelling arc reads as moving along a real
    // border rather than floating in space.
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = color.withValues(alpha: 0.14),
    );

    // A short bright band that fades into transparency, rotated by progress so
    // it sweeps around the perimeter.
    final shader = SweepGradient(
      transform: GradientRotation(progress * 2 * math.pi),
      colors: [
        color.withValues(alpha: 0.0),
        color.withValues(alpha: 0.0),
        color.withValues(alpha: 0.55),
        color.withValues(alpha: 1.0),
        color.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.55, 0.78, 0.9, 1.0],
    ).createShader(rect);

    // Soft blurred halo underneath …
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..shader = shader
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    // … and a crisp core on top.
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant _OrbitGlowPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

class _TopCard extends StatelessWidget {
  final BeneficiaryById? beneficiary;
  final String fullName;
  final String unicodeName;
  final bool hasBottomSection;

  const _TopCard({
    required this.beneficiary,
    required this.fullName,
    required this.unicodeName,
    required this.hasBottomSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasDisbursalMode = (beneficiary?.disbursalMode ?? '')
        .trim()
        .isNotEmpty;
    final hasBankName = (beneficiary?.beneficiaryBankName ?? '')
        .trim()
        .isNotEmpty;
    final hasAccountNumber = (beneficiary?.beneficiaryBankAccountNumber ?? '')
        .trim()
        .isNotEmpty;

    return Container(
      padding: EdgeInsets.all(10).r,
      decoration: context.glassPanel(
        borderRadius: hasBottomSection
            ? BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              )
            : BorderRadius.circular(12.r),
        shadowAlpha: 0.12,
        shadowBlur: 8.r,
        shadowOffset: Offset(0, 2.h),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country flag + label
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSvg(
                  asset: AppGlobal.getFlagAsset(
                    beneficiary?.beneficiaryCountryCode,
                  ),
                  width: 24.w,
                  height: 24.w,
                ),
                SizedBox(height: 4.h),
                Text(
                  'summary.beneficiaryDetails.country'.tr(),
                  style: theme.textTheme.bodySmall,
                ),
                SizedBox(height: 2.h),
                Text(
                  beneficiary?.beneficiaryCountryName?.toUpperCase() ?? '',
                  style: context.typography.secondary.copyWith(
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            SizedBox(
              width: 1.w,
              height: double.infinity,
              child: AppDottedDivider(
                color: context.appColors.glassBorder.withValues(alpha: 0.18),
                dotSize: 0.5,
                dotLength: 2,
                space: 2.5,
                direction: Axis.vertical,
              ),
            ),
            SizedBox(width: 10.w),
            // Right: name / transfer type / bank / account
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (fullName.isNotEmpty) ...[
                    Text(
                      'summary.beneficiaryDetails.name'.tr(),
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 2.h),
                    Text.rich(
                      TextSpan(
                        style: context.typography.secondary.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(text: fullName),
                          if (unicodeName.isNotEmpty)
                            TextSpan(text: ' / $unicodeName'),
                        ],
                      ),
                    ),
                  ],
                  if (hasDisbursalMode) ...[
                    if (fullName.isNotEmpty) _rowDivider(context),
                    Text(
                      'summary.beneficiaryDetails.transferType'.tr(),
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      beneficiary?.disbursalMode ?? '',
                      style: context.typography.secondary.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  if (hasBankName) ...[
                    if (fullName.isNotEmpty || hasDisbursalMode)
                      _rowDivider(context),
                    Text(
                      'summary.beneficiaryDetails.bankOrAgent'.tr(),
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      beneficiary?.beneficiaryBankName ??
                          beneficiary?.beneficiaryAgentName ??
                          '',
                      style: context.typography.secondary.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  if (hasAccountNumber) ...[
                    if (fullName.isNotEmpty || hasDisbursalMode || hasBankName)
                      _rowDivider(context),
                    Text(
                      'summary.beneficiaryDetails.accountNumber'.tr(),
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      beneficiary?.beneficiaryBankAccountNumber ?? '',
                      style: context.typography.secondary.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowDivider(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: AppDottedDivider(
      color: context.appColors.glassBorder.withValues(alpha: 0.18),
      dotSize: 0.5,
      dotLength: 2,
      space: 2.5,
      height: 1,
    ),
  );
}

class _BottomCard extends StatelessWidget {
  final BeneficiaryById? beneficiary;
  final bool hasPurpose;
  final bool hasSourceOfFunds;

  const _BottomCard({
    required this.beneficiary,
    required this.hasPurpose,
    required this.hasSourceOfFunds,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final joinBorderSide = BorderSide(
      color: context.appColors.glassBorder.withValues(alpha: 0.18),
      width: 0.8,
    );

    return Container(
      padding: EdgeInsets.all(10).r,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.appColors.glass.withValues(alpha: 0.06),
            context.appColors.glass.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border(
          left: joinBorderSide,
          right: joinBorderSide,
          bottom: joinBorderSide,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasPurpose) ...[
            Text(
              'summary.beneficiaryDetails.purposeOfTransaction'.tr(),
              style: theme.textTheme.bodySmall,
            ),
            SizedBox(height: 2.h),
            Text(
              beneficiary?.purposeName ?? '',
              style: context.typography.secondary.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (hasPurpose && hasSourceOfFunds)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: AppDottedDivider(
                color: context.appColors.glassBorder.withValues(alpha: 0.18),
                dotSize: 0.5,
                dotLength: 2,
                space: 2.5,
                height: 1,
              ),
            ),
          if (hasSourceOfFunds) ...[
            Text(
              'summary.beneficiaryDetails.sourceOfFunds'.tr(),
              style: theme.textTheme.bodySmall,
            ),
            SizedBox(height: 2.h),
            Text(
              beneficiary?.incomeSourceName ?? '',
              style: context.typography.secondary.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
