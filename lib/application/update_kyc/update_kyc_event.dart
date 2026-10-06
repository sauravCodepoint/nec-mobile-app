part of 'update_kyc_bloc.dart';

@freezed
class UpdateKycEvent with _$UpdateKycEvent {
  const factory UpdateKycEvent.initialized({
    required String initialIdTypeCode,
    required String initialIdNumber,
  }) = _Initialized;

  const factory UpdateKycEvent.identityTypeChanged({
    required CommonSelectableItem selectedIdentityType,
  }) = _IdentityTypeChanged;

  const factory UpdateKycEvent.frontDocumentPicked({required String path}) =
      _FrontDocumentPicked;
  const factory UpdateKycEvent.backDocumentPicked({required String path}) =
      _BackDocumentPicked;
  const factory UpdateKycEvent.frontDocumentRemoved() = _FrontDocumentRemoved;
  const factory UpdateKycEvent.backDocumentRemoved() = _BackDocumentRemoved;

  const factory UpdateKycEvent.identityNumberChanged(String value) =
      _IdentityNumberChanged;
  const factory UpdateKycEvent.issueDateChanged(String value) =
      _IssueDateChanged;
  const factory UpdateKycEvent.expiryDateChanged(String value) =
      _ExpiryDateChanged;
  const factory UpdateKycEvent.remarksChanged(String value) = _RemarksChanged;

  const factory UpdateKycEvent.ocrResultReceived(KycOcrResult result) =
      _OcrResultReceived;

  const factory UpdateKycEvent.submitPressed() = _SubmitPressed;
}