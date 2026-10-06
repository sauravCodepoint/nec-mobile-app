import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/beneficiary/beneficiary_bloc.dart';
import '../../application/home/home_bloc.dart';
import '../../application/summary/summary_bloc.dart';
import '../../application/transaction_history/transaction_history_bloc.dart';
import '../../application/update_kyc/update_kyc_bloc.dart';
import '../../domain/common/common_selectable_dto.dart';
import '../../domain/home/home_advertisement_dto.dart';
import '../../domain/home/home_failure.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/shimmer/app_shimmer.dart';
import '../core/images/app_logo.dart';
import '../core/notify/app_notify.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/showcase/app_showcase.dart';
import '../core/showcase/app_showcase_tour.dart';
import '../core/transaction_tile/app_transaction_details_listener.dart';
import '../core/widgets/locale_bloc_builder.dart';
import '../routes/app_navigation_guard.dart';
import '../routes/app_routes.gr.dart';
import 'widgets/home_agent_view.dart';
import 'widgets/home_bank_or_agent_view.dart';
import 'widgets/home_carousel_dialog.dart';
import 'widgets/home_corridor_notice.dart';
import 'widgets/home_send_receive_view.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_choose_beneficiary_button.dart';
import 'widgets/home_error_view.dart';
import 'widgets/home_recent_beneficiary_view.dart';
import 'widgets/home_recent_transactions_view.dart';
import 'widgets/home_select_field.dart';
import 'widgets/home_transfer_type_view.dart';
import 'widgets/home_user_view.dart';
import '../core/theme/app_theme_ext.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());

    useEffect(() {
      context.read<HomeBloc>().add(const HomeEvent.initialize());
      return null;
    }, const []);

    // ── Guided tour (one-time coach marks) ────────────────────────────────
    final menuShowcaseKey = useMemoized(GlobalKey.new, const []);
    final recentShowcaseKey = useMemoized(GlobalKey.new, const []);
    final destinationShowcaseKey = useMemoized(GlobalKey.new, const []);
    final transferTypeShowcaseKey = useMemoized(GlobalKey.new, const []);
    final bankOrAgentShowcaseKey = useMemoized(GlobalKey.new, const []);
    final agentShowcaseKey = useMemoized(GlobalKey.new, const []);
    final payNowShowcaseKey = useMemoized(GlobalKey.new, const []);
    final recentTransactionsShowcaseKey = useMemoized(GlobalKey.new, const []);

    final state = context.watch<HomeBloc>().state;
    // The Recent Transactions section borrows TransactionHistoryBloc for the
    // details fetch and the receipt PDF, so home has to show the overlay while
    // either is in flight. `select` keeps the dependency to that one bool
    // instead of rebuilding the page on every history-list emit.
    final isTransactionDetailsBusy = context
        .select<TransactionHistoryBloc, bool>(
          (bloc) =>
              bloc.state.isLoadingDetails ||
              bloc.state.isDownloadingOrSharingReceipt,
        );
    final hasRecentBeneficiaries =
        (state.homeRecentBeneficiariesDto?.data?.beneficiaryList ?? [])
            .isNotEmpty;
    // The Bank/Agent field only renders once a corridor resolves a payout list
    // with more than one option (a single option is auto-selected upstream and
    // never shown). Gate its coach mark on the same condition so the tour count
    // stays correct and never spotlights a hidden target.
    final hasBankOrAgent =
        (state.commonBankOrAgentSelectableDto?.data?.list ?? []).length > 1;
    // The Agent field follows the same rule: only rendered once its corridor
    // list resolves with more than one option (a single option is auto-selected
    // upstream and never shown). Gate its coach mark on the same condition.
    final hasAgent =
        (state.commonAgentSelectableDto?.data?.list ?? []).length > 1;
    // The Recent Transactions section collapses to nothing for a customer who
    // has never sent money (and is replaced by an inline retry when its fetch
    // failed), so its coach mark is gated on the section actually rendering —
    // otherwise the tour would spotlight empty space and miscount its steps.
    final hasRecentTransactions =
        (state.homeRecentTransactionsDto?.data.transactions ?? []).isNotEmpty &&
        !state.isRecentTransactionsLoadFailed;

    // Only start once every spotlighted section has finished loading, so the
    // tour never lands on a shimmer or an unmounted widget.
    final showcaseReady = !state.isInitialSectionsLoading;

    // Same first-settle latch as the bottom nav (see MainPage): the app bar
    // renders as shimmer — menu, logo, notification and logout untappable —
    // until the FIRST load settles (or critically fails), and never re-locks
    // on refreshes or rate recalculations.
    final hasSettledOnce = useRef(false);
    if (!state.isInitialSectionsLoading || state.criticalLoadFailed) {
      hasSettledOnce.value = true;
    }
    final isAppBarLoading = !hasSettledOnce.value;

    // Holds an advertisement carousel that arrived while the guided tour is
    // pending/running, so it can be shown once the tour completes instead of
    // fighting the coach marks for the screen.
    final pendingAdvertisement = useRef<HomeAdvertisementDto?>(null);

    final tourActive = useShowcaseTour(
      tourId: 'home',
      ready: showcaseReady,
      steps: [
        menuShowcaseKey,
        if (hasRecentBeneficiaries) recentShowcaseKey,
        destinationShowcaseKey,
        transferTypeShowcaseKey,
        if (hasBankOrAgent) bankOrAgentShowcaseKey,
        if (hasAgent) agentShowcaseKey,
        payNowShowcaseKey,
        if (hasRecentTransactions) recentTransactionsShowcaseKey,
      ],
    );

    // Once the tour has finished (or was dismissed / never ran), flush any
    // advertisement carousel that was held back so it still appears on first
    // launch — just after the coach marks, never on top of them.
    useEffect(() {
      void onTourChange() {
        if (tourActive.value) return;
        final dto = pendingAdvertisement.value;
        if (dto == null) return;
        pendingAdvertisement.value = null;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;
          HomeCarouselDialog.show(context: context, dto: dto);
        });
      }

      tourActive.addListener(onTourChange);
      return () => tourActive.removeListener(onTourChange);
    }, [tourActive]);

    // Opens the transaction-details sheet (and its receipt download/share) for
    // taps on the Recent Transactions section below, reusing the history
    // feature's own BLoC rather than duplicating the flow into home.
    return AppTransactionDetailsListener(
      child: LocaleBlocConsumer<HomeBloc, HomeState>(
        listenWhen: (prev, curr) =>
            prev.homeAdvertisementFailureOrSuccessOption !=
                curr.homeAdvertisementFailureOrSuccessOption ||
            prev.homeUserFailureOrSuccessOption !=
                curr.homeUserFailureOrSuccessOption ||
            prev.selectedTransferTypeItem != curr.selectedTransferTypeItem ||
            prev.selectedBankOrAgentItem != curr.selectedBankOrAgentItem ||
            prev.homeMandatoryFieldCheckFailureOrSuccessOption !=
                curr.homeMandatoryFieldCheckFailureOrSuccessOption ||
            prev.homeSendAgainAgentOption != curr.homeSendAgainAgentOption,
        listener: (context, state) {
          // One-shot: advertisement carousel — BLoC resets to none() immediately after.
          state.homeAdvertisementFailureOrSuccessOption.fold(() {}, (either) {
            either.fold((_) {}, (_) {
              // Defer while the one-time guided tour is pending/running so the
              // carousel never overlaps the coach marks; it is flushed when the
              // tour finishes (see the tourActive listener above). Otherwise show
              // it right away.
              if (tourActive.value) {
                pendingAdvertisement.value = state.homeAdvertisementDto;
              } else {
                HomeCarouselDialog.show(
                  context: context,
                  dto: state.homeAdvertisementDto,
                );
              }
            });
          });

          // One-shot: email verification — BLoC resets to none() immediately after.
          state.homeUserFailureOrSuccessOption.fold(() {}, (either) {
            either.fold((_) => null, (success) {
              final user = success.data?.user;
              final userEmail = user?.email;
              final isEmailVerified = user?.isEmailVerified ?? false;
              final isEmailVerificationRequired =
                  user?.isEmailVerificationRequired ?? false;
              final isKycExpired =
                  (user?.kYCStatus?.toLowerCase() == 'renewal') ||
                  (user?.kYCStatus?.toLowerCase() == 'expired');
              if (!isEmailVerified && isEmailVerificationRequired) {
                HapticFeedback.heavyImpact();
                AppNotify.dialog(
                  title: 'home.emailNotVerified.title'.tr(),
                  message: 'home.emailNotVerified.message'.tr(),
                  buttonText: 'buttons.verifyEmail'.tr(),
                  type: AppDialogType.warning,
                  onPressed: () {
                    context.router.pop();
                    context.replaceIfActive(
                      HomeEmailView(
                        email: (userEmail != null && userEmail.isNotEmpty)
                            ? userEmail
                            : null,
                      ),
                    );
                  },
                );
              } else if (isKycExpired) {
                HapticFeedback.heavyImpact();
                AppNotify.dialog(
                  title: 'home.kycExpired.title'.tr(),
                  message: 'home.kycExpired.message'.tr(),
                  buttonText: 'home.kycExpired.button'.tr(),
                  type: AppDialogType.warning,
                  onPressed: () {
                    context.router.pop();
                    context.read<UpdateKycBloc>().add(
                      UpdateKycEvent.initialized(
                        initialIdTypeCode: user?.identityTypeCode ?? '',
                        initialIdNumber: user?.idNumber ?? '',
                      ),
                    );
                    context.router.replaceAll([const UpdateKycRoute()]);
                  },
                );
              }
            });
          });

          // One-shot: send-again agent step, resolved BEFORE the mandatory
          // check. Only fires for the two cases that need UI — a failed agent
          // fetch (error dialog) or multiple agents (picker dialog). Single-option
          // and 406/empty corridors resolve silently in the BLoC.
          state.homeSendAgainAgentOption.fold(() {}, (either) {
            // Tapping a Send Again card only covers home's own body with the
            // loading overlay — the bottom nav, the drawer and the app bar stay
            // live — so the user can be on another tab or another screen by the
            // time the corridor's agents come back. Their tap is abandoned with
            // them: reacting here would open a picker (or push the summary, in
            // the check below) over whatever they moved to.
            if (!context.isScreenActive) return;
            either.fold(
              (failure) {
                HapticFeedback.heavyImpact();
                // The corridor answered, but with no agent and without the 406
                // that means "agent not required" — a dead end rather than an
                // outage, so it gets no retry: the same request would return
                // the same empty list.
                final beneficiary = state.tappedRecentBeneficiary;
                failure.maybeMap(
                  agentUnavailable: (_) => AppNotify.dialog(
                    message: 'home.sendAgain.agentUnavailable'.tr(),
                    type: AppDialogType.warning,
                    buttonText: 'buttons.ok'.tr(),
                    onPressed: () => context.router.pop(),
                  ),
                  // Agent fetch failed: block the flow behind an error dialog
                  // with a retry that re-runs the whole tap (agent fetch →
                  // mandatory check).
                  orElse: () => AppNotify.dialog(
                    message: 'home.sendAgain.agentLoadFailed'.tr(),
                    type: AppDialogType.error,
                    showTwoButtons: true,
                    buttonText: 'buttons.retry'.tr(),
                    secondButtonText: 'buttons.cancel'.tr(),
                    onPressed: () {
                      context.router.pop();
                      if (beneficiary == null) return;
                      context.read<HomeBloc>().add(
                        HomeEvent.recentBeneficiaryTapped(
                          beneficiary: beneficiary,
                        ),
                      );
                    },
                    onSecondPressed: () => context.router.pop(),
                  ),
                );
              },
              (agentDto) {
                // Multiple agents: let the user pick. Their choice re-enters the
                // BLoC, which then runs the mandatory check with it.
                HapticFeedback.selectionClick();
                context.pushIfActive(
                  AppSelectableRoute(
                    title: 'home.agent.label'.tr(),
                    commonSelectableDto: agentDto,
                    onSelected: (value) => context.read<HomeBloc>().add(
                      HomeEvent.recentBeneficiaryAgentSelected(agent: value),
                    ),
                  ),
                );
              },
            );
          });

          // One-shot: recent-beneficiary mandatory-field check — navigate to the
          // summary only when the beneficiary record still satisfies every field
          // the corridor/product currently requires.
          state.homeMandatoryFieldCheckFailureOrSuccessOption.fold(() {}, (
            either,
          ) {
            // Same abandoned-tap rule as the agent step above.
            if (!context.isScreenActive) return;
            either.fold(
              (failure) {
                HapticFeedback.heavyImpact();
                failure.maybeMap(
                  missingMandatoryFields: (f) {
                    final eId = state.tappedRecentBeneficiary?.eId ?? '';
                    // Cancel dismisses; Edit opens the beneficiary edit form so
                    // the user can fill in the fields the corridor now requires
                    // — mirrors the choose-beneficiary list flow.
                    AppNotify.dialog(
                      message: f.message,
                      type: AppDialogType.warning,
                      showTwoButtons: true,
                      buttonText: 'beneficiaries.actions.edit'.tr(),
                      secondButtonText: 'buttons.cancel'.tr(),
                      onPressed: () {
                        context.router.pop();
                        if (eId.isEmpty) return;
                        // Product-switch edit: the check response carries the
                        // product (name + code) it validated against, so drive
                        // the edit form's bank/agent override off that product —
                        // the form then surfaces (and saves) the fields the
                        // newly-required product now needs.
                        final product = f.product;
                        final bankOrAgentOverride = product != null
                            ? CommonSelectableItem(
                                titleName: product.name,
                                titleCode: product.code?.toString(),
                              )
                            : null;
                        context.read<BeneficiaryBloc>().add(
                          BeneficiaryEvent.getBeneficiaryById(
                            eId,
                            bankOrAgentOverride: bankOrAgentOverride,
                            // Continue straight to the summary once the now-
                            // mandatory fields are saved.
                            proceedToSummaryAfterSave: true,
                          ),
                        );
                        context.pushIfActive(const BeneficiaryEditForm());
                      },
                      onSecondPressed: () => context.router.pop(),
                    );
                  },
                  orElse: () {
                    AppNotify.toast(
                      'home.sendAgain.checkFailed'.tr(),
                      type: AppToastType.error,
                    );
                  },
                );
              },
              (_) {
                final eId = state.tappedRecentBeneficiary?.eId ?? '';
                if (eId.isEmpty) return;
                // Send Again now resolves the corridor's agent before this
                // check (single auto-selected, multiple picked, 406/none skipped),
                // so carry that agent into the summary. Empty ⇒ no agent, and the
                // summary falls back to the beneficiary's own agent.
                context.read<SummaryBloc>().add(
                  SummaryEvent.prepareSummary(
                    beneficiaryId: eId,
                    isTranslistRequired: true,
                    agentCode: state.sendAgainAgentItem?.titleCode ?? '',
                    agentName: state.sendAgainAgentItem?.titleName ?? '',
                  ),
                );
                context.pushIfActive(SummaryRoute());
              },
            );
          });
        },
        builder: (context, state) {
          // A critical first-load API failed (e.g. the user cancelled the retry
          // dialog): render a single full-screen retry instead of a broken layout.
          // Best-effort sections degrade in place and never reach here.
          if (state.criticalLoadFailed) {
            return AppScaffold(
              appBar: AppAppBar(
                centerTitle: false,
                actions: [
                  _HomeActionButton(
                    iconData: Icons.logout_rounded,
                    iconColor: colorScheme.error,
                    onTap: () {
                      context.router.replaceAll([MpinRoute()]);
                    },
                  ),
                  SizedBox(width: 12.w),
                ],
              ),
              body: HomeErrorView(
                onRetry: () =>
                    context.read<HomeBloc>().add(const HomeEvent.initialize()),
              ),
            );
          }
          return AppScaffold(
            onTapOutside: () => FocusScope.of(context).unfocus(),
            scaffoldKey: scaffoldKey,
            isLoading:
                state.isMandatoryFieldCheckLoading || isTransactionDetailsBusy,
            // No drawer while loading, so an edge swipe can't open it either.
            drawer: isAppBarLoading ? null : HomeDrawer(state: state),
            appBar: isAppBarLoading
                ? AppAppBar(
                    centerTitle: false,
                    titleWidget: const _HomeAppBarShimmer.title(),
                    leading: const Center(child: _HomeAppBarShimmer.action()),
                    actions: [
                      const _HomeAppBarShimmer.action(),
                      SizedBox(width: 8.w),
                      const _HomeAppBarShimmer.action(),
                      SizedBox(width: 12.w),
                    ],
                  )
                : AppAppBar(
                    centerTitle: false,
                    titleWidget: const AppLogo(),
                    leading: Center(
                      child: AppShowcase(
                        showcaseKey: menuShowcaseKey,
                        title: 'home.showcase.menu.title'.tr(),
                        description: 'home.showcase.menu.description'.tr(),
                        icon: Icons.menu_rounded,
                        targetBorderRadius: BorderRadius.circular(20.r),
                        targetPadding: const EdgeInsets.all(4),
                        child: _HomeActionButton(
                          iconData: Icons.menu_rounded,
                          onTap: () => scaffoldKey.currentState?.openDrawer(),
                        ),
                      ),
                    ),
                    actions: [
                      _HomeActionButton(
                        iconData: Icons.notifications_outlined,
                        onTap: () {
                          context.router.push(const NotificationRoute());
                        },
                      ),
                      SizedBox(width: 8.w),
                      _HomeActionButton(
                        iconData: Icons.logout_rounded,
                        iconColor: colorScheme.error,
                        onTap: () {
                          context.router.replaceAll([MpinRoute()]);
                        },
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
            body: RefreshIndicator(
              color: colorScheme.tertiary,
              onRefresh: () {
                final bloc = context.read<HomeBloc>();
                final completer = Completer<void>();
                // Only settle the spinner once THIS refresh cycle has actually
                // started (isRefreshing → true) and then finished (→ false).
                // Without the `sawRefreshing` latch an unrelated event emitting a
                // state (every non-refresh handler leaves isRefreshing at its
                // false default) between attaching the listener and the refresh's
                // first emit would complete the completer early and stop the
                // spinner while the reload is still in flight.
                var sawRefreshing = false;
                late StreamSubscription<HomeState> sub;
                sub = bloc.stream.listen((s) {
                  if (s.isRefreshing) {
                    sawRefreshing = true;
                  } else if (sawRefreshing) {
                    if (!completer.isCompleted) completer.complete();
                    sub.cancel();
                  }
                });
                bloc.add(const HomeEvent.initialize(isRefresh: true));
                return completer.future;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.isUserLoading)
                      const _HomeUserSectionShimmer()
                    else
                      HomeUserView(state: state),
                    if (state.isRecentBeneficiariesLoading)
                      const _HomeRecentBeneficiariesSectionShimmer()
                    else
                      AppShowcase(
                        showcaseKey: recentShowcaseKey,
                        title: 'home.showcase.recentBeneficiaries.title'.tr(),
                        description:
                            'home.showcase.recentBeneficiaries.description'
                                .tr(),
                        icon: Icons.people_alt_rounded,
                        child: HomeRecentBeneficiaryView(state: state),
                      ),
                    // Hairline separating the Send Again section from the
                    // receive-country / send-money form. Only shown when the
                    // Send Again section is actually rendered (it collapses
                    // to nothing when there are no recent beneficiaries).
                    if ((hasRecentBeneficiaries ||
                            state.isRecentBeneficiariesLoadFailed) &&
                        !state.isRecentBeneficiariesLoading)
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            // Fade in from the edges so the hairline reads as an
                            // intentional separator, brightest across the middle.
                            gradient: LinearGradient(
                              colors: [
                                context.appColors.glassBorder.withValues(
                                  alpha: 0.0,
                                ),
                                context.appColors.glassBorder.withValues(
                                  alpha: 0.35,
                                ),
                                context.appColors.glassBorder.withValues(
                                  alpha: 0.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (state.isSendMoneyFormLoading) ...[
                      const _HomeSendMoneyFormSectionShimmer(),
                      // Recent Transactions lives inside this same branch, so
                      // it needs its own placeholder here too — otherwise the
                      // first load draws the page as if the customer had never
                      // sent money and then grows a list under the CTA when it
                      // settles. `initialize` clears every section flag in one
                      // emit, so this swaps to the real list (or to nothing,
                      // for a first-time customer) at the same instant the form
                      // above it does.
                      const HomeRecentTransactionsShimmer(),
                      const _HomeTrustBadgesSectionShimmer(),
                    ] else ...[
                      // Section heading — the same accent bar + title as Quick
                      // Transfer above. It used to live inside the section card,
                      // which left the two home headings on different indents;
                      // out here they align down the page.
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
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
                              'home.sendMoney.title'.tr(),
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      // Every selection — destination, transfer type and the
                      // corridor-dependent bank/agent and agent rows — in one
                      // hairline-divided panel, so the step reads as a single
                      // control set instead of a stack of separately bordered
                      // boxes inside an outer card.
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                        child: HomeSelectFieldGroup(
                          children: [
                            AppShowcase(
                              showcaseKey: destinationShowcaseKey,
                              title: 'home.showcase.destination.title'.tr(),
                              description:
                                  'home.showcase.destination.description'.tr(),
                              icon: Icons.public_rounded,
                              targetPadding: EdgeInsets.zero,
                              targetBorderRadius: BorderRadius.circular(12.r),
                              child: HomeSendReceiveView(state: state),
                            ),
                            AppShowcase(
                              showcaseKey: transferTypeShowcaseKey,
                              title: 'home.showcase.transferType.title'.tr(),
                              description:
                                  'home.showcase.transferType.description'.tr(),
                              icon: Icons.swap_horiz_rounded,
                              targetPadding: EdgeInsets.zero,
                              targetBorderRadius: BorderRadius.circular(12.r),
                              child: HomeTransferTypeView(state: state),
                            ),
                            // Bank / Agent row — only takes a slot once the
                            // corridor resolves a payout list worth choosing
                            // from (or while that list is still resolving), so
                            // the group never draws a hairline against an empty
                            // row. Only wrap it in a coach mark when the user
                            // actually has a choice, so the tour never
                            // spotlights a shimmer.
                            if (HomeBankOrAgentView.isVisible(state))
                              hasBankOrAgent
                                  ? AppShowcase(
                                      showcaseKey: bankOrAgentShowcaseKey,
                                      title: 'home.showcase.bankOrAgent.title'
                                          .tr(),
                                      description:
                                          'home.showcase.bankOrAgent.description'
                                              .tr(),
                                      icon: Icons.account_balance_rounded,
                                      targetPadding: EdgeInsets.zero,
                                      targetBorderRadius: BorderRadius.circular(
                                        12.r,
                                      ),
                                      child: HomeBankOrAgentView(state: state),
                                    )
                                  : HomeBankOrAgentView(state: state),
                            // Agent row — sits directly below Bank / Agent and
                            // follows exactly the same visibility rule.
                            if (HomeAgentView.isVisible(state))
                              hasAgent
                                  ? AppShowcase(
                                      showcaseKey: agentShowcaseKey,
                                      title: 'home.showcase.agent.title'.tr(),
                                      description:
                                          'home.showcase.agent.description'
                                              .tr(),
                                      icon: Icons.support_agent_rounded,
                                      targetPadding: EdgeInsets.zero,
                                      targetBorderRadius: BorderRadius.circular(
                                        12.r,
                                      ),
                                      child: HomeAgentView(state: state),
                                    )
                                  : HomeAgentView(state: state),
                          ],
                        ),
                      ),
                      // Kept outside the group so these section messages never
                      // interrupt the row hairlines. Each collapses to nothing
                      // unless it has something to say, and at most one of them
                      // ever does: the single-option note needs exactly one
                      // transfer mode, which the corridor card's two states
                      // (load failed / nothing available) both rule out.
                      HomeTransferTypeNote(state: state),
                      // Why the corridor isn't usable, plus the retry for the one
                      // request that failed. Without it a broken corridor left
                      // the user on a form with empty rows and an inert CTA whose
                      // only escape was a full page refresh.
                      HomeCorridorNotice(state: state),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                        child: Builder(
                          builder: (context) {
                            // Home collects only the destination country and
                            // transfer type; the amount and remaining corridor
                            // details (bank/agent, payment) are gathered later in
                            // the flow. A transaction may only start once EVERY
                            // corridor API has succeeded and every selection it
                            // asks for has been made, and that rule lives in one
                            // place — HomeStateX.transactionBlocker — so the
                            // button's ready state and its explanation can never
                            // disagree, and no future loading or failure flag can
                            // be forgotten here. null ⇒ ready to continue.
                            final blocker = state.transactionBlocker;
                            // Copy for the hint line above the CTA and the toast
                            // raised when the idle button is tapped. The two
                            // unrecoverable-by-tapping cases (a failed corridor
                            // and a corridor with nothing to offer) are spelled
                            // out at length by HomeCorridorNotice just above, so
                            // here they only need to say why the button is idle.
                            final idleMessage = switch (blocker) {
                              null => null,
                              HomeTransactionBlocker.destinationLoadFailed =>
                                'validation.home.destinationLoadFailed'.tr(),
                              HomeTransactionBlocker.destinationUnavailable =>
                                'validation.home.destinationUnavailable'.tr(),
                              HomeTransactionBlocker.destinationMissing =>
                                'validation.home.destinationRequired'.tr(),
                              HomeTransactionBlocker.corridorResolving =>
                                'validation.home.corridorLoading'.tr(),
                              HomeTransactionBlocker.corridorLoadFailed =>
                                'validation.home.corridorLoadFailed'.tr(),
                              HomeTransactionBlocker.transferTypeUnavailable =>
                                'validation.home.transferTypeUnavailable'.tr(),
                              HomeTransactionBlocker.transferTypeMissing =>
                                'validation.home.transferTypeRequired'.tr(),
                              HomeTransactionBlocker.bankOrAgentUnavailable =>
                                'validation.home.bankOrAgentUnavailable'.tr(),
                              HomeTransactionBlocker.bankOrAgentMissing =>
                                'validation.home.bankOrAgentRequired'.tr(),
                              HomeTransactionBlocker.agentUnavailable =>
                                'validation.home.agentUnavailable'.tr(),
                              HomeTransactionBlocker.agentMissing =>
                                'validation.home.agentRequired'.tr(),
                            };

                            return AppShowcase(
                              showcaseKey: payNowShowcaseKey,
                              title: 'home.showcase.payNow.title'.tr(),
                              description: 'home.showcase.payNow.description'
                                  .tr(),
                              icon: Icons.person_search_rounded,
                              targetBorderRadius: BorderRadius.circular(14.r),
                              child: HomeChooseBeneficiaryButton(
                                isReady: idleMessage == null,
                                idleLabel: idleMessage,
                                onTap: () {
                                  context.read<HomeBloc>().add(
                                    const HomeEvent.getBeneficiaryList(),
                                  );
                                  context.router.push(
                                    const HomeBeneficiaryView(),
                                  );
                                },
                                onIdleTap: () {
                                  if (idleMessage == null) return;
                                  AppNotify.toast(
                                    idleMessage,
                                    type: AppToastType.error,
                                    position: AppToastPosition.top,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      AppShowcase(
                        showcaseKey: recentTransactionsShowcaseKey,
                        title: 'home.showcase.recentTransactions.title'.tr(),
                        description:
                            'home.showcase.recentTransactions.description'.tr(),
                        icon: Icons.receipt_long_rounded,
                        child: HomeRecentTransactionsView(state: state),
                      ),
                      const _HomeTrustBadgesSection(),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Trust badges ─────────────────────────────────────────────────────────────

class _HomeTrustBadgesSection extends HookWidget {
  const _HomeTrustBadgesSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final mountCtrl = useAnimationController(
      duration: const Duration(milliseconds: 480),
    );
    useEffect(() {
      final timer = Timer(const Duration(milliseconds: 80), mountCtrl.forward);
      return timer.cancel;
    }, const []);
    final mountCurve = useMemoized(
      () => CurvedAnimation(parent: mountCtrl, curve: Curves.easeOutCubic),
      const [],
    );

    final badges = [
      (
        icon: Icons.shield_outlined,
        title: 'home.trust.secure.title'.tr(),
        subtitle: 'home.trust.secure.subtitle'.tr(),
      ),
      (
        icon: Icons.bolt_outlined,
        title: 'home.trust.fast.title'.tr(),
        subtitle: 'home.trust.fast.subtitle'.tr(),
      ),
      (
        icon: Icons.lock_outline_rounded,
        title: 'home.trust.encrypted.title'.tr(),
        subtitle: 'home.trust.encrypted.subtitle'.tr(),
      ),
    ];

    return AnimatedBuilder(
      animation: mountCtrl,
      builder: (_, child) => Opacity(
        opacity: mountCurve.value,
        child: Transform.translate(
          offset: Offset(0, 12.h * (1.0 - mountCurve.value)),
          child: child,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 28.h),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
          decoration: context.glassPanel(
            borderRadius: BorderRadius.circular(16.r),
            shadowBlur: 14.r,
            shadowOffset: Offset(0, 5.h),
          ),
          child: Row(
            children: [
              for (int i = 0; i < badges.length; i++) ...[
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.appColors.brandFill.withValues(
                                alpha: 0.26,
                              ),
                              context.appColors.brandFill.withValues(
                                alpha: 0.12,
                              ),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.appColors.brandFill.withValues(
                              alpha: 0.34,
                            ),
                            width: 0.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.appColors.brandFill.withValues(
                                alpha: 0.18,
                              ),
                              blurRadius: 8,
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                        child: Icon(
                          badges[i].icon,
                          color: cs.tertiary,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        badges[i].title,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                          color: cs.onSurface,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        badges[i].subtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 9.sp,
                          color: cs.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < badges.length - 1)
                  Container(
                    width: 0.5,
                    height: 48.h,
                    color: context.appColors.glassBorder.withValues(
                      alpha: 0.12,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section shimmer widgets ───────────────────────────────────────────────────

/// Placeholder mirroring the trust-badges card: one glass panel with three
/// evenly-spaced columns, each a circular icon over two text lines.
class _HomeTrustBadgesSectionShimmer extends StatelessWidget {
  const _HomeTrustBadgesSectionShimmer();

  @override
  Widget build(BuildContext context) {
    Widget badge() => Expanded(
      child: Column(
        children: [
          AppShimmer(
            borderRadius: BorderRadius.circular(40.r),
            child: SizedBox(width: 40.w, height: 40.w),
          ),
          SizedBox(height: 8.h),
          AppShimmer(width: 56.w, height: 10.h),
          SizedBox(height: 4.h),
          AppShimmer(width: 72.w, height: 8.h),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 28.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: context.glassPanel(
          borderRadius: BorderRadius.circular(16.r),
          shadowBlur: 14.r,
          shadowOffset: Offset(0, 5.h),
        ),
        child: Row(
          children: [
            for (int i = 0; i < 3; i++) ...[
              badge(),
              if (i < 2) SizedBox(width: 8.w),
            ],
          ],
        ),
      ),
    );
  }
}

/// App-bar placeholders shown until the first load settles: same footprint as
/// the real logo / `_HomeActionButton`s, but with no gesture targets, so the
/// drawer, notifications and logout are unreachable mid-load.
class _HomeAppBarShimmer extends StatelessWidget {
  const _HomeAppBarShimmer.title() : isAction = false;

  const _HomeAppBarShimmer.action() : isAction = true;

  final bool isAction;

  @override
  Widget build(BuildContext context) {
    if (isAction) {
      return AppShimmer(
        borderRadius: BorderRadius.circular(20.r),
        child: SizedBox(width: 40.w, height: 40.w),
      );
    }
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: AppShimmer(width: 120, height: 18),
    );
  }
}

class _HomeUserSectionShimmer extends StatelessWidget {
  const _HomeUserSectionShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        children: [
          AppShimmer(
            width: 44.w,
            height: 44.h,
            borderRadius: BorderRadius.circular(22.r),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppShimmer(width: 120.w, height: 12.h),
              SizedBox(height: 6.h),
              AppShimmer(width: 170.w, height: 10.h),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeRecentBeneficiariesSectionShimmer extends StatelessWidget {
  const _HomeRecentBeneficiariesSectionShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppShimmer(
          width: 150.w,
          height: 14.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 75.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            separatorBuilder: (context, i) => SizedBox(width: 10.w),
            itemBuilder: (context, i) => AppShimmer(
              borderRadius: BorderRadius.circular(14.r),
              child: Container(
                width: 220.w,
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmer(width: 100.w, height: 12.h),
                    SizedBox(height: 8.h),
                    AppShimmer(width: 140.w, height: 10.h),
                    SizedBox(height: 8.h),
                    AppShimmer(width: 160.w, height: 10.h),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}

class _HomeSendMoneyFormSectionShimmer extends StatelessWidget {
  const _HomeSendMoneyFormSectionShimmer();

  @override
  Widget build(BuildContext context) {
    // Mirrors the settled Send Money section: the heading, the selector group
    // holding the receive-country and transfer-type rows, and the CTA. The
    // bank/agent and agent rows are omitted — they only appear once a corridor
    // resolves, well after this first-load shimmer is gone.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading bar.
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
          child: AppShimmer(width: 110, height: 12),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
          child: const HomeSelectFieldGroup(
            children: [HomeSelectFieldShimmer(), HomeSelectFieldShimmer()],
          ),
        ),
        // Choose Beneficiary CTA.
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: AppShimmer(
            height: 56,
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
      ],
    );
  }
}

// ── App bar action button ─────────────────────────────────────────────────────

class _HomeActionButton extends HookWidget {
  const _HomeActionButton({required this.iconData, this.onTap, this.iconColor});

  final IconData iconData;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final pressCtrl = useAnimationController(
      duration: const Duration(milliseconds: 60),
      reverseDuration: const Duration(milliseconds: 200),
    );

    final pressScale = useAnimation(
      Tween<double>(
        begin: 1.0,
        end: 0.86,
      ).animate(CurvedAnimation(parent: pressCtrl, curve: Curves.easeOut)),
    );

    final p = pressCtrl.value;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        pressCtrl.forward();
        HapticFeedback.lightImpact();
      },
      onTapUp: (_) {
        pressCtrl.reverse();
        onTap?.call();
      },
      onTapCancel: () => pressCtrl.reverse(),
      child: Transform.scale(
        scale: pressScale,
        child: SizedBox(
          width: 40.w,
          height: 40.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.lerp(
                    context.appColors.glass.withValues(alpha: 0.08),
                    context.appColors.glass.withValues(alpha: 0.18),
                    p,
                  ),
                  border: Border.all(
                    color: Color.lerp(
                      context.appColors.glassBorder.withValues(alpha: 0.14),
                      context.appColors.glassBorder.withValues(alpha: 0.30),
                      p,
                    )!,
                    width: 0.6,
                  ),
                ),
                child: Center(
                  child: Icon(
                    iconData,
                    size: 20.sp,
                    color: iconColor ?? colors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
