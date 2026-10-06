// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_profile_city_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompleteProfileCityDto _$CompleteProfileCityDtoFromJson(
  Map<String, dynamic> json,
) => _CompleteProfileCityDto(
  success: json['success'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CompleteProfileCityDtoToJson(
  _CompleteProfileCityDto instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

_Data _$DataFromJson(Map<String, dynamic> json) => _Data(
  cityList: (json['city_list'] as List<dynamic>?)
      ?.map((e) => CityList.fromJson(e as Map<String, dynamic>))
      .toList(),
  appMemberCode: (json['app_member_code'] as num?)?.toInt(),
  economicActivityId: (json['economic_activity_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
  'city_list': instance.cityList,
  'app_member_code': instance.appMemberCode,
  'economic_activity_id': instance.economicActivityId,
};

_CityList _$CityListFromJson(Map<String, dynamic> json) => _CityList(
  code: json['code'] as String?,
  name: json['name'] as String?,
  isDefault: json['is_default'] as bool?,
  productCode: (json['product_code'] as num?)?.toInt(),
);

Map<String, dynamic> _$CityListToJson(_CityList instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'is_default': instance.isDefault,
  'product_code': instance.productCode,
};
