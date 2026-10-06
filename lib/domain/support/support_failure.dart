import 'package:freezed_annotation/freezed_annotation.dart';
part 'support_failure.freezed.dart';

@freezed
sealed class SupportFailure with _$SupportFailure {
  const factory SupportFailure.unableToFetchContact(String? message) =
      _UnableToFetchContact;
  const factory SupportFailure.serverError() = _ServerError;
}