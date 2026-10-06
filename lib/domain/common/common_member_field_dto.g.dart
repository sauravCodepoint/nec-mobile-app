// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_member_field_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommonMemberFieldDto _$CommonMemberFieldDtoFromJson(
  Map<String, dynamic> json,
) => _CommonMemberFieldDto(
  success: json['success'] as String?,
  data: json['data'] == null
      ? null
      : CommonMemberFieldData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommonMemberFieldDtoToJson(
  _CommonMemberFieldDto instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

_CommonMemberFieldData _$CommonMemberFieldDataFromJson(
  Map<String, dynamic> json,
) => _CommonMemberFieldData(
  allMemberFieldSettingList:
      (json['all_member_field_setting_list'] as List<dynamic>?)
          ?.map((e) => MemberFieldSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CommonMemberFieldDataToJson(
  _CommonMemberFieldData instance,
) => <String, dynamic>{
  'all_member_field_setting_list': instance.allMemberFieldSettingList,
};

_MemberFieldSetting _$MemberFieldSettingFromJson(Map<String, dynamic> json) =>
    _MemberFieldSetting(
      productCode: (json['product_code'] as num?)?.toInt(),
      displayOrder: (json['display_order'] as num?)?.toInt(),
      fieldName: json['field_name'] as String?,
      displayFieldName: json['display_field_name'] as String?,
      minimumLength: (json['minimum_length'] as num?)?.toInt(),
      maximumLength: (json['maximum_length'] as num?)?.toInt(),
      supportedDataType: json['supported_data_type'] as String?,
      type: json['type'] as String?,
      isTypeSystemReserved: json['is_type_system_reserved'] as bool?,
      enabled: json['enabled'] as bool?,
      mandatory: json['mandatory'] as bool?,
      visible: json['visible'] as bool?,
      defaultValue: json['default_value'] as String?,
      isFromMalaa: json['is_maala_kyc_data'] as bool?,
      allowedSpecialCharacters: json['allowed_special_characters'] as String?,
      regexPattern: json['regex_pattern'] as String?,
      specialCharacterCheckingRqrd:
          json['special_character_checking_rqrd'] as bool?,
      isSystemReserve: json['is_system_reserve'] as bool?,
      wUComboOrder: (json['w_u_combo_order'] as num?)?.toInt(),
      wUFieldSettingsID: (json['w_u_field_settings_i_d'] as num?)?.toInt(),
      dropdownItems: (json['dropdown_items'] as List<dynamic>?)
          ?.map(
            (e) => MemberFieldDropdownItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$MemberFieldSettingToJson(_MemberFieldSetting instance) =>
    <String, dynamic>{
      'product_code': instance.productCode,
      'display_order': instance.displayOrder,
      'field_name': instance.fieldName,
      'display_field_name': instance.displayFieldName,
      'minimum_length': instance.minimumLength,
      'maximum_length': instance.maximumLength,
      'supported_data_type': instance.supportedDataType,
      'type': instance.type,
      'is_type_system_reserved': instance.isTypeSystemReserved,
      'enabled': instance.enabled,
      'mandatory': instance.mandatory,
      'visible': instance.visible,
      'default_value': instance.defaultValue,
      'is_maala_kyc_data': instance.isFromMalaa,
      'allowed_special_characters': instance.allowedSpecialCharacters,
      'regex_pattern': instance.regexPattern,
      'special_character_checking_rqrd': instance.specialCharacterCheckingRqrd,
      'is_system_reserve': instance.isSystemReserve,
      'w_u_combo_order': instance.wUComboOrder,
      'w_u_field_settings_i_d': instance.wUFieldSettingsID,
      'dropdown_items': instance.dropdownItems,
    };

_MemberFieldDropdownItem _$MemberFieldDropdownItemFromJson(
  Map<String, dynamic> json,
) => _MemberFieldDropdownItem(
  code: json['code'] as String?,
  name: json['name'] as String?,
  isDefault: json['is_default'] as bool?,
  productCode: (json['product_code'] as num?)?.toInt(),
);

Map<String, dynamic> _$MemberFieldDropdownItemToJson(
  _MemberFieldDropdownItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'is_default': instance.isDefault,
  'product_code': instance.productCode,
};
