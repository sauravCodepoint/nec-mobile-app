import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../application/home/home_bloc.dart';
import '../../application/summary/summary_bloc.dart';
import '../../domain/common/common_branches_dto.dart';
import '../../domain/company_info/company_info_type.dart';
import '../../domain/summary/summary_failure.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/bottom_sheet/app_brach_bottom_sheet.dart';
import '../core/button/app_slide_button.dart';
import '../core/extension/common_send_money_dto_extentions.dart';
import '../core/extension/text_editing_controller_extension.dart';
import '../core/notify/app_notify.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/send_money_card/widgets/app_payment_details_view.dart';
import '../core/showcase/app_showcase.dart';
import '../core/showcase/app_showcase_tour.dart';
import '../core/stepper/app_stepper.dart';
import '../routes/app_routes.gr.dart';
import 'widgets/summary_beneficiary_details_view.dart';
import 'widgets/summary_mpin_view.dart';
import 'widgets/summary_payment_method_view.dart';
import 'widgets/summary_shimmer_view.dart';
import 'widgets/summary_transfer_details_view.dart';

@RoutePage()
class SummaryPage extends HookWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sourceAmountFocusNode = useFocusNode();
    final destinationAmountFocusNode = useFocusNode();
    final sourceAmountController = useTextEditingController();
    final destinationAmountController = useTextEditingController();
    final paymentMethodController = useTextEditingController();

    useEffect(() {
      final summaryBloc = context.read<SummaryBloc>();
      final useDestination =
          !summaryBloc.state.isLastInputSource &&
          summaryBloc.state.lastRawDestinationAmount.isNotEmpty;
      if (useDestination) {
        destinationAmountController.text =
            summaryBloc.state.lastRawDestinationAmount;
      } else {
        sourceAmountController.text = summaryBloc.state.lastRawSourceAmount;
      }
      return null;
    }, const []);

    // Reconcile the field the user was editing to the backend's canonical amount
    // once they leave it. While typing only the opposite field updates live (the
    // calc listeners skip the focused field so we never fight the user's input);
    // on blur we snap the active field to the API value so both fields reflect
    // the backend. Skipped mid-calculation — there the calc listener updates the
    // now-unfocused field itself when the result lands.
    useEffect(() {
      void reconcileSource() {
        if (sourceAmountFocusNode.hasFocus) return;
        final st = context.read<SummaryBloc>().state;
        if (st.isSourceAmountCalculating ||
            st.isDestinationAmountCalculating ||
            st.isRateLoading) {
          return;
        }
        if ((st.commonSendMoneyDto.sourceAmount ?? 0) <= 0) return;
        sourceAmountController.setTextKeepCaretAtEnd(
          st.commonSendMoneyDto.formattedSourceAmount,
        );
      }

      void reconcileDestination() {
        if (destinationAmountFocusNode.hasFocus) return;
        final st = context.read<SummaryBloc>().state;
        if (st.isSourceAmountCalculating ||
            st.isDestinationAmountCalculating ||
            st.isRateLoading) {
          return;
        }
        if ((st.commonSendMoneyDto.destinationAmount ?? 0) <= 0) return;
        destinationAmountController.setTextKeepCaretAtEnd(
          st.commonSendMoneyDto.formattedDestinationAmount(
            st.selectedCommonDestinationItem?.decimalPlaces ?? 3,
          ),
        );
      }

      sourceAmountFocusNode.addListener(reconcileSource);
      destinationAmountFocusNode.addListener(reconcileDestination);
      return () {
        sourceAmountFocusNode.removeListener(reconcileSource);
        destinationAmountFocusNode.removeListener(reconcileDestination);
      };
    }, const []);

    // ── Guided tour (one-time coach marks) ────────────────────────────────
    final beneficiaryShowcaseKey = useMemoized(GlobalKey.new, const []);
    final transferDetailsShowcaseKey = useMemoized(GlobalKey.new, const []);
    final paymentMethodShowcaseKey = useMemoized(GlobalKey.new, const []);
    final paymentDetailsShowcaseKey = useMemoized(GlobalKey.new, const []);
    final confirmShowcaseKey = useMemoized(GlobalKey.new, const []);

    // Only start once the screen has finished its initial load and the rate /
    // amount calculations have settled, so the tour never lands on a shimmer or
    // a value that is still being computed.
    final tourState = context.watch<SummaryBloc>().state;
    final showcaseReady =
        !tourState.isInitialLoading &&
        !tourState.isBeneficiaryLoading &&
        !tourState.isPaymentMethodLoading &&
        !tourState.isRateLoading &&
        !tourState.isSourceAmountCalculating &&
        !tourState.isDestinationAmountCalculating;

    useShowcaseTour(
      tourId: 'summary',
      ready: showcaseReady,
      steps: [
        beneficiaryShowcaseKey,
        transferDetailsShowcaseKey,
        paymentMethodShowcaseKey,
        paymentDetailsShowcaseKey,
        confirmShowcaseKey,
      ],
    );

    return BlocConsumer<SummaryBloc, SummaryState>(
      listenWhen: (previous, current) =>
          previous.summaryCalculatedSourceAmountFailureOrSuccessOption !=
              current.summaryCalculatedSourceAmountFailureOrSuccessOption ||
          previous.summaryCalculatedDestinationAmountFailureOrSuccessOption !=
              current
                  .summaryCalculatedDestinationAmountFailureOrSuccessOption ||
          previous.selectedPaymentMethodItem !=
              current.selectedPaymentMethodItem ||
          previous.summaryBranchesFailureOrSuccessOption !=
              current.summaryBranchesFailureOrSuccessOption ||
          previous.summaryPayAtBranchFailureOrSuccessOption !=
              current.summaryPayAtBranchFailureOrSuccessOption ||
          previous.summaryRoundOffFailureOrSuccessOption !=
              current.summaryRoundOffFailureOrSuccessOption,
      listener: (context, state) {
        // A completed transaction: full refresh and reset the send-money form
        // to first-load defaults so the next transaction starts clean.
        void resetHomeAfterSuccess() {
          context.read<HomeBloc>().add(
            const HomeEvent.initialize(isRefresh: true, resetSelections: true),
          );
        }

        // A failed or cancelled attempt leaves the user mid-flow — they dismiss
        // the dialog and can go back to retry. Refresh only what can go stale
        // after an attempt (recent beneficiaries) WITHOUT touching the
        // in-progress corridor selections, so re-entering isn't blank.
        void refreshHomeForRetry() {
          context.read<HomeBloc>().add(
            const HomeEvent.getHomeRecentBeneficiaries(),
          );
        }

        // 409 round-off: backend rounded the amount — ask the user to accept
        // and proceed, or cancel. Either choice calls
        // confirm-transaction-changes via roundOffDecision.
        void showRoundOffDialog(String? serverMessage) {
          HapticFeedback.heavyImpact();
          DialogHelper.show(
            context,
            showIcon: false,
            title: 'summary.errors.payAtBranch.roundOff.title'.tr(),
            message: (serverMessage?.isNotEmpty ?? false)
                ? serverMessage
                : 'summary.errors.payAtBranch.roundOff.message'.tr(),
            type: AppDialogType.warning,
            showTwoButtons: true,
            buttonText: 'buttons.acceptAndContinue'.tr(),
            onPressed: () {
              context.router.pop();
              context.read<SummaryBloc>().add(
                const SummaryEvent.roundOffDecision(isReadyToProceed: true),
              );
            },
            secondButtonText: 'buttons.cancel'.tr(),
            onSecondPressed: () {
              context.router.pop();
              context.read<SummaryBloc>().add(
                const SummaryEvent.roundOffDecision(isReadyToProceed: false),
              );
            },
          );
        }

        state.summaryCalculatedSourceAmountFailureOrSuccessOption.fold(() {}, (
          either,
        ) {
          either.fold((_) => destinationAmountController.text = '', (success) {
            // Format the just-edited source field once the user has left it, so
            // dismissing the keyboard mid-calculation still applies the decimals
            // (the rest of this fold only refreshes the destination field).
            if (!sourceAmountFocusNode.hasFocus &&
                (state.commonSendMoneyDto.sourceAmount ?? 0) > 0) {
              sourceAmountController.setTextKeepCaretAtEnd(
                state.commonSendMoneyDto.formattedSourceAmount,
              );
            }
            // Skip only while the user is actively typing here (destination
            // is the newest input, so its own calculation is authoritative).
            // Merely resting focus on the field must not drop the result.
            if (destinationAmountFocusNode.hasFocus &&
                !state.isLastInputSource) {
              return;
            }
            if (state.commonSendMoneyDto.destinationAmount == 0.0) {
              destinationAmountController.setTextKeepCaretAtEnd('');
              return;
            }
            destinationAmountController.setTextKeepCaretAtEnd(
              state.commonSendMoneyDto.formattedDestinationAmount(
                state.selectedCommonDestinationItem?.decimalPlaces ?? 3,
              ),
            );
          });
        });

        state.summaryCalculatedDestinationAmountFailureOrSuccessOption.fold(
          () {},
          (either) {
            either.fold((_) => sourceAmountController.text = '', (success) {
              // Format the just-edited destination field once the user has left
              // it, so dismissing the keyboard mid-calculation still applies the
              // decimals (the rest of this fold only refreshes the source field).
              if (!destinationAmountFocusNode.hasFocus &&
                  (state.commonSendMoneyDto.destinationAmount ?? 0) > 0) {
                destinationAmountController.setTextKeepCaretAtEnd(
                  state.commonSendMoneyDto.formattedDestinationAmount(
                    state.selectedCommonDestinationItem?.decimalPlaces ?? 3,
                  ),
                );
              }
              if (sourceAmountFocusNode.hasFocus && state.isLastInputSource) {
                return;
              }
              if (state.commonSendMoneyDto.sourceAmount == 0.0) {
                sourceAmountController.setTextKeepCaretAtEnd('');
                return;
              }
              sourceAmountController.setTextKeepCaretAtEnd(
                state.commonSendMoneyDto.formattedSourceAmount,
              );
            });
          },
        );
        paymentMethodController.text =
            state.selectedPaymentMethodItem?.titleName?.toUpperCase() ?? '';

        state.summaryBranchesFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              HapticFeedback.heavyImpact();
              DialogHelper.show(
                context,
                showIcon: false,
                message: failure.maybeMap(
                  unableToGetBranches: (value) => value.message,
                  orElse: () => 'errors.orElse'.tr(),
                ),
                type: AppDialogType.error,
              );
            },
            (success) {
              AppBranchBottomSheet.show(
                context,
                commonBranchesDto: state.summaryBranchesDto,
                onSubmit: () {
                  context.router.pop();
                  DialogHelper.show(
                    context,
                    showIcon: false,
                    message: 'summary.success.confirmPayment.message'.tr(),
                    showTwoButtons: true,
                    onPressed: () async {
                      context.router.pop();
                      // Re-authenticate with MPIN before creating the
                      // transaction — required for every payment method.
                      final verified = await SummaryMpinView.show(context);
                      if (!context.mounted || !verified) return;
                      context.read<SummaryBloc>().add(
                        const SummaryEvent.createPayAtBranchTransaction(),
                      );
                    },
                    buttonText: 'buttons.yes'.tr(),
                    secondButtonText: 'buttons.no'.tr(),
                    buttonWidth: 100,
                  );
                },
                onSelected: (value) {
                  context.read<SummaryBloc>().add(
                    SummaryEvent.branchChanged(value),
                  );
                },
              );
            },
          ),
        );
        state.summaryPayAtBranchFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              failure.maybeMap(
                roundOffRequired: (value) =>
                    showRoundOffDialog(value.result.message),
                orElse: () {
                  HapticFeedback.heavyImpact();
                  DialogHelper.show(
                    context,
                    showIcon: false,
                    title: 'summary.errors.payAtBranch.title'.tr(),
                    message: failure.maybeMap(
                      unableToCreatePayAtBranchTransaction: (value) =>
                          (value.message?.isNotEmpty ?? false)
                          ? value.message
                          : 'summary.errors.payAtBranch.branchRequired'.tr(),
                      orElse: () => 'errors.orElse'.tr(),
                    ),
                    type: AppDialogType.error,
                  );
                  refreshHomeForRetry();
                },
              );
            },
            (_) {
              HapticFeedback.lightImpact();
              final selectedCode = state.selectedBranchItem?.titleCode;
              final branchData = state.summaryBranchesDto?.data?.branchList
                  ?.firstWhere(
                    (b) => b.branchCode == selectedCode,
                    orElse: () => const BranchDto(),
                  );
              resetHomeAfterSuccess();
              context.router.popAndPush(
                AppPaymentResultRoute(
                  paymentResult: state.commonPaymentResultDto,
                  isPayAtBranch: true,
                  validTimeLimit: branchData?.validTimeLimit,
                  selectedBranch: branchData,
                ),
              );
            },
          ),
        );

        // Round-off decision outcome. Right: user rejected and the cancel
        // succeeded — acknowledge and stay on the summary screen (no result
        // page). Left: the decision call failed — show the error. Accepted
        // round-offs continue through the pay-at-branch option above instead.
        state.summaryRoundOffFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              HapticFeedback.heavyImpact();
              DialogHelper.show(
                context,
                showIcon: false,
                message: failure.maybeMap(
                  unableToConfirmRoundOff: (value) =>
                      (value.message?.isNotEmpty ?? false)
                      ? value.message
                      : 'errors.orElse'.tr(),
                  orElse: () => 'errors.orElse'.tr(),
                ),
                type: AppDialogType.error,
              );
              refreshHomeForRetry();
            },
            (result) {
              HapticFeedback.lightImpact();
              DialogHelper.show(
                context,
                showIcon: false,
                title: 'summary.errors.payAtBranch.roundOff.cancelledTitle'
                    .tr(),
                message: (result.message?.isNotEmpty ?? false)
                    ? result.message
                    : 'summary.errors.payAtBranch.roundOff.cancelledMessage'
                          .tr(),
                type: AppDialogType.info,
              );
              refreshHomeForRetry();
            },
          ),
        );
      },
      builder: (context, state) {
        final isCalculating =
            state.isSourceAmountCalculating ||
            state.isDestinationAmountCalculating ||
            state.isRateLoading;

        // The slide button only comes alive once the whole summary screen has
        // finished loading all of its data (no shimmer / pending calculations).
        final isSummaryReady =
            !state.isInitialLoading &&
            !state.isBeneficiaryLoading &&
            !state.isPaymentMethodLoading &&
            !state.isRateLoading &&
            !state.isSourceAmountCalculating &&
            !state.isDestinationAmountCalculating;

        final canConfirm =
            state.summaryBeneficiaryByIdDto != null &&
            !state.isBeneficiaryLoading &&
            (state.commonSendMoneyDto.sourceAmount ?? 0) > 0 &&
            state.selectedPaymentMethodItem != null &&
            !isCalculating &&
            !state.isSubmitting;

        String validationMessage() {
          if (state.isBeneficiaryLoading) {
            return 'validation.summary.beneficiaryUpdating'.tr();
          }
          if (state.summaryBeneficiaryByIdDto == null) {
            return 'validation.summary.beneficiaryNotReady'.tr();
          }
          if ((state.commonSendMoneyDto.sourceAmount ?? 0) == 0) {
            return 'validation.summary.amountRequired'.tr();
          }
          if (state.selectedPaymentMethodItem == null) {
            return 'validation.summary.paymentMethodRequired'.tr();
          }
          return 'errors.unknownError'.tr();
        }

        return AppScaffold(
          isLoading: state.isSubmitting || state.isBranchesLoading,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBar(title: 'summary.title'.tr()),
          // Initial load: the whole screen below the app bar is a single shimmer
          // skeleton until every section has resolved and the first rate
          // calculation has landed, so the page reveals once, fully populated,
          // rather than piecing itself together section by section. The reveal
          // is a cross-fade, as on the beneficiary lists.
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.03),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: state.isInitialLoading
                ? const SummaryShimmerView(key: ValueKey('shimmer'))
                : Column(
                    key: const ValueKey('content'),
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              AppStepper(
                                steps: [
                                  'core.stepper.step1'.tr(),
                                  'core.stepper.step2'.tr(),
                                  'core.stepper.step3'.tr(),
                                ],
                                currentStep: 2,
                              ),
                              SizedBox(height: 15.h),
                              AppShowcase(
                                showcaseKey: beneficiaryShowcaseKey,
                                title: 'summary.showcase.beneficiary.title'
                                    .tr(),
                                description:
                                    'summary.showcase.beneficiary.description'
                                        .tr(),
                                icon: Icons.person_rounded,
                                child: SummaryBeneficiaryDetailsView(
                                  state: state,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              AppShowcase(
                                showcaseKey: transferDetailsShowcaseKey,
                                title: 'summary.showcase.transferDetails.title'
                                    .tr(),
                                description:
                                    'summary.showcase.transferDetails.description'
                                        .tr(),
                                icon: Icons.payments_rounded,
                                child: SummaryTransferDetailsView(
                                  state: state,
                                  sourceAmountFocusNode: sourceAmountFocusNode,
                                  destinationAmountFocusNode:
                                      destinationAmountFocusNode,
                                  sourceAmountController:
                                      sourceAmountController,
                                  destinationAmountController:
                                      destinationAmountController,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              AppShowcase(
                                showcaseKey: paymentMethodShowcaseKey,
                                title: 'summary.showcase.paymentMethod.title'
                                    .tr(),
                                description:
                                    'summary.showcase.paymentMethod.description'
                                        .tr(),
                                icon: Icons.credit_card_rounded,
                                child: SummaryPaymentMethodView(
                                  state: state,
                                  controller: paymentMethodController,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              AppShowcase(
                                showcaseKey: paymentDetailsShowcaseKey,
                                title: 'summary.showcase.paymentDetails.title'
                                    .tr(),
                                description:
                                    'summary.showcase.paymentDetails.description'
                                        .tr(),
                                icon: Icons.receipt_long_rounded,
                                child: AppPaymentDetailsView(
                                  dto: state.commonSendMoneyDto,
                                  isCalculating: isCalculating,
                                  srcCode:
                                      state
                                          .selectedCommonSourceItem
                                          ?.trailingCode
                                          ?.toUpperCase() ??
                                      '',
                                  dstCode:
                                      state
                                          .selectedCommonDestinationItem
                                          ?.trailingCode
                                          ?.toUpperCase() ??
                                      '',
                                  destinationDecimalPlaces:
                                      state
                                          .selectedCommonDestinationItem
                                          ?.decimalPlaces ??
                                      3,
                                  margin: EdgeInsets.only(top: 12.h),
                                ),
                              ),
                              SizedBox(height: 15.h),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 12.h,
                          bottom: 10.h,
                        ),
                        child: SafeArea(
                          child: AppShowcase(
                            showcaseKey: confirmShowcaseKey,
                            title: 'summary.showcase.confirm.title'.tr(),
                            description: 'summary.showcase.confirm.description'
                                .tr(),
                            icon: Icons.touch_app_rounded,
                            targetBorderRadius: BorderRadius.circular(8.r),
                            tooltipPosition: TooltipPosition.top,
                            child: AppSlideButton(
                              amount:
                                  state.commonSendMoneyDto.netLcAmount ?? 0.000,
                              currencyCode:
                                  state
                                      .selectedCommonSourceItem
                                      ?.trailingCode
                                      ?.toUpperCase() ??
                                  '',
                              showAcknowledgement: true,
                              onTncTap: () => context.router.push(
                                CompanyInfoRoute(
                                  companyInfoType:
                                      CompanyInfoType.termsAndConditions,
                                ),
                              ),
                              // Same validation order as before: ready gate →
                              // field validation → confirm.
                              enabled: isSummaryReady,
                              onNotReady: () => AppNotify.toast(
                                // Beneficiary just edited and still refreshing
                                // from the backend: tell the user exactly why
                                // they must wait rather than the generic
                                // loading message.
                                state.isBeneficiaryLoading
                                    ? 'validation.summary.beneficiaryUpdating'
                                          .tr()
                                    : 'validation.summary.notReady'.tr(),
                                type: AppToastType.info,
                                position: AppToastPosition.top,
                              ),
                              canConfirm: canConfirm,
                              onValidationFailed: () => AppNotify.toast(
                                validationMessage(),
                                type: AppToastType.error,
                                position: AppToastPosition.top,
                              ),
                              // Pay at branch is the only supported payment
                              // method; anything else the backend may list is
                              // rejected here rather than silently doing
                              // nothing.
                              onConfirm: () {
                                final paymentCode = state
                                    .selectedPaymentMethodItem
                                    ?.titleCode
                                    ?.toUpperCase();
                                if (paymentCode == 'PB') {
                                  context.read<SummaryBloc>().add(
                                    const SummaryEvent.getBranches(),
                                  );
                                } else {
                                  AppNotify.toast(
                                    'validation.summary.paymentMethodUnsupported'
                                        .tr(),
                                    type: AppToastType.error,
                                    position: AppToastPosition.top,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
