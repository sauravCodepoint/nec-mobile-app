// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUpdateDto _$AppUpdateDtoFromJson(Map<String, dynamic> json) =>
    _AppUpdateDto(
      success: json['success'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AppUpdateDataDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppUpdateDtoToJson(_AppUpdateDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

_AppUpdateDataDto _$AppUpdateDataDtoFromJson(Map<String, dynamic> json) =>
    _AppUpdateDataDto(
      updateRequired: json['update_required'] as bool?,
      updateType: json['update_type'] as String?,
      latestVersion: json['latest_version'] as String?,
      minimumSupportedVersion: json['minimum_supported_version'] as String?,
      updateUrl: json['update_url'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AppUpdateDataDtoToJson(_AppUpdateDataDto instance) =>
    <String, dynamic>{
      'update_required': instance.updateRequired,
      'update_type': instance.updateType,
      'latest_version': instance.latestVersion,
      'minimum_supported_version': instance.minimumSupportedVersion,
      'update_url': instance.updateUrl,
      'title': instance.title,
      'message': instance.message,
    };
