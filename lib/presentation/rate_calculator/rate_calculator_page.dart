import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/rate_calculator/rate_calculator_bloc.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/app_states/app_state_view.dart';
import '../core/extension/common_send_money_dto_extentions.dart';
import '../core/extension/text_editing_controller_extension.dart';
import '../core/notify/app_notify.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/send_money_card/app_send_money_card.dart';
import '../core/shimmer/app_shimmer.dart';
import '../core/theme/app_theme_ext.dart';
import '../core/widgets/locale_bloc_builder.dart';
import 'widgets/rate_calculator_backdrop.dart';

/// Standalone currency calculator: pick a source and destination currency,
/// type an amount into either field, and the opposite field + rate badge update
/// live off the backend `calculate-amount` endpoint. Carries no corridor
/// context (transfer type / bank / payment) — it is purely indicative.
@RoutePage()
class RateCalculatorPage extends HookWidget {
  const RateCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sourceAmountFocusNode = useFocusNode();
    final destinationAmountFocusNode = useFocusNode();
    final sourceAmountController = useTextEditingController();
    final destinationAmountController = useTextEditingController();

    useEffect(() {
      context.read<RateCalculatorBloc>().add(
        const RateCalculatorEvent.initialize(),
      );
      return null;
    }, const []);

    // Once the user leaves a field, snap it to the backend's canonical amount so
    // both sides reflect the API value (mirrors the home send-money card). While
    // a field is focused or a calculation is in flight, the listener below owns
    // the opposite field and we never fight the user's own typing.
    useEffect(() {
      void reconcile(
          FocusNode focus,
          TextEditingController controller,
          double? Function() amount,
          String Function() formatted,
          ) {
        if (focus.hasFocus) return;
        final st = context.read<RateCalculatorBloc>().state;
        if (st.isRateLoading ||
            st.isSourceAmountCalculating ||
            st.isDestinationAmountCalculating) {
          return;
        }
        if ((amount() ?? 0) <= 0) return;
        controller.setTextKeepCaretAtEnd(formatted());
      }

      void reconcileSource() => reconcile(
        sourceAmountFocusNode,
        sourceAmountController,
            () => context.read<RateCalculatorBloc>().state.commonSendMoneyDto
            .sourceAmount,
            () => context.read<RateCalculatorBloc>().state.commonSendMoneyDto
            .formattedSourceAmount,
      );
      void reconcileDestination() => reconcile(
        destinationAmountFocusNode,
        destinationAmountController,
            () => context.read<RateCalculatorBloc>().state.commonSendMoneyDto
            .destinationAmount,
            () {
          final st = context.read<RateCalculatorBloc>().state;
          return st.commonSendMoneyDto.formattedDestinationAmount(
            st.selectedDestinationItem?.decimalPlaces ?? 3,
          );
        },
      );

      sourceAmountFocusNode.addListener(reconcileSource);
      destinationAmountFocusNode.addListener(reconcileDestination);
      return () {
        sourceAmountFocusNode.removeListener(reconcileSource);
        destinationAmountFocusNode.removeListener(reconcileDestination);
      };
    }, const []);

    return LocaleBlocConsumer<RateCalculatorBloc, RateCalculatorState>(
      listenWhen: (prev, curr) =>
      prev.calculateOption != curr.calculateOption,
      listener: (context, state) {
        state.calculateOption.fold(() {}, (either) {
          either.fold(
                (_) {
              // Business failure (network/timeout is handled by the global retry
              // dialog). Clear the derived field so no stale amount lingers.
              if (!sourceAmountFocusNode.hasFocus) {
                sourceAmountController.text = '';
              }
              if (!destinationAmountFocusNode.hasFocus) {
                destinationAmountController.text = '';
              }
              AppNotify.toast(
                'rateCalculator.errorSubtitle'.tr(),
                type: AppToastType.error,
                position: AppToastPosition.top,
              );
            },
                (_) {
              final dto = state.commonSendMoneyDto;
              final decimals = state.selectedDestinationItem?.decimalPlaces ?? 3;
              // Update whichever field the user is NOT editing; the focused field
              // keeps their raw input until they blur (see reconcile above).
              if (!sourceAmountFocusNode.hasFocus) {
                sourceAmountController.setTextKeepCaretAtEnd(
                  (dto.sourceAmount ?? 0) > 0 ? dto.formattedSourceAmount : '',
                );
              }
              if (!destinationAmountFocusNode.hasFocus) {
                destinationAmountController.setTextKeepCaretAtEnd(
                  (dto.destinationAmount ?? 0) > 0
                      ? dto.formattedDestinationAmount(decimals)
                      : '',
                );
              }
            },
          );
        });
      },
      builder: (context, state) {
        return AppScaffold(
          appBar: AppAppBar(title: 'rateCalculator.title'.tr()),
          body: Stack(
            children: [
              // Oman-themed silhouette art filling the space above and below
              // the compact card (hidden on the full-screen error state).
              if (!state.criticalLoadFailed)
                const Positioned.fill(child: RateCalculatorBackdrop()),
              Positioned.fill(
                child: state.criticalLoadFailed
                    ? AppErrorView(
                  title: 'rateCalculator.errorTitle'.tr(),
                  subtitle: 'rateCalculator.errorSubtitle'.tr(),
                  retryLabel: 'buttons.retry'.tr(),
                  onRetry: () => context.read<RateCalculatorBloc>().add(
                    const RateCalculatorEvent.initialize(),
                  ),
                )
                    : LayoutBuilder(
                  builder: (context, constraints) {
                    // Center the compact converter block in the viewport so the
                    // screen doesn't read as one card stranded above a large
                    // empty gradient. The ConstrainedBox keeps it scrollable and
                    // re-centers within the smaller space when the keyboard opens.
                    const verticalPadding = 16.0;
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: verticalPadding.h,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight:
                          constraints.maxHeight - (verticalPadding.h * 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            state.isInitialLoading
                                ? const _RateCalculatorShimmer()
                                : _RateCalculatorContent(
                              state: state,
                              sourceAmountController:
                              sourceAmountController,
                              destinationAmountController:
                              destinationAmountController,
                              sourceAmountFocusNode: sourceAmountFocusNode,
                              destinationAmountFocusNode:
                              destinationAmountFocusNode,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RateCalculatorContent extends StatelessWidget {
  final RateCalculatorState state;
  final TextEditingController sourceAmountController;
  final TextEditingController destinationAmountController;
  final FocusNode sourceAmountFocusNode;
  final FocusNode destinationAmountFocusNode;

  const _RateCalculatorContent({
    required this.state,
    required this.sourceAmountController,
    required this.destinationAmountController,
    required this.sourceAmountFocusNode,
    required this.destinationAmountFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header (accent bar + title + supporting line) ──
        Row(
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
              'rateCalculator.title'.tr(),
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 11.w, top: 4.h),
          child: Text(
            'rateCalculator.subtitle'.tr(),
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 11.5.sp,
              color: context.appColors.muted,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        AppSendMoneyCard(
          isRateLoading: state.isRateLoading,
          isSourceAmountCalculating: state.isSourceAmountCalculating,
          isDestinationAmountCalculating: state.isDestinationAmountCalculating,
          commonSourceSelectableDto: state.sourceSelectableDto,
          selectedCommonSourceItem: state.selectedSourceItem,
          commonDestinationSelectableDto: state.destinationSelectableDto,
          selectedCommonDestinationItem: state.selectedDestinationItem,
          commonSendMoneyDto: state.commonSendMoneyDto,
          sourceAmountController: sourceAmountController,
          destinationAmountController: destinationAmountController,
          sourceAmountFocusNode: sourceAmountFocusNode,
          destinationAmountFocusNode: destinationAmountFocusNode,
          sourceAmountChanged: (v) => context.read<RateCalculatorBloc>().add(
            RateCalculatorEvent.sourceAmountChanged(amount: v),
          ),
          destinationAmountChanged: (v) =>
              context.read<RateCalculatorBloc>().add(
                RateCalculatorEvent.destinationAmountChanged(amount: v),
              ),
          onSelectedDestinationCurrency: (item) =>
              context.read<RateCalculatorBloc>().add(
                RateCalculatorEvent.destinationCurrencySelected(item: item),
              ),
        ),
        // ── Backend-authored remark for the latest calculation. Replaces the
        // old hard-coded indicative-rate disclaimer, so the whole row is gone
        // until the backend actually sends one. ──
        if (state.remarks.isNotEmpty) ...[
          SizedBox(height: 14.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 14.w,
                color: context.appColors.muted,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  state.remarks,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 11.sp,
                    height: 1.35,
                    color: context.appColors.muted,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _RateCalculatorShimmer extends StatelessWidget {
  const _RateCalculatorShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppShimmer(
          width: 140.w,
          height: 14.h,
          borderRadius: BorderRadius.circular(4.r),
        ),
        SizedBox(height: 8.h),
        AppShimmer(
          width: 200.w,
          height: 11.h,
          borderRadius: BorderRadius.circular(4.r),
        ),
        SizedBox(height: 20.h),
        AppShimmer(
          width: double.infinity,
          height: 210.h,
          borderRadius: BorderRadius.circular(14.r),
        ),
      ],
    );
  }
}