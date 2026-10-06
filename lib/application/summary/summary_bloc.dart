import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/common/common_branches_dto.dart';
import '../../domain/common/common_payment_result_dto.dart';
import '../../domain/common/common_selectable_dto.dart';
import '../../domain/common/common_send_money_dto.dart';
import '../../domain/summary/i_summary_facade.dart';
import '../../domain/summary/summary_beneficiary_by_id_dto.dart';
import '../../domain/summary/summary_branches_dto.dart';
import '../../domain/summary/summary_calculate_amount_dto.dart';
import '../../domain/summary/summary_currency_list_dto.dart';
import '../../domain/summary/summary_failure.dart';
import '../../domain/summary/summary_payment_method_dto.dart';
import '../../domain/summary/summary_payment_result_dto.dart';

part 'summary_event.dart';
part 'summary_state.dart';
part 'summary_bloc.freezed.dart';

@injectable
class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final ISummaryFacade _summaryFacade;

  // Stale-response guard for the amount calculations. Source and destination
  // changes are separate event types, so their switchMap transformers only
  // cancel in-flight work of their OWN kind — a source-driven calculate can
  // still be mid-flight when the user types a destination amount (and vice
  // versa). Whichever response returns last would win regardless of which
  // request was newest. Every calculation bumps this sequence and a result
  // is applied only if it is still the latest one.
  int _calcSeq = 0;

  SummaryBloc(this._summaryFacade) : super(SummaryState.initial()) {
    on<_PrepareSummary>(_onPrepareSummaryToState);
    on<_RetryBeneficiary>(_onRetryBeneficiaryToState);
    on<_RetryPaymentMethod>(_onRetryPaymentMethodToState);
    on<_BeneficiaryUpdatedChanged>(_onBeneficiaryUpdatedChangedToState);
    on<_SourceAmountChanged>(
      _onSourceAmountChangedToState,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );
    on<_DestinationAmountChanged>(
      _onDestinationAmountChangedToState,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );
    on<_PaymentMethodChanged>(_onPaymentMethodChangedToState);
    on<_GetBranches>(_onGetBranchesToState);
    on<_BranchChanged>(_onBranchChangedToState);
    on<_CreatePayAtBranchTransaction>(_onCreatePayAtBranchTransactionToState);
    on<_RoundOffDecision>(_onRoundOffDecisionToState);
  }

  // ── Progressive parallel initialiser ──────────────────────────────────────
  //
  // All 4 APIs fire simultaneously. Each section emits its own state update the
  // moment its API resolves — sections with cached data (currency lists, payment
  // modes) appear almost instantly while slower endpoints are still in flight.
  //
  // Cross-dependency: destination currency selection depends on the beneficiary's
  // currencyCode. Two resolution paths handle both orderings:
  //   • Beneficiary arrives AFTER dest currency: _onBeneficiaryResolved
  //     re-derives the selection from whatever is already in state.
  //   • Dest currency arrives AFTER beneficiary: _onDestCurrencyResolved reads
  //     the beneficiary already in state and matches correctly.
  //
  // Dart is single-threaded; .then callbacks are serialised on the event loop,
  // so concurrent emit() calls never interleave and state.copyWith() always
  // reads the latest emitted state.

  FutureOr<void> _onPrepareSummaryToState(
      _PrepareSummary event,
      Emitter<SummaryState> emit,
      ) async {
    // This bloc is app-scoped: a calculation still in flight from a previous
    // summary session must never land on the freshly reset state below.
    _calcSeq++;

    // Reset to a clean slate with the full-page shimmer up (isInitialLoading
    // defaults to true). The whole screen stays a shimmer until every section
    // has resolved and the first rate calculation has landed, so the page
    // appears once, fully populated, instead of piecing itself together.
    emit(
      SummaryState.initial().copyWith(
        beneficiaryId: event.beneficiaryId,
        isTranslistRequired: event.isTranslistRequired,
        homeAgentCode: event.agentCode,
        homeAgentName: event.agentName,
      ),
    );

    // Fire all 4 concurrently; each .then emits as soon as that API resolves.
    await Future.wait([
      _summaryFacade
          .getBeneficiaryById(
        event.beneficiaryId,
        isTranslistRequired: event.isTranslistRequired,
      )
          .then(
            (r) => _onBeneficiaryResolved(
          r,
          emit,
          requestedId: event.beneficiaryId,
        ),
      ),
      _summaryFacade.getHomeSourceCurrencyList().then(
            (r) => _onSourceCurrencyResolved(r, emit),
      ),
      _summaryFacade.getHomeDestinationCurrencyList().then(
            (r) => _onDestCurrencyResolved(r, emit),
      ),
      _summaryFacade.getSummaryPaymentMethod().then(
            (r) => _onPaymentMethodResolved(r, emit),
      ),
    ]);

    // Every .then has run and state reflects all 4 results. If every input is
    // present, kick off the first rate calculation — the calc handler drops the
    // full-page shimmer (isInitialLoading = false) once the rate lands, so the
    // page reveals fully populated. If an input is missing (a section failed),
    // no calc will run, so drop the shimmer now and let those sections show
    // their own error/retry views.
    if (_hasAllCalcInputs) {
      _maybeAutoCalculate();
    } else {
      emit(state.copyWith(isInitialLoading: false));
    }
  }

  // ── Per-section resolution helpers ────────────────────────────────────────

  void _onBeneficiaryResolved(
      Either<SummaryFailure, SummaryBeneficiaryByIdDto> result,
      Emitter<SummaryState> emit, {
        required String requestedId,
      }) {
    // Stale-response guard: bloc handles events concurrently, so if the user
    // backed out of a slow-loading summary and opened a different beneficiary
    // before this fetch resolved, a newer prepareSummary has already reset
    // state.beneficiaryId. Never let the old beneficiary overwrite the new one.
    if (state.beneficiaryId != requestedId) return;

    final beneficiaryDto = result.fold((_) => null, (dto) => dto);
    final beneficiary = beneficiaryDto?.data?.beneficiaryById;

    // Re-derive destination selection if the currency list already landed.
    // Handles the case where dest currency resolved before beneficiary.
    final updatedDestItem = _matchDestItemForBeneficiary(
      beneficiary,
      state.commonDestinationSelectableDto?.data?.list ?? [],
    );

    // Re-derive payment-method selection if the payment modes already landed.
    // Handles the case where payment methods resolved before the beneficiary
    // (same both-orderings guarantee as the destination currency above):
    // without this, Send Again — which passes no initial payment item —
    // would stay on modes.first instead of the beneficiary's last-used mode.
    CommonSelectableItem? updatedPaymentItem;
    final existingModes = state.summaryPaymentMethodDto?.data?.paymentModes;
    final lastUsedPaymentCode =
        beneficiary?.tranList?.firstOrNull?.paymentModeCode;
    if (lastUsedPaymentCode != null && existingModes != null) {
      final match = existingModes.firstWhereOrNull(
            (m) => m.code?.toUpperCase() == lastUsedPaymentCode.toUpperCase(),
      );
      if (match != null) {
        updatedPaymentItem = CommonSelectableItem(
          titleName: match.name ?? '',
          titleCode: match.code ?? '',
        );
      }
    }

    emit(
      state.copyWith(
        isBeneficiaryLoading: false,
        beneficiaryFailure: result.fold((f) => f, (_) => null),
        summaryBeneficiaryByIdDto: beneficiaryDto,
        selectedCommonDestinationItem:
        updatedDestItem ?? state.selectedCommonDestinationItem,
        selectedPaymentMethodItem:
        updatedPaymentItem ?? state.selectedPaymentMethodItem,
        summaryBeneficiaryByIdFailureOrSuccessOption: some(result),
      ),
    );
  }

  void _onSourceCurrencyResolved(
      Either<SummaryFailure, SummaryCurrencyListDto> result,
      Emitter<SummaryState> emit,
      ) {
    CommonSelectableDto? selectableDto;
    CommonSelectableItem? selectedItem;
    result.fold((_) {}, (dto) {
      final list = dto.data?.currencyList ?? [];
      if (list.isEmpty) return;
      final items = _toCurrencySelectableItems(list);
      selectableDto = CommonSelectableDto(
        data: CommonSelectableData(list: items),
      );
      selectedItem = items.first;
    });

    emit(
      state.copyWith(
        commonSourceSelectableDto:
        selectableDto ?? state.commonSourceSelectableDto,
        selectedCommonSourceItem:
        selectedItem ?? state.selectedCommonSourceItem,
        summarySourceCurrencyListFailureOrSuccessOption: some(result),
      ),
    );
  }

  void _onDestCurrencyResolved(
      Either<SummaryFailure, SummaryCurrencyListDto> result,
      Emitter<SummaryState> emit,
      ) {
    CommonSelectableDto? selectableDto;
    CommonSelectableItem? selectedItem;
    result.fold((_) {}, (dto) {
      final list = dto.data?.currencyList ?? [];
      if (list.isEmpty) return;
      final items = _toCurrencySelectableItems(list);
      selectableDto = CommonSelectableDto(
        data: CommonSelectableData(list: items),
      );
      // Match the beneficiary's country+currency if already available;
      // fall back to the first item.
      selectedItem =
          _matchDestItemForBeneficiary(
            state.summaryBeneficiaryByIdDto?.data?.beneficiaryById,
            items,
          ) ??
              items.first;
    });

    emit(
      state.copyWith(
        commonDestinationSelectableDto:
        selectableDto ?? state.commonDestinationSelectableDto,
        selectedCommonDestinationItem:
        selectedItem ?? state.selectedCommonDestinationItem,
        summaryDestinationCurrencyListFailureOrSuccessOption: some(result),
      ),
    );
  }

  void _onPaymentMethodResolved(
      Either<SummaryFailure, SummaryPaymentMethodDto> result,
      Emitter<SummaryState> emit,
      ) {
    CommonSelectableDto? selectableDto;
    SummaryPaymentMethodDto? paymentMethodDto;
    CommonSelectableItem? selectedItem;
    result.fold((_) {}, (dto) {
      final modes = dto.data?.paymentModes ?? [];
      if (modes.isEmpty) return;
      paymentMethodDto = dto;
      final beneficiary =
          state.summaryBeneficiaryByIdDto?.data?.beneficiaryById;
      // No incoming payment preference from home anymore — fall back to the
      // beneficiary's last-used mode, then modes.first.
      final preferredCode = beneficiary?.tranList?.firstOrNull?.paymentModeCode;
      final selected = preferredCode != null
          ? modes.firstWhereOrNull(
            (m) => m.code?.toUpperCase() == preferredCode.toUpperCase(),
      ) ??
          modes.first
          : modes.first;
      selectableDto = CommonSelectableDto(
        data: CommonSelectableData(
          list: modes
              .map(
                (m) => CommonSelectableItem(
              titleName: m.name ?? '',
              titleCode: m.code ?? '',
            ),
          )
              .toList(),
        ),
      );
      selectedItem = CommonSelectableItem(
        titleName: selected.name ?? '',
        titleCode: selected.code ?? '',
      );
    });

    emit(
      state.copyWith(
        isPaymentMethodLoading: false,
        paymentMethodFailure: result.fold((f) => f, (_) => null),
        summaryPaymentMethodDto: paymentMethodDto,
        commonPaymentMethodSelectableDto:
        selectableDto ?? state.commonPaymentMethodSelectableDto,
        selectedPaymentMethodItem:
        selectedItem ?? state.selectedPaymentMethodItem,
        summaryPaymentMethodFailureOrSuccessOption: some(result),
      ),
    );
  }

  // Every input the initial rate calculation needs is in state.
  bool get _hasAllCalcInputs =>
      state.summaryBeneficiaryByIdDto != null &&
          state.selectedCommonSourceItem != null &&
          state.selectedCommonDestinationItem != null &&
          state.selectedPaymentMethodItem != null;

  // Triggers rate calculation when all required inputs are present.
  // Called after all 4 parallel APIs resolve.
  void _maybeAutoCalculate() {
    if (_hasAllCalcInputs) {
      add(SummaryEvent.paymentMethodChanged(state.selectedPaymentMethodItem!));
    }
  }

  // ── Section-level retry ──────────────────────────────────────────────────
  //
  // The user never needs to close and reopen the app. A "Retry" button in each
  // failed section re-fetches only that section's data and, when successful,
  // re-triggers the rate calculation chain.

  FutureOr<void> _onRetryBeneficiaryToState(
      _RetryBeneficiary event,
      Emitter<SummaryState> emit,
      ) async {
    final id = state.beneficiaryId ?? '';
    if (id.isEmpty) return;

    emit(
      state.copyWith(
        isBeneficiaryLoading: true,
        beneficiaryFailure: null,
        summaryBeneficiaryByIdFailureOrSuccessOption: none(),
      ),
    );

    final result = await _summaryFacade.getBeneficiaryById(
      id,
      isTranslistRequired: state.isTranslistRequired,
    );
    final beneficiaryDto = result.fold((_) => null, (dto) => dto);
    final beneficiary = beneficiaryDto?.data?.beneficiaryById;

    final updatedDestItem = _matchDestItemForBeneficiary(
      beneficiary,
      state.commonDestinationSelectableDto?.data?.list ?? [],
    );

    emit(
      state.copyWith(
        isBeneficiaryLoading: false,
        beneficiaryFailure: result.fold((f) => f, (_) => null),
        summaryBeneficiaryByIdDto: beneficiaryDto,
        selectedCommonDestinationItem:
        updatedDestItem ?? state.selectedCommonDestinationItem,
        summaryBeneficiaryByIdFailureOrSuccessOption: some(result),
      ),
    );

    if (beneficiaryDto != null) {
      final payment = state.selectedPaymentMethodItem;
      if (payment != null) add(SummaryEvent.paymentMethodChanged(payment));
    }
  }

  FutureOr<void> _onRetryPaymentMethodToState(
      _RetryPaymentMethod event,
      Emitter<SummaryState> emit,
      ) async {
    emit(
      state.copyWith(
        isPaymentMethodLoading: true,
        paymentMethodFailure: null,
        summaryPaymentMethodFailureOrSuccessOption: none(),
      ),
    );

    final result = await _summaryFacade.getSummaryPaymentMethod();
    final paymentMethodDto = result.fold((_) => null, (dto) => dto);

    CommonSelectableDto? selectableDto;
    CommonSelectableItem? selectedItem;
    result.fold((_) {}, (dto) {
      final modes = dto.data?.paymentModes ?? [];
      if (modes.isEmpty) return;
      final beneficiary =
          state.summaryBeneficiaryByIdDto?.data?.beneficiaryById;
      final preferredCode = beneficiary?.tranList?.isNotEmpty == true
          ? beneficiary?.tranList?.first.paymentModeCode
          : state.selectedPaymentMethodItem?.titleCode;
      final selected = preferredCode != null
          ? modes.firstWhereOrNull(
            (m) => m.code?.toUpperCase() == preferredCode.toUpperCase(),
      ) ??
          modes.first
          : modes.first;
      selectableDto = CommonSelectableDto(
        data: CommonSelectableData(
          list: modes
              .map(
                (m) => CommonSelectableItem(
              titleName: m.name ?? '',
              titleCode: m.code ?? '',
            ),
          )
              .toList(),
        ),
      );
      selectedItem = CommonSelectableItem(
        titleName: selected.name ?? '',
        titleCode: selected.code ?? '',
      );
    });

    emit(
      state.copyWith(
        isPaymentMethodLoading: false,
        paymentMethodFailure: result.fold((f) => f, (_) => null),
        summaryPaymentMethodDto: paymentMethodDto,
        commonPaymentMethodSelectableDto:
        selectableDto ?? state.commonPaymentMethodSelectableDto,
        selectedPaymentMethodItem:
        selectedItem ?? state.selectedPaymentMethodItem,
        summaryPaymentMethodFailureOrSuccessOption: some(result),
      ),
    );

    final resolvedPayment = selectedItem ?? state.selectedPaymentMethodItem;
    if (resolvedPayment != null && state.summaryBeneficiaryByIdDto != null) {
      add(SummaryEvent.paymentMethodChanged(resolvedPayment));
    }
  }

  // ── Amount calculation handlers (debounced) ──────────────────────────────

  FutureOr<void> _onSourceAmountChangedToState(
      _SourceAmountChanged event,
      Emitter<SummaryState> emit,
      ) async {
    final seq = ++_calcSeq;
    emit(
      state.copyWith(
        lastRawSourceAmount: event.sourceAmount,
        isLastInputSource: true,
        isSourceAmountCalculating: false,
        isDestinationAmountCalculating: true,
        summaryCalculatedSourceAmountFailureOrSuccessOption: none(),
        summaryCalculatedDestinationAmountFailureOrSuccessOption: none(),
        summaryBranchesFailureOrSuccessOption: none(),
      ),
    );

    final result = await _summaryFacade.getCalculatedSourceAmount(
      destinationCountryCode:
      state.selectedCommonDestinationItem?.titleCode ?? '',
      destinationCurrencyCode:
      state.selectedCommonDestinationItem?.trailingCode ?? '',
      sourceCountryCode: state.selectedCommonSourceItem?.titleCode ?? '',
      sourceCurrencyCode: state.selectedCommonSourceItem?.trailingCode ?? '',
      sourceAmount: event.sourceAmount.trim().isEmpty
          ? '0'
          : event.sourceAmount,
      productCode: _productCode,
      transferTypeCode: _transferTypeCode,
      paymentMethodCode: _paymentMethodCode,
      bankOrAgentCode: _bankOrAgentCode,
      agentCode: _agentCode,
    );

    // A newer calculation (either direction) started while this one was in
    // flight — its result is authoritative; discard this one.
    if (seq != _calcSeq) return;

    emit(
      state.copyWith(
        isInitialLoading: false,
        isSourceAmountCalculating: false,
        isDestinationAmountCalculating: false,
        lastRawDestinationAmount: result.isLeft()
            ? ''
            : state.lastRawDestinationAmount,
        commonSendMoneyDto: _toSendMoneyDto(result),
        summaryCalculatedSourceAmountFailureOrSuccessOption: some(result),
        summaryCalculatedDestinationAmountFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onDestinationAmountChangedToState(
      _DestinationAmountChanged event,
      Emitter<SummaryState> emit,
      ) async {
    final seq = ++_calcSeq;
    emit(
      state.copyWith(
        lastRawDestinationAmount: event.destinationAmount,
        isLastInputSource: false,
        isSourceAmountCalculating: true,
        isDestinationAmountCalculating: false,
        summaryCalculatedSourceAmountFailureOrSuccessOption: none(),
        summaryCalculatedDestinationAmountFailureOrSuccessOption: none(),
        summaryBranchesFailureOrSuccessOption: none(),
      ),
    );

    final result = await _summaryFacade.getCalculatedDestinationAmount(
      destinationCountryCode:
      state.selectedCommonDestinationItem?.titleCode ?? '',
      destinationCurrencyCode:
      state.selectedCommonDestinationItem?.trailingCode ?? '',
      sourceCountryCode: state.selectedCommonSourceItem?.titleCode ?? '',
      sourceCurrencyCode: state.selectedCommonSourceItem?.trailingCode ?? '',
      destinationAmount: event.destinationAmount.trim().isEmpty
          ? '0'
          : event.destinationAmount,
      productCode: _productCode,
      transferTypeCode: _transferTypeCode,
      paymentMethodCode: _paymentMethodCode,
      bankOrAgentCode: _bankOrAgentCode,
      agentCode: _agentCode,
    );

    // A newer calculation (either direction) started while this one was in
    // flight — its result is authoritative; discard this one.
    if (seq != _calcSeq) return;

    emit(
      state.copyWith(
        isInitialLoading: false,
        isSourceAmountCalculating: false,
        isDestinationAmountCalculating: false,
        lastRawSourceAmount: result.isLeft() ? '' : state.lastRawSourceAmount,
        commonSendMoneyDto: _toSendMoneyDto(result),
        summaryCalculatedSourceAmountFailureOrSuccessOption: none(),
        summaryCalculatedDestinationAmountFailureOrSuccessOption: some(result),
      ),
    );
  }

  FutureOr<void> _onPaymentMethodChangedToState(
      _PaymentMethodChanged event,
      Emitter<SummaryState> emit,
      ) async {
    emit(
      state.copyWith(
        summaryBranchesFailureOrSuccessOption: none(),
        selectedPaymentMethodItem: event.selectedPaymentMethodItem,
      ),
    );
    final useDestination =
        !state.isLastInputSource && state.lastRawDestinationAmount.isNotEmpty;
    if (useDestination) {
      add(
        SummaryEvent.destinationAmountChanged(
          destinationAmount: state.lastRawDestinationAmount,
        ),
      );
    } else {
      add(
        SummaryEvent.sourceAmountChanged(
          sourceAmount: state.lastRawSourceAmount,
        ),
      );
    }
  }

  FutureOr<void> _onBeneficiaryUpdatedChangedToState(
      _BeneficiaryUpdatedChanged event,
      Emitter<SummaryState> emit,
      ) async {
    final beneficiary = state.summaryBeneficiaryByIdDto?.data?.beneficiaryById;
    if (beneficiary == null) return;
    // This event fires after EVERY beneficiary edit app-wide and this bloc is
    // an app-scoped singleton: only refresh when the edit targets the
    // beneficiary this summary is actually showing — otherwise an edit of a
    // different beneficiary would trigger a needless refetch.
    if ((event.eId ?? '') != (beneficiary.eId ?? '')) return;

    // Re-fetch the whole record from the backend so every field — including the
    // codes the edit may have changed (beneficiaryBankCode, agent/product/
    // service codes that feed calculate and the transaction payloads) — is the
    // authoritative server copy, not a locally-patched one. On failure the
    // existing (pre-edit) record stays in place. Flag the load so the summary
    // shows its loading state and the confirm button stays disabled until the
    // authoritative record (and its codes) has landed.
    emit(state.copyWith(isBeneficiaryLoading: true));
    final refreshed = await _summaryFacade.getBeneficiaryById(
      beneficiary.eId ?? '',
      isTranslistRequired: state.isTranslistRequired,
    );
    refreshed.fold(
          (_) {},
          (dto) => emit(state.copyWith(summaryBeneficiaryByIdDto: dto)),
    );
    emit(state.copyWith(isBeneficiaryLoading: false));

    // The edit may have changed rate-relevant fields (disbursalMode,
    // currencyCode): re-run the calculation so the displayed fees/rate — and
    // the payload later built from them — match the updated record.
    final payment = state.selectedPaymentMethodItem;
    if (payment != null) add(SummaryEvent.paymentMethodChanged(payment));
  }

  // ── Private helpers ──────────────────────────────────────────────────────

  String get _productCode {
    final beneficiary = state.summaryBeneficiaryByIdDto?.data?.beneficiaryById;
    return (beneficiary?.productCode ?? 0).toString();
  }

  String get _transferTypeCode =>
      state.summaryBeneficiaryByIdDto?.data?.beneficiaryById?.disbursalMode ??
          '';

  String get _paymentMethodCode {
    // The visible selection wins: it is what createPayAtBranchTransaction
    // submits, so the fee calculation must use the same code. It is already initialised from the beneficiary's last
    // transaction in _onPaymentMethodResolved; the tranList fallback below
    // only covers calls that fire before the payment-method API resolves.
    final selectedCode = state.selectedPaymentMethodItem?.titleCode ?? '';
    if (selectedCode.isNotEmpty) return selectedCode;
    final beneficiary = state.summaryBeneficiaryByIdDto?.data?.beneficiaryById;
    return beneficiary?.tranList?.isNotEmpty == true
        ? beneficiary?.tranList?.first.paymentModeCode ?? ''
        : '';
  }

  String get _bankOrAgentCode =>
      state
          .summaryBeneficiaryByIdDto
          ?.data
          ?.beneficiaryById
          ?.beneficiaryBankCode ??
          '';

  // The agent is always supplied by the caller (home flow) via prepareSummary —
  // never derived from the beneficiary-by-id record. An empty value means "no
  // agent" and is passed through as-is.
  String get _agentCode => state.homeAgentCode;

  String get _agentName => state.homeAgentName;

  CommonSendMoneyDto _toSendMoneyDto(
      Either<SummaryFailure, SummaryCalculateAmountDto> result,
      ) => result.fold((_) => CommonSendMoneyDto.empty(), (dto) {
    final amount = dto.data?.amount;
    return CommonSendMoneyDto(
      sourceAmount: amount?.payAmount ?? 0.0,
      destinationAmount: amount?.netReceiveAmount ?? 0.0,
      displayRate: amount?.displayRate ?? 0.0,
      rate: amount?.rate ?? 0.0,
      rateOperator: amount?.mobileRateOperator,
      netLcAmount: amount?.netPayAmount ?? 0.0,
      commission: amount?.commission ?? 0.0,
      fee: amount?.fee ?? 0.0,
      fCCommission: amount?.fcCommission ?? 0.0,
      tax: amount?.tax ?? 0.0,
      taxPercentage: amount?.taxPercentage,
      payAmount: amount?.netPayAmount ?? 0.0,
      totalPayableAmount: amount?.netPayAmount ?? 0.0,
      branchName: amount?.branchName,
      branchCode: amount?.branchCode,
      hoRate: amount?.hoRate,
      amountVariation: amount?.amountVariation,
      apiBaseCurrencyRate: amount?.apiBaseCurrencyRate,
      apiBaseCurrencyValue: amount?.apiBaseCurrencyValue,
    );
  });

  /// Picks the destination-currency item matching [beneficiary].
  ///
  /// List items are country+currency pairs and a currency can be shared by
  /// several countries, so an exact country+currency match is tried first,
  /// then a currency-only match, then the first item. Returns null when
  /// there is nothing to match against.
  CommonSelectableItem? _matchDestItemForBeneficiary(
      BeneficiaryById? beneficiary,
      List<CommonSelectableItem> destList,
      ) {
    if (beneficiary == null || destList.isEmpty) return null;
    final currency = beneficiary.currencyCode?.toUpperCase();
    final country = beneficiary.beneficiaryCountryCode?.toUpperCase();
    return destList.firstWhereOrNull(
          (item) =>
      item.trailingCode?.toUpperCase() == currency &&
          item.titleCode?.toUpperCase() == country,
    ) ??
        destList.firstWhereOrNull(
              (item) => item.trailingCode?.toUpperCase() == currency,
        ) ??
        destList.first;
  }

  List<CommonSelectableItem> _toCurrencySelectableItems(
      List<CurrencyList> list,
      ) => list
      .map(
        (c) => CommonSelectableItem(
      leading: c.flagUrl,
      titleName: c.countryName ?? '',
      titleCode: c.countryCode ?? '',
      trailingName: c.currencyName ?? '',
      trailingCode: c.currencyCode ?? '',
      decimalPlaces: c.decimalPlaces,
    ),
  )
      .toList();

  EventTransformer<T> _debounce<T>(Duration duration) =>
          (events, mapper) => events.debounceTime(duration).switchMap(mapper);

  FutureOr<void> _onGetBranchesToState(
      _GetBranches event,
      Emitter<SummaryState> emit,
      ) async {
    emit(
      state.copyWith(
        isBranchesLoading: true,
        summaryPayAtBranchFailureOrSuccessOption: none(),
        summaryBranchesFailureOrSuccessOption: none(),
      ),
    );

    final failureOrSuccess = await _summaryFacade.getBranches();

    failureOrSuccess.fold(
          (failure) {
        emit(
          state.copyWith(
            isBranchesLoading: false,
            summaryBranchesFailureOrSuccessOption: some(left(failure)),
          ),
        );
        // One-shot signal: reset so the error dialog fires exactly once and is
        // not re-shown when an unrelated field later re-triggers the listener.
        // (Do NOT auto re-dispatch getBranches here — that re-runs the failing
        // call in a tight loop and re-opens the dialog endlessly.)
        emit(state.copyWith(summaryBranchesFailureOrSuccessOption: none()));
      },
          (success) {
        emit(
          state.copyWith(
            isBranchesLoading: false,
            summaryBranchesDto: CommonBranchesDto(
              data: BranchesData(
                branchList: success.data?.branchList
                    ?.map(
                      (e) => BranchDto(
                    branchCode: e.branchCode,
                    branchName: e.branchName,
                    address1: e.address1,
                    address2: e.address2,
                    address3: e.address3,
                    phone: e.phone,
                    email: e.email,
                    latitude: e.latitude,
                    longitude: e.longitude,
                    workingHours: e.workingHours,
                    appMessage1: e.appMessage1,
                    appMessage2: e.appMessage2,
                    validTimeLimit: e.validTimeLimit,
                  ),
                )
                    .toList(),
              ),
            ),
            summaryBranchesFailureOrSuccessOption: some(right(success)),
          ),
        );
        // One-shot signal: reset so the branch bottom sheet opens exactly once
        // and is not re-opened when an unrelated field later re-triggers the
        // listener.
        emit(state.copyWith(summaryBranchesFailureOrSuccessOption: none()));
      },
    );
  }

  FutureOr<void> _onBranchChangedToState(
      _BranchChanged event,
      Emitter<SummaryState> emit,
      ) async {
    emit(
      state.copyWith(
        summaryBranchesFailureOrSuccessOption: none(),
        selectedBranchItem: event.selectedBranchItem,
      ),
    );
  }

  FutureOr<void> _onCreatePayAtBranchTransactionToState(
      _CreatePayAtBranchTransaction event,
      Emitter<SummaryState> emit,
      ) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        summaryBranchesFailureOrSuccessOption: none(),
        summaryPayAtBranchFailureOrSuccessOption: none(),
      ),
    );

    // Guard: a branch must be selected before confirming. Without this an
    // empty/invalid titleCode would crash int.parse with a FormatException.
    // The message is left null so the presentation layer can localise it.
    final payLocation = int.tryParse(state.selectedBranchItem?.titleCode ?? '');
    if (payLocation == null) {
      emit(
        state.copyWith(
          isSubmitting: false,
          summaryPayAtBranchFailureOrSuccessOption: some(
            left(
              const SummaryFailure.unableToCreatePayAtBranchTransaction(null),
            ),
          ),
        ),
      );
      // Reset the one-shot option so the dialog fires exactly once and does not
      // re-appear when an unrelated field later re-triggers the listener.
      emit(state.copyWith(summaryPayAtBranchFailureOrSuccessOption: none()));
      return;
    }
    final beneficiary = state.summaryBeneficiaryByIdDto?.data?.beneficiaryById;
    final source = state.selectedCommonSourceItem;
    final destination = state.selectedCommonDestinationItem;
    // Source amount is the principal that converts (pay_amount), NOT the total
    // payable (net_pay_amount). pay_amount × rate ≈ net_receive_amount, so the
    // principal is what the destination amount is derived from. netAmount below
    // carries the total payable.
    final sourceAmount = state.commonSendMoneyDto.sourceAmount ?? 0.0;
    final sourceCurrencyCode = source?.trailingCode ?? '';
    final sourceCountryCode = source?.titleCode ?? '';
    final destinationAmount = state.commonSendMoneyDto.destinationAmount ?? 0.0;
    final destinationCurrencyCode = destination?.trailingCode ?? '';
    final destinationCountryCode = destination?.titleCode ?? '';
    final displayRate = state.commonSendMoneyDto.rate ?? 0.0;
    final rateOperator = state.commonSendMoneyDto.rateOperator ?? '';
    final transferTypeCode = beneficiary?.disbursalMode ?? '';
    final productCode = beneficiary?.productCode ?? 0;
    final serviceCode = beneficiary?.serviceCode ?? '';
    final purposeOfTransactionCode = beneficiary?.purposeOfTransaction ?? '';
    final purposeOfTransactionName = beneficiary?.purposeName ?? '';
    final sourceOfFundsCode = beneficiary?.sourceOfFund ?? '';
    final sourceOfFundsName = beneficiary?.incomeSourceName ?? '';
    final beneficiaryCode = beneficiary?.beneficiaryCode ?? 0;
    final beneficiaryId = beneficiary?.eId ?? '';
    final commission = state.commonSendMoneyDto.commission ?? 0.0;
    final paymentCommission = state.commonSendMoneyDto.fee ?? 0.0;
    final fcCommission = state.commonSendMoneyDto.fCCommission ?? 0.0;
    final taxPercentage = state.commonSendMoneyDto.taxPercentage ?? 0;
    final taxCollected = state.commonSendMoneyDto.tax ?? 0.0;
    final netAmount = state.commonSendMoneyDto.totalPayableAmount ?? 0.0;
    final paymentMethodCode = state.selectedPaymentMethodItem?.titleCode ?? '';

    final failureOrSuccess = await _summaryFacade.createPayAtBranchTransaction(
      payLocation: payLocation,
      sourceAmount: sourceAmount,
      sourceCurrencyCode: sourceCurrencyCode,
      sourceCountryCode: sourceCountryCode,
      destinationAmount: destinationAmount,
      destinationCurrencyCode: destinationCurrencyCode,
      destinationCountryCode: destinationCountryCode,
      displayRate: displayRate,
      rateOperator: rateOperator,
      transferTypeCode: transferTypeCode,
      productCode: productCode,
      serviceCode: serviceCode,
      purposeOfTransactionCode: purposeOfTransactionCode,
      purposeOfTransactionName: purposeOfTransactionName,
      sourceOfFundsCode: sourceOfFundsCode,
      sourceOfFundsName: sourceOfFundsName,
      beneficiaryCode: beneficiaryCode,
      beneficiaryId: beneficiaryId,
      commission: commission,
      paymentCommission: paymentCommission,
      fcCommission: fcCommission,
      taxPercentage: taxPercentage,
      taxCollected: taxCollected,
      netAmount: netAmount,
      paymentMethodCode: paymentMethodCode,
      agentName: _agentName,
      agentCode: _agentCode,
      hoRate: state.commonSendMoneyDto.hoRate,
      apiBaseCurrencyRate: state.commonSendMoneyDto.apiBaseCurrencyRate,
      apiBaseCurrencyValue: state.commonSendMoneyDto.apiBaseCurrencyValue,
    );

    failureOrSuccess.fold((failure) {
      emit(
        state.copyWith(
          isSubmitting: false,
          // Keep the 409 payload while the round-off dialog is up; the
          // decision handler reads its references back out of state.
          roundOffResult: failure.maybeMap(
            roundOffRequired: (f) => f.result,
            orElse: () => null,
          ),
          summaryPayAtBranchFailureOrSuccessOption: some(left(failure)),
        ),
      );
      // Reset the one-shot option so the error dialog fires exactly once and
      // does not re-appear when an unrelated field later re-triggers the
      // listener (e.g. amount recalculation).
      emit(state.copyWith(summaryPayAtBranchFailureOrSuccessOption: none()));
    }, (success) => _emitPayAtBranchSuccess(emit, success));
  }

  // ── 409 round-off decision ─────────────────────────────────────────────────
  // Calls confirm-transaction-changes with the references captured from the
  // 409 body: accept (true) finalises with the rounded amount, reject (false)
  // voids the initiated transaction.
  FutureOr<void> _onRoundOffDecisionToState(
      _RoundOffDecision event,
      Emitter<SummaryState> emit,
      ) async {
    final pending = state.roundOffResult;
    final appTransaction = pending?.data?.appTransaction;
    if (appTransaction == null) return;

    emit(state.copyWith(isSubmitting: true));

    final failureOrSuccess = await _summaryFacade.confirmRoundOff(
      eId: pending?.data?.eId ?? '',
      transactionReference: appTransaction.transactionReference ?? 0,
      appTransactionReference: appTransaction.appTransactionReference ?? 0,
      isReadyToProceed: event.isReadyToProceed,
    );

    failureOrSuccess.fold(
          (failure) {
        // One-shot: reset right after so the error dialog fires exactly once.
        emit(
          state.copyWith(
            isSubmitting: false,
            roundOffResult: null,
            summaryRoundOffFailureOrSuccessOption: some(left(failure)),
          ),
        );
        emit(state.copyWith(summaryRoundOffFailureOrSuccessOption: none()));
      },
          (success) {
        if (!event.isReadyToProceed) {
          // Rejected: stay on the summary screen and acknowledge the
          // cancellation with a dialog (one-shot consumed by the page).
          emit(
            state.copyWith(
              isSubmitting: false,
              roundOffResult: null,
              summaryRoundOffFailureOrSuccessOption: some(right(success)),
            ),
          );
          emit(state.copyWith(summaryRoundOffFailureOrSuccessOption: none()));
        } else {
          // Accepted: finalise the pay-at-branch transaction.
          _emitPayAtBranchSuccess(emit, success);
        }
      },
    );
  }

  // Shared terminal path for pay-at-branch: reached by the direct confirm
  // call and by an accepted 409 round-off.
  void _emitPayAtBranchSuccess(
      Emitter<SummaryState> emit,
      SummaryPaymentResultDto success,
      ) {
    final transactions = success.data?.appTransaction?.transactions ?? [];
    emit(
      state.copyWith(
        isSubmitting: false,
        roundOffResult: null,
        commonPaymentResultDto: CommonPaymentResultDto(
          message: success.message,
          data: PaymentResultData(
            paymentTransaction: PaymentTransaction(
              transactionReference:
              success.data?.appTransaction?.transactionReference,
              netAmount: success.data?.appTransaction?.netAmount,
              transactions: TransactionDetails(
                isSuccessful: true,
                transactionReference:
                success.data?.appTransaction?.transactionReference,
                netAmount: transactions.isNotEmpty
                    ? transactions.first.netAmount?.toDouble()
                    : null,
                status: transactions.isNotEmpty
                    ? transactions.first.status
                    : null,
                beneficiaryName: transactions.isNotEmpty
                    ? transactions.first.beneficiaryName
                    : null,
                appStatus: transactions.isNotEmpty
                    ? transactions.first.status
                    : null,
              ),
            ),
          ),
        ),
        summaryPayAtBranchFailureOrSuccessOption: some(right(success)),
      ),
    );
    // One-shot success signal: reset so navigating away (popAndPush) cannot
    // be retriggered by a later unrelated state change.
    emit(state.copyWith(summaryPayAtBranchFailureOrSuccessOption: none()));
  }
}
