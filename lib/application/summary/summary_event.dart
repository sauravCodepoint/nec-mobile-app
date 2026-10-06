part of 'summary_bloc.dart';

@freezed
sealed class SummaryEvent with _$SummaryEvent {
  // ── Initialisation ───────────────────────────────────────────────────────
  const factory SummaryEvent.prepareSummary({
    required String beneficiaryId,
    @Default(false) bool isTranslistRequired,
    // Agent picked on the home send-money corridor. When non-empty it overrides
    // the beneficiary's own agent for this summary session; empty falls back to
    // the beneficiary record.
    @Default('') String agentCode,
    @Default('') String agentName,
  }) = _PrepareSummary;

  // ── Section-level retry (user taps "Retry" in a failed card) ─────────────
  const factory SummaryEvent.retryBeneficiary() = _RetryBeneficiary;
  const factory SummaryEvent.retryPaymentMethod() = _RetryPaymentMethod;

  // ── Beneficiary edited elsewhere: refetch this summary's record ────────────
  // Carries only the edited beneficiary's eId; the handler refetches the full
  // record from the backend when it matches the one this summary is showing.
  const factory SummaryEvent.beneficiaryUpdatedChanged({String? eId}) =
      _BeneficiaryUpdatedChanged;

  // ── Amount editing (debounced) ────────────────────────────────────────────
  const factory SummaryEvent.sourceAmountChanged({
    required String sourceAmount,
  }) = _SourceAmountChanged;

  const factory SummaryEvent.destinationAmountChanged({
    required String destinationAmount,
  }) = _DestinationAmountChanged;

  // ── Payment method selection ──────────────────────────────────────────────
  const factory SummaryEvent.paymentMethodChanged(
    CommonSelectableItem selectedPaymentMethodItem,
  ) = _PaymentMethodChanged;

  // ── Transaction submission ────────────────────────────────────────────────
  const factory SummaryEvent.getBranches() = _GetBranches;

  const factory SummaryEvent.branchChanged(
    CommonSelectableItem selectedBranchItem,
  ) = _BranchChanged;

  const factory SummaryEvent.createPayAtBranchTransaction() =
      _CreatePayAtBranchTransaction;

  // User's answer to the 409 round-off dialog: true = accept the rounded
  // amount and proceed, false = reject and void the initiated transaction.
  const factory SummaryEvent.roundOffDecision({
    required bool isReadyToProceed,
  }) = _RoundOffDecision;
}
