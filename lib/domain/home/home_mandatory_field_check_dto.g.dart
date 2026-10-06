// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_mandatory_field_check_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeMandatoryFieldCheckDto _$HomeMandatoryFieldCheckDtoFromJson(
  Map<String, dynamic> json,
) => _HomeMandatoryFieldCheckDto(
  success: json['success'] as String?,
  statusCode: (json['status_code'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : HomeMandatoryFieldCheckData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  timeStamp: json['time_stamp'] == null
      ? null
      : DateTime.parse(json['time_stamp'] as String),
  version: json['version'] as String?,
);

Map<String, dynamic> _$HomeMandatoryFieldCheckDtoToJson(
  _HomeMandatoryFieldCheckDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
  'time_stamp': instance.timeStamp?.toIso8601String(),
  'version': instance.version,
};

_HomeMandatoryFieldCheckData _$HomeMandatoryFieldCheckDataFromJson(
  Map<String, dynamic> json,
) => _HomeMandatoryFieldCheckData(
  product: json['product'] == null
      ? null
      : HomeMandatoryFieldProduct.fromJson(
          json['product'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$HomeMandatoryFieldCheckDataToJson(
  _HomeMandatoryFieldCheckData instance,
) => <String, dynamic>{'product': instance.product};

_HomeMandatoryFieldProduct _$HomeMandatoryFieldProductFromJson(
  Map<String, dynamic> json,
) => _HomeMandatoryFieldProduct(
  code: (json['code'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Map<String, dynamic> _$HomeMandatoryFieldProductToJson(
  _HomeMandatoryFieldProduct instance,
) => <String, dynamic>{'code': instance.code, 'name': instance.name};
