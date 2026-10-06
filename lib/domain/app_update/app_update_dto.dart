import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_update_dto.freezed.dart';
part 'app_update_dto.g.dart';

@freezed
sealed class AppUpdateDto with _$AppUpdateDto {
  const factory AppUpdateDto({
    @JsonKey(name: 'success') String? success,
    @JsonKey(name: 'status_code') int? statusCode,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'data') AppUpdateDataDto? data,
  }) = _AppUpdateDto;

  factory AppUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateDtoFromJson(json);
}

@freezed
sealed class AppUpdateDataDto with _$AppUpdateDataDto {
  const AppUpdateDataDto._();

  const factory AppUpdateDataDto({
    @JsonKey(name: 'update_required') bool? updateRequired,
    @JsonKey(name: 'update_type') String? updateType,
    @JsonKey(name: 'latest_version') String? latestVersion,
    @JsonKey(name: 'minimum_supported_version') String? minimumSupportedVersion,
    @JsonKey(name: 'update_url') String? updateUrl,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') String? message,
  }) = _AppUpdateDataDto;

  bool get isUpdateRequired => updateRequired ?? false;

  /// A force update blocks dismissal — the user must go to the store.
  bool get isForceUpdate => updateType?.toLowerCase().trim() == 'force';

  factory AppUpdateDataDto.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateDataDtoFromJson(json);
}
