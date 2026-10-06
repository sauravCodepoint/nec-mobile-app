import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_member_field_dto.freezed.dart';
part 'common_member_field_dto.g.dart';

/// Dynamic-form field settings returned by
/// `/Customer/get-all-member-field-settings`, shared by the Registration and
/// Complete Profile flows. Dropdown options arrive inline per field
/// (`dropdown_items`); for a complete-profile fetch (request carries the
/// member codes) the backend prefills each field's `default_value` with the
/// member's saved data.
@freezed
sealed class CommonMemberFieldDto with _$CommonMemberFieldDto {
  const factory CommonMemberFieldDto({
    @JsonKey(name: 'success') String? success,
    @JsonKey(name: 'data') CommonMemberFieldData? data,
  }) = _CommonMemberFieldDto;

  factory CommonMemberFieldDto.fromJson(Map<String, dynamic> json) =>
      _$CommonMemberFieldDtoFromJson(json);
}

@freezed
sealed class CommonMemberFieldData with _$CommonMemberFieldData {
  const factory CommonMemberFieldData({
    @JsonKey(name: 'all_member_field_setting_list')
    List<MemberFieldSetting>? allMemberFieldSettingList,
  }) = _CommonMemberFieldData;

  factory CommonMemberFieldData.fromJson(Map<String, dynamic> json) =>
      _$CommonMemberFieldDataFromJson(json);
}

@freezed
sealed class MemberFieldSetting with _$MemberFieldSetting {
  const factory MemberFieldSetting({
    @JsonKey(name: 'product_code') int? productCode,
    @JsonKey(name: 'display_order') int? displayOrder,
    @JsonKey(name: 'field_name') String? fieldName,
    @JsonKey(name: 'display_field_name') String? displayFieldName,
    @JsonKey(name: 'minimum_length') int? minimumLength,
    @JsonKey(name: 'maximum_length') int? maximumLength,
    @JsonKey(name: 'supported_data_type') String? supportedDataType,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'is_type_system_reserved') bool? isTypeSystemReserved,
    @JsonKey(name: 'enabled') bool? enabled,
    @JsonKey(name: 'mandatory') bool? mandatory,
    @JsonKey(name: 'visible') bool? visible,
    @JsonKey(name: 'default_value') String? defaultValue,
    @JsonKey(name: 'is_maala_kyc_data') bool? isFromMalaa,
    @JsonKey(name: 'allowed_special_characters')
    String? allowedSpecialCharacters,
    @JsonKey(name: 'regex_pattern') String? regexPattern,
    @JsonKey(name: 'special_character_checking_rqrd')
    bool? specialCharacterCheckingRqrd,
    @JsonKey(name: 'is_system_reserve') bool? isSystemReserve,
    @JsonKey(name: 'w_u_combo_order') int? wUComboOrder,
    @JsonKey(name: 'w_u_field_settings_i_d') int? wUFieldSettingsID,
    @JsonKey(name: 'dropdown_items')
    List<MemberFieldDropdownItem>? dropdownItems,
  }) = _MemberFieldSetting;

  factory MemberFieldSetting.fromJson(Map<String, dynamic> json) =>
      _$MemberFieldSettingFromJson(json);
}

@freezed
sealed class MemberFieldDropdownItem with _$MemberFieldDropdownItem {
  const factory MemberFieldDropdownItem({
    @JsonKey(name: 'code') String? code,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'is_default') bool? isDefault,
    @JsonKey(name: 'product_code') int? productCode,
  }) = _MemberFieldDropdownItem;

  factory MemberFieldDropdownItem.fromJson(Map<String, dynamic> json) =>
      _$MemberFieldDropdownItemFromJson(json);
}