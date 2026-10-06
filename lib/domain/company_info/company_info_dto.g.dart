// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompanyInfoDto _$CompanyInfoDtoFromJson(Map<String, dynamic> json) =>
    _CompanyInfoDto(
      success: json['success'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$CompanyInfoDtoToJson(_CompanyInfoDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
