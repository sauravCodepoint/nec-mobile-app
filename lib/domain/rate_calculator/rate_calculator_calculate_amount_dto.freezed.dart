// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate_calculator_calculate_amount_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RateCalculatorCalculateAmountDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "status_code") int? get statusCode;@JsonKey(name: "message") String? get message;@JsonKey(name: "data") RateCalcData? get data;@JsonKey(name: "time_stamp") DateTime? get timeStamp;@JsonKey(name: "version") String? get version;
/// Create a copy of RateCalculatorCalculateAmountDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateCalculatorCalculateAmountDtoCopyWith<RateCalculatorCalculateAmountDto> get copyWith => _$RateCalculatorCalculateAmountDtoCopyWithImpl<RateCalculatorCalculateAmountDto>(this as RateCalculatorCalculateAmountDto, _$identity);

  /// Serializes this RateCalculatorCalculateAmountDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateCalculatorCalculateAmountDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data,timeStamp,version);

@override
String toString() {
  return 'RateCalculatorCalculateAmountDto(success: $success, statusCode: $statusCode, message: $message, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class $RateCalculatorCalculateAmountDtoCopyWith<$Res>  {
  factory $RateCalculatorCalculateAmountDtoCopyWith(RateCalculatorCalculateAmountDto value, $Res Function(RateCalculatorCalculateAmountDto) _then) = _$RateCalculatorCalculateAmountDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") RateCalcData? data,@JsonKey(name: "time_stamp") DateTime? timeStamp,@JsonKey(name: "version") String? version
});


$RateCalcDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$RateCalculatorCalculateAmountDtoCopyWithImpl<$Res>
    implements $RateCalculatorCalculateAmountDtoCopyWith<$Res> {
  _$RateCalculatorCalculateAmountDtoCopyWithImpl(this._self, this._then);

  final RateCalculatorCalculateAmountDto _self;
  final $Res Function(RateCalculatorCalculateAmountDto) _then;

/// Create a copy of RateCalculatorCalculateAmountDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RateCalcData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of RateCalculatorCalculateAmountDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateCalcDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RateCalcDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [RateCalculatorCalculateAmountDto].
extension RateCalculatorCalculateAmountDtoPatterns on RateCalculatorCalculateAmountDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateCalculatorCalculateAmountDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateCalculatorCalculateAmountDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateCalculatorCalculateAmountDto value)  $default,){
final _that = this;
switch (_that) {
case _RateCalculatorCalculateAmountDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateCalculatorCalculateAmountDto value)?  $default,){
final _that = this;
switch (_that) {
case _RateCalculatorCalculateAmountDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  RateCalcData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateCalculatorCalculateAmountDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  RateCalcData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)  $default,) {final _that = this;
switch (_that) {
case _RateCalculatorCalculateAmountDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  RateCalcData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)?  $default,) {final _that = this;
switch (_that) {
case _RateCalculatorCalculateAmountDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.message,_that.data,_that.timeStamp,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateCalculatorCalculateAmountDto implements RateCalculatorCalculateAmountDto {
  const _RateCalculatorCalculateAmountDto({@JsonKey(name: "success") this.success, @JsonKey(name: "status_code") this.statusCode, @JsonKey(name: "message") this.message, @JsonKey(name: "data") this.data, @JsonKey(name: "time_stamp") this.timeStamp, @JsonKey(name: "version") this.version});
  factory _RateCalculatorCalculateAmountDto.fromJson(Map<String, dynamic> json) => _$RateCalculatorCalculateAmountDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "status_code") final  int? statusCode;
@override@JsonKey(name: "message") final  String? message;
@override@JsonKey(name: "data") final  RateCalcData? data;
@override@JsonKey(name: "time_stamp") final  DateTime? timeStamp;
@override@JsonKey(name: "version") final  String? version;

/// Create a copy of RateCalculatorCalculateAmountDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateCalculatorCalculateAmountDtoCopyWith<_RateCalculatorCalculateAmountDto> get copyWith => __$RateCalculatorCalculateAmountDtoCopyWithImpl<_RateCalculatorCalculateAmountDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateCalculatorCalculateAmountDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateCalculatorCalculateAmountDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data,timeStamp,version);

@override
String toString() {
  return 'RateCalculatorCalculateAmountDto(success: $success, statusCode: $statusCode, message: $message, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class _$RateCalculatorCalculateAmountDtoCopyWith<$Res> implements $RateCalculatorCalculateAmountDtoCopyWith<$Res> {
  factory _$RateCalculatorCalculateAmountDtoCopyWith(_RateCalculatorCalculateAmountDto value, $Res Function(_RateCalculatorCalculateAmountDto) _then) = __$RateCalculatorCalculateAmountDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") RateCalcData? data,@JsonKey(name: "time_stamp") DateTime? timeStamp,@JsonKey(name: "version") String? version
});


@override $RateCalcDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$RateCalculatorCalculateAmountDtoCopyWithImpl<$Res>
    implements _$RateCalculatorCalculateAmountDtoCopyWith<$Res> {
  __$RateCalculatorCalculateAmountDtoCopyWithImpl(this._self, this._then);

  final _RateCalculatorCalculateAmountDto _self;
  final $Res Function(_RateCalculatorCalculateAmountDto) _then;

/// Create a copy of RateCalculatorCalculateAmountDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_RateCalculatorCalculateAmountDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RateCalcData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RateCalculatorCalculateAmountDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateCalcDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RateCalcDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$RateCalcData {

@JsonKey(name: "amount") RateCalcAmount? get amount;
/// Create a copy of RateCalcData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateCalcDataCopyWith<RateCalcData> get copyWith => _$RateCalcDataCopyWithImpl<RateCalcData>(this as RateCalcData, _$identity);

  /// Serializes this RateCalcData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateCalcData&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'RateCalcData(amount: $amount)';
}


}

/// @nodoc
abstract mixin class $RateCalcDataCopyWith<$Res>  {
  factory $RateCalcDataCopyWith(RateCalcData value, $Res Function(RateCalcData) _then) = _$RateCalcDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "amount") RateCalcAmount? amount
});


$RateCalcAmountCopyWith<$Res>? get amount;

}
/// @nodoc
class _$RateCalcDataCopyWithImpl<$Res>
    implements $RateCalcDataCopyWith<$Res> {
  _$RateCalcDataCopyWithImpl(this._self, this._then);

  final RateCalcData _self;
  final $Res Function(RateCalcData) _then;

/// Create a copy of RateCalcData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = freezed,}) {
  return _then(_self.copyWith(
amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as RateCalcAmount?,
  ));
}
/// Create a copy of RateCalcData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateCalcAmountCopyWith<$Res>? get amount {
    if (_self.amount == null) {
    return null;
  }

  return $RateCalcAmountCopyWith<$Res>(_self.amount!, (value) {
    return _then(_self.copyWith(amount: value));
  });
}
}


/// Adds pattern-matching-related methods to [RateCalcData].
extension RateCalcDataPatterns on RateCalcData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateCalcData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateCalcData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateCalcData value)  $default,){
final _that = this;
switch (_that) {
case _RateCalcData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateCalcData value)?  $default,){
final _that = this;
switch (_that) {
case _RateCalcData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "amount")  RateCalcAmount? amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateCalcData() when $default != null:
return $default(_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "amount")  RateCalcAmount? amount)  $default,) {final _that = this;
switch (_that) {
case _RateCalcData():
return $default(_that.amount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "amount")  RateCalcAmount? amount)?  $default,) {final _that = this;
switch (_that) {
case _RateCalcData() when $default != null:
return $default(_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateCalcData implements RateCalcData {
  const _RateCalcData({@JsonKey(name: "amount") this.amount});
  factory _RateCalcData.fromJson(Map<String, dynamic> json) => _$RateCalcDataFromJson(json);

@override@JsonKey(name: "amount") final  RateCalcAmount? amount;

/// Create a copy of RateCalcData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateCalcDataCopyWith<_RateCalcData> get copyWith => __$RateCalcDataCopyWithImpl<_RateCalcData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateCalcDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateCalcData&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'RateCalcData(amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$RateCalcDataCopyWith<$Res> implements $RateCalcDataCopyWith<$Res> {
  factory _$RateCalcDataCopyWith(_RateCalcData value, $Res Function(_RateCalcData) _then) = __$RateCalcDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "amount") RateCalcAmount? amount
});


@override $RateCalcAmountCopyWith<$Res>? get amount;

}
/// @nodoc
class __$RateCalcDataCopyWithImpl<$Res>
    implements _$RateCalcDataCopyWith<$Res> {
  __$RateCalcDataCopyWithImpl(this._self, this._then);

  final _RateCalcData _self;
  final $Res Function(_RateCalcData) _then;

/// Create a copy of RateCalcData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = freezed,}) {
  return _then(_RateCalcData(
amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as RateCalcAmount?,
  ));
}

/// Create a copy of RateCalcData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateCalcAmountCopyWith<$Res>? get amount {
    if (_self.amount == null) {
    return null;
  }

  return $RateCalcAmountCopyWith<$Res>(_self.amount!, (value) {
    return _then(_self.copyWith(amount: value));
  });
}
}


/// @nodoc
mixin _$RateCalcAmount {

@JsonKey(name: "pay_amount") double? get payAmount;@JsonKey(name: "rate") double? get rate;@JsonKey(name: "display_rate") double? get displayRate;@JsonKey(name: "net_receive_amount") double? get netReceiveAmount;@JsonKey(name: "rate_operator") String? get rateOperator;@JsonKey(name: "mobile_rate_operator") String? get mobileRateOperator;@JsonKey(name: "remarks") String? get remarks;
/// Create a copy of RateCalcAmount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateCalcAmountCopyWith<RateCalcAmount> get copyWith => _$RateCalcAmountCopyWithImpl<RateCalcAmount>(this as RateCalcAmount, _$identity);

  /// Serializes this RateCalcAmount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateCalcAmount&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.displayRate, displayRate) || other.displayRate == displayRate)&&(identical(other.netReceiveAmount, netReceiveAmount) || other.netReceiveAmount == netReceiveAmount)&&(identical(other.rateOperator, rateOperator) || other.rateOperator == rateOperator)&&(identical(other.mobileRateOperator, mobileRateOperator) || other.mobileRateOperator == mobileRateOperator)&&(identical(other.remarks, remarks) || other.remarks == remarks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payAmount,rate,displayRate,netReceiveAmount,rateOperator,mobileRateOperator,remarks);

@override
String toString() {
  return 'RateCalcAmount(payAmount: $payAmount, rate: $rate, displayRate: $displayRate, netReceiveAmount: $netReceiveAmount, rateOperator: $rateOperator, mobileRateOperator: $mobileRateOperator, remarks: $remarks)';
}


}

/// @nodoc
abstract mixin class $RateCalcAmountCopyWith<$Res>  {
  factory $RateCalcAmountCopyWith(RateCalcAmount value, $Res Function(RateCalcAmount) _then) = _$RateCalcAmountCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "pay_amount") double? payAmount,@JsonKey(name: "rate") double? rate,@JsonKey(name: "display_rate") double? displayRate,@JsonKey(name: "net_receive_amount") double? netReceiveAmount,@JsonKey(name: "rate_operator") String? rateOperator,@JsonKey(name: "mobile_rate_operator") String? mobileRateOperator,@JsonKey(name: "remarks") String? remarks
});




}
/// @nodoc
class _$RateCalcAmountCopyWithImpl<$Res>
    implements $RateCalcAmountCopyWith<$Res> {
  _$RateCalcAmountCopyWithImpl(this._self, this._then);

  final RateCalcAmount _self;
  final $Res Function(RateCalcAmount) _then;

/// Create a copy of RateCalcAmount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? payAmount = freezed,Object? rate = freezed,Object? displayRate = freezed,Object? netReceiveAmount = freezed,Object? rateOperator = freezed,Object? mobileRateOperator = freezed,Object? remarks = freezed,}) {
  return _then(_self.copyWith(
payAmount: freezed == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as double?,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,displayRate: freezed == displayRate ? _self.displayRate : displayRate // ignore: cast_nullable_to_non_nullable
as double?,netReceiveAmount: freezed == netReceiveAmount ? _self.netReceiveAmount : netReceiveAmount // ignore: cast_nullable_to_non_nullable
as double?,rateOperator: freezed == rateOperator ? _self.rateOperator : rateOperator // ignore: cast_nullable_to_non_nullable
as String?,mobileRateOperator: freezed == mobileRateOperator ? _self.mobileRateOperator : mobileRateOperator // ignore: cast_nullable_to_non_nullable
as String?,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RateCalcAmount].
extension RateCalcAmountPatterns on RateCalcAmount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateCalcAmount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateCalcAmount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateCalcAmount value)  $default,){
final _that = this;
switch (_that) {
case _RateCalcAmount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateCalcAmount value)?  $default,){
final _that = this;
switch (_that) {
case _RateCalcAmount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "pay_amount")  double? payAmount, @JsonKey(name: "rate")  double? rate, @JsonKey(name: "display_rate")  double? displayRate, @JsonKey(name: "net_receive_amount")  double? netReceiveAmount, @JsonKey(name: "rate_operator")  String? rateOperator, @JsonKey(name: "mobile_rate_operator")  String? mobileRateOperator, @JsonKey(name: "remarks")  String? remarks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateCalcAmount() when $default != null:
return $default(_that.payAmount,_that.rate,_that.displayRate,_that.netReceiveAmount,_that.rateOperator,_that.mobileRateOperator,_that.remarks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "pay_amount")  double? payAmount, @JsonKey(name: "rate")  double? rate, @JsonKey(name: "display_rate")  double? displayRate, @JsonKey(name: "net_receive_amount")  double? netReceiveAmount, @JsonKey(name: "rate_operator")  String? rateOperator, @JsonKey(name: "mobile_rate_operator")  String? mobileRateOperator, @JsonKey(name: "remarks")  String? remarks)  $default,) {final _that = this;
switch (_that) {
case _RateCalcAmount():
return $default(_that.payAmount,_that.rate,_that.displayRate,_that.netReceiveAmount,_that.rateOperator,_that.mobileRateOperator,_that.remarks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "pay_amount")  double? payAmount, @JsonKey(name: "rate")  double? rate, @JsonKey(name: "display_rate")  double? displayRate, @JsonKey(name: "net_receive_amount")  double? netReceiveAmount, @JsonKey(name: "rate_operator")  String? rateOperator, @JsonKey(name: "mobile_rate_operator")  String? mobileRateOperator, @JsonKey(name: "remarks")  String? remarks)?  $default,) {final _that = this;
switch (_that) {
case _RateCalcAmount() when $default != null:
return $default(_that.payAmount,_that.rate,_that.displayRate,_that.netReceiveAmount,_that.rateOperator,_that.mobileRateOperator,_that.remarks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateCalcAmount implements RateCalcAmount {
  const _RateCalcAmount({@JsonKey(name: "pay_amount") this.payAmount, @JsonKey(name: "rate") this.rate, @JsonKey(name: "display_rate") this.displayRate, @JsonKey(name: "net_receive_amount") this.netReceiveAmount, @JsonKey(name: "rate_operator") this.rateOperator, @JsonKey(name: "mobile_rate_operator") this.mobileRateOperator, @JsonKey(name: "remarks") this.remarks});
  factory _RateCalcAmount.fromJson(Map<String, dynamic> json) => _$RateCalcAmountFromJson(json);

@override@JsonKey(name: "pay_amount") final  double? payAmount;
@override@JsonKey(name: "rate") final  double? rate;
@override@JsonKey(name: "display_rate") final  double? displayRate;
@override@JsonKey(name: "net_receive_amount") final  double? netReceiveAmount;
@override@JsonKey(name: "rate_operator") final  String? rateOperator;
@override@JsonKey(name: "mobile_rate_operator") final  String? mobileRateOperator;
@override@JsonKey(name: "remarks") final  String? remarks;

/// Create a copy of RateCalcAmount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateCalcAmountCopyWith<_RateCalcAmount> get copyWith => __$RateCalcAmountCopyWithImpl<_RateCalcAmount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateCalcAmountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateCalcAmount&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.displayRate, displayRate) || other.displayRate == displayRate)&&(identical(other.netReceiveAmount, netReceiveAmount) || other.netReceiveAmount == netReceiveAmount)&&(identical(other.rateOperator, rateOperator) || other.rateOperator == rateOperator)&&(identical(other.mobileRateOperator, mobileRateOperator) || other.mobileRateOperator == mobileRateOperator)&&(identical(other.remarks, remarks) || other.remarks == remarks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payAmount,rate,displayRate,netReceiveAmount,rateOperator,mobileRateOperator,remarks);

@override
String toString() {
  return 'RateCalcAmount(payAmount: $payAmount, rate: $rate, displayRate: $displayRate, netReceiveAmount: $netReceiveAmount, rateOperator: $rateOperator, mobileRateOperator: $mobileRateOperator, remarks: $remarks)';
}


}

/// @nodoc
abstract mixin class _$RateCalcAmountCopyWith<$Res> implements $RateCalcAmountCopyWith<$Res> {
  factory _$RateCalcAmountCopyWith(_RateCalcAmount value, $Res Function(_RateCalcAmount) _then) = __$RateCalcAmountCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "pay_amount") double? payAmount,@JsonKey(name: "rate") double? rate,@JsonKey(name: "display_rate") double? displayRate,@JsonKey(name: "net_receive_amount") double? netReceiveAmount,@JsonKey(name: "rate_operator") String? rateOperator,@JsonKey(name: "mobile_rate_operator") String? mobileRateOperator,@JsonKey(name: "remarks") String? remarks
});




}
/// @nodoc
class __$RateCalcAmountCopyWithImpl<$Res>
    implements _$RateCalcAmountCopyWith<$Res> {
  __$RateCalcAmountCopyWithImpl(this._self, this._then);

  final _RateCalcAmount _self;
  final $Res Function(_RateCalcAmount) _then;

/// Create a copy of RateCalcAmount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? payAmount = freezed,Object? rate = freezed,Object? displayRate = freezed,Object? netReceiveAmount = freezed,Object? rateOperator = freezed,Object? mobileRateOperator = freezed,Object? remarks = freezed,}) {
  return _then(_RateCalcAmount(
payAmount: freezed == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as double?,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,displayRate: freezed == displayRate ? _self.displayRate : displayRate // ignore: cast_nullable_to_non_nullable
as double?,netReceiveAmount: freezed == netReceiveAmount ? _self.netReceiveAmount : netReceiveAmount // ignore: cast_nullable_to_non_nullable
as double?,rateOperator: freezed == rateOperator ? _self.rateOperator : rateOperator // ignore: cast_nullable_to_non_nullable
as String?,mobileRateOperator: freezed == mobileRateOperator ? _self.mobileRateOperator : mobileRateOperator // ignore: cast_nullable_to_non_nullable
as String?,remarks: freezed == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
