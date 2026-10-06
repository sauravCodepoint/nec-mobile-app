import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_contact_dto.freezed.dart';
part 'support_contact_dto.g.dart';

SupportContactDto supportContactDtoFromJson(String str) =>
    SupportContactDto.fromJson(json.decode(str));

String supportContactDtoToJson(SupportContactDto data) =>
    json.encode(data.toJson());

@freezed
sealed class SupportContactDto with _$SupportContactDto {
  const factory SupportContactDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "status_code") int? statusCode,
    @JsonKey(name: "data") SupportContactData? data,
    @JsonKey(name: "time_stamp") String? timeStamp,
    @JsonKey(name: "version") String? version,
  }) = _SupportContactDto;

  factory SupportContactDto.fromJson(Map<String, dynamic> json) =>
      _$SupportContactDtoFromJson(json);
}

@freezed
sealed class SupportContactData with _$SupportContactData {
  const factory SupportContactData({
    @JsonKey(name: "screen_title") String? screenTitle,
    @JsonKey(name: "section_title") String? sectionTitle,
    @JsonKey(name: "header") SupportContactHeader? header,
    @JsonKey(name: "channels") List<SupportContactChannel>? channels,
    @JsonKey(name: "footer") String? footer,
  }) = _SupportContactData;

  factory SupportContactData.fromJson(Map<String, dynamic> json) =>
      _$SupportContactDataFromJson(json);
}

@freezed
sealed class SupportContactHeader with _$SupportContactHeader {
  const factory SupportContactHeader({
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "subtitle") String? subtitle,
    @JsonKey(name: "is_online") bool? isOnline,
    @JsonKey(name: "online_label") String? onlineLabel,
  }) = _SupportContactHeader;

  factory SupportContactHeader.fromJson(Map<String, dynamic> json) =>
      _$SupportContactHeaderFromJson(json);
}

@freezed
sealed class SupportContactChannel with _$SupportContactChannel {
  const factory SupportContactChannel({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "action_type") String? actionType,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "subtitle") String? subtitle,
    @JsonKey(name: "value") List<String>? value,
    @JsonKey(name: "display_value") List<String>? displayValue,
    @JsonKey(name: "prefilled_message") String? prefilledMessage,
    @JsonKey(name: "email_subject") String? emailSubject,
    @JsonKey(name: "is_enabled") bool? isEnabled,
    @JsonKey(name: "order") int? order,
  }) = _SupportContactChannel;

  factory SupportContactChannel.fromJson(Map<String, dynamic> json) =>
      _$SupportContactChannelFromJson(json);
}