import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/beneficiary/beneficiary_bloc.dart';
import '../../application/home/home_bloc.dart';
import '../../application/summary/summary_bloc.dart';
import '../../domain/beneficiary/beneficiary_failure.dart';
import '../../domain/beneficiary/beneficiary_list_dto.dart';
import '../../domain/common/common_selectable_dto.dart';
import '../core/animation/list_reveal.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/bottom_sheet/app_action_sheet.dart';
import '../core/button/app_button.dart';
import '../core/notify/app_notify.dart';
import '../core/app_states/app_state_view.dart';
import '../core/overlay_loading/app_overlay_loading.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/theme/app_theme_ext.dart';
import '../core/widgets/locale_bloc_builder.dart';
import '../routes/app_navigation_guard.dart';
import '../routes/app_routes.gr.dart';
import 'widgets/beneficiary_shimmer_view.dart';
import 'widgets/beneficiary_tile.dart';

@RoutePage()
class BeneficiaryPage extends HookWidget {
  const BeneficiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final query = useState('');
    // eIds already revealed by the entrance animation. Kept on the page so it
    // survives the list widget remounting (e.g. clearing a no-results search)
    // and so only genuinely new rows animate on an add.
    final revealedIds = useRef(<String>{}).value;
    // Flipped once the first list fetch has settled (data or failure). Held on
    // the page rather than derived from the BLoC because the form handlers emit
    // `BeneficiaryState.initial()`, which would clear such a flag and drop the
    // list back to its first-load shimmer on every return from Add/Edit.
    final hasSettled = useRef(false);

    useEffect(() {
      context.read<BeneficiaryBloc>().add(
        const BeneficiaryEvent.getBeneficiaries(),
      );
      return null;
    }, const []);

    return LocaleBlocConsumer<BeneficiaryBloc, BeneficiaryState>(
      listenWhen: (prev, curr) =>
          curr.deleteBeneficiaryFailureOrSuccessOption !=
              prev.deleteBeneficiaryFailureOrSuccessOption ||
          curr.paymentAgentOption != prev.paymentAgentOption ||
          curr.paymentMandatoryCheckOption != prev.paymentMandatoryCheckOption,
      listener: (context, state) {
        _onDeleteResult(context, state);
        _onPaymentAgentResult(context, state);
        _onPaymentCheckResult(context, state);
      },
      builder: (context, state) {
        final list =
            state.beneficiaryListDto?.data?.beneficiaryList ??
            const <BeneficiaryList>[];
        final filtered = _filtered(list, query.value);

        // Only the list fetch drives these — not the form's country/record
        // loads that also flip isLoading — so tapping Add/Edit won't flash them.
        // The first load is gated on `hasSettled`, not on isListLoading: the
        // fetch is dispatched after the first build, so keying off the loading
        // flag alone rendered one frame of the empty view — cross-faded in and
        // straight back out by the AnimatedSwitcher — ahead of the shimmer.
        // The dto is preserved across later reloads, so reloading an empty list
        // (adding the first record) is a refresh, not a first load.
        if (state.beneficiaryListDto != null ||
            state.beneficiaryFailureOrSuccessOption.isSome()) {
          hasSettled.value = true;
        }
        final firstLoad = !hasSettled.value;
        final refreshing = state.isListLoading && hasSettled.value;

        return AppScaffold(
          // Covers the payment flow's agent fetch + mandatory check.
          isLoading: state.isPaymentLoading,
          appBar: AppAppBar(title: 'beneficiaries.title'.tr()),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    AppButton(
                      text: 'buttons.addNewBeneficiary'.tr(),
                      sideWidget: Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 20.sp,
                        color: context.appColors.onAccent,
                      ),
                      onTap: () {
                        context.read<BeneficiaryBloc>().add(
                          const BeneficiaryEvent.getBeneficiaryCountries(),
                        );
                        context.router.push(const BeneficiaryAddForm());
                      },
                    ),
                    if (!firstLoad && list.isNotEmpty) ...[
                      Divider(
                        height: 32.h,
                        color: context.appColors.glassBorder.withValues(
                          alpha: 0.12,
                        ),
                        thickness: 0.5,
                      ),
                      _SearchField(
                        controller: searchController,
                        hasQuery: query.value.isNotEmpty,
                        onChanged: (v) => query.value = v,
                        onClear: () {
                          searchController.clear();
                          query.value = '';
                        },
                      ),
                    ],
                    SizedBox(height: 16.h),
                    Expanded(
                      child: _ScanSweepOverlay(
                        active: refreshing,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 280),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.03),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              ),
                          child: _content(
                            firstLoad: firstLoad,
                            list: list,
                            filtered: filtered,
                            refreshing: refreshing,
                            revealedIds: revealedIds,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.isDeleting) const AppOverlayLoading(),
            ],
          ),
        );
      },
    );
  }

  /// The list-area content for the current state, keyed so [AnimatedSwitcher]
  /// can cross-fade between the shimmer, empty, no-results and list views.
  Widget _content({
    required bool firstLoad,
    required List<BeneficiaryList> list,
    required List<BeneficiaryList> filtered,
    required bool refreshing,
    required Set<String> revealedIds,
  }) {
    if (firstLoad) {
      return const BeneficiaryShimmerView(key: ValueKey('shimmer'));
    }
    if (list.isEmpty) {
      return AppEmptyView(
        key: const ValueKey('empty'),
        icon: Icons.people_outline_rounded,
        title: 'beneficiaries.empty.title'.tr(),
        subtitle: 'beneficiaries.empty.subtitle'.tr(),
      );
    }
    if (filtered.isEmpty) {
      return AppEmptyView(
        key: const ValueKey('no-results'),
        icon: Icons.search_off_rounded,
        title: 'beneficiaries.noSearchResults'.tr(),
      );
    }
    return _BeneficiaryList(
      key: const ValueKey('list'),
      list: filtered,
      // Hold taps while refreshing so a tile can't be acted on mid-replace.
      active: refreshing,
      revealedIds: revealedIds,
    );
  }

  void _onDeleteResult(BuildContext context, BeneficiaryState state) {
    state.deleteBeneficiaryFailureOrSuccessOption.fold(() {}, (either) {
      either.fold(
        (failure) => DialogHelper.show(
          context,
          type: AppDialogType.error,
          title: 'beneficiaries.delete.errorTitle'.tr(),
          message: failure.maybeMap(
            unableToDeleteBeneficiary: (e) => e.message,
            serverError: (e) => e.message,
            orElse: () => 'beneficiaries.delete.error'.tr(),
          ),
          onPressed: () => context.router.pop(),
        ),
        (_) {
          AppNotify.toast('beneficiaries.delete.success'.tr());
          // The deleted record may be in home's recent list — refresh only that.
          context.read<HomeBloc>().add(
            const HomeEvent.getHomeRecentBeneficiaries(),
          );
        },
      );
    });
  }

  // ── Payment (action-sheet) flow — mirrors home_recent_beneficiary_view ──────
  // One-shot: the agent step resolved BEFORE the mandatory check. Only fires for
  // the two UI cases — a failed agent fetch (error dialog) or multiple agents
  // (picker dialog). Single-option and 406/empty resolve silently in the BLoC.
  void _onPaymentAgentResult(BuildContext context, BeneficiaryState state) {
    state.paymentAgentOption.fold(() {}, (either) {
      // The payment overlay covers this page's body only — the bottom nav and
      // the app bar stay live — so the user can be on another tab or another
      // screen by the time the agents come back. Their tap goes with them:
      // reacting would open a picker (or push the summary, in the check below)
      // over whatever they moved to.
      if (!context.isScreenActive) return;
      either.fold(
        (_) {
          // Agent fetch failed: block behind an error dialog whose retry re-runs
          // the whole tap (agent fetch → mandatory check).
          final beneficiary = state.paymentBeneficiary;
          AppNotify.dialog(
            message: 'beneficiaries.payment.agentLoadFailed'.tr(),
            type: AppDialogType.error,
            showTwoButtons: true,
            buttonText: 'buttons.retry'.tr(),
            secondButtonText: 'buttons.cancel'.tr(),
            onPressed: () {
              context.router.pop();
              if (beneficiary == null) return;
              context.read<BeneficiaryBloc>().add(
                BeneficiaryEvent.paymentRequested(beneficiary: beneficiary),
              );
            },
            onSecondPressed: () => context.router.pop(),
          );
        },
        (agentDto) {
          // Multiple agents: let the user pick. Their choice re-enters the BLoC,
          // which then runs the mandatory check with it.
          context.pushIfActive(
            AppSelectableRoute(
              title: 'beneficiaries.payment.selectAgent'.tr(),
              commonSelectableDto: agentDto,
              onSelected: (value) => context.read<BeneficiaryBloc>().add(
                BeneficiaryEvent.paymentAgentSelected(agent: value),
              ),
            ),
          );
        },
      );
    });
  }

  // One-shot: mandatory-field check — navigate to the summary (carrying the
  // resolved agent) only when the record still satisfies every required field.
  void _onPaymentCheckResult(BuildContext context, BeneficiaryState state) {
    state.paymentMandatoryCheckOption.fold(() {}, (either) {
      // Same abandoned-tap rule as the agent step above.
      if (!context.isScreenActive) return;
      either.fold(
        (failure) {
          failure.maybeMap(
            missingMandatoryFields: (f) {
              final eId = state.paymentBeneficiary?.eId ?? '';
              // Edit opens the beneficiary edit form so the user can fill the
              // now-required fields; Cancel dismisses.
              AppNotify.dialog(
                message: f.message,
                type: AppDialogType.warning,
                showTwoButtons: true,
                buttonText: 'beneficiaries.actions.edit'.tr(),
                secondButtonText: 'buttons.cancel'.tr(),
                onPressed: () {
                  context.router.pop();
                  if (eId.isEmpty) return;
                  // Drive the edit off the product the check validated against.
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
                'beneficiaries.payment.checkFailed'.tr(),
                type: AppToastType.error,
              );
            },
          );
        },
        (_) {
          final eId = state.paymentBeneficiary?.eId ?? '';
          if (eId.isEmpty) return;
          // Carry the resolved agent (empty ⇒ no agent, summary falls back to
          // the beneficiary's own).
          context.read<SummaryBloc>().add(
            SummaryEvent.prepareSummary(
              beneficiaryId: eId,
              isTranslistRequired: true,
              agentCode: state.paymentAgentItem?.titleCode ?? '',
              agentName: state.paymentAgentItem?.titleName ?? '',
            ),
          );
          context.pushIfActive(SummaryRoute());
        },
      );
    });
  }

  static List<BeneficiaryList> _filtered(
    List<BeneficiaryList> list,
    String rawQuery,
  ) {
    final q = rawQuery.trim().toLowerCase();
    if (q.isEmpty) return list;
    bool matches(BeneficiaryList b) => [
      b.beneficiaryFirstName,
      b.beneficiaryLastName,
      b.beneficiaryBankName,
      b.currencyCode,
      b.beneficiaryCountryName,
    ].any((s) => (s ?? '').toLowerCase().contains(q));
    return list.where(matches).toList(growable: false);
  }
}

// ─── Search field ─────────────────────────────────────────────────────────────

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final bool hasQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.hasQuery,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyMedium,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'beneficiaries.searchHint'.tr(),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: 20.sp,
          color: cs.onSurface.withValues(alpha: 0.45),
        ),
        suffixIcon: hasQuery
            ? IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  size: 18.sp,
                  color: cs.onSurface.withValues(alpha: 0.45),
                ),
                onPressed: onClear,
              )
            : null,
      ),
    );
  }
}

// ─── List ─────────────────────────────────────────────────────────────────────

class _BeneficiaryList extends HookWidget {
  final List<BeneficiaryList> list;

  /// While true the list is reloading — taps are held so a tile can't be acted
  /// on as it's about to be replaced.
  final bool active;

  /// eIds already revealed. Rows in here render at rest; rows not in here
  /// animate in. Owned by the page so it outlives this widget.
  final Set<String> revealedIds;

  const _BeneficiaryList({
    super.key,
    required this.list,
    required this.active,
    required this.revealedIds,
  });

  @override
  Widget build(BuildContext context) {
    final reveal = useListReveal(revealedIds, _ids(list));

    return IgnorePointer(
      ignoring: active,
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 20.h),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.length,
        separatorBuilder: (_, _) => SizedBox(height: 10.h),
        itemBuilder: (context, i) {
          final b = list[i];
          return RevealItem(
            key: ValueKey('row-${b.eId ?? i}'),
            controller: reveal.controller,
            index: i,
            pop: reveal.isFresh(b.eId),
            child: BeneficiaryTile(
              beneficiary: b,
              onTap: () => _showActions(context, b),
              onMoreTap: () => _showActions(context, b),
            ),
          );
        },
      ),
    );
  }

  static Iterable<String> _ids(List<BeneficiaryList> list) =>
      list.map((b) => b.eId).whereType<String>().where((id) => id.isNotEmpty);

  void _showActions(BuildContext context, BeneficiaryList b) {
    final eId = b.eId ?? '';
    final appColors = context.appColors;
    final cs = Theme.of(context).colorScheme;

    AppActionSheet.show(
      context,
      title: 'beneficiaries.actions.title'.tr(),
      description: 'beneficiaries.actions.description'.tr(),
      items: [
        AppActionSheetItem(
          title: 'beneficiaries.actions.payment'.tr(),
          subtitle: 'beneficiaries.actions.paymentSubtitle'.tr(),
          icon: Icons.payments_outlined,
          // Brighter `success` (not successDark) so the icon/accent stays legible
          // on the dark theme's surface; in light it resolves to the solid green.
          color: appColors.success,
          onTap: () {
            if (eId.isEmpty) return;
            // Same flow as the home send again, driven entirely by
            // BeneficiaryBloc: resolve the agent → mandatory check → summary.
            context.read<BeneficiaryBloc>().add(
              BeneficiaryEvent.paymentRequested(beneficiary: b),
            );
          },
        ),
        AppActionSheetItem(
          title: 'beneficiaries.actions.edit'.tr(),
          subtitle: 'beneficiaries.actions.editSubtitle'.tr(),
          icon: Icons.edit_outlined,
          color: appColors.statusInitiated,
          onTap: () {
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
            _showDeleteConfirmation(context, eId, appColors, cs);
          },
        ),
      ],
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    String eId,
    dynamic appColors,
    ColorScheme cs,
  ) {
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
          color: cs.onSurface,
        ),
        onTap: () => context.router.pop(),
      ),
      secondaryButton: AppButton(
        text: 'buttons.delete'.tr(),
        backgroundColor: appColors.errorDark,
        onTap: () {
          context.router.pop();
          context.read<BeneficiaryBloc>().add(
            BeneficiaryEvent.deleteBeneficiary(eId),
          );
        },
      ),
    );
  }
}

// ─── In-place refresh affordance ──────────────────────────────────────────────

/// While [active], glides a soft accent "scanner" band down over the list — the
/// records stay fully legible underneath (no veil, no shimmer), signalling that
/// the directory is re-syncing after an add / edit / delete. A calmer sibling of
/// the summary card's orbiting glow, sized for a full scrolling list.
class _ScanSweepOverlay extends HookWidget {
  final Widget child;
  final bool active;

  const _ScanSweepOverlay({required this.child, required this.active});

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
      // Let the sweep bleed past the page's horizontal padding so the scanner
      // light spans the full screen width rather than stopping at the rows.
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: 0,
          bottom: 0,
          left: -16.w,
          right: -16.w,
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
