// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'beneficiary_country_list_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BeneficiaryCountryListDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "status_code") int? get statusCode;@JsonKey(name: "message") String? get message;@JsonKey(name: "data") BeneficiaryCountryListData? get data;@JsonKey(name: "time_stamp") DateTime? get timeStamp;@JsonKey(name: "version") String? get version;
/// Create a copy of BeneficiaryCountryListDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BeneficiaryCountryListDtoCopyWith<BeneficiaryCountryListDto> get copyWith => _$BeneficiaryCountryListDtoCopyWithImpl<BeneficiaryCountryListDto>(this as BeneficiaryCountryListDto, _$identity);

  /// Serializes this BeneficiaryCountryListDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BeneficiaryCountryListDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data,timeStamp,version);

@override
String toString() {
  return 'BeneficiaryCountryListDto(success: $success, statusCode: $statusCode, message: $message, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class $BeneficiaryCountryListDtoCopyWith<$Res>  {
  factory $BeneficiaryCountryListDtoCopyWith(BeneficiaryCountryListDto value, $Res Function(BeneficiaryCountryListDto) _then) = _$BeneficiaryCountryListDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") BeneficiaryCountryListData? data,@JsonKey(name: "time_stamp") DateTime? timeStamp,@JsonKey(name: "version") String? version
});


$BeneficiaryCountryListDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$BeneficiaryCountryListDtoCopyWithImpl<$Res>
    implements $BeneficiaryCountryListDtoCopyWith<$Res> {
  _$BeneficiaryCountryListDtoCopyWithImpl(this._self, this._then);

  final BeneficiaryCountryListDto _self;
  final $Res Function(BeneficiaryCountryListDto) _then;

/// Create a copy of BeneficiaryCountryListDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as BeneficiaryCountryListData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BeneficiaryCountryListDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BeneficiaryCountryListDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $BeneficiaryCountryListDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [BeneficiaryCountryListDto].
extension BeneficiaryCountryListDtoPatterns on BeneficiaryCountryListDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BeneficiaryCountryListDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BeneficiaryCountryListDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BeneficiaryCountryListDto value)  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryCountryListDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BeneficiaryCountryListDto value)?  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryCountryListDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  BeneficiaryCountryListData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BeneficiaryCountryListDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.message,_that.data,_that.timeStamp,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  BeneficiaryCountryListData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryCountryListDto():
return $default(_that.success,_that.statusCode,_that.message,_that.data,_that.timeStamp,_that.version);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  BeneficiaryCountryListData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)?  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryCountryListDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.message,_that.data,_that.timeStamp,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BeneficiaryCountryListDto implements BeneficiaryCountryListDto {
  const _BeneficiaryCountryListDto({@JsonKey(name: "success") this.success, @JsonKey(name: "status_code") this.statusCode, @JsonKey(name: "message") this.message, @JsonKey(name: "data") this.data, @JsonKey(name: "time_stamp") this.timeStamp, @JsonKey(name: "version") this.version});
  factory _BeneficiaryCountryListDto.fromJson(Map<String, dynamic> json) => _$BeneficiaryCountryListDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "status_code") final  int? statusCode;
@override@JsonKey(name: "message") final  String? message;
@override@JsonKey(name: "data") final  BeneficiaryCountryListData? data;
@override@JsonKey(name: "time_stamp") final  DateTime? timeStamp;
@override@JsonKey(name: "version") final  String? version;

/// Create a copy of BeneficiaryCountryListDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BeneficiaryCountryListDtoCopyWith<_BeneficiaryCountryListDto> get copyWith => __$BeneficiaryCountryListDtoCopyWithImpl<_BeneficiaryCountryListDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BeneficiaryCountryListDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BeneficiaryCountryListDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data,timeStamp,version);

@override
String toString() {
  return 'BeneficiaryCountryListDto(success: $success, statusCode: $statusCode, message: $message, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class _$BeneficiaryCountryListDtoCopyWith<$Res> implements $BeneficiaryCountryListDtoCopyWith<$Res> {
  factory _$BeneficiaryCountryListDtoCopyWith(_BeneficiaryCountryListDto value, $Res Function(_BeneficiaryCountryListDto) _then) = __$BeneficiaryCountryListDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") BeneficiaryCountryListData? data,@JsonKey(name: "time_stamp") DateTime? timeStamp,@JsonKey(name: "version") String? version
});


@override $BeneficiaryCountryListDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$BeneficiaryCountryListDtoCopyWithImpl<$Res>
    implements _$BeneficiaryCountryListDtoCopyWith<$Res> {
  __$BeneficiaryCountryListDtoCopyWithImpl(this._self, this._then);

  final _BeneficiaryCountryListDto _self;
  final $Res Function(_BeneficiaryCountryListDto) _then;

/// Create a copy of BeneficiaryCountryListDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_BeneficiaryCountryListDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as BeneficiaryCountryListData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BeneficiaryCountryListDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BeneficiaryCountryListDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $BeneficiaryCountryListDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$BeneficiaryCountryListData {

@JsonKey(name: "app_member_code") int? get appMemberCode;@JsonKey(name: "economic_activity_id") int? get economicActivityId;@JsonKey(name: "country_list") List<BeneficiaryCountryItem>? get countryList;
/// Create a copy of BeneficiaryCountryListData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BeneficiaryCountryListDataCopyWith<BeneficiaryCountryListData> get copyWith => _$BeneficiaryCountryListDataCopyWithImpl<BeneficiaryCountryListData>(this as BeneficiaryCountryListData, _$identity);

  /// Serializes this BeneficiaryCountryListData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BeneficiaryCountryListData&&(identical(other.appMemberCode, appMemberCode) || other.appMemberCode == appMemberCode)&&(identical(other.economicActivityId, economicActivityId) || other.economicActivityId == economicActivityId)&&const DeepCollectionEquality().equals(other.countryList, countryList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appMemberCode,economicActivityId,const DeepCollectionEquality().hash(countryList));

@override
String toString() {
  return 'BeneficiaryCountryListData(appMemberCode: $appMemberCode, economicActivityId: $economicActivityId, countryList: $countryList)';
}


}

/// @nodoc
abstract mixin class $BeneficiaryCountryListDataCopyWith<$Res>  {
  factory $BeneficiaryCountryListDataCopyWith(BeneficiaryCountryListData value, $Res Function(BeneficiaryCountryListData) _then) = _$BeneficiaryCountryListDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "app_member_code") int? appMemberCode,@JsonKey(name: "economic_activity_id") int? economicActivityId,@JsonKey(name: "country_list") List<BeneficiaryCountryItem>? countryList
});




}
/// @nodoc
class _$BeneficiaryCountryListDataCopyWithImpl<$Res>
    implements $BeneficiaryCountryListDataCopyWith<$Res> {
  _$BeneficiaryCountryListDataCopyWithImpl(this._self, this._then);

  final BeneficiaryCountryListData _self;
  final $Res Function(BeneficiaryCountryListData) _then;

/// Create a copy of BeneficiaryCountryListData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appMemberCode = freezed,Object? economicActivityId = freezed,Object? countryList = freezed,}) {
  return _then(_self.copyWith(
appMemberCode: freezed == appMemberCode ? _self.appMemberCode : appMemberCode // ignore: cast_nullable_to_non_nullable
as int?,economicActivityId: freezed == economicActivityId ? _self.economicActivityId : economicActivityId // ignore: cast_nullable_to_non_nullable
as int?,countryList: freezed == countryList ? _self.countryList : countryList // ignore: cast_nullable_to_non_nullable
as List<BeneficiaryCountryItem>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BeneficiaryCountryListData].
extension BeneficiaryCountryListDataPatterns on BeneficiaryCountryListData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BeneficiaryCountryListData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BeneficiaryCountryListData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BeneficiaryCountryListData value)  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryCountryListData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BeneficiaryCountryListData value)?  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryCountryListData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "app_member_code")  int? appMemberCode, @JsonKey(name: "economic_activity_id")  int? economicActivityId, @JsonKey(name: "country_list")  List<BeneficiaryCountryItem>? countryList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BeneficiaryCountryListData() when $default != null:
return $default(_that.appMemberCode,_that.economicActivityId,_that.countryList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "app_member_code")  int? appMemberCode, @JsonKey(name: "economic_activity_id")  int? economicActivityId, @JsonKey(name: "country_list")  List<BeneficiaryCountryItem>? countryList)  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryCountryListData():
return $default(_that.appMemberCode,_that.economicActivityId,_that.countryList);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "app_member_code")  int? appMemberCode, @JsonKey(name: "economic_activity_id")  int? economicActivityId, @JsonKey(name: "country_list")  List<BeneficiaryCountryItem>? countryList)?  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryCountryListData() when $default != null:
return $default(_that.appMemberCode,_that.economicActivityId,_that.countryList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BeneficiaryCountryListData implements BeneficiaryCountryListData {
  const _BeneficiaryCountryListData({@JsonKey(name: "app_member_code") this.appMemberCode, @JsonKey(name: "economic_activity_id") this.economicActivityId, @JsonKey(name: "country_list") final  List<BeneficiaryCountryItem>? countryList}): _countryList = countryList;
  factory _BeneficiaryCountryListData.fromJson(Map<String, dynamic> json) => _$BeneficiaryCountryListDataFromJson(json);

@override@JsonKey(name: "app_member_code") final  int? appMemberCode;
@override@JsonKey(name: "economic_activity_id") final  int? economicActivityId;
 final  List<BeneficiaryCountryItem>? _countryList;
@override@JsonKey(name: "country_list") List<BeneficiaryCountryItem>? get countryList {
  final value = _countryList;
  if (value == null) return null;
  if (_countryList is EqualUnmodifiableListView) return _countryList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of BeneficiaryCountryListData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BeneficiaryCountryListDataCopyWith<_BeneficiaryCountryListData> get copyWith => __$BeneficiaryCountryListDataCopyWithImpl<_BeneficiaryCountryListData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BeneficiaryCountryListDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BeneficiaryCountryListData&&(identical(other.appMemberCode, appMemberCode) || other.appMemberCode == appMemberCode)&&(identical(other.economicActivityId, economicActivityId) || other.economicActivityId == economicActivityId)&&const DeepCollectionEquality().equals(other._countryList, _countryList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appMemberCode,economicActivityId,const DeepCollectionEquality().hash(_countryList));

@override
String toString() {
  return 'BeneficiaryCountryListData(appMemberCode: $appMemberCode, economicActivityId: $economicActivityId, countryList: $countryList)';
}


}

/// @nodoc
abstract mixin class _$BeneficiaryCountryListDataCopyWith<$Res> implements $BeneficiaryCountryListDataCopyWith<$Res> {
  factory _$BeneficiaryCountryListDataCopyWith(_BeneficiaryCountryListData value, $Res Function(_BeneficiaryCountryListData) _then) = __$BeneficiaryCountryListDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "app_member_code") int? appMemberCode,@JsonKey(name: "economic_activity_id") int? economicActivityId,@JsonKey(name: "country_list") List<BeneficiaryCountryItem>? countryList
});




}
/// @nodoc
class __$BeneficiaryCountryListDataCopyWithImpl<$Res>
    implements _$BeneficiaryCountryListDataCopyWith<$Res> {
  __$BeneficiaryCountryListDataCopyWithImpl(this._self, this._then);

  final _BeneficiaryCountryListData _self;
  final $Res Function(_BeneficiaryCountryListData) _then;

/// Create a copy of BeneficiaryCountryListData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appMemberCode = freezed,Object? economicActivityId = freezed,Object? countryList = freezed,}) {
  return _then(_BeneficiaryCountryListData(
appMemberCode: freezed == appMemberCode ? _self.appMemberCode : appMemberCode // ignore: cast_nullable_to_non_nullable
as int?,economicActivityId: freezed == economicActivityId ? _self.economicActivityId : economicActivityId // ignore: cast_nullable_to_non_nullable
as int?,countryList: freezed == countryList ? _self._countryList : countryList // ignore: cast_nullable_to_non_nullable
as List<BeneficiaryCountryItem>?,
  ));
}


}


/// @nodoc
mixin _$BeneficiaryCountryItem {

@JsonKey(name: "code") String? get code;@JsonKey(name: "name") String? get name;@JsonKey(name: "decimal_place") int? get decimalPlace;@JsonKey(name: "combo_name") String? get comboName;
/// Create a copy of BeneficiaryCountryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BeneficiaryCountryItemCopyWith<BeneficiaryCountryItem> get copyWith => _$BeneficiaryCountryItemCopyWithImpl<BeneficiaryCountryItem>(this as BeneficiaryCountryItem, _$identity);

  /// Serializes this BeneficiaryCountryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BeneficiaryCountryItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.decimalPlace, decimalPlace) || other.decimalPlace == decimalPlace)&&(identical(other.comboName, comboName) || other.comboName == comboName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,decimalPlace,comboName);

@override
String toString() {
  return 'BeneficiaryCountryItem(code: $code, name: $name, decimalPlace: $decimalPlace, comboName: $comboName)';
}


}

/// @nodoc
abstract mixin class $BeneficiaryCountryItemCopyWith<$Res>  {
  factory $BeneficiaryCountryItemCopyWith(BeneficiaryCountryItem value, $Res Function(BeneficiaryCountryItem) _then) = _$BeneficiaryCountryItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "code") String? code,@JsonKey(name: "name") String? name,@JsonKey(name: "decimal_place") int? decimalPlace,@JsonKey(name: "combo_name") String? comboName
});




}
/// @nodoc
class _$BeneficiaryCountryItemCopyWithImpl<$Res>
    implements $BeneficiaryCountryItemCopyWith<$Res> {
  _$BeneficiaryCountryItemCopyWithImpl(this._self, this._then);

  final BeneficiaryCountryItem _self;
  final $Res Function(BeneficiaryCountryItem) _then;

/// Create a copy of BeneficiaryCountryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? name = freezed,Object? decimalPlace = freezed,Object? comboName = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,decimalPlace: freezed == decimalPlace ? _self.decimalPlace : decimalPlace // ignore: cast_nullable_to_non_nullable
as int?,comboName: freezed == comboName ? _self.comboName : comboName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BeneficiaryCountryItem].
extension BeneficiaryCountryItemPatterns on BeneficiaryCountryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BeneficiaryCountryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BeneficiaryCountryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BeneficiaryCountryItem value)  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryCountryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BeneficiaryCountryItem value)?  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryCountryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  String? code, @JsonKey(name: "name")  String? name, @JsonKey(name: "decimal_place")  int? decimalPlace, @JsonKey(name: "combo_name")  String? comboName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BeneficiaryCountryItem() when $default != null:
return $default(_that.code,_that.name,_that.decimalPlace,_that.comboName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  String? code, @JsonKey(name: "name")  String? name, @JsonKey(name: "decimal_place")  int? decimalPlace, @JsonKey(name: "combo_name")  String? comboName)  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryCountryItem():
return $default(_that.code,_that.name,_that.decimalPlace,_that.comboName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "code")  String? code, @JsonKey(name: "name")  String? name, @JsonKey(name: "decimal_place")  int? decimalPlace, @JsonKey(name: "combo_name")  String? comboName)?  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryCountryItem() when $default != null:
return $default(_that.code,_that.name,_that.decimalPlace,_that.comboName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BeneficiaryCountryItem implements BeneficiaryCountryItem {
  const _BeneficiaryCountryItem({@JsonKey(name: "code") this.code, @JsonKey(name: "name") this.name, @JsonKey(name: "decimal_place") this.decimalPlace, @JsonKey(name: "combo_name") this.comboName});
  factory _BeneficiaryCountryItem.fromJson(Map<String, dynamic> json) => _$BeneficiaryCountryItemFromJson(json);

@override@JsonKey(name: "code") final  String? code;
@override@JsonKey(name: "name") final  String? name;
@override@JsonKey(name: "decimal_place") final  int? decimalPlace;
@override@JsonKey(name: "combo_name") final  String? comboName;

/// Create a copy of BeneficiaryCountryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BeneficiaryCountryItemCopyWith<_BeneficiaryCountryItem> get copyWith => __$BeneficiaryCountryItemCopyWithImpl<_BeneficiaryCountryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BeneficiaryCountryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BeneficiaryCountryItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.decimalPlace, decimalPlace) || other.decimalPlace == decimalPlace)&&(identical(other.comboName, comboName) || other.comboName == comboName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,decimalPlace,comboName);

@override
String toString() {
  return 'BeneficiaryCountryItem(code: $code, name: $name, decimalPlace: $decimalPlace, comboName: $comboName)';
}


}

/// @nodoc
abstract mixin class _$BeneficiaryCountryItemCopyWith<$Res> implements $BeneficiaryCountryItemCopyWith<$Res> {
  factory _$BeneficiaryCountryItemCopyWith(_BeneficiaryCountryItem value, $Res Function(_BeneficiaryCountryItem) _then) = __$BeneficiaryCountryItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "code") String? code,@JsonKey(name: "name") String? name,@JsonKey(name: "decimal_place") int? decimalPlace,@JsonKey(name: "combo_name") String? comboName
});




}
/// @nodoc
class __$BeneficiaryCountryItemCopyWithImpl<$Res>
    implements _$BeneficiaryCountryItemCopyWith<$Res> {
  __$BeneficiaryCountryItemCopyWithImpl(this._self, this._then);

  final _BeneficiaryCountryItem _self;
  final $Res Function(_BeneficiaryCountryItem) _then;

/// Create a copy of BeneficiaryCountryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? name = freezed,Object? decimalPlace = freezed,Object? comboName = freezed,}) {
  return _then(_BeneficiaryCountryItem(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,decimalPlace: freezed == decimalPlace ? _self.decimalPlace : decimalPlace // ignore: cast_nullable_to_non_nullable
as int?,comboName: freezed == comboName ? _self.comboName : comboName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
