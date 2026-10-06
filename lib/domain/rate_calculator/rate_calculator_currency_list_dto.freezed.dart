// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate_calculator_currency_list_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RateCalculatorCurrencyListDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "status_code") int? get statusCode;@JsonKey(name: "message") String? get message;@JsonKey(name: "data") RateCurrencyData? get data;@JsonKey(name: "time_stamp") DateTime? get timeStamp;@JsonKey(name: "version") String? get version;
/// Create a copy of RateCalculatorCurrencyListDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateCalculatorCurrencyListDtoCopyWith<RateCalculatorCurrencyListDto> get copyWith => _$RateCalculatorCurrencyListDtoCopyWithImpl<RateCalculatorCurrencyListDto>(this as RateCalculatorCurrencyListDto, _$identity);

  /// Serializes this RateCalculatorCurrencyListDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateCalculatorCurrencyListDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data,timeStamp,version);

@override
String toString() {
  return 'RateCalculatorCurrencyListDto(success: $success, statusCode: $statusCode, message: $message, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class $RateCalculatorCurrencyListDtoCopyWith<$Res>  {
  factory $RateCalculatorCurrencyListDtoCopyWith(RateCalculatorCurrencyListDto value, $Res Function(RateCalculatorCurrencyListDto) _then) = _$RateCalculatorCurrencyListDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") RateCurrencyData? data,@JsonKey(name: "time_stamp") DateTime? timeStamp,@JsonKey(name: "version") String? version
});


$RateCurrencyDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$RateCalculatorCurrencyListDtoCopyWithImpl<$Res>
    implements $RateCalculatorCurrencyListDtoCopyWith<$Res> {
  _$RateCalculatorCurrencyListDtoCopyWithImpl(this._self, this._then);

  final RateCalculatorCurrencyListDto _self;
  final $Res Function(RateCalculatorCurrencyListDto) _then;

/// Create a copy of RateCalculatorCurrencyListDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RateCurrencyData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of RateCalculatorCurrencyListDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateCurrencyDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RateCurrencyDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [RateCalculatorCurrencyListDto].
extension RateCalculatorCurrencyListDtoPatterns on RateCalculatorCurrencyListDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateCalculatorCurrencyListDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateCalculatorCurrencyListDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateCalculatorCurrencyListDto value)  $default,){
final _that = this;
switch (_that) {
case _RateCalculatorCurrencyListDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateCalculatorCurrencyListDto value)?  $default,){
final _that = this;
switch (_that) {
case _RateCalculatorCurrencyListDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  RateCurrencyData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateCalculatorCurrencyListDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  RateCurrencyData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)  $default,) {final _that = this;
switch (_that) {
case _RateCalculatorCurrencyListDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  RateCurrencyData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)?  $default,) {final _that = this;
switch (_that) {
case _RateCalculatorCurrencyListDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.message,_that.data,_that.timeStamp,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateCalculatorCurrencyListDto implements RateCalculatorCurrencyListDto {
  const _RateCalculatorCurrencyListDto({@JsonKey(name: "success") this.success, @JsonKey(name: "status_code") this.statusCode, @JsonKey(name: "message") this.message, @JsonKey(name: "data") this.data, @JsonKey(name: "time_stamp") this.timeStamp, @JsonKey(name: "version") this.version});
  factory _RateCalculatorCurrencyListDto.fromJson(Map<String, dynamic> json) => _$RateCalculatorCurrencyListDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "status_code") final  int? statusCode;
@override@JsonKey(name: "message") final  String? message;
@override@JsonKey(name: "data") final  RateCurrencyData? data;
@override@JsonKey(name: "time_stamp") final  DateTime? timeStamp;
@override@JsonKey(name: "version") final  String? version;

/// Create a copy of RateCalculatorCurrencyListDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateCalculatorCurrencyListDtoCopyWith<_RateCalculatorCurrencyListDto> get copyWith => __$RateCalculatorCurrencyListDtoCopyWithImpl<_RateCalculatorCurrencyListDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateCalculatorCurrencyListDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateCalculatorCurrencyListDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data,timeStamp,version);

@override
String toString() {
  return 'RateCalculatorCurrencyListDto(success: $success, statusCode: $statusCode, message: $message, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class _$RateCalculatorCurrencyListDtoCopyWith<$Res> implements $RateCalculatorCurrencyListDtoCopyWith<$Res> {
  factory _$RateCalculatorCurrencyListDtoCopyWith(_RateCalculatorCurrencyListDto value, $Res Function(_RateCalculatorCurrencyListDto) _then) = __$RateCalculatorCurrencyListDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") RateCurrencyData? data,@JsonKey(name: "time_stamp") DateTime? timeStamp,@JsonKey(name: "version") String? version
});


@override $RateCurrencyDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$RateCalculatorCurrencyListDtoCopyWithImpl<$Res>
    implements _$RateCalculatorCurrencyListDtoCopyWith<$Res> {
  __$RateCalculatorCurrencyListDtoCopyWithImpl(this._self, this._then);

  final _RateCalculatorCurrencyListDto _self;
  final $Res Function(_RateCalculatorCurrencyListDto) _then;

/// Create a copy of RateCalculatorCurrencyListDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_RateCalculatorCurrencyListDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RateCurrencyData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RateCalculatorCurrencyListDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateCurrencyDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RateCurrencyDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$RateCurrencyData {

@JsonKey(name: "currency_list") List<RateCurrencyItem>? get currencyList;
/// Create a copy of RateCurrencyData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateCurrencyDataCopyWith<RateCurrencyData> get copyWith => _$RateCurrencyDataCopyWithImpl<RateCurrencyData>(this as RateCurrencyData, _$identity);

  /// Serializes this RateCurrencyData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateCurrencyData&&const DeepCollectionEquality().equals(other.currencyList, currencyList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(currencyList));

@override
String toString() {
  return 'RateCurrencyData(currencyList: $currencyList)';
}


}

/// @nodoc
abstract mixin class $RateCurrencyDataCopyWith<$Res>  {
  factory $RateCurrencyDataCopyWith(RateCurrencyData value, $Res Function(RateCurrencyData) _then) = _$RateCurrencyDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "currency_list") List<RateCurrencyItem>? currencyList
});




}
/// @nodoc
class _$RateCurrencyDataCopyWithImpl<$Res>
    implements $RateCurrencyDataCopyWith<$Res> {
  _$RateCurrencyDataCopyWithImpl(this._self, this._then);

  final RateCurrencyData _self;
  final $Res Function(RateCurrencyData) _then;

/// Create a copy of RateCurrencyData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currencyList = freezed,}) {
  return _then(_self.copyWith(
currencyList: freezed == currencyList ? _self.currencyList : currencyList // ignore: cast_nullable_to_non_nullable
as List<RateCurrencyItem>?,
  ));
}

}


/// Adds pattern-matching-related methods to [RateCurrencyData].
extension RateCurrencyDataPatterns on RateCurrencyData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateCurrencyData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateCurrencyData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateCurrencyData value)  $default,){
final _that = this;
switch (_that) {
case _RateCurrencyData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateCurrencyData value)?  $default,){
final _that = this;
switch (_that) {
case _RateCurrencyData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "currency_list")  List<RateCurrencyItem>? currencyList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateCurrencyData() when $default != null:
return $default(_that.currencyList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "currency_list")  List<RateCurrencyItem>? currencyList)  $default,) {final _that = this;
switch (_that) {
case _RateCurrencyData():
return $default(_that.currencyList);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "currency_list")  List<RateCurrencyItem>? currencyList)?  $default,) {final _that = this;
switch (_that) {
case _RateCurrencyData() when $default != null:
return $default(_that.currencyList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateCurrencyData implements RateCurrencyData {
  const _RateCurrencyData({@JsonKey(name: "currency_list") final  List<RateCurrencyItem>? currencyList}): _currencyList = currencyList;
  factory _RateCurrencyData.fromJson(Map<String, dynamic> json) => _$RateCurrencyDataFromJson(json);

 final  List<RateCurrencyItem>? _currencyList;
@override@JsonKey(name: "currency_list") List<RateCurrencyItem>? get currencyList {
  final value = _currencyList;
  if (value == null) return null;
  if (_currencyList is EqualUnmodifiableListView) return _currencyList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of RateCurrencyData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateCurrencyDataCopyWith<_RateCurrencyData> get copyWith => __$RateCurrencyDataCopyWithImpl<_RateCurrencyData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateCurrencyDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateCurrencyData&&const DeepCollectionEquality().equals(other._currencyList, _currencyList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_currencyList));

@override
String toString() {
  return 'RateCurrencyData(currencyList: $currencyList)';
}


}

/// @nodoc
abstract mixin class _$RateCurrencyDataCopyWith<$Res> implements $RateCurrencyDataCopyWith<$Res> {
  factory _$RateCurrencyDataCopyWith(_RateCurrencyData value, $Res Function(_RateCurrencyData) _then) = __$RateCurrencyDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "currency_list") List<RateCurrencyItem>? currencyList
});




}
/// @nodoc
class __$RateCurrencyDataCopyWithImpl<$Res>
    implements _$RateCurrencyDataCopyWith<$Res> {
  __$RateCurrencyDataCopyWithImpl(this._self, this._then);

  final _RateCurrencyData _self;
  final $Res Function(_RateCurrencyData) _then;

/// Create a copy of RateCurrencyData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currencyList = freezed,}) {
  return _then(_RateCurrencyData(
currencyList: freezed == currencyList ? _self._currencyList : currencyList // ignore: cast_nullable_to_non_nullable
as List<RateCurrencyItem>?,
  ));
}


}


/// @nodoc
mixin _$RateCurrencyItem {

@JsonKey(name: "e_id") String? get eId;@JsonKey(name: "currency_code") String? get currencyCode;@JsonKey(name: "currency_name") String? get currencyName;@JsonKey(name: "country_code") String? get countryCode;@JsonKey(name: "country_name") String? get countryName;@JsonKey(name: "flag_url") String? get flagUrl;@JsonKey(name: "decimal_places") int? get decimalPlaces;
/// Create a copy of RateCurrencyItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateCurrencyItemCopyWith<RateCurrencyItem> get copyWith => _$RateCurrencyItemCopyWithImpl<RateCurrencyItem>(this as RateCurrencyItem, _$identity);

  /// Serializes this RateCurrencyItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateCurrencyItem&&(identical(other.eId, eId) || other.eId == eId)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencyName, currencyName) || other.currencyName == currencyName)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.flagUrl, flagUrl) || other.flagUrl == flagUrl)&&(identical(other.decimalPlaces, decimalPlaces) || other.decimalPlaces == decimalPlaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eId,currencyCode,currencyName,countryCode,countryName,flagUrl,decimalPlaces);

@override
String toString() {
  return 'RateCurrencyItem(eId: $eId, currencyCode: $currencyCode, currencyName: $currencyName, countryCode: $countryCode, countryName: $countryName, flagUrl: $flagUrl, decimalPlaces: $decimalPlaces)';
}


}

/// @nodoc
abstract mixin class $RateCurrencyItemCopyWith<$Res>  {
  factory $RateCurrencyItemCopyWith(RateCurrencyItem value, $Res Function(RateCurrencyItem) _then) = _$RateCurrencyItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "e_id") String? eId,@JsonKey(name: "currency_code") String? currencyCode,@JsonKey(name: "currency_name") String? currencyName,@JsonKey(name: "country_code") String? countryCode,@JsonKey(name: "country_name") String? countryName,@JsonKey(name: "flag_url") String? flagUrl,@JsonKey(name: "decimal_places") int? decimalPlaces
});




}
/// @nodoc
class _$RateCurrencyItemCopyWithImpl<$Res>
    implements $RateCurrencyItemCopyWith<$Res> {
  _$RateCurrencyItemCopyWithImpl(this._self, this._then);

  final RateCurrencyItem _self;
  final $Res Function(RateCurrencyItem) _then;

/// Create a copy of RateCurrencyItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eId = freezed,Object? currencyCode = freezed,Object? currencyName = freezed,Object? countryCode = freezed,Object? countryName = freezed,Object? flagUrl = freezed,Object? decimalPlaces = freezed,}) {
  return _then(_self.copyWith(
eId: freezed == eId ? _self.eId : eId // ignore: cast_nullable_to_non_nullable
as String?,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,currencyName: freezed == currencyName ? _self.currencyName : currencyName // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String?,flagUrl: freezed == flagUrl ? _self.flagUrl : flagUrl // ignore: cast_nullable_to_non_nullable
as String?,decimalPlaces: freezed == decimalPlaces ? _self.decimalPlaces : decimalPlaces // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RateCurrencyItem].
extension RateCurrencyItemPatterns on RateCurrencyItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateCurrencyItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateCurrencyItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateCurrencyItem value)  $default,){
final _that = this;
switch (_that) {
case _RateCurrencyItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateCurrencyItem value)?  $default,){
final _that = this;
switch (_that) {
case _RateCurrencyItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "e_id")  String? eId, @JsonKey(name: "currency_code")  String? currencyCode, @JsonKey(name: "currency_name")  String? currencyName, @JsonKey(name: "country_code")  String? countryCode, @JsonKey(name: "country_name")  String? countryName, @JsonKey(name: "flag_url")  String? flagUrl, @JsonKey(name: "decimal_places")  int? decimalPlaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateCurrencyItem() when $default != null:
return $default(_that.eId,_that.currencyCode,_that.currencyName,_that.countryCode,_that.countryName,_that.flagUrl,_that.decimalPlaces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "e_id")  String? eId, @JsonKey(name: "currency_code")  String? currencyCode, @JsonKey(name: "currency_name")  String? currencyName, @JsonKey(name: "country_code")  String? countryCode, @JsonKey(name: "country_name")  String? countryName, @JsonKey(name: "flag_url")  String? flagUrl, @JsonKey(name: "decimal_places")  int? decimalPlaces)  $default,) {final _that = this;
switch (_that) {
case _RateCurrencyItem():
return $default(_that.eId,_that.currencyCode,_that.currencyName,_that.countryCode,_that.countryName,_that.flagUrl,_that.decimalPlaces);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "e_id")  String? eId, @JsonKey(name: "currency_code")  String? currencyCode, @JsonKey(name: "currency_name")  String? currencyName, @JsonKey(name: "country_code")  String? countryCode, @JsonKey(name: "country_name")  String? countryName, @JsonKey(name: "flag_url")  String? flagUrl, @JsonKey(name: "decimal_places")  int? decimalPlaces)?  $default,) {final _that = this;
switch (_that) {
case _RateCurrencyItem() when $default != null:
return $default(_that.eId,_that.currencyCode,_that.currencyName,_that.countryCode,_that.countryName,_that.flagUrl,_that.decimalPlaces);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateCurrencyItem implements RateCurrencyItem {
  const _RateCurrencyItem({@JsonKey(name: "e_id") this.eId, @JsonKey(name: "currency_code") this.currencyCode, @JsonKey(name: "currency_name") this.currencyName, @JsonKey(name: "country_code") this.countryCode, @JsonKey(name: "country_name") this.countryName, @JsonKey(name: "flag_url") this.flagUrl, @JsonKey(name: "decimal_places") this.decimalPlaces});
  factory _RateCurrencyItem.fromJson(Map<String, dynamic> json) => _$RateCurrencyItemFromJson(json);

@override@JsonKey(name: "e_id") final  String? eId;
@override@JsonKey(name: "currency_code") final  String? currencyCode;
@override@JsonKey(name: "currency_name") final  String? currencyName;
@override@JsonKey(name: "country_code") final  String? countryCode;
@override@JsonKey(name: "country_name") final  String? countryName;
@override@JsonKey(name: "flag_url") final  String? flagUrl;
@override@JsonKey(name: "decimal_places") final  int? decimalPlaces;

/// Create a copy of RateCurrencyItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateCurrencyItemCopyWith<_RateCurrencyItem> get copyWith => __$RateCurrencyItemCopyWithImpl<_RateCurrencyItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateCurrencyItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateCurrencyItem&&(identical(other.eId, eId) || other.eId == eId)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencyName, currencyName) || other.currencyName == currencyName)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.flagUrl, flagUrl) || other.flagUrl == flagUrl)&&(identical(other.decimalPlaces, decimalPlaces) || other.decimalPlaces == decimalPlaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eId,currencyCode,currencyName,countryCode,countryName,flagUrl,decimalPlaces);

@override
String toString() {
  return 'RateCurrencyItem(eId: $eId, currencyCode: $currencyCode, currencyName: $currencyName, countryCode: $countryCode, countryName: $countryName, flagUrl: $flagUrl, decimalPlaces: $decimalPlaces)';
}


}

/// @nodoc
abstract mixin class _$RateCurrencyItemCopyWith<$Res> implements $RateCurrencyItemCopyWith<$Res> {
  factory _$RateCurrencyItemCopyWith(_RateCurrencyItem value, $Res Function(_RateCurrencyItem) _then) = __$RateCurrencyItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "e_id") String? eId,@JsonKey(name: "currency_code") String? currencyCode,@JsonKey(name: "currency_name") String? currencyName,@JsonKey(name: "country_code") String? countryCode,@JsonKey(name: "country_name") String? countryName,@JsonKey(name: "flag_url") String? flagUrl,@JsonKey(name: "decimal_places") int? decimalPlaces
});




}
/// @nodoc
class __$RateCurrencyItemCopyWithImpl<$Res>
    implements _$RateCurrencyItemCopyWith<$Res> {
  __$RateCurrencyItemCopyWithImpl(this._self, this._then);

  final _RateCurrencyItem _self;
  final $Res Function(_RateCurrencyItem) _then;

/// Create a copy of RateCurrencyItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eId = freezed,Object? currencyCode = freezed,Object? currencyName = freezed,Object? countryCode = freezed,Object? countryName = freezed,Object? flagUrl = freezed,Object? decimalPlaces = freezed,}) {
  return _then(_RateCurrencyItem(
eId: freezed == eId ? _self.eId : eId // ignore: cast_nullable_to_non_nullable
as String?,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,currencyName: freezed == currencyName ? _self.currencyName : currencyName // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String?,flagUrl: freezed == flagUrl ? _self.flagUrl : flagUrl // ignore: cast_nullable_to_non_nullable
as String?,decimalPlaces: freezed == decimalPlaces ? _self.decimalPlaces : decimalPlaces // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
