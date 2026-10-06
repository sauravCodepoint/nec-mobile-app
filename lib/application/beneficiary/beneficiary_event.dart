part of 'beneficiary_bloc.dart';

@freezed
class BeneficiaryEvent with _$BeneficiaryEvent {
  const factory BeneficiaryEvent.getBeneficiaries() = _GetBeneficiaries;
  const factory BeneficiaryEvent.getBeneficiaryById(
    String? beneficiaryId, {
    // Product-switch edit (from the home mandatory-field check): the bank/agent,
    // product and service to edit against come from the corridor the user picked
    // on home, not the beneficiary's stored values. Null for a plain edit.
    CommonSelectableItem? bankOrAgentOverride,
    // When true (only the missingMandatoryFields → Edit path), a successful save
    // continues straight to the summary instead of popping back to the list.
    @Default(false) bool proceedToSummaryAfterSave,
  }) = _GetBeneficiaryById;
  const factory BeneficiaryEvent.prepareBeneficiaryForEdit({
    required CommonSelectableItem beneficiaryCountry,
    required CommonSelectableItem beneficiaryCurrency,
    required CommonSelectableItem beneficiaryTransferType,
    required CommonSelectableItem beneficiaryBankOrAgent,
    required CommonSelectableItem beneficiaryPurposeOfTransaction,
    required CommonSelectableItem beneficiarySourceOfFund,
  }) = _PrepareBeneficiaryForEdit;
  const factory BeneficiaryEvent.prepareBeneficiaryForAddFromHome({
    required CommonSelectableItem beneficiaryCountry,
    required CommonSelectableItem beneficiaryCurrency,
    required CommonSelectableItem beneficiaryTransferType,
    required CommonSelectableItem beneficiaryBankOrAgent,
  }) = _PrepareBeneficiaryForAddFromHome;
  const factory BeneficiaryEvent.getBeneficiaryCountries() =
  _GetBeneficiaryCountries;
  const factory BeneficiaryEvent.beneficiaryCountrySelected(
      CommonSelectableItem selectedBeneficiaryCountry,
      ) = _BeneficiaryCountrySelected;
  const factory BeneficiaryEvent.getBeneficiaryCurrencies() =
  _GetBeneficiaryCurrencies;
  const factory BeneficiaryEvent.beneficiaryCurrencySelected(
      CommonSelectableItem selectedBeneficiaryCurrency,
      ) = _BeneficiaryCurrencySelected;
  const factory BeneficiaryEvent.getBeneficiaryTransferTypes() =
  _GetBeneficiaryTransferTypes;
  const factory BeneficiaryEvent.beneficiaryTransferTypeSelected(
      CommonSelectableItem selectedBeneficiaryTransferType,
      ) = _BeneficiaryTransferTypeSelected;
  const factory BeneficiaryEvent.getBeneficiaryBanksOrAgents() =
  _GetBeneficiaryBanksOrAgents;
  const factory BeneficiaryEvent.beneficiaryBankOrAgentSelected(
      CommonSelectableItem selectedBeneficiaryBankOrAgent,
      ) = _BeneficiaryBankOrAgentSelected;
  const factory BeneficiaryEvent.getBeneficiaryProductFields() =
  _GetBeneficiaryProductFields;
  const factory BeneficiaryEvent.beneficiaryProductFieldChanged({
    required Beneficiary backendField,
    required String value,
  }) = _BeneficiaryProductFieldChanged;
  const factory BeneficiaryEvent.clearBeneficiaryProductFieldValue({
    required Beneficiary backendField,
  }) = _ClearBeneficiaryProductFieldValue;
  const factory BeneficiaryEvent.getBranchCombo(
      String? bankCode, {
        @Default('') String? bankName,
        @Default('') String? expectedBranchCode,
      }) = _GetBranchCombo;
  const factory BeneficiaryEvent.beneficiaryPurposeOfTransactionSelected(
      CommonSelectableItem selectedPurposeOfTransaction,
      ) = _BeneficiaryPurposeOfTransactionSelected;
  const factory BeneficiaryEvent.beneficiarySourceOfFundSelected(
      CommonSelectableItem selectedSourceOfFund,
      ) = _BeneficiarySourceOfFundSelected;
  const factory BeneficiaryEvent.saveOrUpdateBeneficiaryPressed() =
  _SaveOrUpdateBeneficiaryPressed;
  const factory BeneficiaryEvent.beneficiaryOtpChanged(String otpStr) =
  _BeneficiaryOtpChanged;
  const factory BeneficiaryEvent.beneficiaryOtpSubmitted() =
  _BeneficiaryOtpSubmitted;
  const factory BeneficiaryEvent.resendBeneficiaryOtp() = _ResendBeneficiaryOtp;
  const factory BeneficiaryEvent.beneficiaryBankComboChanged({
    required String bankCode,
    required String bankName,
  }) = _BeneficiaryBankComboChanged;
  const factory BeneficiaryEvent.beneficiaryBranchComboChanged({
    required String branchCode,
    required String branchName,
  }) = _BeneficiaryBranchComboChanged;
  const factory BeneficiaryEvent.beneficiaryRouteCodeChanged(String routeCode) =
  _BeneficiaryRouteCodeChanged;
  const factory BeneficiaryEvent.beneficiaryRouteCodeSelected(
      String routeCode,
      ) = _BeneficiaryRouteCodeSelected;
  const factory BeneficiaryEvent.loadFormSupportData() = _LoadFormSupportData;
  const factory BeneficiaryEvent.deleteBeneficiary(String beneficiaryId) =
      _DeleteBeneficiary;

  // ── Payment (action-sheet) flow ──────────────────────────────────────────
  // User tapped "Payment" on a beneficiary: resolve the corridor agent, then run
  // the mandatory-field check before the summary. Mirrors the home send-again
  // flow, owned by the beneficiary feature.
  const factory BeneficiaryEvent.paymentRequested({
    required BeneficiaryList beneficiary,
  }) = _PaymentRequested;
  // The user picked an agent from the multi-option dialog raised after the tap.
  const factory BeneficiaryEvent.paymentAgentSelected({
    required CommonSelectableItem agent,
  }) = _PaymentAgentSelected;
}
