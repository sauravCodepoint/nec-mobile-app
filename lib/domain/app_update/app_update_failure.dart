import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_update_failure.freezed.dart';

@freezed
sealed class AppUpdateFailure with _$AppUpdateFailure {
  const factory AppUpdateFailure.serverError() = _ServerError;
  const factory AppUpdateFailure.unableToCheck() = _UnableToCheck;
}
