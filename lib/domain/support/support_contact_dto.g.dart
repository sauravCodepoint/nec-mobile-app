// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_contact_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SupportContactDto _$SupportContactDtoFromJson(Map<String, dynamic> json) =>
    _SupportContactDto(
      success: json['success'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : SupportContactData.fromJson(json['data'] as Map<String, dynamic>),
      timeStamp: json['time_stamp'] as String?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$SupportContactDtoToJson(_SupportContactDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
      'time_stamp': instance.timeStamp,
      'version': instance.version,
    };

_SupportContactData _$SupportContactDataFromJson(
  Map<String, dynamic> json,
) => _SupportContactData(
  screenTitle: json['screen_title'] as String?,
  sectionTitle: json['section_title'] as String?,
  header: json['header'] == null
      ? null
      : SupportContactHeader.fromJson(json['header'] as Map<String, dynamic>),
  channels: (json['channels'] as List<dynamic>?)
      ?.map((e) => SupportContactChannel.fromJson(e as Map<String, dynamic>))
      .toList(),
  footer: json['footer'] as String?,
);

Map<String, dynamic> _$SupportContactDataToJson(_SupportContactData instance) =>
    <String, dynamic>{
      'screen_title': instance.screenTitle,
      'section_title': instance.sectionTitle,
      'header': instance.header,
      'channels': instance.channels,
      'footer': instance.footer,
    };

_SupportContactHeader _$SupportContactHeaderFromJson(
  Map<String, dynamic> json,
) => _SupportContactHeader(
  title: json['title'] as String?,
  subtitle: json['subtitle'] as String?,
  isOnline: json['is_online'] as bool?,
  onlineLabel: json['online_label'] as String?,
);

Map<String, dynamic> _$SupportContactHeaderToJson(
  _SupportContactHeader instance,
) => <String, dynamic>{
  'title': instance.title,
  'subtitle': instance.subtitle,
  'is_online': instance.isOnline,
  'online_label': instance.onlineLabel,
};

_SupportContactChannel _$SupportContactChannelFromJson(
  Map<String, dynamic> json,
) => _SupportContactChannel(
  id: json['id'] as String?,
  type: json['type'] as String?,
  actionType: json['action_type'] as String?,
  title: json['title'] as String?,
  subtitle: json['subtitle'] as String?,
  value: (json['value'] as List<dynamic>?)?.map((e) => e as String).toList(),
  displayValue: (json['display_value'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  prefilledMessage: json['prefilled_message'] as String?,
  emailSubject: json['email_subject'] as String?,
  isEnabled: json['is_enabled'] as bool?,
  order: (json['order'] as num?)?.toInt(),
);

Map<String, dynamic> _$SupportContactChannelToJson(
  _SupportContactChannel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'action_type': instance.actionType,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'value': instance.value,
  'display_value': instance.displayValue,
  'prefilled_message': instance.prefilledMessage,
  'email_subject': instance.emailSubject,
  'is_enabled': instance.isEnabled,
  'order': instance.order,
};
