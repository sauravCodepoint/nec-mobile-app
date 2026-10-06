part of 'beneficiary_bloc.dart';

@freezed
sealed class BeneficiaryState with _$BeneficiaryState {
  const factory BeneficiaryState({
    required bool isEditing,
    required bool isAddingFromHome,
    // Set only when the edit was launched from the home mandatory-field check
    // (missingMandatoryFields → Edit). On save success the flow continues
    // straight to the summary instead of popping back to the list. Every other
    // edit entry point leaves this false via BeneficiaryState.initial().
    @Default(false) bool proceedToSummaryAfterSave,
    required bool isLoading,
    // Scoped to the beneficiary list fetch only (isLoading is shared by the
    // form's country/currency/record loads). The list screen keys its shimmer
    // and refresh overlay off this so tapping Add/Edit doesn't flash them.
    @Default(false) bool isListLoading,
    @Default(false) bool isInitialLoading,
    required bool showErrorMessages,
    required bool isSubmitting,
    required bool isOtpSubmitting,
    @Default(false) bool isResendingOtp,
    required bool showOtpErrorMessages,
    required BeneficiaryOtp beneficiaryOtp,
    DateTime? otpResendCooldownUntil,
    @Default(false) bool isRouteCodeLoading,
    @Default(false) bool isRouteLookupLoading,
    @Default(false) bool isRouteCodeAutoFilled,
    @Default('') String selectedBankComboCode,
    BeneficiaryRouteCodeDto? beneficiaryRouteCodeDto,
    BeneficiaryBankBranchRouteDto? beneficiaryBankBranchRouteDto,
    BeneficiaryListDto? beneficiaryListDto,
    BeneficiaryByIdDto? beneficiaryByIdDto,
    BeneficiaryCountryListDto? beneficiaryCountryListDto,
    CommonSelectableItem? selectedBeneficiaryCountry,
    BeneficiaryCurrencyListDto? beneficiaryCurrencyListDto,
    CommonSelectableItem? selectedBeneficiaryCurrency,
    BeneficiaryTransferModeListDto? beneficiaryTransferModeListDto,
    CommonSelectableItem? selectedBeneficiaryTransferType,
    BeneficiaryBankOrAgentListDto? beneficiaryBankOrAgentListDto,
    CommonSelectableItem? selectedBeneficiaryBankOrAgent,
    BeneficiaryProductFieldSettingsDto? beneficiaryProductFieldSettingsDto,
    required Map<String, BeneficiaryDynamicInput> dynamicFieldValues,
    required Map<String, BeneficiaryDynamicInput> initialDynamicFieldValues,

    /// Field names rendered read-only: server-disabled (enabled == false)
    /// fields that already carry a prefilled value. Mirrors the registration
    /// and complete-profile lockedFields semantics.
    @Default({}) Set<String> lockedFields,
    BeneficiaryPurposeOfTransferDto? beneficiaryPurposeOfTransferDto,
    CommonSelectableItem? selectedBeneficiaryPurposeOfTransaction,
    BeneficiarySourceOfFundDto? beneficiarySourceOfFundDto,
    CommonSelectableItem? selectedBeneficiarySourceOfFund,

    /// Dropdown options for the dynamic product fields, keyed by
    /// [BeneficiaryFieldKeys.normalize]d field name.
    @Default({}) Map<String, List<ComboItem>> comboLists,
    required Option<Either<BeneficiaryFailure, BeneficiaryListDto>>
    beneficiaryFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryByIdDto>>
    beneficiaryByIdFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryCountryListDto>>
    beneficiaryCountryListFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryCurrencyListDto>>
    beneficiaryCurrenciesFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryTransferModeListDto>>
    beneficiaryTransferTypesFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryBankOrAgentListDto>>
    beneficiaryBankOrAgentListFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryProductFieldSettingsDto>>
    beneficiaryProductSettingsFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryBankComboListDto>>
    beneficiaryBankComboListFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryBankBranchComboListDto>>
    beneficiaryBankBranchComboListFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryPurposeOfTransferDto>>
    beneficiaryPurposeOfTransactionFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiarySourceOfFundDto>>
    beneficiarySourceOfFundFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, int>> saveBeneficiaryFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, String>> beneficiaryOtpFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryRouteCodeDto>>
    beneficiaryRouteCodeFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, BeneficiaryBankBranchRouteDto>>
    beneficiaryBankBranchRouteFailureOrSuccessOption,
    required Option<Either<BeneficiaryFailure, int>> resendBeneficiaryOtpFailureOrSuccessOption,
    @Default(false) bool isDeleting,
    required Option<Either<BeneficiaryFailure, Unit>> deleteBeneficiaryFailureOrSuccessOption,

    // ── Payment (action-sheet) flow ────────────────────────────────────────
    // True while the agent fetch + mandatory check run (drives the page's
    // loading overlay). Dropped while the multi-agent picker is shown.
    @Default(false) bool isPaymentLoading,
    // The beneficiary being paid — kept so the one-shot listener has the eId for
    // the summary / edit navigation.
    BeneficiaryList? paymentBeneficiary,
    // Agent resolved for the payment: auto-selected single option, or the user's
    // pick. Null ⇒ no agent (406 / not required); passed verbatim to the summary.
    CommonSelectableItem? paymentAgentItem,
    // One-shot for the agent step. Fires only for the two UI cases: Left(failure)
    // → error dialog; Right(agent list) with multiple options → picker dialog.
    // Single-option and 406/empty resolve silently and go to the mandatory check.
    required Option<Either<BeneficiaryFailure, CommonSelectableDto>>
    paymentAgentOption,
    // One-shot for the mandatory check: Left(missingMandatoryFields) → edit
    // dialog, other Left → toast, Right → navigate to summary.
    required Option<Either<BeneficiaryFailure, HomeMandatoryFieldCheckDto>>
    paymentMandatoryCheckOption,
  }) = _BeneficiaryState;

  factory BeneficiaryState.initial() => BeneficiaryState(
    isEditing: false,
    isAddingFromHome: false,
    isLoading: false,
    showErrorMessages: false,
    isSubmitting: false,
    isOtpSubmitting: false,
    showOtpErrorMessages: false,
    dynamicFieldValues: {},
    initialDynamicFieldValues: {},
    beneficiaryOtp: BeneficiaryOtp(''),
    beneficiaryFailureOrSuccessOption: none(),
    beneficiaryByIdFailureOrSuccessOption: none(),
    beneficiaryCountryListFailureOrSuccessOption: none(),
    beneficiaryCurrenciesFailureOrSuccessOption: none(),
    beneficiaryTransferTypesFailureOrSuccessOption: none(),
    beneficiaryBankOrAgentListFailureOrSuccessOption: none(),
    beneficiaryProductSettingsFailureOrSuccessOption: none(),
    beneficiaryBankComboListFailureOrSuccessOption: none(),
    beneficiaryBankBranchComboListFailureOrSuccessOption: none(),
    beneficiaryPurposeOfTransactionFailureOrSuccessOption: none(),
    beneficiarySourceOfFundFailureOrSuccessOption: none(),
    saveBeneficiaryFailureOrSuccessOption: none(),
    beneficiaryOtpFailureOrSuccessOption: none(),
    beneficiaryRouteCodeFailureOrSuccessOption: none(),
    beneficiaryBankBranchRouteFailureOrSuccessOption: none(),
    resendBeneficiaryOtpFailureOrSuccessOption: none(),
    deleteBeneficiaryFailureOrSuccessOption: none(),
    paymentAgentOption: none(),
    paymentMandatoryCheckOption: none(),
  );
}
