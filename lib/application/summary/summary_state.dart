part of 'summary_bloc.dart';

@freezed
sealed class SummaryState with _$SummaryState {
  const factory SummaryState({
    // ── Page-level flags ─────────────────────────────────────────────────────
    // True only during the initial parallel API burst; resolved in
    // _onPrepareSummaryToState once all 4 APIs complete (pass or fail).
    @Default(true) bool isInitialLoading,
    // Per-section loading flags (used for retry operations after initial load).
    @Default(false) bool isBeneficiaryLoading,
    @Default(false) bool isPaymentMethodLoading,
    @Default(false) bool isSubmitting,
    @Default(false) bool isRateLoading,
    @Default(false) bool isSourceAmountCalculating,
    @Default(false) bool isDestinationAmountCalculating,
    @Default(false) bool isBranchesLoading,

    // ── Input preservation ───────────────────────────────────────────────────
    @Default('') String lastRawSourceAmount,
    @Default('') String lastRawDestinationAmount,
    @Default(true) bool isLastInputSource,

    // ── Retry support ────────────────────────────────────────────────────────
    // Stored so retry handlers can re-fetch without needing external input.
    String? beneficiaryId,
    // Carried for the whole summary session so every beneficiary fetch
    // (initial load, retry, post-edit refresh) requests the transaction list
    // when the session originated from the recent-beneficiary flow.
    @Default(false) bool isTranslistRequired,
    // Agent supplied by the caller (home flow) via prepareSummary, carried for
    // the whole summary session and used verbatim as the agent for every
    // calculate/pay call (see _agentCode / _agentName). Never derived from the
    // beneficiary-by-id record; empty simply means "no agent".
    @Default('') String homeAgentCode,
    @Default('') String homeAgentName,
    // Non-null when the corresponding section failed on initial load or retry.
    SummaryFailure? beneficiaryFailure,
    SummaryFailure? paymentMethodFailure,

    // ── Domain data ──────────────────────────────────────────────────────────
    SummaryBeneficiaryByIdDto? summaryBeneficiaryByIdDto,
    required CommonSendMoneyDto commonSendMoneyDto,
    CommonSelectableDto? commonSourceSelectableDto,
    CommonSelectableItem? selectedCommonSourceItem,
    CommonSelectableDto? commonDestinationSelectableDto,
    CommonSelectableItem? selectedCommonDestinationItem,
    CommonSelectableDto? commonPaymentMethodSelectableDto,
    CommonSelectableItem? selectedPaymentMethodItem,
    SummaryPaymentMethodDto? summaryPaymentMethodDto,
    CommonPaymentResultDto? commonPaymentResultDto,
    CommonBranchesDto? summaryBranchesDto,
    CommonSelectableItem? selectedBranchItem,
    // Pending 409 round-off payload; holds the references confirmRoundOff
    // needs while the accept/cancel dialog is on screen.
    SummaryPaymentResultDto? roundOffResult,

    // ── Option streams (drive listeners / section rendering) ─────────────────
    required Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>>
    summaryBeneficiaryByIdFailureOrSuccessOption,
    required Option<Either<SummaryFailure, SummaryCurrencyListDto>>
    summarySourceCurrencyListFailureOrSuccessOption,
    required Option<Either<SummaryFailure, SummaryCurrencyListDto>>
    summaryDestinationCurrencyListFailureOrSuccessOption,
    required Option<Either<SummaryFailure, SummaryCalculateAmountDto>>
    summaryCalculatedSourceAmountFailureOrSuccessOption,
    required Option<Either<SummaryFailure, SummaryCalculateAmountDto>>
    summaryCalculatedDestinationAmountFailureOrSuccessOption,
    required Option<Either<SummaryFailure, SummaryPaymentMethodDto>>
    summaryPaymentMethodFailureOrSuccessOption,
    required Option<Either<SummaryFailure, SummaryBranchesDto>>
    summaryBranchesFailureOrSuccessOption,
    required Option<Either<SummaryFailure, SummaryPaymentResultDto>>
    summaryPayAtBranchFailureOrSuccessOption,
    // One-shot for the 409 round-off decision call: right = user rejected and
    // the cancellation succeeded (page acknowledges with a dialog and stays on
    // the summary screen); left = the decision call itself failed. An accepted
    // round-off instead continues through the pay-at-branch option above.
    required Option<Either<SummaryFailure, SummaryPaymentResultDto>>
    summaryRoundOffFailureOrSuccessOption,
  }) = _SummaryState;

  factory SummaryState.initial() => SummaryState(
    commonSendMoneyDto: CommonSendMoneyDto.empty(),
    summaryBeneficiaryByIdFailureOrSuccessOption: none(),
    summarySourceCurrencyListFailureOrSuccessOption: none(),
    summaryDestinationCurrencyListFailureOrSuccessOption: none(),
    summaryCalculatedSourceAmountFailureOrSuccessOption: none(),
    summaryCalculatedDestinationAmountFailureOrSuccessOption: none(),
    summaryPaymentMethodFailureOrSuccessOption: none(),
    summaryBranchesFailureOrSuccessOption: none(),
    summaryPayAtBranchFailureOrSuccessOption: none(),
    summaryRoundOffFailureOrSuccessOption: none(),
  );
}
