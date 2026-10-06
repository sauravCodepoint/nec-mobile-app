// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_profile_state_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompleteProfileStateDto _$CompleteProfileStateDtoFromJson(
  Map<String, dynamic> json,
) => _CompleteProfileStateDto(
  success: json['success'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CompleteProfileStateDtoToJson(
  _CompleteProfileStateDto instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

_Data _$DataFromJson(Map<String, dynamic> json) => _Data(
  stateList: (json['state_list'] as List<dynamic>?)
      ?.map((e) => StateList.fromJson(e as Map<String, dynamic>))
      .toList(),
  appMemberCode: (json['app_member_code'] as num?)?.toInt(),
  economicActivityId: (json['economic_activity_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
  'state_list': instance.stateList,
  'app_member_code': instance.appMemberCode,
  'economic_activity_id': instance.economicActivityId,
};

_StateList _$StateListFromJson(Map<String, dynamic> json) => _StateList(
  code: json['code'] as String?,
  name: json['name'] as String?,
  isDefault: json['is_default'] as bool?,
  productCode: (json['product_code'] as num?)?.toInt(),
);

Map<String, dynamic> _$StateListToJson(_StateList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'is_default': instance.isDefault,
      'product_code': instance.productCode,
    };
