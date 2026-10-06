import 'dart:async';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/common/common_selectable_dto.dart';
import '../../domain/common/common_transaction_dto.dart';
import '../../domain/home/home_advertisement_dto.dart';
import '../../domain/home/home_beneficiary_list_dto.dart';
import '../../domain/home/home_failure.dart';
import '../../domain/home/home_mandatory_field_check_dto.dart';
import '../../domain/home/home_recent_beneficiaries_dto.dart';
import '../../domain/home/home_transfer_type_dto.dart';
import '../../domain/home/home_user_dto.dart';
import '../../domain/home/i_home_facade.dart';
import '../../domain/home/value_validators.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeFacade _homeFacade;

  HomeBloc(this._homeFacade) : super(HomeState.initial()) {
    on<_InitializeEvent>(_initialize);
    on<_GetHomeRecentBeneficiariesEvent>(_getHomeRecentBeneficiaries);
    on<_GetHomeRecentTransactionsEvent>(_getHomeRecentTransactions);
    on<_RecentBeneficiaryTappedEvent>(_onRecentBeneficiaryTappedToState);
    on<_RecentBeneficiaryAgentSelectedEvent>(_onRecentBeneficiaryAgentSelected);
    on<_DestinationCountrySelectedEvent>(_destinationCountrySelected);
    on<_GetHomeTransferTypesEvent>(_getHomeTransferTypes);
    on<_RetryCorridorEvent>(_retryCorridor);
    on<_TransferTypeSelectedEvent>(_transferTypeSelected);
    on<_GetHomeBankOrAgentListEvent>(_getHomeBankOrAgentList);
    on<_BankOrAgentSelectedEvent>(_bankOrAgentSelected);
    on<_GetHomeAgentListEvent>(_getHomeAgentList);
    on<_AgentSelectedEvent>(_agentSelected);
    on<_GetBeneficiaryListEvent>(_getBeneficiaryList);
    on<_SelectedBeneficiaryIndexChangedEvent>(_selectedBeneficiaryIndexChanged);
    on<_DeleteBeneficiaryEvent>(_onDeleteBeneficiaryToState);
    on<_SelectedBeneficiaryContinuePressedEvent>(
      _onSelectedBeneficiaryContinuePressedToState,
    );
    on<_CurrentEmailAddressChanged>(_onCurrentEmailAddressChangedToState);
    on<_UpdateEmailAddressChanged>(_onUpdateEmailAddressChangedToState);
    on<_RequestUpdateEmailAddressPressed>(
      _onRequestUpdateEmailAddressPressedToState,
    );
    on<_EmailOtpChanged>(_onEmailOtpChangedToState);
    on<_ContinueOtpButtonPressed>(_onContinueOtpButtonPressedToState);
  }

  // ── Single-lane API gate ────────────────────────────────────────────────

  /// Tail of the queue every facade call in this BLoC waits on, so home never
  /// has two requests in flight at once.
  ///
  /// `_initialize` already awaits its four endpoints in order, but that alone
  /// isn't enough: BLoC's default event transformer is *concurrent*, so
  /// separate handlers overlap freely — a pull-to-refresh landing on top of a
  /// running corridor chain, a recent-beneficiary tap during first load, a
  /// delete-driven recent-list refresh, a beneficiary-list fetch. Each of those
  /// would otherwise issue its request immediately, and firing several
  /// authenticated requests at once on the same session makes the backend
  /// contend server-side and answer 500 — which maps to
  /// `HomeFailure.serverError()` and trips the full-screen retry.
  ///
  /// Queueing them means request N starts only once request N-1 has settled.
  /// The stale-response guards downstream (`isStale` in the corridor fetches)
  /// already drop any result whose corridor the user has since moved past, so
  /// waiting a turn is always safe.
  Future<void> _requestLane = Future<void>.value();

  /// Runs [request] once every previously queued request has settled, and
  /// hands back its own result so each caller keeps its own return type.
  ///
  /// The lane itself is kept error-free: repositories return `Either` and don't
  /// throw, but a surprise throw is forwarded to *this* caller only rather than
  /// poisoning the tail and wedging every later request.
  Future<T> _serialize<T>(Future<T> Function() request) {
    final completer = Completer<T>();
    _requestLane = _requestLane.then((_) async {
      try {
        completer.complete(await request());
      } catch (e, stackTrace) {
        completer.completeError(e, stackTrace);
      }
    });
    return completer.future;
  }

  // ── Sequential initializer: fires the independent APIs one after another ──

  FutureOr<void> _initialize(
      _InitializeEvent event,
      Emitter<HomeState> emit,
      ) async {
    final isRefresh = event.isRefresh;
    final resetSelections = event.resetSelections;

    if (isRefresh) {
      emit(
        state.copyWith(
          isRefreshing: true,
          homeAdvertisementFailureOrSuccessOption: none(),
          homeUserFailureOrSuccessOption: none(),
          // Clear the previous attempt's corridor verdict so a refresh that
          // never reaches the chain (no destination resolves, or the critical
          // batch fails) can't leave a stale failure card sitting under a form
          // that has since been reloaded. The chain sets it again if it breaks
          // again. A non-refresh load resets via HomeState.initial() below.
          failedCorridorStage: null,
          isTransferTypeUnavailable: false,
          // Same reasoning for the receive-country verdicts: this attempt
          // decides them afresh, and a stale "couldn't load" must not outlive
          // the reload that fixes it.
          isDestinationLoadFailed: false,
          isDestinationUnavailable: false,
          // Post-transaction reset: dropping the selections here is all it
          // takes — every restore point downstream (destination, transfer
          // type, bank/agent) reads the previous selection from state and,
          // finding none, falls back to its first-load default. Stale list
          // data stays visible while the reload runs, unlike a cold
          // HomeState.initial() reset.
          selectedCommonDestinationItem: resetSelections
              ? null
              : state.selectedCommonDestinationItem,
          selectedTransferTypeItem: resetSelections
              ? null
              : state.selectedTransferTypeItem,
          selectedBankOrAgentItem: resetSelections
              ? null
              : state.selectedBankOrAgentItem,
          selectedAgentItem: resetSelections
              ? null
              : state.selectedAgentItem,
          selectedBeneficiaryIndex: resetSelections
              ? -1
              : state.selectedBeneficiaryIndex,
        ),
      );
    } else {
      emit(HomeState.initial());
    }

    // Fired one at a time, never concurrently: firing all four at once right
    // after login overwhelmed the backend (concurrent authenticated requests on
    // the same session contend server-side and surface as 500s, which map to
    // HomeFailure.serverError() and trip the full-screen retry). Awaiting each
    // in turn also means only the first request can hit a 401 and trigger the
    // token refresh; the rest reuse the freshly minted token.
    // Order puts the form-critical corridor inputs (user nationality →
    // destination currency) first; the advertisement (a promo dialog) is least
    // critical and goes last.
    // Each also goes through `_serialize`, so this batch additionally can't
    // overlap a request started by any *other* handler (a refresh, a
    // beneficiary tap) — see the single-lane API gate above.
    final userResult = await _serialize(() => _homeFacade.getHomeUserData());
    final destCurrencyResult = await _serialize(
      () => _homeFacade.getHomeDestinationCurrencyList(),
    );
    final beneficiariesResult = await _serialize(
      () => _homeFacade.getHomeBeneficiaries(),
    );
    final recentTransactionsResult = await _serialize(
      () => _homeFacade.getHomeRecentTransactions(),
    );
    final advertisementResult = await _serialize(
      () => _homeFacade.getHomeAdvertisement(),
    );

    // Process user nationality for destination auto-selection
    final userDto = userResult.fold((_) => null, (dto) => dto);
    final userNationalityCode = userDto?.data?.user?.nationalityCode;

    // Process destination currencies — separate fold closure avoids CurrencyList name clash
    CommonSelectableDto? destCurrencySelectableDto;
    CommonSelectableItem? selectedDestItem;
    // True when the fetch succeeded but the backend offers no receive country
    // at all — a dead end, and distinct from the fetch failing.
    var isDestinationUnavailable = false;
    destCurrencyResult.fold((_) {}, (dto) {
      final list = dto.data?.currencyList ?? [];
      // Materialise the (possibly empty) list either way. Leaving it null on an
      // empty response left HomeSendReceiveView — which shimmers precisely when
      // the dto is null — spinning forever on a row that would never arrive.
      destCurrencySelectableDto = CommonSelectableDto(
        data: CommonSelectableData(
          list: list
              .map(
                (e) => CommonSelectableItem(
              leading: e.flagUrl,
              titleName: e.countryName ?? '',
              titleCode: e.countryCode ?? '',
              trailingName: e.currencyName ?? '',
              trailingCode: e.currencyCode ?? '',
              decimalPlaces: e.decimalPlaces,
            ),
          )
              .toList(),
        ),
      );
      if (list.isEmpty) {
        isDestinationUnavailable = true;
        return;
      }
      // On refresh, restore the user's previously selected destination if still in the list
      final prevDest = isRefresh ? state.selectedCommonDestinationItem : null;
      final selected = prevDest != null
          ? list.firstWhereOrNull(
            (e) =>
        e.countryCode == prevDest.titleCode &&
            e.currencyCode == prevDest.trailingCode,
      ) ??
          list.firstWhere(
                (e) => e.countryCode == userNationalityCode,
            orElse: () => list.first,
          )
          : list.firstWhere(
            (e) => e.countryCode == userNationalityCode,
        orElse: () => list.first,
      );
      selectedDestItem = CommonSelectableItem(
        leading: selected.flagUrl,
        titleName: selected.countryName ?? '',
        titleCode: selected.countryCode ?? '',
        trailingName: selected.currencyName ?? '',
        trailingCode: selected.currencyCode ?? '',
        decimalPlaces: selected.decimalPlaces,
      );
    });

    // Only the two endpoints the screen cannot be drawn without trip the
    // full-screen retry: the user record (drives the greeting, the KYC/email
    // gates and the destination default) and the destination-currency list
    // (without it there is no corridor to build, so no transaction is
    // possible). The other two degrade in place instead of blanking a
    // working home — the recent-beneficiaries strip shows an inline retry
    // card, and a failed advertisement simply means no promo dialog. On
    // refresh nothing trips: stale data stays on screen and the global retry
    // dialog owns the failure.
    final criticalLoadFailed =
        !isRefresh && (userResult.isLeft() || destCurrencyResult.isLeft());
    // The send-money gate needs its own verdict on the receive-country list,
    // because `criticalLoadFailed` deliberately never trips on a refresh: that
    // path keeps stale data on screen AND skips the corridor chain, so a failed
    // refresh otherwise left every corridor flag at its innocent default and
    // the CTA ready over data nothing had re-validated.
    final isDestinationLoadFailed = destCurrencyResult.isLeft();

    final beneficiariesDto = beneficiariesResult.fold(
          (_) => null,
          (dto) => dto,
    );
    // What the strip will actually render: this fetch's list, or (on refresh)
    // the stale one it keeps on failure.
    final retainedBeneficiariesDto =
        beneficiariesDto ?? (isRefresh ? state.homeRecentBeneficiariesDto : null);
    final recentTransactionsDto = recentTransactionsResult.fold(
          (_) => null,
          (dto) => dto,
    );
    // Same keep-what-we-have rule as the strip above: a failed refresh leaves
    // the list the user is already looking at on screen.
    final retainedRecentTransactionsDto =
        recentTransactionsDto ??
            (isRefresh ? state.homeRecentTransactionsDto : null);
    final advertisementDto = advertisementResult.fold(
          (_) => null,
          (dto) => dto,
    );

    emit(
      state.copyWith(
        isUserLoading: false,
        isRecentBeneficiariesLoading: false,
        isRecentTransactionsLoading: false,
        isSendMoneyFormLoading: false,
        isRefreshing: false,
        criticalLoadFailed: criticalLoadFailed,
        isDestinationLoadFailed: isDestinationLoadFailed,
        isDestinationUnavailable: isDestinationUnavailable,
        // An empty receive-country list means there is no corridor to build,
        // so nothing selected under the previous one is still meaningful. A
        // *failed* fetch keeps the selections instead: the retry re-runs this
        // load and restores exactly what the user had picked.
        selectedCommonDestinationItem: isDestinationUnavailable
            ? null
            : state.selectedCommonDestinationItem,
        selectedTransferTypeItem: isDestinationUnavailable
            ? null
            : state.selectedTransferTypeItem,
        homeTransferTypeDto: isDestinationUnavailable
            ? null
            : state.homeTransferTypeDto,
        selectedBankOrAgentItem: isDestinationUnavailable
            ? null
            : state.selectedBankOrAgentItem,
        commonBankOrAgentSelectableDto: isDestinationUnavailable
            ? null
            : state.commonBankOrAgentSelectableDto,
        selectedAgentItem: isDestinationUnavailable
            ? null
            : state.selectedAgentItem,
        commonAgentSelectableDto: isDestinationUnavailable
            ? null
            : state.commonAgentSelectableDto,
        // Best-effort section: surface its own failure inline rather than
        // hiding an outage behind an empty strip — but only when there is
        // genuinely nothing to show. A failed refresh that still has stale
        // cards keeps them (the global retry dialog owns that failure).
        isRecentBeneficiariesLoadFailed:
            beneficiariesResult.isLeft() && retainedBeneficiariesDto == null,
        // Best-effort in the same way, and for the same reason: an outage must
        // not read as "you have never sent money".
        isRecentTransactionsLoadFailed:
            recentTransactionsResult.isLeft() &&
                retainedRecentTransactionsDto == null,
        // A resolved destination means the dependent chain (transfer type →
        // bank/agent) is about to fire via the queued events below. Mark the
        // corridor as loading now so consumers that gate on a settled chain
        // (e.g. the home coach-mark tour) don't observe the brief window
        // between this emit and the chain actually starting.
        isCorridorLoading: selectedDestItem != null,
        // User data (keep stale on refresh if new fetch failed)
        homeUserDto: userDto ?? (isRefresh ? state.homeUserDto : null),
        homeUserFailureOrSuccessOption: some(userResult),
        // Recent beneficiaries
        homeRecentBeneficiariesDto: retainedBeneficiariesDto,
        // Recent transactions
        homeRecentTransactionsDto: retainedRecentTransactionsDto,
        // Destination currency list (selection handled below via destinationCountrySelected)
        commonDestinationSelectableDto:
        destCurrencySelectableDto ??
            (isRefresh ? state.commonDestinationSelectableDto : null),
        // Advertisement — only trigger dialog on first load, not refresh
        homeAdvertisementDto: advertisementDto ?? state.homeAdvertisementDto,
        homeAdvertisementFailureOrSuccessOption: isRefresh
            ? none()
            : some(advertisementResult),
      ),
    );

    // Clear both one-shot options in a single emit so the listener only fires
    // once more (for the combined reset) instead of twice — one intermediate
    // emit with advertisement=none but user=some(result) would otherwise
    // re-trigger the user-data listener block a second time.
    emit(
      state.copyWith(
        homeAdvertisementFailureOrSuccessOption: none(),
        homeUserFailureOrSuccessOption: none(),
      ),
    );

    // Trigger the corridor chain if we resolved a destination country.
    // Use a fresh local so Dart flow analysis can narrow past the null check
    // (variables assigned inside closures can't be narrowed directly).
    final resolvedDestItem = selectedDestItem;
    if (resolvedDestItem != null && !criticalLoadFailed) {
      final prevDest = state.selectedCommonDestinationItem;
      final isSameDest =
          prevDest?.titleCode == resolvedDestItem.titleCode &&
              prevDest?.trailingCode == resolvedDestItem.trailingCode;

      if (!isSameDest) {
        // Destination changed (or first load): run full chain
        add(
          HomeEvent.destinationCountrySelected(
            selectedCommonDestinationItem: resolvedDestItem,
          ),
        );
      } else {
        // Same destination on refresh: bypass the duplicate-selection guard
        emit(state.copyWith(isCorridorLoading: true));
        add(const HomeEvent.getHomeTransferTypes());
      }
    }
  }

  FutureOr<void> _getHomeRecentBeneficiaries(
      _GetHomeRecentBeneficiariesEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        isRecentBeneficiariesLoading: true,
        isRecentBeneficiariesLoadFailed: false,
      ),
    );
    final result = await _serialize(() => _homeFacade.getHomeBeneficiaries());
    emit(
      state.copyWith(
        isRecentBeneficiariesLoading: false,
        // Best-effort section: a failure shows an inline retry card in place of
        // the strip instead of collapsing it to an indistinguishable "no recent
        // beneficiaries" gap.
        isRecentBeneficiariesLoadFailed: result.isLeft(),
        homeRecentBeneficiariesDto: result.fold((_) => null, (dto) => dto),
      ),
    );
  }

  FutureOr<void> _getHomeRecentTransactions(
      _GetHomeRecentTransactionsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        isRecentTransactionsLoading: true,
        isRecentTransactionsLoadFailed: false,
      ),
    );
    final result = await _serialize(
      () => _homeFacade.getHomeRecentTransactions(),
    );
    emit(
      state.copyWith(
        isRecentTransactionsLoading: false,
        // Best-effort section: a failure shows an inline retry card in place of
        // the list rather than collapsing it to an indistinguishable "no
        // transactions yet" gap.
        isRecentTransactionsLoadFailed: result.isLeft(),
        homeRecentTransactionsDto: result.fold((_) => null, (dto) => dto),
      ),
    );
  }

  FutureOr<void> _onRecentBeneficiaryTappedToState(
      _RecentBeneficiaryTappedEvent event,
      Emitter<HomeState> emit,
      ) async {
    final beneficiary = event.beneficiary;
    // Send-again flow: resolve the corridor's agent BEFORE the mandatory
    // field check, using the tapped beneficiary's own corridor
    // (country / currency / disbursal mode).
    emit(
      state.copyWith(
        isMandatoryFieldCheckLoading: true,
        tappedRecentBeneficiary: beneficiary,
        // Start each tap from a clean slate for both one-shots and the resolved
        // agent so a prior tap can't leak through.
        sendAgainAgentItem: null,
        homeMandatoryFieldCheckFailureOrSuccessOption: none(),
        homeSendAgainAgentOption: none(),
      ),
    );
    final agentResult = await _serialize(() => _homeFacade.getHomeAgentList(
      destinationCountryCode: beneficiary.beneficiaryCountryCode ?? '',
      destinationCurrencyCode: beneficiary.currencyCode ?? '',
      transferTypeCode: beneficiary.disbursalMode ?? '',
    ));
    await agentResult.fold(
          (failure) async {
        // Agent fetch failed (non-406 error): surface a dialog and stop — don't
        // run the mandatory check on an unresolved corridor.
        emit(
          state.copyWith(
            isMandatoryFieldCheckLoading: false,
            homeSendAgainAgentOption: some(left(failure)),
          ),
        );
        emit(state.copyWith(homeSendAgainAgentOption: none()));
      },
          (dto) async {
        final list = dto.data?.agentList ?? [];
        // An empty list only means "this corridor needs no agent" when the
        // backend said so with a 406, which the repository records as
        // `agentNotRequired`. The same strict rule the send-money gate applies:
        // an empty list on a 200 is a corridor that offers no agent at all, and
        // sending through it would post a transaction with no payout agent.
        // Report it like a failure so the tap stops here — but as its own
        // variant, because retrying returns the same empty answer.
        if (list.isEmpty && !dto.agentNotRequired) {
          emit(
            state.copyWith(
              isMandatoryFieldCheckLoading: false,
              homeSendAgainAgentOption: some(
                left(const HomeFailure.agentUnavailable()),
              ),
            ),
          );
          emit(state.copyWith(homeSendAgainAgentOption: none()));
          return;
        }
        // 406 "agent not required": skip the agent step and proceed with none.
        if (list.isEmpty) {
          await _runRecentBeneficiaryMandatoryCheck(beneficiary, null, emit);
          return;
        }
        // Single option ⇒ auto-select it as the default; proceed straight to
        // the mandatory check.
        if (list.length == 1) {
          final only = list.first;
          await _runRecentBeneficiaryMandatoryCheck(
            beneficiary,
            CommonSelectableItem(
              titleName: (only.name ?? '').toUpperCase(),
              titleCode: only.code ?? '',
            ),
            emit,
          );
          return;
        }
        // Multiple options ⇒ hand the list to the UI as a one-shot so it can
        // raise the picker dialog. The user's choice re-enters via
        // recentBeneficiaryAgentSelected, which then runs the mandatory check.
        final agentDto = CommonSelectableDto(
          data: CommonSelectableData(
            list: list
                .map(
                  (e) => CommonSelectableItem(
                titleName: (e.name ?? '').toUpperCase(),
                titleCode: e.code ?? '',
              ),
            )
                .toList(),
          ),
        );
        emit(
          state.copyWith(
            // Drop the loading overlay while the user makes a choice.
            isMandatoryFieldCheckLoading: false,
            homeSendAgainAgentOption: some(right(agentDto)),
          ),
        );
        emit(state.copyWith(homeSendAgainAgentOption: none()));
      },
    );
  }

  FutureOr<void> _onRecentBeneficiaryAgentSelected(
      _RecentBeneficiaryAgentSelectedEvent event,
      Emitter<HomeState> emit,
      ) async {
    final beneficiary = state.tappedRecentBeneficiary;
    // The tapped beneficiary should always be in state here (the picker only
    // opens after a tap), but guard anyway rather than run the check blind.
    if (beneficiary == null) return;
    await _runRecentBeneficiaryMandatoryCheck(beneficiary, event.agent, emit);
  }

  /// Shared tail of the send-again flow: run the beneficiary mandatory-field
  /// check with the already-resolved [agent] (null ⇒ no agent / not required),
  /// stashing the agent so the summary navigation can carry it forward.
  Future<void> _runRecentBeneficiaryMandatoryCheck(
      RecentBeneficiaryList beneficiary,
      CommonSelectableItem? agent,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        isMandatoryFieldCheckLoading: true,
        sendAgainAgentItem: agent,
        homeMandatoryFieldCheckFailureOrSuccessOption: none(),
      ),
    );
    final failureOrSuccess = await _serialize(() => _homeFacade.checkBeneficiaryMandatoryFields(
      beneficiaryId: beneficiary.eId ?? '',
      destinationCountryCode: beneficiary.beneficiaryCountryCode ?? '',
      disbursalModeName: beneficiary.disbursalMode ?? '',
      destinationCurrencyCode: beneficiary.currencyCode ?? '',
    ));
    emit(
      state.copyWith(
        isMandatoryFieldCheckLoading: false,
        homeMandatoryFieldCheckFailureOrSuccessOption: some(failureOrSuccess),
      ),
    );
    // One-shot: reset immediately so unrelated listener runs (any other
    // listenWhen condition firing) don't replay the toast/navigation.
    emit(state.copyWith(homeMandatoryFieldCheckFailureOrSuccessOption: none()));
  }

  // ── Chain: country selected → transfer types → bank/agent ──

  FutureOr<void> _destinationCountrySelected(
      _DestinationCountrySelectedEvent event,
      Emitter<HomeState> emit,
      ) async {
    final incoming = event.selectedCommonDestinationItem;
    if (state.selectedCommonDestinationItem?.titleCode == incoming.titleCode &&
        state.selectedCommonDestinationItem?.trailingCode ==
            incoming.trailingCode) {
      return;
    }
    emit(
      state.copyWith(
        isCorridorLoading: true,
        selectedCommonDestinationItem: incoming,
        // Keep the previous corridor's transfer-type selection so
        // getHomeTransferTypes can re-select the same mode by code when the
        // newly chosen country also offers it (e.g. "cash pickup" stays
        // selected across countries), only falling back to the first mode when
        // the new country lacks it.
        // Drop the previous corridor's bank/agent + agent *lists* so their
        // fields fall back to a shimmer while the new corridor loads instead of
        // showing stale options. The *selected items* are kept so the re-match
        // (by code) in the bank/agent → agent fetches can restore them if the
        // new corridor still offers the same option.
        commonBankOrAgentSelectableDto: null,
        commonAgentSelectableDto: null,
      ),
    );
    add(const HomeEvent.getHomeTransferTypes());
  }

  FutureOr<void> _getHomeTransferTypes(
      _GetHomeTransferTypesEvent event,
      Emitter<HomeState> emit,
      ) async {
    // Entry to the corridor chain (destination changed): clear any prior
    // corridor failure so the Pay Now gate reflects only this attempt.
    emit(
      state.copyWith(
        isTransferTypeLoading: true,
        failedCorridorStage: null,
        isTransferTypeUnavailable: false,
        // The 406 "agent not required" verdict belongs to the corridor that
        // produced it. Re-entering the chain invalidates it, and leaving it
        // standing would let the next corridor's empty agent list inherit a
        // pass it never earned.
        isAgentNotRequired: false,
      ),
    );
    // Capture the corridor this request is for so a late response can be
    // matched against the current selection below.
    final requestedCountry =
        state.selectedCommonDestinationItem?.titleCode ?? '';
    final requestedCurrency =
        state.selectedCommonDestinationItem?.trailingCode ?? '';
    final result = await _serialize(() => _homeFacade.getHomeTransferTypes(
      destinationCurrencyCode: requestedCurrency,
      destinationCountryCode: requestedCountry,
    ));
    // Stale-response guard (same race as _getHomeBankOrAgentList): the user may
    // have switched destination country while this was in flight, so a slower
    // earlier fetch must not overwrite the transfer types of the currently
    // selected corridor. If the selection has moved on, drop this response.
    if (state.selectedCommonDestinationItem?.titleCode != requestedCountry ||
        state.selectedCommonDestinationItem?.trailingCode !=
            requestedCurrency) {
      return;
    }
    result.fold(
          (_) => emit(
        state.copyWith(
          isTransferTypeLoading: false,
          isCorridorLoading: false,
          failedCorridorStage: HomeCorridorStage.transferType,
          // Chain broke: drop the previous corridor's context so stale
          // selections can't satisfy the Pay Now validation.
          selectedTransferTypeItem: null,
          homeTransferTypeDto: null,
          selectedBankOrAgentItem: null,
          commonBankOrAgentSelectableDto: null,
          selectedAgentItem: null,
          commonAgentSelectableDto: null,
        ),
      ),
          (dto) {
        emit(
          state.copyWith(
            isTransferTypeLoading: false,
            homeTransferTypeDto: dto,
          ),
        );
        final list = dto.data?.transferModeList ?? [];
        if (list.isNotEmpty) {
          final prevCode = state.selectedTransferTypeItem?.titleCode;
          final match = prevCode != null
              ? list.firstWhereOrNull((e) => e.code == prevCode) ?? list.first
              : list.first;
          add(
            HomeEvent.transferTypeSelected(
              selectedTransferTypeItem: CommonSelectableItem(
                titleName: match.name ?? '',
                titleCode: match.code ?? '',
              ),
            ),
          );
        } else {
          // No transfer modes for this corridor: same stale-context reset as
          // the failure branch — nothing downstream is valid. Flagged as
          // *unavailable* rather than failed, because retrying the same
          // corridor would return the same empty list; the UI asks the user to
          // choose another receive country instead.
          emit(
            state.copyWith(
              isCorridorLoading: false,
              isTransferTypeUnavailable: true,
              selectedTransferTypeItem: null,
              selectedBankOrAgentItem: null,
              commonBankOrAgentSelectableDto: null,
              selectedAgentItem: null,
              commonAgentSelectableDto: null,
            ),
          );
        }
      },
    );
  }

  /// Re-runs only the corridor request recorded in
  /// [HomeState.failedCorridorStage], reusing the selections already in state.
  ///
  /// Retrying the broken link rather than the whole page matters twice over:
  /// the user keeps the work they've done (country, transfer type, and any
  /// bank/agent pick), and the backend isn't handed a fresh burst of
  /// authenticated requests it would answer with 500s.
  FutureOr<void> _retryCorridor(
      _RetryCorridorEvent event,
      Emitter<HomeState> emit,
      ) async {
    final stage = state.failedCorridorStage;
    if (stage == null) return;
    final countryCode = state.selectedCommonDestinationItem?.titleCode ?? '';
    final currencyCode = state.selectedCommonDestinationItem?.trailingCode ?? '';
    final transferTypeCode = state.selectedTransferTypeItem?.titleCode ?? '';

    switch (stage) {
      case HomeCorridorStage.transferType:
        // Re-enter at the head of the chain; the handler clears the failure and
        // re-raises the loading flags itself.
        emit(state.copyWith(isCorridorLoading: true));
        add(const HomeEvent.getHomeTransferTypes());
      case HomeCorridorStage.bankOrAgent:
        // The transfer type resolved, so resume at the payout leg. Without a
        // transfer type there is nothing to resume with — restart the chain.
        if (transferTypeCode.isEmpty) {
          emit(state.copyWith(isCorridorLoading: true));
          add(const HomeEvent.getHomeTransferTypes());
          return;
        }
        emit(
          state.copyWith(
            isCorridorLoading: true,
            failedCorridorStage: null,
            isAgentNotRequired: false,
          ),
        );
        add(
          HomeEvent.getHomeBankOrAgentList(
            destinationCountryCode: countryCode,
            destinationCurrencyCode: currencyCode,
            transferTypeCode: transferTypeCode,
          ),
        );
      case HomeCorridorStage.agent:
        // Last link: the bank/agent list already landed, so only the agent
        // list needs re-fetching.
        if (transferTypeCode.isEmpty) {
          emit(state.copyWith(isCorridorLoading: true));
          add(const HomeEvent.getHomeTransferTypes());
          return;
        }
        emit(
          state.copyWith(
            isCorridorLoading: true,
            failedCorridorStage: null,
            isAgentNotRequired: false,
          ),
        );
        add(
          HomeEvent.getHomeAgentList(
            destinationCountryCode: countryCode,
            destinationCurrencyCode: currencyCode,
            transferTypeCode: transferTypeCode,
          ),
        );
    }
  }

  FutureOr<void> _transferTypeSelected(
      _TransferTypeSelectedEvent event,
      Emitter<HomeState> emit,
      ) async {
    if (event.fromUser &&
        state.selectedTransferTypeItem?.titleCode ==
            event.selectedTransferTypeItem.titleCode) {
      return;
    }
    emit(
      state.copyWith(
        selectedTransferTypeItem: event.selectedTransferTypeItem,
        // Re-entering the bank/agent → agent leg: mark the corridor as loading
        // again so the Pay/Choose button can't stay ready on the previous
        // corridor's bank/agent/agent selections while the new lists load. The
        // agent fetch (last link) clears this once the leg settles.
        isCorridorLoading: true,
        // Re-entering the bank/agent → agent leg: clear any prior corridor
        // failure so a fresh attempt starts clean.
        failedCorridorStage: null,
        // Drop the previous transfer type's bank/agent + agent *lists* so their
        // fields shimmer while the new leg loads instead of showing stale
        // options. The *selected items* stay for the re-match (by code) in the
        // bank/agent → agent fetches.
        commonBankOrAgentSelectableDto: null,
        commonAgentSelectableDto: null,
        // Corridor-scoped verdict, invalidated with the lists it described.
        isAgentNotRequired: false,
      ),
    );
    add(
      HomeEvent.getHomeBankOrAgentList(
        destinationCountryCode:
        state.selectedCommonDestinationItem?.titleCode ?? '',
        destinationCurrencyCode:
        state.selectedCommonDestinationItem?.trailingCode ?? '',
        transferTypeCode: event.selectedTransferTypeItem.titleCode ?? '',
      ),
    );
  }

  FutureOr<void> _getHomeBankOrAgentList(
      _GetHomeBankOrAgentListEvent event,
      Emitter<HomeState> emit,
      ) async {
    final result = await _serialize(() => _homeFacade.getHomeBankOrAgentList(
      destinationCountryCode: event.destinationCountryCode,
      destinationCurrencyCode: event.destinationCurrencyCode,
      transferTypeCode: event.transferTypeCode,
    ));
    // Stale-response guard. This request runs concurrently with any newer one
    // the user triggered by switching transfer type/corridor while it was in
    // flight (e.g. a slow cash-pickup fetch resolving after a fast bank fetch).
    // The latest selection is already committed to state before this event is
    // added, so if the request's params no longer match the current selection,
    // a newer request has superseded it — drop this result so it can't
    // overwrite the correct list. The winning request emits normally.
    final isStale =
        state.selectedTransferTypeItem?.titleCode != event.transferTypeCode ||
            state.selectedCommonDestinationItem?.titleCode !=
                event.destinationCountryCode ||
            state.selectedCommonDestinationItem?.trailingCode !=
                event.destinationCurrencyCode;
    if (isStale) return;
    result.fold(
          (_) => emit(
        state.copyWith(
          isCorridorLoading: false,
          failedCorridorStage: HomeCorridorStage.bankOrAgent,
          // Chain broke: drop the previous corridor's bank/agent context so
          // stale values can't satisfy the Pay Now validation.
          selectedBankOrAgentItem: null,
          commonBankOrAgentSelectableDto: null,
          selectedAgentItem: null,
          commonAgentSelectableDto: null,
        ),
      ),
          (dto) {
        final list = dto.data?.beneficiaryBankList ?? [];
        // Expose the list so the home Bank/Agent field can render + pick. Only
        // the display name and the product code are needed downstream, and the
        // product code is carried as the item's titleCode.
        final bankDto = CommonSelectableDto(
          data: CommonSelectableData(
            list: list
                .map(
                  (e) => CommonSelectableItem(
                titleName: (e.name ?? '').toUpperCase(),
                titleCode: e.code.toString(),
              ),
            )
                .toList(),
          ),
        );
        emit(state.copyWith(commonBankOrAgentSelectableDto: bankDto));
        if (list.isEmpty) {
          // A 200 carrying no payout option at all. This is NOT "no selection
          // required": the beneficiary list is fetched *by* product code and
          // only a payout option supplies one, so continuing would send
          // `product_code=''`. The row self-hides on an empty list, so the gate
          // used to see an unselected-but-invisible field and wave the user
          // through. Settle the corridor here — there is nothing for the agent
          // leg to resolve against either — and let the gate report it.
          emit(
            state.copyWith(
              isCorridorLoading: false,
              selectedBankOrAgentItem: null,
              selectedAgentItem: null,
              commonAgentSelectableDto: null,
              isAgentNotRequired: false,
            ),
          );
          return;
        }
        if (list.length == 1) {
          add(
            HomeEvent.bankOrAgentSelected(
              selectedBankOrAgent: (list.first.name ?? '').toUpperCase(),
              selectedBankOrAgentCode: list.first.code.toString(),
            ),
          );
        } else {
          final prevCode = state.selectedBankOrAgentItem?.titleCode;
          final match = prevCode != null
              ? list.firstWhereOrNull(
                (e) => e.code.toString() == prevCode,
          )
              : null;
          if (match != null) {
            add(
              HomeEvent.bankOrAgentSelected(
                selectedBankOrAgent: (match.name ?? '').toUpperCase(),
                selectedBankOrAgentCode: match.code.toString(),
              ),
            );
          } else {
            // Multiple options and no prior match — user must pick.
            emit(state.copyWith(selectedBankOrAgentItem: null));
          }
        }
        // The Agent list shares the corridor params (country/currency/disbursal)
        // and is the final link in the chain — kick it off now regardless of the
        // bank/agent outcome; the agent fetch owns the corridor-settled signal.
        add(
          HomeEvent.getHomeAgentList(
            destinationCountryCode: event.destinationCountryCode,
            destinationCurrencyCode: event.destinationCurrencyCode,
            transferTypeCode: event.transferTypeCode,
          ),
        );
      },
    );
  }

  FutureOr<void> _bankOrAgentSelected(
      _BankOrAgentSelectedEvent event,
      Emitter<HomeState> emit,
      ) async {
    if (event.fromUser &&
        state.selectedBankOrAgentItem?.titleCode ==
            event.selectedBankOrAgentCode) {
      return;
    }
    emit(
      state.copyWith(
        selectedBankOrAgentItem: CommonSelectableItem(
          titleName: event.selectedBankOrAgent,
          titleCode: event.selectedBankOrAgentCode,
        ),
        // The Agent list (fetched next) is the last link in the chain and owns
        // the corridor-settled signal, so don't clear isCorridorLoading here.
      ),
    );
  }

  FutureOr<void> _getHomeAgentList(
      _GetHomeAgentListEvent event,
      Emitter<HomeState> emit,
      ) async {
    final result = await _serialize(() => _homeFacade.getHomeAgentList(
      destinationCountryCode: event.destinationCountryCode,
      destinationCurrencyCode: event.destinationCurrencyCode,
      transferTypeCode: event.transferTypeCode,
    ));
    // Stale-response guard (same race as the bank/agent fetch): drop the result
    // if the corridor / transfer type moved on while this was in flight, so a
    // slower earlier fetch can't overwrite the current corridor's agent list.
    final isStale =
        state.selectedTransferTypeItem?.titleCode != event.transferTypeCode ||
            state.selectedCommonDestinationItem?.titleCode !=
                event.destinationCountryCode ||
            state.selectedCommonDestinationItem?.trailingCode !=
                event.destinationCurrencyCode;
    if (isStale) return;
    result.fold(
          (_) => emit(
        state.copyWith(
          // Chain broke: drop stale agent context and settle the corridor.
          isCorridorLoading: false,
          failedCorridorStage: HomeCorridorStage.agent,
          selectedAgentItem: null,
          commonAgentSelectableDto: null,
        ),
      ),
          (dto) {
        final list = dto.data?.agentList ?? [];
        // Expose the list so the home Agent field can render + pick. Only the
        // display name and the agent code are needed downstream, and the agent
        // code is carried as the item's titleCode.
        final agentDto = CommonSelectableDto(
          data: CommonSelectableData(
            list: list
                .map(
                  (e) => CommonSelectableItem(
                titleName: (e.name ?? '').toUpperCase(),
                titleCode: e.code ?? '',
              ),
            )
                .toList(),
          ),
        );
        // `agentNotRequired` is the repository's record of a 406 answer — the
        // one case in which an empty agent list still lets the flow continue.
        // Carried into state (rather than inferred from the empty list) so the
        // gate can tell it apart from a 200 that simply offers no agent.
        emit(
          state.copyWith(
            commonAgentSelectableDto: agentDto,
            isAgentNotRequired: dto.agentNotRequired,
          ),
        );
        if (list.length == 1) {
          add(
            HomeEvent.agentSelected(
              selectedAgent: (list.first.name ?? '').toUpperCase(),
              selectedAgentCode: list.first.code ?? '',
            ),
          );
        } else {
          final prevCode = state.selectedAgentItem?.titleCode;
          final match = prevCode != null
              ? list.firstWhereOrNull((e) => (e.code ?? '') == prevCode)
              : null;
          if (match != null) {
            add(
              HomeEvent.agentSelected(
                selectedAgent: (match.name ?? '').toUpperCase(),
                selectedAgentCode: match.code ?? '',
              ),
            );
          } else {
            // Multiple options (or none) and no prior match — nothing to
            // auto-select. The corridor chain has settled either way.
            emit(
              state.copyWith(
                selectedAgentItem: null,
                isCorridorLoading: false,
              ),
            );
          }
        }
      },
    );
  }

  FutureOr<void> _agentSelected(
      _AgentSelectedEvent event,
      Emitter<HomeState> emit,
      ) async {
    if (event.fromUser &&
        state.selectedAgentItem?.titleCode == event.selectedAgentCode) {
      return;
    }
    emit(
      state.copyWith(
        selectedAgentItem: CommonSelectableItem(
          titleName: event.selectedAgent,
          titleCode: event.selectedAgentCode,
        ),
        // Agent is the last link in the corridor chain — settle it.
        isCorridorLoading: false,
      ),
    );
  }

  FutureOr<void> _getBeneficiaryList(
      _GetBeneficiaryListEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        isBeneficiaryListLoading: true,
        isBeneficiaryListLoadFailed: false,
        selectedBeneficiaryIndex: -1,
        homeDeleteBeneficiaryFailureOrSuccessOption: none(),
        homeBeneficiaryListFailureOrSuccessOption: none(),
      ),
    );
    final failureOrSuccess = await _serialize(() => _homeFacade.getHomeBeneficiaryList(
      destinationCountryCode:
      state.selectedCommonDestinationItem?.titleCode ?? '',
      transferTypeCode: state.selectedTransferTypeItem?.titleCode ?? '',
      destinationCurrencyCode:
      state.selectedCommonDestinationItem?.trailingCode ?? '',
      // Bank/agent item carries the product code in subTitleCode and the
      // agent code in extraCode.
      productCode: state.selectedBankOrAgentItem?.titleCode ?? '',
    ));

    failureOrSuccess.fold(
          (f) => emit(
        state.copyWith(
          isBeneficiaryListLoading: false,
          // Drives the screen's retry state. Previously this failure was only
          // recorded in the one-shot option below, which nothing consumed, so
          // the screen fell through to its "no beneficiary found" empty state.
          isBeneficiaryListLoadFailed: true,
          homeBeneficiaryListFailureOrSuccessOption: some(left(f)),
        ),
      ),
          (dto) => emit(
        state.copyWith(
          isBeneficiaryListLoading: false,
          isBeneficiaryListLoadFailed: false,
          homeBeneficiaryListDto: dto,
          homeBeneficiaryListFailureOrSuccessOption: some(right(dto)),
        ),
      ),
    );
  }

  FutureOr<void> _selectedBeneficiaryIndexChanged(
      _SelectedBeneficiaryIndexChangedEvent event,
      Emitter<HomeState> emit,
      ) async {
    final isSameIndex =
        state.selectedBeneficiaryIndex == event.selectedBeneficiaryIndex;

    emit(
      state.copyWith(
        selectedBeneficiaryIndex: isSameIndex
            ? -1
            : event.selectedBeneficiaryIndex,
      ),
    );
  }

  FutureOr<void> _onDeleteBeneficiaryToState(
      _DeleteBeneficiaryEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        isDeletingBeneficiary: true,
        homeDeleteBeneficiaryFailureOrSuccessOption: none(),
      ),
    );
    final failureOrSuccess = await _serialize(() => _homeFacade.deleteBeneficiary(
      eId: event.eId,
    ));

    failureOrSuccess.fold(
          (f) => emit(
        state.copyWith(
          isDeletingBeneficiary: false,
          homeDeleteBeneficiaryFailureOrSuccessOption: some(left(f)),
        ),
      ),
          (success) {
        final updatedList = state.homeBeneficiaryListDto?.data?.beneficiaryList
            ?.where((e) => e.eId != event.eId)
            .toList();
        emit(
          state.copyWith(
            isDeletingBeneficiary: false,
            selectedBeneficiaryIndex: -1,
            homeBeneficiaryListDto: state.homeBeneficiaryListDto?.copyWith(
              data: state.homeBeneficiaryListDto?.data?.copyWith(
                beneficiaryList: updatedList ?? [],
              ),
            ),
            homeDeleteBeneficiaryFailureOrSuccessOption: some(right(success)),
          ),
        );
      },
    );
    // One-shot: reset immediately so later state emissions don't replay the
    // delete toast (same pattern as the mandatory-field check handlers).
    emit(state.copyWith(homeDeleteBeneficiaryFailureOrSuccessOption: none()));
  }

  FutureOr<void> _onSelectedBeneficiaryContinuePressedToState(
      _SelectedBeneficiaryContinuePressedEvent event,
      Emitter<HomeState> emit,
      ) async {
    final list = state.homeBeneficiaryListDto?.data?.beneficiaryList ?? [];
    final index = state.selectedBeneficiaryIndex;
    if (index < 0 || index >= list.length) return;
    final beneficiary = list[index];
    emit(
      state.copyWith(
        isMandatoryFieldCheckLoading: true,
        homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption: none(),
      ),
    );
    // Corridor context comes from the beneficiary record itself, matching the
    // recent-beneficiary flow: validating against the send-money selections
    // could pass the check on a different corridor than the one the payment
    // will actually use.
    final failureOrSuccess = await _serialize(() => _homeFacade.checkBeneficiaryMandatoryFields(
      beneficiaryId: beneficiary.eId ?? '',
      destinationCountryCode: beneficiary.beneficiaryCountryCode ?? '',
      disbursalModeName: beneficiary.disbursalMode ?? '',
      destinationCurrencyCode: beneficiary.currencyCode ?? '',
    ));
    emit(
      state.copyWith(
        isMandatoryFieldCheckLoading: false,
        homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption: some(
          failureOrSuccess,
        ),
      ),
    );
    // One-shot: reset immediately (same reason as above).
    emit(
      state.copyWith(
        homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onCurrentEmailAddressChangedToState(
      _CurrentEmailAddressChanged event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        currentEmailAddress: event.emailAddress.toLowerCase().trim(),
        homeRequestEmailOtpFailureOrSuccessOption: none(),
      ),
    );
    add(HomeEvent.updateEmailAddressChanged(emailAddress: event.emailAddress));
  }

  FutureOr<void> _onUpdateEmailAddressChangedToState(
      _UpdateEmailAddressChanged event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        emailAddress: EmailAddress(event.emailAddress),
        homeVerifyEmailOtpFailureOrSuccessOption: none(),
        homeRequestEmailOtpFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onRequestUpdateEmailAddressPressedToState(
      _RequestUpdateEmailAddressPressed event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        homeVerifyEmailOtpFailureOrSuccessOption: none(),
        homeRequestEmailOtpFailureOrSuccessOption: none(),
      ),
    );
    final isEmailValid = state.emailAddress.isValid();
    if (isEmailValid) {
      if (state.currentEmailAddress.toLowerCase() ==
          state.emailAddress.getOrCrash().toLowerCase()) {
        emit(
          state.copyWith(
            isSubmitting: false,
            showErrorMessages: true,
            homeRequestEmailOtpFailureOrSuccessOption: some(
              left(const HomeFailure.emailNotChanged()),
            ),
          ),
        );
        return;
      }
      final failureOrSuccess = await _serialize(() => _homeFacade.requestEmailOtp(
        email: state.emailAddress.getOrCrash(),
      ));

      failureOrSuccess.fold(
            (failure) => emit(
          state.copyWith(
            isSubmitting: false,
            homeRequestEmailOtpFailureOrSuccessOption: some(left(failure)),
          ),
        ),
            (_) => emit(
          state.copyWith(
            isSubmitting: false,
            homeRequestEmailOtpFailureOrSuccessOption: some(right(unit)),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          homeRequestEmailOtpFailureOrSuccessOption: none(),
        ),
      );
    }
  }

  FutureOr<void> _onEmailOtpChangedToState(
      _EmailOtpChanged event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        emailOtp: Otp(event.emailOtp),
        homeRequestEmailOtpFailureOrSuccessOption: none(),
        homeVerifyEmailOtpFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onContinueOtpButtonPressedToState(
      _ContinueOtpButtonPressed event,
      Emitter<HomeState> emit,
      ) async {
    emit(
      state.copyWith(
        isOtpSubmitting: true,
        homeRequestEmailOtpFailureOrSuccessOption: none(),
        homeVerifyEmailOtpFailureOrSuccessOption: none(),
      ),
    );
    final isOtpValid = state.emailOtp.isValid();
    if (isOtpValid) {
      final failureOrSuccess = await _serialize(() => _homeFacade.verifyEmailOtp(
        otp: state.emailOtp.getOrCrash(),
        email: state.emailAddress.getOrCrash(),
      ));

      failureOrSuccess.fold(
            (failure) => emit(
          state.copyWith(
            isOtpSubmitting: false,
            homeVerifyEmailOtpFailureOrSuccessOption: some(left(failure)),
          ),
        ),
            (_) => emit(
          state.copyWith(
            isOtpSubmitting: false,
            homeVerifyEmailOtpFailureOrSuccessOption: some(right(unit)),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          isOtpSubmitting: false,
          showOtpErrorMessages: true,
          homeVerifyEmailOtpFailureOrSuccessOption: none(),
        ),
      );
    }
  }
}
