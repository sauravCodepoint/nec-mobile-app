part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.initialize({
    @Default(false) bool isRefresh,

    /// Drops every user selection on the send-money form (destination,
    /// transfer type, bank/agent, payment method, tapped beneficiary) so the
    /// refresh lands on first-load defaults instead of restoring them.
    /// Used after a completed transaction.
    @Default(false) bool resetSelections,
  }) = _InitializeEvent;
  const factory HomeEvent.getHomeRecentBeneficiaries({
    @Default(false) bool isRefresh,
  }) = _GetHomeRecentBeneficiariesEvent;
  /// Re-runs only the recent-transactions fetch. Raised by that section's
  /// inline retry, so a single failed list doesn't cost a full page reload.
  const factory HomeEvent.getHomeRecentTransactions() =
  _GetHomeRecentTransactionsEvent;
  const factory HomeEvent.recentBeneficiaryTapped({
    required RecentBeneficiaryList beneficiary,
  }) = _RecentBeneficiaryTappedEvent;
  // Send-again flow only: the user picked an agent from the multi-option
  // dialog raised after the tap. Carries the choice forward into the mandatory
  // field check → summary.
  const factory HomeEvent.recentBeneficiaryAgentSelected({
    required CommonSelectableItem agent,
  }) = _RecentBeneficiaryAgentSelectedEvent;
  const factory HomeEvent.destinationCountrySelected({
    required CommonSelectableItem selectedCommonDestinationItem,
  }) = _DestinationCountrySelectedEvent;
  const factory HomeEvent.getHomeTransferTypes() = _GetHomeTransferTypesEvent;

  /// Re-runs only the corridor request that failed
  /// ([HomeState.failedCorridorStage]), reusing the selections already in
  /// state. Raised by the inline corridor error card, so a single flaky call
  /// doesn't cost the user a full-page reload (and doesn't re-fire every other
  /// home endpoint on a backend that answers concurrent requests with 500s).
  /// A no-op when no stage is recorded as failed.
  const factory HomeEvent.retryCorridor() = _RetryCorridorEvent;
  const factory HomeEvent.transferTypeSelected({
    required CommonSelectableItem selectedTransferTypeItem,
    @Default(false) bool fromUser,
  }) = _TransferTypeSelectedEvent;
  const factory HomeEvent.getHomeBankOrAgentList({
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String transferTypeCode,
  }) = _GetHomeBankOrAgentListEvent;
  const factory HomeEvent.bankOrAgentSelected({
    required String selectedBankOrAgent,
    // Product code — the only bank/agent value the downstream beneficiary list
    // needs. Stored as the selected item's titleCode.
    required String selectedBankOrAgentCode,
    @Default(false) bool fromUser,
  }) = _BankOrAgentSelectedEvent;
  const factory HomeEvent.getHomeAgentList({
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String transferTypeCode,
  }) = _GetHomeAgentListEvent;
  const factory HomeEvent.agentSelected({
    required String selectedAgent,
    // Agent code — stored as the selected item's titleCode.
    required String selectedAgentCode,
    @Default(false) bool fromUser,
  }) = _AgentSelectedEvent;
  const factory HomeEvent.getBeneficiaryList() = _GetBeneficiaryListEvent;
  const factory HomeEvent.selectedBeneficiaryIndexChanged({
    required int selectedBeneficiaryIndex,
  }) = _SelectedBeneficiaryIndexChangedEvent;
  const factory HomeEvent.deleteBeneficiary(String eId) =
  _DeleteBeneficiaryEvent;
  const factory HomeEvent.selectedBeneficiaryContinuePressed() =
  _SelectedBeneficiaryContinuePressedEvent;
  const factory HomeEvent.currentEmailAddressChanged({
    required String emailAddress,
  }) = _CurrentEmailAddressChanged;
  const factory HomeEvent.updateEmailAddressChanged({
    required String emailAddress,
  }) = _UpdateEmailAddressChanged;
  const factory HomeEvent.requestUpdateEmailAddressPressed() =
  _RequestUpdateEmailAddressPressed;
  const factory HomeEvent.emailOtpChanged({required String emailOtp}) =
  _EmailOtpChanged;
  const factory HomeEvent.continueOtpButtonPressed() =
  _ContinueOtpButtonPressed;
}
