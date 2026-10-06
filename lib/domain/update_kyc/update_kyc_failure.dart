import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_kyc_failure.freezed.dart';

@freezed
abstract class UpdateKycFailure with _$UpdateKycFailure {
  const factory UpdateKycFailure.unableToFetchIdentityTypes(String message) =
      _UnableToFetchIdentityTypes;
  const factory UpdateKycFailure.frontUploadFailed(String message) =
      _FrontUploadFailed;
  const factory UpdateKycFailure.backUploadFailed(String message) =
      _BackUploadFailed;
  const factory UpdateKycFailure.deleteFailed(String message) = _DeleteFailed;
  const factory UpdateKycFailure.submitFailed(String message) = _SubmitFailed;
  const factory UpdateKycFailure.serverError() = _ServerError;
}