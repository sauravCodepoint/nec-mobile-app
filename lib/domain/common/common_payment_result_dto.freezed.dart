// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_payment_result_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommonPaymentResultDto {

 String? get success; String? get message; PaymentResultData? get data; DateTime? get timeStamp;
/// Create a copy of CommonPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommonPaymentResultDtoCopyWith<CommonPaymentResultDto> get copyWith => _$CommonPaymentResultDtoCopyWithImpl<CommonPaymentResultDto>(this as CommonPaymentResultDto, _$identity);

  /// Serializes this CommonPaymentResultDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommonPaymentResultDto&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data,timeStamp);

@override
String toString() {
  return 'CommonPaymentResultDto(success: $success, message: $message, data: $data, timeStamp: $timeStamp)';
}


}

/// @nodoc
abstract mixin class $CommonPaymentResultDtoCopyWith<$Res>  {
  factory $CommonPaymentResultDtoCopyWith(CommonPaymentResultDto value, $Res Function(CommonPaymentResultDto) _then) = _$CommonPaymentResultDtoCopyWithImpl;
@useResult
$Res call({
 String? success, String? message, PaymentResultData? data, DateTime? timeStamp
});


$PaymentResultDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$CommonPaymentResultDtoCopyWithImpl<$Res>
    implements $CommonPaymentResultDtoCopyWith<$Res> {
  _$CommonPaymentResultDtoCopyWithImpl(this._self, this._then);

  final CommonPaymentResultDto _self;
  final $Res Function(CommonPaymentResultDto) _then;

/// Create a copy of CommonPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PaymentResultData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CommonPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentResultDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PaymentResultDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommonPaymentResultDto].
extension CommonPaymentResultDtoPatterns on CommonPaymentResultDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommonPaymentResultDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommonPaymentResultDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommonPaymentResultDto value)  $default,){
final _that = this;
switch (_that) {
case _CommonPaymentResultDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommonPaymentResultDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommonPaymentResultDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? success,  String? message,  PaymentResultData? data,  DateTime? timeStamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommonPaymentResultDto() when $default != null:
return $default(_that.success,_that.message,_that.data,_that.timeStamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? success,  String? message,  PaymentResultData? data,  DateTime? timeStamp)  $default,) {final _that = this;
switch (_that) {
case _CommonPaymentResultDto():
return $default(_that.success,_that.message,_that.data,_that.timeStamp);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? success,  String? message,  PaymentResultData? data,  DateTime? timeStamp)?  $default,) {final _that = this;
switch (_that) {
case _CommonPaymentResultDto() when $default != null:
return $default(_that.success,_that.message,_that.data,_that.timeStamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommonPaymentResultDto implements CommonPaymentResultDto {
  const _CommonPaymentResultDto({this.success, this.message, this.data, this.timeStamp});
  factory _CommonPaymentResultDto.fromJson(Map<String, dynamic> json) => _$CommonPaymentResultDtoFromJson(json);

@override final  String? success;
@override final  String? message;
@override final  PaymentResultData? data;
@override final  DateTime? timeStamp;

/// Create a copy of CommonPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommonPaymentResultDtoCopyWith<_CommonPaymentResultDto> get copyWith => __$CommonPaymentResultDtoCopyWithImpl<_CommonPaymentResultDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommonPaymentResultDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommonPaymentResultDto&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data,timeStamp);

@override
String toString() {
  return 'CommonPaymentResultDto(success: $success, message: $message, data: $data, timeStamp: $timeStamp)';
}


}

/// @nodoc
abstract mixin class _$CommonPaymentResultDtoCopyWith<$Res> implements $CommonPaymentResultDtoCopyWith<$Res> {
  factory _$CommonPaymentResultDtoCopyWith(_CommonPaymentResultDto value, $Res Function(_CommonPaymentResultDto) _then) = __$CommonPaymentResultDtoCopyWithImpl;
@override @useResult
$Res call({
 String? success, String? message, PaymentResultData? data, DateTime? timeStamp
});


@override $PaymentResultDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$CommonPaymentResultDtoCopyWithImpl<$Res>
    implements _$CommonPaymentResultDtoCopyWith<$Res> {
  __$CommonPaymentResultDtoCopyWithImpl(this._self, this._then);

  final _CommonPaymentResultDto _self;
  final $Res Function(_CommonPaymentResultDto) _then;

/// Create a copy of CommonPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,}) {
  return _then(_CommonPaymentResultDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PaymentResultData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CommonPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentResultDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PaymentResultDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$PaymentResultData {

 PaymentTransaction? get paymentTransaction; String? get eId;
/// Create a copy of PaymentResultData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentResultDataCopyWith<PaymentResultData> get copyWith => _$PaymentResultDataCopyWithImpl<PaymentResultData>(this as PaymentResultData, _$identity);

  /// Serializes this PaymentResultData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentResultData&&(identical(other.paymentTransaction, paymentTransaction) || other.paymentTransaction == paymentTransaction)&&(identical(other.eId, eId) || other.eId == eId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentTransaction,eId);

@override
String toString() {
  return 'PaymentResultData(paymentTransaction: $paymentTransaction, eId: $eId)';
}


}

/// @nodoc
abstract mixin class $PaymentResultDataCopyWith<$Res>  {
  factory $PaymentResultDataCopyWith(PaymentResultData value, $Res Function(PaymentResultData) _then) = _$PaymentResultDataCopyWithImpl;
@useResult
$Res call({
 PaymentTransaction? paymentTransaction, String? eId
});


$PaymentTransactionCopyWith<$Res>? get paymentTransaction;

}
/// @nodoc
class _$PaymentResultDataCopyWithImpl<$Res>
    implements $PaymentResultDataCopyWith<$Res> {
  _$PaymentResultDataCopyWithImpl(this._self, this._then);

  final PaymentResultData _self;
  final $Res Function(PaymentResultData) _then;

/// Create a copy of PaymentResultData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentTransaction = freezed,Object? eId = freezed,}) {
  return _then(_self.copyWith(
paymentTransaction: freezed == paymentTransaction ? _self.paymentTransaction : paymentTransaction // ignore: cast_nullable_to_non_nullable
as PaymentTransaction?,eId: freezed == eId ? _self.eId : eId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PaymentResultData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentTransactionCopyWith<$Res>? get paymentTransaction {
    if (_self.paymentTransaction == null) {
    return null;
  }

  return $PaymentTransactionCopyWith<$Res>(_self.paymentTransaction!, (value) {
    return _then(_self.copyWith(paymentTransaction: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaymentResultData].
extension PaymentResultDataPatterns on PaymentResultData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentResultData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentResultData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentResultData value)  $default,){
final _that = this;
switch (_that) {
case _PaymentResultData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentResultData value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentResultData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaymentTransaction? paymentTransaction,  String? eId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentResultData() when $default != null:
return $default(_that.paymentTransaction,_that.eId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaymentTransaction? paymentTransaction,  String? eId)  $default,) {final _that = this;
switch (_that) {
case _PaymentResultData():
return $default(_that.paymentTransaction,_that.eId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaymentTransaction? paymentTransaction,  String? eId)?  $default,) {final _that = this;
switch (_that) {
case _PaymentResultData() when $default != null:
return $default(_that.paymentTransaction,_that.eId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentResultData implements PaymentResultData {
  const _PaymentResultData({this.paymentTransaction, this.eId});
  factory _PaymentResultData.fromJson(Map<String, dynamic> json) => _$PaymentResultDataFromJson(json);

@override final  PaymentTransaction? paymentTransaction;
@override final  String? eId;

/// Create a copy of PaymentResultData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentResultDataCopyWith<_PaymentResultData> get copyWith => __$PaymentResultDataCopyWithImpl<_PaymentResultData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentResultDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentResultData&&(identical(other.paymentTransaction, paymentTransaction) || other.paymentTransaction == paymentTransaction)&&(identical(other.eId, eId) || other.eId == eId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentTransaction,eId);

@override
String toString() {
  return 'PaymentResultData(paymentTransaction: $paymentTransaction, eId: $eId)';
}


}

/// @nodoc
abstract mixin class _$PaymentResultDataCopyWith<$Res> implements $PaymentResultDataCopyWith<$Res> {
  factory _$PaymentResultDataCopyWith(_PaymentResultData value, $Res Function(_PaymentResultData) _then) = __$PaymentResultDataCopyWithImpl;
@override @useResult
$Res call({
 PaymentTransaction? paymentTransaction, String? eId
});


@override $PaymentTransactionCopyWith<$Res>? get paymentTransaction;

}
/// @nodoc
class __$PaymentResultDataCopyWithImpl<$Res>
    implements _$PaymentResultDataCopyWith<$Res> {
  __$PaymentResultDataCopyWithImpl(this._self, this._then);

  final _PaymentResultData _self;
  final $Res Function(_PaymentResultData) _then;

/// Create a copy of PaymentResultData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentTransaction = freezed,Object? eId = freezed,}) {
  return _then(_PaymentResultData(
paymentTransaction: freezed == paymentTransaction ? _self.paymentTransaction : paymentTransaction // ignore: cast_nullable_to_non_nullable
as PaymentTransaction?,eId: freezed == eId ? _self.eId : eId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PaymentResultData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentTransactionCopyWith<$Res>? get paymentTransaction {
    if (_self.paymentTransaction == null) {
    return null;
  }

  return $PaymentTransactionCopyWith<$Res>(_self.paymentTransaction!, (value) {
    return _then(_self.copyWith(paymentTransaction: value));
  });
}
}


/// @nodoc
mixin _$PaymentTransaction {

 int? get transactionReference; double? get netAmount; TransactionDetails? get transactions;
/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentTransactionCopyWith<PaymentTransaction> get copyWith => _$PaymentTransactionCopyWithImpl<PaymentTransaction>(this as PaymentTransaction, _$identity);

  /// Serializes this PaymentTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransaction&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.transactions, transactions) || other.transactions == transactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionReference,netAmount,transactions);

@override
String toString() {
  return 'PaymentTransaction(transactionReference: $transactionReference, netAmount: $netAmount, transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class $PaymentTransactionCopyWith<$Res>  {
  factory $PaymentTransactionCopyWith(PaymentTransaction value, $Res Function(PaymentTransaction) _then) = _$PaymentTransactionCopyWithImpl;
@useResult
$Res call({
 int? transactionReference, double? netAmount, TransactionDetails? transactions
});


$TransactionDetailsCopyWith<$Res>? get transactions;

}
/// @nodoc
class _$PaymentTransactionCopyWithImpl<$Res>
    implements $PaymentTransactionCopyWith<$Res> {
  _$PaymentTransactionCopyWithImpl(this._self, this._then);

  final PaymentTransaction _self;
  final $Res Function(PaymentTransaction) _then;

/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionReference = freezed,Object? netAmount = freezed,Object? transactions = freezed,}) {
  return _then(_self.copyWith(
transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as int?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,transactions: freezed == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as TransactionDetails?,
  ));
}
/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionDetailsCopyWith<$Res>? get transactions {
    if (_self.transactions == null) {
    return null;
  }

  return $TransactionDetailsCopyWith<$Res>(_self.transactions!, (value) {
    return _then(_self.copyWith(transactions: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaymentTransaction].
extension PaymentTransactionPatterns on PaymentTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentTransaction value)  $default,){
final _that = this;
switch (_that) {
case _PaymentTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? transactionReference,  double? netAmount,  TransactionDetails? transactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentTransaction() when $default != null:
return $default(_that.transactionReference,_that.netAmount,_that.transactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? transactionReference,  double? netAmount,  TransactionDetails? transactions)  $default,) {final _that = this;
switch (_that) {
case _PaymentTransaction():
return $default(_that.transactionReference,_that.netAmount,_that.transactions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? transactionReference,  double? netAmount,  TransactionDetails? transactions)?  $default,) {final _that = this;
switch (_that) {
case _PaymentTransaction() when $default != null:
return $default(_that.transactionReference,_that.netAmount,_that.transactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentTransaction implements PaymentTransaction {
  const _PaymentTransaction({this.transactionReference, this.netAmount, this.transactions});
  factory _PaymentTransaction.fromJson(Map<String, dynamic> json) => _$PaymentTransactionFromJson(json);

@override final  int? transactionReference;
@override final  double? netAmount;
@override final  TransactionDetails? transactions;

/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentTransactionCopyWith<_PaymentTransaction> get copyWith => __$PaymentTransactionCopyWithImpl<_PaymentTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentTransaction&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.transactions, transactions) || other.transactions == transactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionReference,netAmount,transactions);

@override
String toString() {
  return 'PaymentTransaction(transactionReference: $transactionReference, netAmount: $netAmount, transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$PaymentTransactionCopyWith<$Res> implements $PaymentTransactionCopyWith<$Res> {
  factory _$PaymentTransactionCopyWith(_PaymentTransaction value, $Res Function(_PaymentTransaction) _then) = __$PaymentTransactionCopyWithImpl;
@override @useResult
$Res call({
 int? transactionReference, double? netAmount, TransactionDetails? transactions
});


@override $TransactionDetailsCopyWith<$Res>? get transactions;

}
/// @nodoc
class __$PaymentTransactionCopyWithImpl<$Res>
    implements _$PaymentTransactionCopyWith<$Res> {
  __$PaymentTransactionCopyWithImpl(this._self, this._then);

  final _PaymentTransaction _self;
  final $Res Function(_PaymentTransaction) _then;

/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionReference = freezed,Object? netAmount = freezed,Object? transactions = freezed,}) {
  return _then(_PaymentTransaction(
transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as int?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,transactions: freezed == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as TransactionDetails?,
  ));
}

/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionDetailsCopyWith<$Res>? get transactions {
    if (_self.transactions == null) {
    return null;
  }

  return $TransactionDetailsCopyWith<$Res>(_self.transactions!, (value) {
    return _then(_self.copyWith(transactions: value));
  });
}
}


/// @nodoc
mixin _$TransactionDetails {

 bool? get isSuccessful; int? get transactionReference; double? get netAmount; String? get status; String? get beneficiaryName; String? get paymentMode; String? get appStatus;
/// Create a copy of TransactionDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionDetailsCopyWith<TransactionDetails> get copyWith => _$TransactionDetailsCopyWithImpl<TransactionDetails>(this as TransactionDetails, _$identity);

  /// Serializes this TransactionDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionDetails&&(identical(other.isSuccessful, isSuccessful) || other.isSuccessful == isSuccessful)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.beneficiaryName, beneficiaryName) || other.beneficiaryName == beneficiaryName)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.appStatus, appStatus) || other.appStatus == appStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSuccessful,transactionReference,netAmount,status,beneficiaryName,paymentMode,appStatus);

@override
String toString() {
  return 'TransactionDetails(isSuccessful: $isSuccessful, transactionReference: $transactionReference, netAmount: $netAmount, status: $status, beneficiaryName: $beneficiaryName, paymentMode: $paymentMode, appStatus: $appStatus)';
}


}

/// @nodoc
abstract mixin class $TransactionDetailsCopyWith<$Res>  {
  factory $TransactionDetailsCopyWith(TransactionDetails value, $Res Function(TransactionDetails) _then) = _$TransactionDetailsCopyWithImpl;
@useResult
$Res call({
 bool? isSuccessful, int? transactionReference, double? netAmount, String? status, String? beneficiaryName, String? paymentMode, String? appStatus
});




}
/// @nodoc
class _$TransactionDetailsCopyWithImpl<$Res>
    implements $TransactionDetailsCopyWith<$Res> {
  _$TransactionDetailsCopyWithImpl(this._self, this._then);

  final TransactionDetails _self;
  final $Res Function(TransactionDetails) _then;

/// Create a copy of TransactionDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSuccessful = freezed,Object? transactionReference = freezed,Object? netAmount = freezed,Object? status = freezed,Object? beneficiaryName = freezed,Object? paymentMode = freezed,Object? appStatus = freezed,}) {
  return _then(_self.copyWith(
isSuccessful: freezed == isSuccessful ? _self.isSuccessful : isSuccessful // ignore: cast_nullable_to_non_nullable
as bool?,transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as int?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,beneficiaryName: freezed == beneficiaryName ? _self.beneficiaryName : beneficiaryName // ignore: cast_nullable_to_non_nullable
as String?,paymentMode: freezed == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String?,appStatus: freezed == appStatus ? _self.appStatus : appStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionDetails].
extension TransactionDetailsPatterns on TransactionDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionDetails value)  $default,){
final _that = this;
switch (_that) {
case _TransactionDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionDetails value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? isSuccessful,  int? transactionReference,  double? netAmount,  String? status,  String? beneficiaryName,  String? paymentMode,  String? appStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionDetails() when $default != null:
return $default(_that.isSuccessful,_that.transactionReference,_that.netAmount,_that.status,_that.beneficiaryName,_that.paymentMode,_that.appStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? isSuccessful,  int? transactionReference,  double? netAmount,  String? status,  String? beneficiaryName,  String? paymentMode,  String? appStatus)  $default,) {final _that = this;
switch (_that) {
case _TransactionDetails():
return $default(_that.isSuccessful,_that.transactionReference,_that.netAmount,_that.status,_that.beneficiaryName,_that.paymentMode,_that.appStatus);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? isSuccessful,  int? transactionReference,  double? netAmount,  String? status,  String? beneficiaryName,  String? paymentMode,  String? appStatus)?  $default,) {final _that = this;
switch (_that) {
case _TransactionDetails() when $default != null:
return $default(_that.isSuccessful,_that.transactionReference,_that.netAmount,_that.status,_that.beneficiaryName,_that.paymentMode,_that.appStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionDetails implements TransactionDetails {
  const _TransactionDetails({this.isSuccessful, this.transactionReference, this.netAmount, this.status, this.beneficiaryName, this.paymentMode, this.appStatus});
  factory _TransactionDetails.fromJson(Map<String, dynamic> json) => _$TransactionDetailsFromJson(json);

@override final  bool? isSuccessful;
@override final  int? transactionReference;
@override final  double? netAmount;
@override final  String? status;
@override final  String? beneficiaryName;
@override final  String? paymentMode;
@override final  String? appStatus;

/// Create a copy of TransactionDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionDetailsCopyWith<_TransactionDetails> get copyWith => __$TransactionDetailsCopyWithImpl<_TransactionDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionDetails&&(identical(other.isSuccessful, isSuccessful) || other.isSuccessful == isSuccessful)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.beneficiaryName, beneficiaryName) || other.beneficiaryName == beneficiaryName)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.appStatus, appStatus) || other.appStatus == appStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSuccessful,transactionReference,netAmount,status,beneficiaryName,paymentMode,appStatus);

@override
String toString() {
  return 'TransactionDetails(isSuccessful: $isSuccessful, transactionReference: $transactionReference, netAmount: $netAmount, status: $status, beneficiaryName: $beneficiaryName, paymentMode: $paymentMode, appStatus: $appStatus)';
}


}

/// @nodoc
abstract mixin class _$TransactionDetailsCopyWith<$Res> implements $TransactionDetailsCopyWith<$Res> {
  factory _$TransactionDetailsCopyWith(_TransactionDetails value, $Res Function(_TransactionDetails) _then) = __$TransactionDetailsCopyWithImpl;
@override @useResult
$Res call({
 bool? isSuccessful, int? transactionReference, double? netAmount, String? status, String? beneficiaryName, String? paymentMode, String? appStatus
});




}
/// @nodoc
class __$TransactionDetailsCopyWithImpl<$Res>
    implements _$TransactionDetailsCopyWith<$Res> {
  __$TransactionDetailsCopyWithImpl(this._self, this._then);

  final _TransactionDetails _self;
  final $Res Function(_TransactionDetails) _then;

/// Create a copy of TransactionDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSuccessful = freezed,Object? transactionReference = freezed,Object? netAmount = freezed,Object? status = freezed,Object? beneficiaryName = freezed,Object? paymentMode = freezed,Object? appStatus = freezed,}) {
  return _then(_TransactionDetails(
isSuccessful: freezed == isSuccessful ? _self.isSuccessful : isSuccessful // ignore: cast_nullable_to_non_nullable
as bool?,transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as int?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,beneficiaryName: freezed == beneficiaryName ? _self.beneficiaryName : beneficiaryName // ignore: cast_nullable_to_non_nullable
as String?,paymentMode: freezed == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String?,appStatus: freezed == appStatus ? _self.appStatus : appStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
