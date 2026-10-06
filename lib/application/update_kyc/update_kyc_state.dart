part of 'update_kyc_bloc.dart';

@freezed
sealed class UpdateKycState with _$UpdateKycState {
  const factory UpdateKycState({
    LoginIdIdentityDto? loginIdIdentityDto,
    CommonSelectableItem? selectedIdentityType,
    required bool isLoadingIdentityTypes,
    required Option<UpdateKycFailure> identityTypesFailureOption,
    String? frontDocumentPath,
    String? backDocumentPath,
    String? frontDocEId,
    String? backDocEId,
    required String idTypeCode,
    required IdentityNumber identityNumber,
    required IssueDate issueDate,
    required ExpiryDate expiryDate,
    // Whether each date was auto-filled by OCR (vs. picked by the user).
    // OCR-sourced dates are cleared when the scanned document is removed;
    // user-picked dates survive document deletion.
    required bool issueDateFromOcr,
    required bool expiryDateFromOcr,
    required Remarks remarks,
    required bool isFrontUploading,
    required bool isBackUploading,
    required bool isFrontDeleting,
    required bool isBackDeleting,
    required bool showErrorMessages,
    required Option<UpdateKycFailure> uploadFailureOption,
    required Option<UpdateKycFailure> deleteFailureOption,
    required bool isSubmitting,
    required Option<Either<UpdateKycFailure, Unit>> submitFailureOrSuccessOption,
  }) = _UpdateKycState;

  factory UpdateKycState.initial() => UpdateKycState(
    isLoadingIdentityTypes: false,
    identityTypesFailureOption: none(),
    isFrontUploading: false,
    isBackUploading: false,
    isFrontDeleting: false,
    isBackDeleting: false,
    showErrorMessages: false,
    idTypeCode: '',
    identityNumber: IdentityNumber('', ''),
    issueDate: IssueDate(''),
    expiryDate: ExpiryDate(''),
    issueDateFromOcr: false,
    expiryDateFromOcr: false,
    remarks: Remarks(''),
    uploadFailureOption: none(),
    deleteFailureOption: none(),
    isSubmitting: false,
    submitFailureOrSuccessOption: none(),
  );
}