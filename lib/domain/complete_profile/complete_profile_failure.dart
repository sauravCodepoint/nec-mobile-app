import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_profile_failure.freezed.dart';

@freezed
abstract class CompleteProfileFailure with _$CompleteProfileFailure {
  const factory CompleteProfileFailure.unableToGetFieldSettings() =
  _UnableToGetFieldSettings;
  const factory CompleteProfileFailure.unableToGetStates() = _UnableToGetStates;
  const factory CompleteProfileFailure.unableToGetCities() = _UnableToGetCities;
  const factory CompleteProfileFailure.unableToSubmit(String message) =
  _UnableToSubmit;
  const factory CompleteProfileFailure.unexpectedServerState(String errorId) =
  _UnexpectedServerState;
  const factory CompleteProfileFailure.selfieVideoUploadFailed(String message) =
  _SelfieVideoUploadFailed;
  const factory CompleteProfileFailure.selfieVideoDeleteFailed(String message) =
  _SelfieVideoDeleteFailed;
  const factory CompleteProfileFailure.serverError() = _ServerError;
}