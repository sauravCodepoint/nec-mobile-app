import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/beneficiary/beneficiary_bloc.dart';
import '../../../application/home/home_bloc.dart';
import '../../../application/summary/summary_bloc.dart';
import '../../../domain/common/common_selectable_dto.dart';
import '../../../domain/home/home_beneficiary_list_dto.dart';
import '../../../domain/home/home_failure.dart';
import '../../core/animation/list_reveal.dart';
import '../../core/app_bar/app_app_bar.dart';
import '../../core/app_states/app_state_view.dart';
import '../../core/bottom_sheet/app_action_sheet.dart';
import '../../core/button/app_button.dart';
import '../../core/dotted_border/app_dotted_border.dart';
import '../../core/global/app_global.dart';
import '../../core/notify/app_notify.dart';
import '../../core/scaffold/app_scaffold.dart';
import '../../core/showcase/app_showcase.dart';
import '../../core/showcase/app_showcase_tour.dart';
import '../../core/stepper/app_stepper.dart';
import '../../core/svg/app_svg.dart';
import '../../core/theme/app_theme_ext.dart';
import '../../core/widgets/app_beneficiary_tile.dart';
import '../../routes/app_navigation_guard.dart';
import '../../routes/app_routes.gr.dart';
import 'home_beneficiary_shimmer_view.dart';

@RoutePage()
class HomeBeneficiaryView extends HookWidget {
  const HomeBeneficiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    // ── Guided tour (one-time coach marks) ────────────────────────────────
    final contextShowcaseKey = useMemoized(GlobalKey.new, const []);
    final addBeneficiaryShowcaseKey = useMemoized(GlobalKey.new, const []);
    final listShowcaseKey = useMemoized(GlobalKey.new, const []);

    final tourState = context.watch<HomeBloc>().state;
    final hasBeneficiaries =
        (tourState.homeBeneficiaryListDto?.data?.beneficiaryList ?? [])
            .isNotEmpty;

    // Only start once the list fetch has actually settled — the first load
    // replaces the entire body with the skeleton, so none of the targets below
    // (context card, Add button, first tile) exist until then, and the list step
    // needs the final list before the step sequence is captured. Checking the
    // result option rather than the loading flag also covers the gap before the
    // fetch is dispatched: this screen is pushed in the same frame as the event.
    final showcaseReady =
        !tourState.isBeneficiaryListLoading &&
            tourState.homeBeneficiaryListFailureOrSuccessOption.isSome();

    useShowcaseTour(
      tourId: 'home_beneficiary',
      ready: showcaseReady,
      steps: [
        contextShowcaseKey,
        addBeneficiaryShowcaseKey,
        if (hasBeneficiaries) listShowcaseKey,
      ],
    );

    // Entrance animation state is owned here (not in the list widget) so it
    // outlives the list rebuilding; the cascade itself runs inside the list
    // widget, which only mounts once the records are actually shown.
    final revealedIds = useRef(<String>{}).value;
    // Per-screen load lifecycle: a fresh entry shows the skeleton; a reload while
    // already showing the list (after an add/edit) shows the refresh sweep.
    final hasSettled = useRef(false);
    // Outcome of the last *settled* fetch. Starts false on every visit, so a
    // stale list left in the BLoC from an earlier visit can't be treated as
    // loaded before this screen's own fetch resolves.
    final lastFetchSucceeded = useRef(false);

    return BlocConsumer<HomeBloc, HomeState>(
      // One-shot options only: run the listener when one of them actually
      // transitions, so an option a handler forgot to reset to none() can
      // never replay its toast/dialog on unrelated state changes.
      listenWhen: (previous, current) =>
      previous.homeDeleteBeneficiaryFailureOrSuccessOption !=
          current.homeDeleteBeneficiaryFailureOrSuccessOption ||
          previous.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption !=
              current
                  .homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,
      listener: (context, state) {
        state.homeDeleteBeneficiaryFailureOrSuccessOption.fold(
              () {},
              (either) => either.fold(
                (failure) {
              AppNotify.toast(
                'home.chooseBeneficiary.deleteBeneficiaryFailed'.tr(),
              );
            },
                (_) {
              AppNotify.toast(
                'home.chooseBeneficiary.deleteBeneficiarySuccess'.tr(),
              );
              // Keep the standalone manage list in sync by refetching from the
              // backend (same as the add/edit flow). Once opened, that tab is
              // kept alive in MainPage's IndexedStack and never re-fetches on
              // its own — and a refetch reflects the deletion regardless of eId
              // matching. (Before its first open the page isn't mounted, but
              // BeneficiaryBloc is provided app-wide, so the refetch still
              // lands and the tab opens on fresh data.)
              context.read<BeneficiaryBloc>().add(
                const BeneficiaryEvent.getBeneficiaries(),
              );
              // The deleted record may also be in home's recent list — refresh
              // just that section.
              context.read<HomeBloc>().add(
                const HomeEvent.getHomeRecentBeneficiaries(),
              );
            },
          ),
        );

        // One-shot: mandatory-field check for the selected beneficiary —
        // navigate to the summary only when the record satisfies every field
        // the corridor/product currently requires (BLoC resets to none()
        // immediately after emitting).
        state.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption.fold(
              () {},
              (either) {
            // The loading overlay covers this page's body only, so the user can
            // have pushed another screen while the check was in flight. Their
            // tap is abandoned with them rather than landing the summary (or an
            // edit form) on top of wherever they went.
            if (!context.isScreenActive) return;
            final beneficiaries =
                state.homeBeneficiaryListDto?.data?.beneficiaryList ?? [];
            final index = state.selectedBeneficiaryIndex;
            if (index < 0 || index >= beneficiaries.length) return;
            final selectedBeneficiary = beneficiaries[index];
            final eId = selectedBeneficiary.eId ?? '';

            either.fold(
                  (failure) {
                failure.maybeMap(
                  missingMandatoryFields: (f) {
                    // Cancel dismisses; Edit opens the beneficiary edit form so
                    // the user can fill in the fields the corridor now requires.
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
                            // mandatory fields are saved, instead of popping
                            // back to this list.
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
                // Home no longer carries an amount or payment method — the
                // summary gathers both itself from the beneficiary/corridor.
                // It does carry the corridor's picked agent (when any), which
                // overrides the beneficiary's own agent in the summary.
                context.read<SummaryBloc>().add(
                  SummaryEvent.prepareSummary(
                    beneficiaryId: eId,
                    agentCode: state.selectedAgentItem?.titleCode ?? '',
                    agentName: state.selectedAgentItem?.titleName ?? '',
                  ),
                );
                context.pushIfActive(SummaryRoute());
              },
            );
          },
        );
      },
      builder: (context, state) {
        final beneficiaries =
            state.homeBeneficiaryListDto?.data?.beneficiaryList ?? [];

        // Only the very first fetch of this screen shows the skeleton; a later
        // reload (after an add/edit/delete) keeps the list and shows the sweep.
        // Gated on the fetch having settled rather than on the loading flag, as
        // on the manage-beneficiary page: the fetch is dispatched in the same
        // frame this screen is pushed, so keying off the flag alone renders one
        // frame of content that the AnimatedSwitcher then cross-fades straight
        // back out. The latch makes every later reload a refresh, even one that
        // resolves to an empty list.
        if (state.homeBeneficiaryListFailureOrSuccessOption.isSome()) {
          hasSettled.value = true;
        }
        final firstLoad = !hasSettled.value;
        final refreshing = state.isBeneficiaryListLoading && hasSettled.value;
        // Outcome of the list fetch read straight off the result option instead
        // of inferred from the loading/failed flags: the BLoC clears it to
        // none() the moment a fetch starts, so it says nothing before the first
        // fetch is even dispatched (this screen is pushed in the same frame as
        // the event, with a stale list from an earlier visit still in state) or
        // while one is in flight. Latching the settled verdict is what lets a
        // refresh keep showing the list it already has.
        state.homeBeneficiaryListFailureOrSuccessOption.fold(() {}, (either) {
          lastFetchSucceeded.value = either.isRight();
        });
        // The Continue footer only belongs on screen once a successful fetch has
        // actually produced a list to choose from — never over the skeleton, a
        // stale list, the retry view or the empty state, where there is nothing
        // to continue with.
        final hasSelectableList =
            lastFetchSucceeded.value && beneficiaries.isNotEmpty;

        return AppScaffold(
          isLoading:
          state.isDeletingBeneficiary || state.isMandatoryFieldCheckLoading,
          appBar: AppAppBar(title: 'home.chooseBeneficiary.title'.tr()),
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
            // The first fetch takes over the whole body: the stepper, context
            // card and Add button are all skeletonised too, so the screen loads
            // as one page under a single shimmer sweep rather than a live header
            // sitting above a shimmering list.
            child: firstLoad
                ? const HomeBeneficiaryShimmerView(key: ValueKey('shimmer'))
                : Column(
              key: const ValueKey('content'),
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: AppStepper(
                          steps: [
                            'core.stepper.step1'.tr(),
                            'core.stepper.step2'.tr(),
                            'core.stepper.step3'.tr(),
                          ],
                          currentStep: 1,
                        ),
                      ),
                      AppShowcase(
                        showcaseKey: contextShowcaseKey,
                        title:
                        'home.chooseBeneficiary.showcase.context.title'
                            .tr(),
                        description:
                        'home.chooseBeneficiary.showcase.context.description'
                            .tr(),
                        icon: Icons.info_outline_rounded,
                        child: _ContextSummaryCard(state: state),
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: AppShowcase(
                          showcaseKey: addBeneficiaryShowcaseKey,
                          title:
                          'home.chooseBeneficiary.showcase.addBeneficiary.title'
                              .tr(),
                          description:
                          'home.chooseBeneficiary.showcase.addBeneficiary.description'
                              .tr(),
                          icon: Icons.person_add_alt_1_rounded,
                          targetBorderRadius: BorderRadius.circular(12.r),
                          child: AppButton(
                            text: 'buttons.addNewBeneficiary'.tr(),
                            onTap: () {
                              final selectedCommonDestinationItem =
                                  state.selectedCommonDestinationItem;
                              final selectedTransferTypeItem =
                                  state.selectedTransferTypeItem;
                              final selectedBankOrAgentItem =
                                  state.selectedBankOrAgentItem;
                              if (selectedCommonDestinationItem == null ||
                                  selectedTransferTypeItem == null ||
                                  selectedBankOrAgentItem == null) {
                                AppNotify.toast(
                                  'home.chooseBeneficiary.selectContextFirst'
                                      .tr(),
                                );
                                return;
                              }
                              context.read<BeneficiaryBloc>().add(
                                BeneficiaryEvent.prepareBeneficiaryForAddFromHome(
                                  beneficiaryCountry:
                                  selectedCommonDestinationItem,
                                  beneficiaryCurrency:
                                  selectedCommonDestinationItem,
                                  beneficiaryTransferType:
                                  selectedTransferTypeItem,
                                  beneficiaryBankOrAgent:
                                  selectedBankOrAgentItem,
                                ),
                              );
                              context.router.push(
                                const BeneficiaryAddForm(),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Expanded(
                        child: _SyncRefreshBar(
                          active: refreshing,
                          // A failed fetch must never fall through to the
                          // empty state below: "no beneficiary found" beside
                          // an Add New Beneficiary button reads as a fact
                          // about the user's account and invites them to
                          // re-create a recipient they already have. Offer
                          // the retry instead — this is the last call before
                          // the transaction, so it has to succeed.
                          child: state.isBeneficiaryListLoadFailed
                              ? AppErrorView(
                            key: const ValueKey('load-failed'),
                            title: 'network.error.dataLoadTitle'
                                .tr(),
                            subtitle:
                            'home.chooseBeneficiary.loadFailed'
                                .tr(),
                            retryLabel: 'buttons.retry'.tr(),
                            onRetry: () =>
                                context.read<HomeBloc>().add(
                                  const HomeEvent.getBeneficiaryList(),
                                ),
                          )
                              : beneficiaries.isEmpty
                              ? AppEmptyView(
                            key: const ValueKey('no-results'),
                            icon: Icons.search_off_rounded,
                            title:
                            'home.chooseBeneficiary.noBeneficiary'
                                .tr(),
                          )
                              : _HomeBeneficiaryList(
                            beneficiaries: beneficiaries,
                            selectedIndex:
                            state.selectedBeneficiaryIndex,
                            active: refreshing,
                            revealedIds: revealedIds,
                            listShowcaseKey: listShowcaseKey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // While the list is there, the footer keeps its slot
                // whether or not a beneficiary is picked, switching only
                // between disabled and enabled. Adding it to the tree on
                // selection would shrink the list's viewport at exactly the
                // wrong moment, swallowing the row the user just tapped if
                // it sat near the bottom of the screen.
                if (hasSelectableList)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: SafeArea(
                      child: AppButton(
                        text: 'buttons.continue'.tr(),
                        isDisabled: state.selectedBeneficiaryIndex == -1,
                        onTap: () {
                          if (beneficiaries.isEmpty) return;
                          // Navigation to the summary happens in the listener
                          // above once the mandatory-field check succeeds.
                          context.read<HomeBloc>().add(
                            const HomeEvent.selectedBeneficiaryContinuePressed(),
                          );
                        },
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

// ─── Selectable beneficiary list ──────────────────────────────────────────────

class _HomeBeneficiaryList extends HookWidget {
  final List<BeneficiaryList> beneficiaries;
  final int selectedIndex;
  final bool active;
  final Set<String> revealedIds;
  final GlobalKey listShowcaseKey;

  const _HomeBeneficiaryList({
    required this.beneficiaries,
    required this.selectedIndex,
    required this.active,
    required this.revealedIds,
    required this.listShowcaseKey,
  });

  @override
  Widget build(BuildContext context) {
    final reveal = useListReveal(
      revealedIds,
      beneficiaries
          .map((b) => b.eId)
          .whereType<String>()
          .where((id) => id.isNotEmpty),
    );

    return IgnorePointer(
      // Hold taps while refreshing so a tile can't be selected/acted on as it's
      // about to be replaced.
      ignoring: active,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ).add(EdgeInsets.only(bottom: 20.h)),
        itemCount: beneficiaries.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final b = beneficiaries[index];
          final tile = _HomeBeneficiaryTile(
            index: index,
            beneficiary: b,
            isSelected: selectedIndex == index,
            onSelect: () => context.read<HomeBloc>().add(
              HomeEvent.selectedBeneficiaryIndexChanged(
                selectedBeneficiaryIndex: index,
              ),
            ),
            onMoreTap: () => _showActions(context, b),
          );
          // Spotlight only the first tile during the guided tour — it stands in
          // for the whole selectable list.
          final child = index == 0
              ? AppShowcase(
            showcaseKey: listShowcaseKey,
            title: 'home.chooseBeneficiary.showcase.list.title'.tr(),
            description:
            'home.chooseBeneficiary.showcase.list.description'.tr(),
            icon: Icons.people_alt_rounded,
            child: tile,
          )
              : tile;
          return RevealItem(
            key: ValueKey('row-${b.eId ?? index}'),
            controller: reveal.controller,
            index: index,
            pop: reveal.isFresh(b.eId),
            child: child,
          );
        },
      ),
    );
  }
}

// ─── Context summary card ─────────────────────────────────────────────────────

class _ContextSummaryCard extends StatelessWidget {
  final HomeState state;

  const _ContextSummaryCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final destinationCountryName =
        state.selectedCommonDestinationItem?.titleName ?? '';
    final destinationCountryCode =
        state.selectedCommonDestinationItem?.titleCode ?? '';
    final transferTypeName = state.selectedTransferTypeItem?.titleName ?? '';

    return Container(
      padding: EdgeInsets.all(10).r,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ).add(EdgeInsets.only(bottom: 10.h)),
      decoration: context.glassPanel(
        borderRadius: BorderRadius.circular(10.r),
        shadowBlur: 10.r,
        shadowOffset: Offset(0, 3.h),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _infoColumn(
                context: context,
                leading: AppSvg(
                  asset: AppGlobal.getFlagAsset(destinationCountryCode),
                  width: 22.w,
                  height: 22.w,
                ),
                label: 'home.chooseBeneficiary.country'.tr(),
                value: destinationCountryName.toUpperCase(),
              ),
            ),
            SizedBox(width: 10.w),
            AppDottedDivider(
              color: context.appColors.glassBorder.withValues(alpha: 0.18),
              dotSize: 0.75,
              dotLength: 2,
              space: 5,
              height: 8,
              direction: Axis.vertical,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _infoColumn(
                context: context,
                leading: Icon(
                  Icons.swap_horiz_rounded,
                  size: 22.w,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: 'home.chooseBeneficiary.transferType'.tr(),
                value: transferTypeName,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Flag/icon on top, then a muted label and its bold value — the shared shape
  // for both the country and transfer-type sides so they sit symmetrically.
  Widget _infoColumn({
    required BuildContext context,
    required Widget leading,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        leading,
        SizedBox(height: 6.h),
        Text(label, style: theme.textTheme.bodySmall),
        SizedBox(height: 2.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.typography.secondary.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ─── Single beneficiary tile for the home selection list ──────────────────────

class _HomeBeneficiaryTile extends StatelessWidget {
  final int index;
  final BeneficiaryList beneficiary;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onMoreTap;

  const _HomeBeneficiaryTile({
    required this.index,
    required this.beneficiary,
    required this.isSelected,
    required this.onSelect,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final b = beneficiary;
    final name = [b.beneficiaryFirstName, b.beneficiaryLastName]
        .where((s) => s?.trim().isNotEmpty == true)
        .map((s) => s!.trim())
        .join(' ');

    return AppBeneficiaryTile(
      name: name,
      onTap: onSelect,
      onMoreTap: onMoreTap,
      rawAccountNumber: b.beneficiaryBankAccountNumber,
      disbursalMode: b.disbursalMode,
      countryCode: b.beneficiaryCountryCode,
      currencyCode: b.currencyCode,
      isSelected: isSelected,
      showRadio: true,
    );
  }
}

// ─── Actions helpers ──────────────────────────────────────────────────────────

void _showActions(BuildContext context, BeneficiaryList b) {
  final eId = b.eId ?? '';
  final appColors = context.appColors;

  AppActionSheet.show(
    context,
    title: 'beneficiaries.actions.title'.tr(),
    description: 'beneficiaries.actions.description'.tr(),
    items: [
      AppActionSheetItem(
        title: 'beneficiaries.actions.edit'.tr(),
        subtitle: 'beneficiaries.actions.editSubtitle'.tr(),
        icon: Icons.edit_outlined,
        color: appColors.statusInitiated,
        onTap: () {
          if (eId.isEmpty) return;
          context.read<BeneficiaryBloc>().add(
            BeneficiaryEvent.getBeneficiaryById(eId),
          );
          context.router.push(const BeneficiaryEditForm());
        },
      ),
      AppActionSheetItem(
        title: 'beneficiaries.actions.delete'.tr(),
        subtitle: 'beneficiaries.actions.deleteSubtitle'.tr(),
        icon: Icons.delete_outline_rounded,
        color: appColors.errorDark,
        isDestructive: true,
        onTap: () {
          if (eId.isEmpty) return;
          _showDeleteConfirmation(context, eId);
        },
      ),
    ],
  );
}

void _showDeleteConfirmation(BuildContext context, String eId) {
  final cs = Theme.of(context).colorScheme;
  final appColors = context.appColors;

  DialogHelper.show(
    context,
    type: AppDialogType.warning,
    title: 'beneficiaries.delete.confirmTitle'.tr(),
    message: 'beneficiaries.delete.confirmMessage'.tr(),
    showTwoButtons: true,
    primaryButton: AppButton(
      text: 'buttons.cancel'.tr(),
      backgroundColor: context.appColors.glassBorder.withValues(alpha: 0.12),
      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: cs.onPrimary,
      ),
      onTap: () => context.router.pop(),
    ),
    secondaryButton: AppButton(
      text: 'buttons.delete'.tr(),
      backgroundColor: appColors.errorDark,
      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: cs.onPrimary,
      ),
      onTap: () {
        context.router.pop();
        context.read<HomeBloc>().add(HomeEvent.deleteBeneficiary(eId));
      },
    ),
  );
}

// ─── In-place refresh affordance ──────────────────────────────────────────────

/// While [active], glides a soft accent "scanner" band down over the list — the
/// beneficiaries stay fully legible underneath (no veil, no shimmer), signalling
/// that the list is re-syncing after an add / edit / delete. Mirrors the manage
/// list's scanner sweep so the two sibling lists refresh with the same feel.
class _SyncRefreshBar extends HookWidget {
  final Widget child;
  final bool active;

  const _SyncRefreshBar({required this.child, required this.active});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1500),
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
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOut,
              opacity: active ? 1 : 0,
              child: ClipRect(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) => CustomPaint(
                    painter: _ScanSweepPainter(
                      progress: controller.value,
                      color: accent,
                    ),
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

class _ScanSweepPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ScanSweepPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final bandHeight = size.height * 0.30;
    final travel = size.height + bandHeight;
    final centerY = -bandHeight / 2 + progress * travel;
    final rect = Rect.fromLTWH(
      0,
      centerY - bandHeight / 2,
      size.width,
      bandHeight,
    );

    // Soft glow band that brightens the rows as it passes over them.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.0),
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.0),
          ],
        ).createShader(rect),
    );

    // Crisp leading light line at the band's centre.
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      Paint()
        ..color = color.withValues(alpha: 0.45)
        ..strokeWidth = 1.4
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
  }

  @override
  bool shouldRepaint(covariant _ScanSweepPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
