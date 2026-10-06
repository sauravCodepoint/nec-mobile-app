// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_member_field_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommonMemberFieldDto {

@JsonKey(name: 'success') String? get success;@JsonKey(name: 'data') CommonMemberFieldData? get data;
/// Create a copy of CommonMemberFieldDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommonMemberFieldDtoCopyWith<CommonMemberFieldDto> get copyWith => _$CommonMemberFieldDtoCopyWithImpl<CommonMemberFieldDto>(this as CommonMemberFieldDto, _$identity);

  /// Serializes this CommonMemberFieldDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommonMemberFieldDto&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data);

@override
String toString() {
  return 'CommonMemberFieldDto(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class $CommonMemberFieldDtoCopyWith<$Res>  {
  factory $CommonMemberFieldDtoCopyWith(CommonMemberFieldDto value, $Res Function(CommonMemberFieldDto) _then) = _$CommonMemberFieldDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'success') String? success,@JsonKey(name: 'data') CommonMemberFieldData? data
});


$CommonMemberFieldDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$CommonMemberFieldDtoCopyWithImpl<$Res>
    implements $CommonMemberFieldDtoCopyWith<$Res> {
  _$CommonMemberFieldDtoCopyWithImpl(this._self, this._then);

  final CommonMemberFieldDto _self;
  final $Res Function(CommonMemberFieldDto) _then;

/// Create a copy of CommonMemberFieldDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CommonMemberFieldData?,
  ));
}
/// Create a copy of CommonMemberFieldDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonMemberFieldDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CommonMemberFieldDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommonMemberFieldDto].
extension CommonMemberFieldDtoPatterns on CommonMemberFieldDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommonMemberFieldDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommonMemberFieldDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommonMemberFieldDto value)  $default,){
final _that = this;
switch (_that) {
case _CommonMemberFieldDto():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommonMemberFieldDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommonMemberFieldDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  String? success, @JsonKey(name: 'data')  CommonMemberFieldData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommonMemberFieldDto() when $default != null:
return $default(_that.success,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  String? success, @JsonKey(name: 'data')  CommonMemberFieldData? data)  $default,) {final _that = this;
switch (_that) {
case _CommonMemberFieldDto():
return $default(_that.success,_that.data);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'success')  String? success, @JsonKey(name: 'data')  CommonMemberFieldData? data)?  $default,) {final _that = this;
switch (_that) {
case _CommonMemberFieldDto() when $default != null:
return $default(_that.success,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommonMemberFieldDto implements CommonMemberFieldDto {
  const _CommonMemberFieldDto({@JsonKey(name: 'success') this.success, @JsonKey(name: 'data') this.data});
  factory _CommonMemberFieldDto.fromJson(Map<String, dynamic> json) => _$CommonMemberFieldDtoFromJson(json);

@override@JsonKey(name: 'success') final  String? success;
@override@JsonKey(name: 'data') final  CommonMemberFieldData? data;

/// Create a copy of CommonMemberFieldDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommonMemberFieldDtoCopyWith<_CommonMemberFieldDto> get copyWith => __$CommonMemberFieldDtoCopyWithImpl<_CommonMemberFieldDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommonMemberFieldDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommonMemberFieldDto&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data);

@override
String toString() {
  return 'CommonMemberFieldDto(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CommonMemberFieldDtoCopyWith<$Res> implements $CommonMemberFieldDtoCopyWith<$Res> {
  factory _$CommonMemberFieldDtoCopyWith(_CommonMemberFieldDto value, $Res Function(_CommonMemberFieldDto) _then) = __$CommonMemberFieldDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'success') String? success,@JsonKey(name: 'data') CommonMemberFieldData? data
});


@override $CommonMemberFieldDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$CommonMemberFieldDtoCopyWithImpl<$Res>
    implements _$CommonMemberFieldDtoCopyWith<$Res> {
  __$CommonMemberFieldDtoCopyWithImpl(this._self, this._then);

  final _CommonMemberFieldDto _self;
  final $Res Function(_CommonMemberFieldDto) _then;

/// Create a copy of CommonMemberFieldDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? data = freezed,}) {
  return _then(_CommonMemberFieldDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CommonMemberFieldData?,
  ));
}

/// Create a copy of CommonMemberFieldDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonMemberFieldDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CommonMemberFieldDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$CommonMemberFieldData {

@JsonKey(name: 'all_member_field_setting_list') List<MemberFieldSetting>? get allMemberFieldSettingList;
/// Create a copy of CommonMemberFieldData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommonMemberFieldDataCopyWith<CommonMemberFieldData> get copyWith => _$CommonMemberFieldDataCopyWithImpl<CommonMemberFieldData>(this as CommonMemberFieldData, _$identity);

  /// Serializes this CommonMemberFieldData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommonMemberFieldData&&const DeepCollectionEquality().equals(other.allMemberFieldSettingList, allMemberFieldSettingList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(allMemberFieldSettingList));

@override
String toString() {
  return 'CommonMemberFieldData(allMemberFieldSettingList: $allMemberFieldSettingList)';
}


}

/// @nodoc
abstract mixin class $CommonMemberFieldDataCopyWith<$Res>  {
  factory $CommonMemberFieldDataCopyWith(CommonMemberFieldData value, $Res Function(CommonMemberFieldData) _then) = _$CommonMemberFieldDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'all_member_field_setting_list') List<MemberFieldSetting>? allMemberFieldSettingList
});




}
/// @nodoc
class _$CommonMemberFieldDataCopyWithImpl<$Res>
    implements $CommonMemberFieldDataCopyWith<$Res> {
  _$CommonMemberFieldDataCopyWithImpl(this._self, this._then);

  final CommonMemberFieldData _self;
  final $Res Function(CommonMemberFieldData) _then;

/// Create a copy of CommonMemberFieldData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allMemberFieldSettingList = freezed,}) {
  return _then(_self.copyWith(
allMemberFieldSettingList: freezed == allMemberFieldSettingList ? _self.allMemberFieldSettingList : allMemberFieldSettingList // ignore: cast_nullable_to_non_nullable
as List<MemberFieldSetting>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommonMemberFieldData].
extension CommonMemberFieldDataPatterns on CommonMemberFieldData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommonMemberFieldData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommonMemberFieldData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommonMemberFieldData value)  $default,){
final _that = this;
switch (_that) {
case _CommonMemberFieldData():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommonMemberFieldData value)?  $default,){
final _that = this;
switch (_that) {
case _CommonMemberFieldData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'all_member_field_setting_list')  List<MemberFieldSetting>? allMemberFieldSettingList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommonMemberFieldData() when $default != null:
return $default(_that.allMemberFieldSettingList);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'all_member_field_setting_list')  List<MemberFieldSetting>? allMemberFieldSettingList)  $default,) {final _that = this;
switch (_that) {
case _CommonMemberFieldData():
return $default(_that.allMemberFieldSettingList);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'all_member_field_setting_list')  List<MemberFieldSetting>? allMemberFieldSettingList)?  $default,) {final _that = this;
switch (_that) {
case _CommonMemberFieldData() when $default != null:
return $default(_that.allMemberFieldSettingList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommonMemberFieldData implements CommonMemberFieldData {
  const _CommonMemberFieldData({@JsonKey(name: 'all_member_field_setting_list') final  List<MemberFieldSetting>? allMemberFieldSettingList}): _allMemberFieldSettingList = allMemberFieldSettingList;
  factory _CommonMemberFieldData.fromJson(Map<String, dynamic> json) => _$CommonMemberFieldDataFromJson(json);

 final  List<MemberFieldSetting>? _allMemberFieldSettingList;
@override@JsonKey(name: 'all_member_field_setting_list') List<MemberFieldSetting>? get allMemberFieldSettingList {
  final value = _allMemberFieldSettingList;
  if (value == null) return null;
  if (_allMemberFieldSettingList is EqualUnmodifiableListView) return _allMemberFieldSettingList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CommonMemberFieldData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommonMemberFieldDataCopyWith<_CommonMemberFieldData> get copyWith => __$CommonMemberFieldDataCopyWithImpl<_CommonMemberFieldData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommonMemberFieldDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommonMemberFieldData&&const DeepCollectionEquality().equals(other._allMemberFieldSettingList, _allMemberFieldSettingList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allMemberFieldSettingList));

@override
String toString() {
  return 'CommonMemberFieldData(allMemberFieldSettingList: $allMemberFieldSettingList)';
}


}

/// @nodoc
abstract mixin class _$CommonMemberFieldDataCopyWith<$Res> implements $CommonMemberFieldDataCopyWith<$Res> {
  factory _$CommonMemberFieldDataCopyWith(_CommonMemberFieldData value, $Res Function(_CommonMemberFieldData) _then) = __$CommonMemberFieldDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'all_member_field_setting_list') List<MemberFieldSetting>? allMemberFieldSettingList
});




}
/// @nodoc
class __$CommonMemberFieldDataCopyWithImpl<$Res>
    implements _$CommonMemberFieldDataCopyWith<$Res> {
  __$CommonMemberFieldDataCopyWithImpl(this._self, this._then);

  final _CommonMemberFieldData _self;
  final $Res Function(_CommonMemberFieldData) _then;

/// Create a copy of CommonMemberFieldData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allMemberFieldSettingList = freezed,}) {
  return _then(_CommonMemberFieldData(
allMemberFieldSettingList: freezed == allMemberFieldSettingList ? _self._allMemberFieldSettingList : allMemberFieldSettingList // ignore: cast_nullable_to_non_nullable
as List<MemberFieldSetting>?,
  ));
}


}


/// @nodoc
mixin _$MemberFieldSetting {

@JsonKey(name: 'product_code') int? get productCode;@JsonKey(name: 'display_order') int? get displayOrder;@JsonKey(name: 'field_name') String? get fieldName;@JsonKey(name: 'display_field_name') String? get displayFieldName;@JsonKey(name: 'minimum_length') int? get minimumLength;@JsonKey(name: 'maximum_length') int? get maximumLength;@JsonKey(name: 'supported_data_type') String? get supportedDataType;@JsonKey(name: 'type') String? get type;@JsonKey(name: 'is_type_system_reserved') bool? get isTypeSystemReserved;@JsonKey(name: 'enabled') bool? get enabled;@JsonKey(name: 'mandatory') bool? get mandatory;@JsonKey(name: 'visible') bool? get visible;@JsonKey(name: 'default_value') String? get defaultValue;@JsonKey(name: 'is_maala_kyc_data') bool? get isFromMalaa;@JsonKey(name: 'allowed_special_characters') String? get allowedSpecialCharacters;@JsonKey(name: 'regex_pattern') String? get regexPattern;@JsonKey(name: 'special_character_checking_rqrd') bool? get specialCharacterCheckingRqrd;@JsonKey(name: 'is_system_reserve') bool? get isSystemReserve;@JsonKey(name: 'w_u_combo_order') int? get wUComboOrder;@JsonKey(name: 'w_u_field_settings_i_d') int? get wUFieldSettingsID;@JsonKey(name: 'dropdown_items') List<MemberFieldDropdownItem>? get dropdownItems;
/// Create a copy of MemberFieldSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberFieldSettingCopyWith<MemberFieldSetting> get copyWith => _$MemberFieldSettingCopyWithImpl<MemberFieldSetting>(this as MemberFieldSetting, _$identity);

  /// Serializes this MemberFieldSetting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberFieldSetting&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.fieldName, fieldName) || other.fieldName == fieldName)&&(identical(other.displayFieldName, displayFieldName) || other.displayFieldName == displayFieldName)&&(identical(other.minimumLength, minimumLength) || other.minimumLength == minimumLength)&&(identical(other.maximumLength, maximumLength) || other.maximumLength == maximumLength)&&(identical(other.supportedDataType, supportedDataType) || other.supportedDataType == supportedDataType)&&(identical(other.type, type) || other.type == type)&&(identical(other.isTypeSystemReserved, isTypeSystemReserved) || other.isTypeSystemReserved == isTypeSystemReserved)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.mandatory, mandatory) || other.mandatory == mandatory)&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue)&&(identical(other.isFromMalaa, isFromMalaa) || other.isFromMalaa == isFromMalaa)&&(identical(other.allowedSpecialCharacters, allowedSpecialCharacters) || other.allowedSpecialCharacters == allowedSpecialCharacters)&&(identical(other.regexPattern, regexPattern) || other.regexPattern == regexPattern)&&(identical(other.specialCharacterCheckingRqrd, specialCharacterCheckingRqrd) || other.specialCharacterCheckingRqrd == specialCharacterCheckingRqrd)&&(identical(other.isSystemReserve, isSystemReserve) || other.isSystemReserve == isSystemReserve)&&(identical(other.wUComboOrder, wUComboOrder) || other.wUComboOrder == wUComboOrder)&&(identical(other.wUFieldSettingsID, wUFieldSettingsID) || other.wUFieldSettingsID == wUFieldSettingsID)&&const DeepCollectionEquality().equals(other.dropdownItems, dropdownItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,productCode,displayOrder,fieldName,displayFieldName,minimumLength,maximumLength,supportedDataType,type,isTypeSystemReserved,enabled,mandatory,visible,defaultValue,isFromMalaa,allowedSpecialCharacters,regexPattern,specialCharacterCheckingRqrd,isSystemReserve,wUComboOrder,wUFieldSettingsID,const DeepCollectionEquality().hash(dropdownItems)]);

@override
String toString() {
  return 'MemberFieldSetting(productCode: $productCode, displayOrder: $displayOrder, fieldName: $fieldName, displayFieldName: $displayFieldName, minimumLength: $minimumLength, maximumLength: $maximumLength, supportedDataType: $supportedDataType, type: $type, isTypeSystemReserved: $isTypeSystemReserved, enabled: $enabled, mandatory: $mandatory, visible: $visible, defaultValue: $defaultValue, isFromMalaa: $isFromMalaa, allowedSpecialCharacters: $allowedSpecialCharacters, regexPattern: $regexPattern, specialCharacterCheckingRqrd: $specialCharacterCheckingRqrd, isSystemReserve: $isSystemReserve, wUComboOrder: $wUComboOrder, wUFieldSettingsID: $wUFieldSettingsID, dropdownItems: $dropdownItems)';
}


}

/// @nodoc
abstract mixin class $MemberFieldSettingCopyWith<$Res>  {
  factory $MemberFieldSettingCopyWith(MemberFieldSetting value, $Res Function(MemberFieldSetting) _then) = _$MemberFieldSettingCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'product_code') int? productCode,@JsonKey(name: 'display_order') int? displayOrder,@JsonKey(name: 'field_name') String? fieldName,@JsonKey(name: 'display_field_name') String? displayFieldName,@JsonKey(name: 'minimum_length') int? minimumLength,@JsonKey(name: 'maximum_length') int? maximumLength,@JsonKey(name: 'supported_data_type') String? supportedDataType,@JsonKey(name: 'type') String? type,@JsonKey(name: 'is_type_system_reserved') bool? isTypeSystemReserved,@JsonKey(name: 'enabled') bool? enabled,@JsonKey(name: 'mandatory') bool? mandatory,@JsonKey(name: 'visible') bool? visible,@JsonKey(name: 'default_value') String? defaultValue,@JsonKey(name: 'is_maala_kyc_data') bool? isFromMalaa,@JsonKey(name: 'allowed_special_characters') String? allowedSpecialCharacters,@JsonKey(name: 'regex_pattern') String? regexPattern,@JsonKey(name: 'special_character_checking_rqrd') bool? specialCharacterCheckingRqrd,@JsonKey(name: 'is_system_reserve') bool? isSystemReserve,@JsonKey(name: 'w_u_combo_order') int? wUComboOrder,@JsonKey(name: 'w_u_field_settings_i_d') int? wUFieldSettingsID,@JsonKey(name: 'dropdown_items') List<MemberFieldDropdownItem>? dropdownItems
});




}
/// @nodoc
class _$MemberFieldSettingCopyWithImpl<$Res>
    implements $MemberFieldSettingCopyWith<$Res> {
  _$MemberFieldSettingCopyWithImpl(this._self, this._then);

  final MemberFieldSetting _self;
  final $Res Function(MemberFieldSetting) _then;

/// Create a copy of MemberFieldSetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productCode = freezed,Object? displayOrder = freezed,Object? fieldName = freezed,Object? displayFieldName = freezed,Object? minimumLength = freezed,Object? maximumLength = freezed,Object? supportedDataType = freezed,Object? type = freezed,Object? isTypeSystemReserved = freezed,Object? enabled = freezed,Object? mandatory = freezed,Object? visible = freezed,Object? defaultValue = freezed,Object? isFromMalaa = freezed,Object? allowedSpecialCharacters = freezed,Object? regexPattern = freezed,Object? specialCharacterCheckingRqrd = freezed,Object? isSystemReserve = freezed,Object? wUComboOrder = freezed,Object? wUFieldSettingsID = freezed,Object? dropdownItems = freezed,}) {
  return _then(_self.copyWith(
productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as int?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int?,fieldName: freezed == fieldName ? _self.fieldName : fieldName // ignore: cast_nullable_to_non_nullable
as String?,displayFieldName: freezed == displayFieldName ? _self.displayFieldName : displayFieldName // ignore: cast_nullable_to_non_nullable
as String?,minimumLength: freezed == minimumLength ? _self.minimumLength : minimumLength // ignore: cast_nullable_to_non_nullable
as int?,maximumLength: freezed == maximumLength ? _self.maximumLength : maximumLength // ignore: cast_nullable_to_non_nullable
as int?,supportedDataType: freezed == supportedDataType ? _self.supportedDataType : supportedDataType // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,isTypeSystemReserved: freezed == isTypeSystemReserved ? _self.isTypeSystemReserved : isTypeSystemReserved // ignore: cast_nullable_to_non_nullable
as bool?,enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,mandatory: freezed == mandatory ? _self.mandatory : mandatory // ignore: cast_nullable_to_non_nullable
as bool?,visible: freezed == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool?,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as String?,isFromMalaa: freezed == isFromMalaa ? _self.isFromMalaa : isFromMalaa // ignore: cast_nullable_to_non_nullable
as bool?,allowedSpecialCharacters: freezed == allowedSpecialCharacters ? _self.allowedSpecialCharacters : allowedSpecialCharacters // ignore: cast_nullable_to_non_nullable
as String?,regexPattern: freezed == regexPattern ? _self.regexPattern : regexPattern // ignore: cast_nullable_to_non_nullable
as String?,specialCharacterCheckingRqrd: freezed == specialCharacterCheckingRqrd ? _self.specialCharacterCheckingRqrd : specialCharacterCheckingRqrd // ignore: cast_nullable_to_non_nullable
as bool?,isSystemReserve: freezed == isSystemReserve ? _self.isSystemReserve : isSystemReserve // ignore: cast_nullable_to_non_nullable
as bool?,wUComboOrder: freezed == wUComboOrder ? _self.wUComboOrder : wUComboOrder // ignore: cast_nullable_to_non_nullable
as int?,wUFieldSettingsID: freezed == wUFieldSettingsID ? _self.wUFieldSettingsID : wUFieldSettingsID // ignore: cast_nullable_to_non_nullable
as int?,dropdownItems: freezed == dropdownItems ? _self.dropdownItems : dropdownItems // ignore: cast_nullable_to_non_nullable
as List<MemberFieldDropdownItem>?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberFieldSetting].
extension MemberFieldSettingPatterns on MemberFieldSetting {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberFieldSetting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberFieldSetting() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberFieldSetting value)  $default,){
final _that = this;
switch (_that) {
case _MemberFieldSetting():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberFieldSetting value)?  $default,){
final _that = this;
switch (_that) {
case _MemberFieldSetting() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_code')  int? productCode, @JsonKey(name: 'display_order')  int? displayOrder, @JsonKey(name: 'field_name')  String? fieldName, @JsonKey(name: 'display_field_name')  String? displayFieldName, @JsonKey(name: 'minimum_length')  int? minimumLength, @JsonKey(name: 'maximum_length')  int? maximumLength, @JsonKey(name: 'supported_data_type')  String? supportedDataType, @JsonKey(name: 'type')  String? type, @JsonKey(name: 'is_type_system_reserved')  bool? isTypeSystemReserved, @JsonKey(name: 'enabled')  bool? enabled, @JsonKey(name: 'mandatory')  bool? mandatory, @JsonKey(name: 'visible')  bool? visible, @JsonKey(name: 'default_value')  String? defaultValue, @JsonKey(name: 'is_maala_kyc_data')  bool? isFromMalaa, @JsonKey(name: 'allowed_special_characters')  String? allowedSpecialCharacters, @JsonKey(name: 'regex_pattern')  String? regexPattern, @JsonKey(name: 'special_character_checking_rqrd')  bool? specialCharacterCheckingRqrd, @JsonKey(name: 'is_system_reserve')  bool? isSystemReserve, @JsonKey(name: 'w_u_combo_order')  int? wUComboOrder, @JsonKey(name: 'w_u_field_settings_i_d')  int? wUFieldSettingsID, @JsonKey(name: 'dropdown_items')  List<MemberFieldDropdownItem>? dropdownItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberFieldSetting() when $default != null:
return $default(_that.productCode,_that.displayOrder,_that.fieldName,_that.displayFieldName,_that.minimumLength,_that.maximumLength,_that.supportedDataType,_that.type,_that.isTypeSystemReserved,_that.enabled,_that.mandatory,_that.visible,_that.defaultValue,_that.isFromMalaa,_that.allowedSpecialCharacters,_that.regexPattern,_that.specialCharacterCheckingRqrd,_that.isSystemReserve,_that.wUComboOrder,_that.wUFieldSettingsID,_that.dropdownItems);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_code')  int? productCode, @JsonKey(name: 'display_order')  int? displayOrder, @JsonKey(name: 'field_name')  String? fieldName, @JsonKey(name: 'display_field_name')  String? displayFieldName, @JsonKey(name: 'minimum_length')  int? minimumLength, @JsonKey(name: 'maximum_length')  int? maximumLength, @JsonKey(name: 'supported_data_type')  String? supportedDataType, @JsonKey(name: 'type')  String? type, @JsonKey(name: 'is_type_system_reserved')  bool? isTypeSystemReserved, @JsonKey(name: 'enabled')  bool? enabled, @JsonKey(name: 'mandatory')  bool? mandatory, @JsonKey(name: 'visible')  bool? visible, @JsonKey(name: 'default_value')  String? defaultValue, @JsonKey(name: 'is_maala_kyc_data')  bool? isFromMalaa, @JsonKey(name: 'allowed_special_characters')  String? allowedSpecialCharacters, @JsonKey(name: 'regex_pattern')  String? regexPattern, @JsonKey(name: 'special_character_checking_rqrd')  bool? specialCharacterCheckingRqrd, @JsonKey(name: 'is_system_reserve')  bool? isSystemReserve, @JsonKey(name: 'w_u_combo_order')  int? wUComboOrder, @JsonKey(name: 'w_u_field_settings_i_d')  int? wUFieldSettingsID, @JsonKey(name: 'dropdown_items')  List<MemberFieldDropdownItem>? dropdownItems)  $default,) {final _that = this;
switch (_that) {
case _MemberFieldSetting():
return $default(_that.productCode,_that.displayOrder,_that.fieldName,_that.displayFieldName,_that.minimumLength,_that.maximumLength,_that.supportedDataType,_that.type,_that.isTypeSystemReserved,_that.enabled,_that.mandatory,_that.visible,_that.defaultValue,_that.isFromMalaa,_that.allowedSpecialCharacters,_that.regexPattern,_that.specialCharacterCheckingRqrd,_that.isSystemReserve,_that.wUComboOrder,_that.wUFieldSettingsID,_that.dropdownItems);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'product_code')  int? productCode, @JsonKey(name: 'display_order')  int? displayOrder, @JsonKey(name: 'field_name')  String? fieldName, @JsonKey(name: 'display_field_name')  String? displayFieldName, @JsonKey(name: 'minimum_length')  int? minimumLength, @JsonKey(name: 'maximum_length')  int? maximumLength, @JsonKey(name: 'supported_data_type')  String? supportedDataType, @JsonKey(name: 'type')  String? type, @JsonKey(name: 'is_type_system_reserved')  bool? isTypeSystemReserved, @JsonKey(name: 'enabled')  bool? enabled, @JsonKey(name: 'mandatory')  bool? mandatory, @JsonKey(name: 'visible')  bool? visible, @JsonKey(name: 'default_value')  String? defaultValue, @JsonKey(name: 'is_maala_kyc_data')  bool? isFromMalaa, @JsonKey(name: 'allowed_special_characters')  String? allowedSpecialCharacters, @JsonKey(name: 'regex_pattern')  String? regexPattern, @JsonKey(name: 'special_character_checking_rqrd')  bool? specialCharacterCheckingRqrd, @JsonKey(name: 'is_system_reserve')  bool? isSystemReserve, @JsonKey(name: 'w_u_combo_order')  int? wUComboOrder, @JsonKey(name: 'w_u_field_settings_i_d')  int? wUFieldSettingsID, @JsonKey(name: 'dropdown_items')  List<MemberFieldDropdownItem>? dropdownItems)?  $default,) {final _that = this;
switch (_that) {
case _MemberFieldSetting() when $default != null:
return $default(_that.productCode,_that.displayOrder,_that.fieldName,_that.displayFieldName,_that.minimumLength,_that.maximumLength,_that.supportedDataType,_that.type,_that.isTypeSystemReserved,_that.enabled,_that.mandatory,_that.visible,_that.defaultValue,_that.isFromMalaa,_that.allowedSpecialCharacters,_that.regexPattern,_that.specialCharacterCheckingRqrd,_that.isSystemReserve,_that.wUComboOrder,_that.wUFieldSettingsID,_that.dropdownItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberFieldSetting implements MemberFieldSetting {
  const _MemberFieldSetting({@JsonKey(name: 'product_code') this.productCode, @JsonKey(name: 'display_order') this.displayOrder, @JsonKey(name: 'field_name') this.fieldName, @JsonKey(name: 'display_field_name') this.displayFieldName, @JsonKey(name: 'minimum_length') this.minimumLength, @JsonKey(name: 'maximum_length') this.maximumLength, @JsonKey(name: 'supported_data_type') this.supportedDataType, @JsonKey(name: 'type') this.type, @JsonKey(name: 'is_type_system_reserved') this.isTypeSystemReserved, @JsonKey(name: 'enabled') this.enabled, @JsonKey(name: 'mandatory') this.mandatory, @JsonKey(name: 'visible') this.visible, @JsonKey(name: 'default_value') this.defaultValue, @JsonKey(name: 'is_maala_kyc_data') this.isFromMalaa, @JsonKey(name: 'allowed_special_characters') this.allowedSpecialCharacters, @JsonKey(name: 'regex_pattern') this.regexPattern, @JsonKey(name: 'special_character_checking_rqrd') this.specialCharacterCheckingRqrd, @JsonKey(name: 'is_system_reserve') this.isSystemReserve, @JsonKey(name: 'w_u_combo_order') this.wUComboOrder, @JsonKey(name: 'w_u_field_settings_i_d') this.wUFieldSettingsID, @JsonKey(name: 'dropdown_items') final  List<MemberFieldDropdownItem>? dropdownItems}): _dropdownItems = dropdownItems;
  factory _MemberFieldSetting.fromJson(Map<String, dynamic> json) => _$MemberFieldSettingFromJson(json);

@override@JsonKey(name: 'product_code') final  int? productCode;
@override@JsonKey(name: 'display_order') final  int? displayOrder;
@override@JsonKey(name: 'field_name') final  String? fieldName;
@override@JsonKey(name: 'display_field_name') final  String? displayFieldName;
@override@JsonKey(name: 'minimum_length') final  int? minimumLength;
@override@JsonKey(name: 'maximum_length') final  int? maximumLength;
@override@JsonKey(name: 'supported_data_type') final  String? supportedDataType;
@override@JsonKey(name: 'type') final  String? type;
@override@JsonKey(name: 'is_type_system_reserved') final  bool? isTypeSystemReserved;
@override@JsonKey(name: 'enabled') final  bool? enabled;
@override@JsonKey(name: 'mandatory') final  bool? mandatory;
@override@JsonKey(name: 'visible') final  bool? visible;
@override@JsonKey(name: 'default_value') final  String? defaultValue;
@override@JsonKey(name: 'is_maala_kyc_data') final  bool? isFromMalaa;
@override@JsonKey(name: 'allowed_special_characters') final  String? allowedSpecialCharacters;
@override@JsonKey(name: 'regex_pattern') final  String? regexPattern;
@override@JsonKey(name: 'special_character_checking_rqrd') final  bool? specialCharacterCheckingRqrd;
@override@JsonKey(name: 'is_system_reserve') final  bool? isSystemReserve;
@override@JsonKey(name: 'w_u_combo_order') final  int? wUComboOrder;
@override@JsonKey(name: 'w_u_field_settings_i_d') final  int? wUFieldSettingsID;
 final  List<MemberFieldDropdownItem>? _dropdownItems;
@override@JsonKey(name: 'dropdown_items') List<MemberFieldDropdownItem>? get dropdownItems {
  final value = _dropdownItems;
  if (value == null) return null;
  if (_dropdownItems is EqualUnmodifiableListView) return _dropdownItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of MemberFieldSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberFieldSettingCopyWith<_MemberFieldSetting> get copyWith => __$MemberFieldSettingCopyWithImpl<_MemberFieldSetting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberFieldSettingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberFieldSetting&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.fieldName, fieldName) || other.fieldName == fieldName)&&(identical(other.displayFieldName, displayFieldName) || other.displayFieldName == displayFieldName)&&(identical(other.minimumLength, minimumLength) || other.minimumLength == minimumLength)&&(identical(other.maximumLength, maximumLength) || other.maximumLength == maximumLength)&&(identical(other.supportedDataType, supportedDataType) || other.supportedDataType == supportedDataType)&&(identical(other.type, type) || other.type == type)&&(identical(other.isTypeSystemReserved, isTypeSystemReserved) || other.isTypeSystemReserved == isTypeSystemReserved)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.mandatory, mandatory) || other.mandatory == mandatory)&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue)&&(identical(other.isFromMalaa, isFromMalaa) || other.isFromMalaa == isFromMalaa)&&(identical(other.allowedSpecialCharacters, allowedSpecialCharacters) || other.allowedSpecialCharacters == allowedSpecialCharacters)&&(identical(other.regexPattern, regexPattern) || other.regexPattern == regexPattern)&&(identical(other.specialCharacterCheckingRqrd, specialCharacterCheckingRqrd) || other.specialCharacterCheckingRqrd == specialCharacterCheckingRqrd)&&(identical(other.isSystemReserve, isSystemReserve) || other.isSystemReserve == isSystemReserve)&&(identical(other.wUComboOrder, wUComboOrder) || other.wUComboOrder == wUComboOrder)&&(identical(other.wUFieldSettingsID, wUFieldSettingsID) || other.wUFieldSettingsID == wUFieldSettingsID)&&const DeepCollectionEquality().equals(other._dropdownItems, _dropdownItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,productCode,displayOrder,fieldName,displayFieldName,minimumLength,maximumLength,supportedDataType,type,isTypeSystemReserved,enabled,mandatory,visible,defaultValue,isFromMalaa,allowedSpecialCharacters,regexPattern,specialCharacterCheckingRqrd,isSystemReserve,wUComboOrder,wUFieldSettingsID,const DeepCollectionEquality().hash(_dropdownItems)]);

@override
String toString() {
  return 'MemberFieldSetting(productCode: $productCode, displayOrder: $displayOrder, fieldName: $fieldName, displayFieldName: $displayFieldName, minimumLength: $minimumLength, maximumLength: $maximumLength, supportedDataType: $supportedDataType, type: $type, isTypeSystemReserved: $isTypeSystemReserved, enabled: $enabled, mandatory: $mandatory, visible: $visible, defaultValue: $defaultValue, isFromMalaa: $isFromMalaa, allowedSpecialCharacters: $allowedSpecialCharacters, regexPattern: $regexPattern, specialCharacterCheckingRqrd: $specialCharacterCheckingRqrd, isSystemReserve: $isSystemReserve, wUComboOrder: $wUComboOrder, wUFieldSettingsID: $wUFieldSettingsID, dropdownItems: $dropdownItems)';
}


}

/// @nodoc
abstract mixin class _$MemberFieldSettingCopyWith<$Res> implements $MemberFieldSettingCopyWith<$Res> {
  factory _$MemberFieldSettingCopyWith(_MemberFieldSetting value, $Res Function(_MemberFieldSetting) _then) = __$MemberFieldSettingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'product_code') int? productCode,@JsonKey(name: 'display_order') int? displayOrder,@JsonKey(name: 'field_name') String? fieldName,@JsonKey(name: 'display_field_name') String? displayFieldName,@JsonKey(name: 'minimum_length') int? minimumLength,@JsonKey(name: 'maximum_length') int? maximumLength,@JsonKey(name: 'supported_data_type') String? supportedDataType,@JsonKey(name: 'type') String? type,@JsonKey(name: 'is_type_system_reserved') bool? isTypeSystemReserved,@JsonKey(name: 'enabled') bool? enabled,@JsonKey(name: 'mandatory') bool? mandatory,@JsonKey(name: 'visible') bool? visible,@JsonKey(name: 'default_value') String? defaultValue,@JsonKey(name: 'is_maala_kyc_data') bool? isFromMalaa,@JsonKey(name: 'allowed_special_characters') String? allowedSpecialCharacters,@JsonKey(name: 'regex_pattern') String? regexPattern,@JsonKey(name: 'special_character_checking_rqrd') bool? specialCharacterCheckingRqrd,@JsonKey(name: 'is_system_reserve') bool? isSystemReserve,@JsonKey(name: 'w_u_combo_order') int? wUComboOrder,@JsonKey(name: 'w_u_field_settings_i_d') int? wUFieldSettingsID,@JsonKey(name: 'dropdown_items') List<MemberFieldDropdownItem>? dropdownItems
});




}
/// @nodoc
class __$MemberFieldSettingCopyWithImpl<$Res>
    implements _$MemberFieldSettingCopyWith<$Res> {
  __$MemberFieldSettingCopyWithImpl(this._self, this._then);

  final _MemberFieldSetting _self;
  final $Res Function(_MemberFieldSetting) _then;

/// Create a copy of MemberFieldSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productCode = freezed,Object? displayOrder = freezed,Object? fieldName = freezed,Object? displayFieldName = freezed,Object? minimumLength = freezed,Object? maximumLength = freezed,Object? supportedDataType = freezed,Object? type = freezed,Object? isTypeSystemReserved = freezed,Object? enabled = freezed,Object? mandatory = freezed,Object? visible = freezed,Object? defaultValue = freezed,Object? isFromMalaa = freezed,Object? allowedSpecialCharacters = freezed,Object? regexPattern = freezed,Object? specialCharacterCheckingRqrd = freezed,Object? isSystemReserve = freezed,Object? wUComboOrder = freezed,Object? wUFieldSettingsID = freezed,Object? dropdownItems = freezed,}) {
  return _then(_MemberFieldSetting(
productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as int?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int?,fieldName: freezed == fieldName ? _self.fieldName : fieldName // ignore: cast_nullable_to_non_nullable
as String?,displayFieldName: freezed == displayFieldName ? _self.displayFieldName : displayFieldName // ignore: cast_nullable_to_non_nullable
as String?,minimumLength: freezed == minimumLength ? _self.minimumLength : minimumLength // ignore: cast_nullable_to_non_nullable
as int?,maximumLength: freezed == maximumLength ? _self.maximumLength : maximumLength // ignore: cast_nullable_to_non_nullable
as int?,supportedDataType: freezed == supportedDataType ? _self.supportedDataType : supportedDataType // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,isTypeSystemReserved: freezed == isTypeSystemReserved ? _self.isTypeSystemReserved : isTypeSystemReserved // ignore: cast_nullable_to_non_nullable
as bool?,enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,mandatory: freezed == mandatory ? _self.mandatory : mandatory // ignore: cast_nullable_to_non_nullable
as bool?,visible: freezed == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool?,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as String?,isFromMalaa: freezed == isFromMalaa ? _self.isFromMalaa : isFromMalaa // ignore: cast_nullable_to_non_nullable
as bool?,allowedSpecialCharacters: freezed == allowedSpecialCharacters ? _self.allowedSpecialCharacters : allowedSpecialCharacters // ignore: cast_nullable_to_non_nullable
as String?,regexPattern: freezed == regexPattern ? _self.regexPattern : regexPattern // ignore: cast_nullable_to_non_nullable
as String?,specialCharacterCheckingRqrd: freezed == specialCharacterCheckingRqrd ? _self.specialCharacterCheckingRqrd : specialCharacterCheckingRqrd // ignore: cast_nullable_to_non_nullable
as bool?,isSystemReserve: freezed == isSystemReserve ? _self.isSystemReserve : isSystemReserve // ignore: cast_nullable_to_non_nullable
as bool?,wUComboOrder: freezed == wUComboOrder ? _self.wUComboOrder : wUComboOrder // ignore: cast_nullable_to_non_nullable
as int?,wUFieldSettingsID: freezed == wUFieldSettingsID ? _self.wUFieldSettingsID : wUFieldSettingsID // ignore: cast_nullable_to_non_nullable
as int?,dropdownItems: freezed == dropdownItems ? _self._dropdownItems : dropdownItems // ignore: cast_nullable_to_non_nullable
as List<MemberFieldDropdownItem>?,
  ));
}


}


/// @nodoc
mixin _$MemberFieldDropdownItem {

@JsonKey(name: 'code') String? get code;@JsonKey(name: 'name') String? get name;@JsonKey(name: 'is_default') bool? get isDefault;@JsonKey(name: 'product_code') int? get productCode;
/// Create a copy of MemberFieldDropdownItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberFieldDropdownItemCopyWith<MemberFieldDropdownItem> get copyWith => _$MemberFieldDropdownItemCopyWithImpl<MemberFieldDropdownItem>(this as MemberFieldDropdownItem, _$identity);

  /// Serializes this MemberFieldDropdownItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberFieldDropdownItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.productCode, productCode) || other.productCode == productCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,isDefault,productCode);

@override
String toString() {
  return 'MemberFieldDropdownItem(code: $code, name: $name, isDefault: $isDefault, productCode: $productCode)';
}


}

/// @nodoc
abstract mixin class $MemberFieldDropdownItemCopyWith<$Res>  {
  factory $MemberFieldDropdownItemCopyWith(MemberFieldDropdownItem value, $Res Function(MemberFieldDropdownItem) _then) = _$MemberFieldDropdownItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'code') String? code,@JsonKey(name: 'name') String? name,@JsonKey(name: 'is_default') bool? isDefault,@JsonKey(name: 'product_code') int? productCode
});




}
/// @nodoc
class _$MemberFieldDropdownItemCopyWithImpl<$Res>
    implements $MemberFieldDropdownItemCopyWith<$Res> {
  _$MemberFieldDropdownItemCopyWithImpl(this._self, this._then);

  final MemberFieldDropdownItem _self;
  final $Res Function(MemberFieldDropdownItem) _then;

/// Create a copy of MemberFieldDropdownItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? name = freezed,Object? isDefault = freezed,Object? productCode = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberFieldDropdownItem].
extension MemberFieldDropdownItemPatterns on MemberFieldDropdownItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberFieldDropdownItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberFieldDropdownItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberFieldDropdownItem value)  $default,){
final _that = this;
switch (_that) {
case _MemberFieldDropdownItem():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberFieldDropdownItem value)?  $default,){
final _that = this;
switch (_that) {
case _MemberFieldDropdownItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'code')  String? code, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'is_default')  bool? isDefault, @JsonKey(name: 'product_code')  int? productCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberFieldDropdownItem() when $default != null:
return $default(_that.code,_that.name,_that.isDefault,_that.productCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'code')  String? code, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'is_default')  bool? isDefault, @JsonKey(name: 'product_code')  int? productCode)  $default,) {final _that = this;
switch (_that) {
case _MemberFieldDropdownItem():
return $default(_that.code,_that.name,_that.isDefault,_that.productCode);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'code')  String? code, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'is_default')  bool? isDefault, @JsonKey(name: 'product_code')  int? productCode)?  $default,) {final _that = this;
switch (_that) {
case _MemberFieldDropdownItem() when $default != null:
return $default(_that.code,_that.name,_that.isDefault,_that.productCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberFieldDropdownItem implements MemberFieldDropdownItem {
  const _MemberFieldDropdownItem({@JsonKey(name: 'code') this.code, @JsonKey(name: 'name') this.name, @JsonKey(name: 'is_default') this.isDefault, @JsonKey(name: 'product_code') this.productCode});
  factory _MemberFieldDropdownItem.fromJson(Map<String, dynamic> json) => _$MemberFieldDropdownItemFromJson(json);

@override@JsonKey(name: 'code') final  String? code;
@override@JsonKey(name: 'name') final  String? name;
@override@JsonKey(name: 'is_default') final  bool? isDefault;
@override@JsonKey(name: 'product_code') final  int? productCode;

/// Create a copy of MemberFieldDropdownItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberFieldDropdownItemCopyWith<_MemberFieldDropdownItem> get copyWith => __$MemberFieldDropdownItemCopyWithImpl<_MemberFieldDropdownItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberFieldDropdownItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberFieldDropdownItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.productCode, productCode) || other.productCode == productCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,isDefault,productCode);

@override
String toString() {
  return 'MemberFieldDropdownItem(code: $code, name: $name, isDefault: $isDefault, productCode: $productCode)';
}


}

/// @nodoc
abstract mixin class _$MemberFieldDropdownItemCopyWith<$Res> implements $MemberFieldDropdownItemCopyWith<$Res> {
  factory _$MemberFieldDropdownItemCopyWith(_MemberFieldDropdownItem value, $Res Function(_MemberFieldDropdownItem) _then) = __$MemberFieldDropdownItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'code') String? code,@JsonKey(name: 'name') String? name,@JsonKey(name: 'is_default') bool? isDefault,@JsonKey(name: 'product_code') int? productCode
});




}
/// @nodoc
class __$MemberFieldDropdownItemCopyWithImpl<$Res>
    implements _$MemberFieldDropdownItemCopyWith<$Res> {
  __$MemberFieldDropdownItemCopyWithImpl(this._self, this._then);

  final _MemberFieldDropdownItem _self;
  final $Res Function(_MemberFieldDropdownItem) _then;

/// Create a copy of MemberFieldDropdownItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? name = freezed,Object? isDefault = freezed,Object? productCode = freezed,}) {
  return _then(_MemberFieldDropdownItem(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
