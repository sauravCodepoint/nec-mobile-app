// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_profile_city_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompleteProfileCityDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "data") Data? get data;
/// Create a copy of CompleteProfileCityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteProfileCityDtoCopyWith<CompleteProfileCityDto> get copyWith => _$CompleteProfileCityDtoCopyWithImpl<CompleteProfileCityDto>(this as CompleteProfileCityDto, _$identity);

  /// Serializes this CompleteProfileCityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteProfileCityDto&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data);

@override
String toString() {
  return 'CompleteProfileCityDto(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class $CompleteProfileCityDtoCopyWith<$Res>  {
  factory $CompleteProfileCityDtoCopyWith(CompleteProfileCityDto value, $Res Function(CompleteProfileCityDto) _then) = _$CompleteProfileCityDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "data") Data? data
});


$DataCopyWith<$Res>? get data;

}
/// @nodoc
class _$CompleteProfileCityDtoCopyWithImpl<$Res>
    implements $CompleteProfileCityDtoCopyWith<$Res> {
  _$CompleteProfileCityDtoCopyWithImpl(this._self, this._then);

  final CompleteProfileCityDto _self;
  final $Res Function(CompleteProfileCityDto) _then;

/// Create a copy of CompleteProfileCityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data?,
  ));
}
/// Create a copy of CompleteProfileCityDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompleteProfileCityDto].
extension CompleteProfileCityDtoPatterns on CompleteProfileCityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompleteProfileCityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteProfileCityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompleteProfileCityDto value)  $default,){
final _that = this;
switch (_that) {
case _CompleteProfileCityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompleteProfileCityDto value)?  $default,){
final _that = this;
switch (_that) {
case _CompleteProfileCityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "data")  Data? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteProfileCityDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "data")  Data? data)  $default,) {final _that = this;
switch (_that) {
case _CompleteProfileCityDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "data")  Data? data)?  $default,) {final _that = this;
switch (_that) {
case _CompleteProfileCityDto() when $default != null:
return $default(_that.success,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompleteProfileCityDto implements CompleteProfileCityDto {
  const _CompleteProfileCityDto({@JsonKey(name: "success") this.success, @JsonKey(name: "data") this.data});
  factory _CompleteProfileCityDto.fromJson(Map<String, dynamic> json) => _$CompleteProfileCityDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "data") final  Data? data;

/// Create a copy of CompleteProfileCityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteProfileCityDtoCopyWith<_CompleteProfileCityDto> get copyWith => __$CompleteProfileCityDtoCopyWithImpl<_CompleteProfileCityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompleteProfileCityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteProfileCityDto&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data);

@override
String toString() {
  return 'CompleteProfileCityDto(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CompleteProfileCityDtoCopyWith<$Res> implements $CompleteProfileCityDtoCopyWith<$Res> {
  factory _$CompleteProfileCityDtoCopyWith(_CompleteProfileCityDto value, $Res Function(_CompleteProfileCityDto) _then) = __$CompleteProfileCityDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "data") Data? data
});


@override $DataCopyWith<$Res>? get data;

}
/// @nodoc
class __$CompleteProfileCityDtoCopyWithImpl<$Res>
    implements _$CompleteProfileCityDtoCopyWith<$Res> {
  __$CompleteProfileCityDtoCopyWithImpl(this._self, this._then);

  final _CompleteProfileCityDto _self;
  final $Res Function(_CompleteProfileCityDto) _then;

/// Create a copy of CompleteProfileCityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? data = freezed,}) {
  return _then(_CompleteProfileCityDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data?,
  ));
}

/// Create a copy of CompleteProfileCityDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$Data {

@JsonKey(name: "city_list") List<CityList>? get cityList;@JsonKey(name: "app_member_code") int? get appMemberCode;@JsonKey(name: "economic_activity_id") int? get economicActivityId;
/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataCopyWith<Data> get copyWith => _$DataCopyWithImpl<Data>(this as Data, _$identity);

  /// Serializes this Data to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Data&&const DeepCollectionEquality().equals(other.cityList, cityList)&&(identical(other.appMemberCode, appMemberCode) || other.appMemberCode == appMemberCode)&&(identical(other.economicActivityId, economicActivityId) || other.economicActivityId == economicActivityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cityList),appMemberCode,economicActivityId);

@override
String toString() {
  return 'Data(cityList: $cityList, appMemberCode: $appMemberCode, economicActivityId: $economicActivityId)';
}


}

/// @nodoc
abstract mixin class $DataCopyWith<$Res>  {
  factory $DataCopyWith(Data value, $Res Function(Data) _then) = _$DataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "city_list") List<CityList>? cityList,@JsonKey(name: "app_member_code") int? appMemberCode,@JsonKey(name: "economic_activity_id") int? economicActivityId
});




}
/// @nodoc
class _$DataCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._self, this._then);

  final Data _self;
  final $Res Function(Data) _then;

/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cityList = freezed,Object? appMemberCode = freezed,Object? economicActivityId = freezed,}) {
  return _then(_self.copyWith(
cityList: freezed == cityList ? _self.cityList : cityList // ignore: cast_nullable_to_non_nullable
as List<CityList>?,appMemberCode: freezed == appMemberCode ? _self.appMemberCode : appMemberCode // ignore: cast_nullable_to_non_nullable
as int?,economicActivityId: freezed == economicActivityId ? _self.economicActivityId : economicActivityId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Data].
extension DataPatterns on Data {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Data value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Data() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Data value)  $default,){
final _that = this;
switch (_that) {
case _Data():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Data value)?  $default,){
final _that = this;
switch (_that) {
case _Data() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "city_list")  List<CityList>? cityList, @JsonKey(name: "app_member_code")  int? appMemberCode, @JsonKey(name: "economic_activity_id")  int? economicActivityId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.cityList,_that.appMemberCode,_that.economicActivityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "city_list")  List<CityList>? cityList, @JsonKey(name: "app_member_code")  int? appMemberCode, @JsonKey(name: "economic_activity_id")  int? economicActivityId)  $default,) {final _that = this;
switch (_that) {
case _Data():
return $default(_that.cityList,_that.appMemberCode,_that.economicActivityId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "city_list")  List<CityList>? cityList, @JsonKey(name: "app_member_code")  int? appMemberCode, @JsonKey(name: "economic_activity_id")  int? economicActivityId)?  $default,) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.cityList,_that.appMemberCode,_that.economicActivityId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Data implements Data {
  const _Data({@JsonKey(name: "city_list") final  List<CityList>? cityList, @JsonKey(name: "app_member_code") this.appMemberCode, @JsonKey(name: "economic_activity_id") this.economicActivityId}): _cityList = cityList;
  factory _Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

 final  List<CityList>? _cityList;
@override@JsonKey(name: "city_list") List<CityList>? get cityList {
  final value = _cityList;
  if (value == null) return null;
  if (_cityList is EqualUnmodifiableListView) return _cityList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "app_member_code") final  int? appMemberCode;
@override@JsonKey(name: "economic_activity_id") final  int? economicActivityId;

/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataCopyWith<_Data> get copyWith => __$DataCopyWithImpl<_Data>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data&&const DeepCollectionEquality().equals(other._cityList, _cityList)&&(identical(other.appMemberCode, appMemberCode) || other.appMemberCode == appMemberCode)&&(identical(other.economicActivityId, economicActivityId) || other.economicActivityId == economicActivityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cityList),appMemberCode,economicActivityId);

@override
String toString() {
  return 'Data(cityList: $cityList, appMemberCode: $appMemberCode, economicActivityId: $economicActivityId)';
}


}

/// @nodoc
abstract mixin class _$DataCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) _then) = __$DataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "city_list") List<CityList>? cityList,@JsonKey(name: "app_member_code") int? appMemberCode,@JsonKey(name: "economic_activity_id") int? economicActivityId
});




}
/// @nodoc
class __$DataCopyWithImpl<$Res>
    implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(this._self, this._then);

  final _Data _self;
  final $Res Function(_Data) _then;

/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cityList = freezed,Object? appMemberCode = freezed,Object? economicActivityId = freezed,}) {
  return _then(_Data(
cityList: freezed == cityList ? _self._cityList : cityList // ignore: cast_nullable_to_non_nullable
as List<CityList>?,appMemberCode: freezed == appMemberCode ? _self.appMemberCode : appMemberCode // ignore: cast_nullable_to_non_nullable
as int?,economicActivityId: freezed == economicActivityId ? _self.economicActivityId : economicActivityId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CityList {

@JsonKey(name: "code") String? get code;@JsonKey(name: "name") String? get name;@JsonKey(name: "is_default") bool? get isDefault;@JsonKey(name: "product_code") int? get productCode;
/// Create a copy of CityList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityListCopyWith<CityList> get copyWith => _$CityListCopyWithImpl<CityList>(this as CityList, _$identity);

  /// Serializes this CityList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityList&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.productCode, productCode) || other.productCode == productCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,isDefault,productCode);

@override
String toString() {
  return 'CityList(code: $code, name: $name, isDefault: $isDefault, productCode: $productCode)';
}


}

/// @nodoc
abstract mixin class $CityListCopyWith<$Res>  {
  factory $CityListCopyWith(CityList value, $Res Function(CityList) _then) = _$CityListCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "code") String? code,@JsonKey(name: "name") String? name,@JsonKey(name: "is_default") bool? isDefault,@JsonKey(name: "product_code") int? productCode
});




}
/// @nodoc
class _$CityListCopyWithImpl<$Res>
    implements $CityListCopyWith<$Res> {
  _$CityListCopyWithImpl(this._self, this._then);

  final CityList _self;
  final $Res Function(CityList) _then;

/// Create a copy of CityList
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


/// Adds pattern-matching-related methods to [CityList].
extension CityListPatterns on CityList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityList value)  $default,){
final _that = this;
switch (_that) {
case _CityList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityList value)?  $default,){
final _that = this;
switch (_that) {
case _CityList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  String? code, @JsonKey(name: "name")  String? name, @JsonKey(name: "is_default")  bool? isDefault, @JsonKey(name: "product_code")  int? productCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityList() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  String? code, @JsonKey(name: "name")  String? name, @JsonKey(name: "is_default")  bool? isDefault, @JsonKey(name: "product_code")  int? productCode)  $default,) {final _that = this;
switch (_that) {
case _CityList():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "code")  String? code, @JsonKey(name: "name")  String? name, @JsonKey(name: "is_default")  bool? isDefault, @JsonKey(name: "product_code")  int? productCode)?  $default,) {final _that = this;
switch (_that) {
case _CityList() when $default != null:
return $default(_that.code,_that.name,_that.isDefault,_that.productCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityList implements CityList {
  const _CityList({@JsonKey(name: "code") this.code, @JsonKey(name: "name") this.name, @JsonKey(name: "is_default") this.isDefault, @JsonKey(name: "product_code") this.productCode});
  factory _CityList.fromJson(Map<String, dynamic> json) => _$CityListFromJson(json);

@override@JsonKey(name: "code") final  String? code;
@override@JsonKey(name: "name") final  String? name;
@override@JsonKey(name: "is_default") final  bool? isDefault;
@override@JsonKey(name: "product_code") final  int? productCode;

/// Create a copy of CityList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityListCopyWith<_CityList> get copyWith => __$CityListCopyWithImpl<_CityList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityList&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.productCode, productCode) || other.productCode == productCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,isDefault,productCode);

@override
String toString() {
  return 'CityList(code: $code, name: $name, isDefault: $isDefault, productCode: $productCode)';
}


}

/// @nodoc
abstract mixin class _$CityListCopyWith<$Res> implements $CityListCopyWith<$Res> {
  factory _$CityListCopyWith(_CityList value, $Res Function(_CityList) _then) = __$CityListCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "code") String? code,@JsonKey(name: "name") String? name,@JsonKey(name: "is_default") bool? isDefault,@JsonKey(name: "product_code") int? productCode
});




}
/// @nodoc
class __$CityListCopyWithImpl<$Res>
    implements _$CityListCopyWith<$Res> {
  __$CityListCopyWithImpl(this._self, this._then);

  final _CityList _self;
  final $Res Function(_CityList) _then;

/// Create a copy of CityList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? name = freezed,Object? isDefault = freezed,Object? productCode = freezed,}) {
  return _then(_CityList(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
