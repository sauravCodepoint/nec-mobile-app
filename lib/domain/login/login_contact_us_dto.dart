import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_contact_us_dto.freezed.dart';
part 'login_contact_us_dto.g.dart';

ContactUsDto contactUsDtoFromJson(String str) =>
    ContactUsDto.fromJson(json.decode(str));

String contactUsDtoToJson(ContactUsDto data) => json.encode(data.toJson());

@freezed
sealed class ContactUsDto with _$ContactUsDto {
  const factory ContactUsDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "status_code") int? statusCode,
    @JsonKey(name: "data") ContactUsData? data,
    @JsonKey(name: "time_stamp") String? timeStamp,
    @JsonKey(name: "version") String? version,
  }) = _ContactUsDto;

  factory ContactUsDto.fromJson(Map<String, dynamic> json) =>
      _$ContactUsDtoFromJson(json);
}

@freezed
sealed class ContactUsData with _$ContactUsData {
  const factory ContactUsData({
    @JsonKey(name: "screen_title") String? screenTitle,
    @JsonKey(name: "section_title") String? sectionTitle,
    @JsonKey(name: "header") ContactUsHeader? header,
    @JsonKey(name: "channels") List<ContactChannel>? channels,
    @JsonKey(name: "footer") String? footer,
  }) = _ContactUsData;

  factory ContactUsData.fromJson(Map<String, dynamic> json) =>
      _$ContactUsDataFromJson(json);
}

@freezed
sealed class ContactUsHeader with _$ContactUsHeader {
  const factory ContactUsHeader({
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "subtitle") String? subtitle,
    @JsonKey(name: "is_online") bool? isOnline,
    @JsonKey(name: "online_label") String? onlineLabel,
  }) = _ContactUsHeader;

  factory ContactUsHeader.fromJson(Map<String, dynamic> json) =>
      _$ContactUsHeaderFromJson(json);
}

@freezed
sealed class ContactChannel with _$ContactChannel {
  const factory ContactChannel({
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
  }) = _ContactChannel;

  factory ContactChannel.fromJson(Map<String, dynamic> json) =>
      _$ContactChannelFromJson(json);
}
