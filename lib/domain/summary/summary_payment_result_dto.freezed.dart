// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary_payment_result_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SummaryPaymentResultDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "status_code") int? get statusCode;@JsonKey(name: "message") String? get message;@JsonKey(name: "data") SummaryPaymentResultDtoData? get data;
/// Create a copy of SummaryPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryPaymentResultDtoCopyWith<SummaryPaymentResultDto> get copyWith => _$SummaryPaymentResultDtoCopyWithImpl<SummaryPaymentResultDto>(this as SummaryPaymentResultDto, _$identity);

  /// Serializes this SummaryPaymentResultDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryPaymentResultDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data);

@override
String toString() {
  return 'SummaryPaymentResultDto(success: $success, statusCode: $statusCode, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $SummaryPaymentResultDtoCopyWith<$Res>  {
  factory $SummaryPaymentResultDtoCopyWith(SummaryPaymentResultDto value, $Res Function(SummaryPaymentResultDto) _then) = _$SummaryPaymentResultDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") SummaryPaymentResultDtoData? data
});


$SummaryPaymentResultDtoDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$SummaryPaymentResultDtoCopyWithImpl<$Res>
    implements $SummaryPaymentResultDtoCopyWith<$Res> {
  _$SummaryPaymentResultDtoCopyWithImpl(this._self, this._then);

  final SummaryPaymentResultDto _self;
  final $Res Function(SummaryPaymentResultDto) _then;

/// Create a copy of SummaryPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SummaryPaymentResultDtoData?,
  ));
}
/// Create a copy of SummaryPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryPaymentResultDtoDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SummaryPaymentResultDtoDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SummaryPaymentResultDto].
extension SummaryPaymentResultDtoPatterns on SummaryPaymentResultDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryPaymentResultDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryPaymentResultDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryPaymentResultDto value)  $default,){
final _that = this;
switch (_that) {
case _SummaryPaymentResultDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryPaymentResultDto value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryPaymentResultDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  SummaryPaymentResultDtoData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryPaymentResultDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  SummaryPaymentResultDtoData? data)  $default,) {final _that = this;
switch (_that) {
case _SummaryPaymentResultDto():
return $default(_that.success,_that.statusCode,_that.message,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  SummaryPaymentResultDtoData? data)?  $default,) {final _that = this;
switch (_that) {
case _SummaryPaymentResultDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SummaryPaymentResultDto implements SummaryPaymentResultDto {
  const _SummaryPaymentResultDto({@JsonKey(name: "success") this.success, @JsonKey(name: "status_code") this.statusCode, @JsonKey(name: "message") this.message, @JsonKey(name: "data") this.data});
  factory _SummaryPaymentResultDto.fromJson(Map<String, dynamic> json) => _$SummaryPaymentResultDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "status_code") final  int? statusCode;
@override@JsonKey(name: "message") final  String? message;
@override@JsonKey(name: "data") final  SummaryPaymentResultDtoData? data;

/// Create a copy of SummaryPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryPaymentResultDtoCopyWith<_SummaryPaymentResultDto> get copyWith => __$SummaryPaymentResultDtoCopyWithImpl<_SummaryPaymentResultDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SummaryPaymentResultDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryPaymentResultDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data);

@override
String toString() {
  return 'SummaryPaymentResultDto(success: $success, statusCode: $statusCode, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SummaryPaymentResultDtoCopyWith<$Res> implements $SummaryPaymentResultDtoCopyWith<$Res> {
  factory _$SummaryPaymentResultDtoCopyWith(_SummaryPaymentResultDto value, $Res Function(_SummaryPaymentResultDto) _then) = __$SummaryPaymentResultDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") SummaryPaymentResultDtoData? data
});


@override $SummaryPaymentResultDtoDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$SummaryPaymentResultDtoCopyWithImpl<$Res>
    implements _$SummaryPaymentResultDtoCopyWith<$Res> {
  __$SummaryPaymentResultDtoCopyWithImpl(this._self, this._then);

  final _SummaryPaymentResultDto _self;
  final $Res Function(_SummaryPaymentResultDto) _then;

/// Create a copy of SummaryPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_SummaryPaymentResultDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SummaryPaymentResultDtoData?,
  ));
}

/// Create a copy of SummaryPaymentResultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryPaymentResultDtoDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SummaryPaymentResultDtoDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SummaryPaymentResultDtoData {

@JsonKey(name: "app_transaction") AppTransaction? get appTransaction;@JsonKey(name: "e_id") String? get eId;
/// Create a copy of SummaryPaymentResultDtoData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryPaymentResultDtoDataCopyWith<SummaryPaymentResultDtoData> get copyWith => _$SummaryPaymentResultDtoDataCopyWithImpl<SummaryPaymentResultDtoData>(this as SummaryPaymentResultDtoData, _$identity);

  /// Serializes this SummaryPaymentResultDtoData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryPaymentResultDtoData&&(identical(other.appTransaction, appTransaction) || other.appTransaction == appTransaction)&&(identical(other.eId, eId) || other.eId == eId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appTransaction,eId);

@override
String toString() {
  return 'SummaryPaymentResultDtoData(appTransaction: $appTransaction, eId: $eId)';
}


}

/// @nodoc
abstract mixin class $SummaryPaymentResultDtoDataCopyWith<$Res>  {
  factory $SummaryPaymentResultDtoDataCopyWith(SummaryPaymentResultDtoData value, $Res Function(SummaryPaymentResultDtoData) _then) = _$SummaryPaymentResultDtoDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "app_transaction") AppTransaction? appTransaction,@JsonKey(name: "e_id") String? eId
});


$AppTransactionCopyWith<$Res>? get appTransaction;

}
/// @nodoc
class _$SummaryPaymentResultDtoDataCopyWithImpl<$Res>
    implements $SummaryPaymentResultDtoDataCopyWith<$Res> {
  _$SummaryPaymentResultDtoDataCopyWithImpl(this._self, this._then);

  final SummaryPaymentResultDtoData _self;
  final $Res Function(SummaryPaymentResultDtoData) _then;

/// Create a copy of SummaryPaymentResultDtoData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appTransaction = freezed,Object? eId = freezed,}) {
  return _then(_self.copyWith(
appTransaction: freezed == appTransaction ? _self.appTransaction : appTransaction // ignore: cast_nullable_to_non_nullable
as AppTransaction?,eId: freezed == eId ? _self.eId : eId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SummaryPaymentResultDtoData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppTransactionCopyWith<$Res>? get appTransaction {
    if (_self.appTransaction == null) {
    return null;
  }

  return $AppTransactionCopyWith<$Res>(_self.appTransaction!, (value) {
    return _then(_self.copyWith(appTransaction: value));
  });
}
}


/// Adds pattern-matching-related methods to [SummaryPaymentResultDtoData].
extension SummaryPaymentResultDtoDataPatterns on SummaryPaymentResultDtoData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryPaymentResultDtoData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryPaymentResultDtoData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryPaymentResultDtoData value)  $default,){
final _that = this;
switch (_that) {
case _SummaryPaymentResultDtoData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryPaymentResultDtoData value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryPaymentResultDtoData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "app_transaction")  AppTransaction? appTransaction, @JsonKey(name: "e_id")  String? eId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryPaymentResultDtoData() when $default != null:
return $default(_that.appTransaction,_that.eId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "app_transaction")  AppTransaction? appTransaction, @JsonKey(name: "e_id")  String? eId)  $default,) {final _that = this;
switch (_that) {
case _SummaryPaymentResultDtoData():
return $default(_that.appTransaction,_that.eId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "app_transaction")  AppTransaction? appTransaction, @JsonKey(name: "e_id")  String? eId)?  $default,) {final _that = this;
switch (_that) {
case _SummaryPaymentResultDtoData() when $default != null:
return $default(_that.appTransaction,_that.eId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SummaryPaymentResultDtoData implements SummaryPaymentResultDtoData {
  const _SummaryPaymentResultDtoData({@JsonKey(name: "app_transaction") this.appTransaction, @JsonKey(name: "e_id") this.eId});
  factory _SummaryPaymentResultDtoData.fromJson(Map<String, dynamic> json) => _$SummaryPaymentResultDtoDataFromJson(json);

@override@JsonKey(name: "app_transaction") final  AppTransaction? appTransaction;
@override@JsonKey(name: "e_id") final  String? eId;

/// Create a copy of SummaryPaymentResultDtoData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryPaymentResultDtoDataCopyWith<_SummaryPaymentResultDtoData> get copyWith => __$SummaryPaymentResultDtoDataCopyWithImpl<_SummaryPaymentResultDtoData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SummaryPaymentResultDtoDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryPaymentResultDtoData&&(identical(other.appTransaction, appTransaction) || other.appTransaction == appTransaction)&&(identical(other.eId, eId) || other.eId == eId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appTransaction,eId);

@override
String toString() {
  return 'SummaryPaymentResultDtoData(appTransaction: $appTransaction, eId: $eId)';
}


}

/// @nodoc
abstract mixin class _$SummaryPaymentResultDtoDataCopyWith<$Res> implements $SummaryPaymentResultDtoDataCopyWith<$Res> {
  factory _$SummaryPaymentResultDtoDataCopyWith(_SummaryPaymentResultDtoData value, $Res Function(_SummaryPaymentResultDtoData) _then) = __$SummaryPaymentResultDtoDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "app_transaction") AppTransaction? appTransaction,@JsonKey(name: "e_id") String? eId
});


@override $AppTransactionCopyWith<$Res>? get appTransaction;

}
/// @nodoc
class __$SummaryPaymentResultDtoDataCopyWithImpl<$Res>
    implements _$SummaryPaymentResultDtoDataCopyWith<$Res> {
  __$SummaryPaymentResultDtoDataCopyWithImpl(this._self, this._then);

  final _SummaryPaymentResultDtoData _self;
  final $Res Function(_SummaryPaymentResultDtoData) _then;

/// Create a copy of SummaryPaymentResultDtoData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appTransaction = freezed,Object? eId = freezed,}) {
  return _then(_SummaryPaymentResultDtoData(
appTransaction: freezed == appTransaction ? _self.appTransaction : appTransaction // ignore: cast_nullable_to_non_nullable
as AppTransaction?,eId: freezed == eId ? _self.eId : eId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SummaryPaymentResultDtoData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppTransactionCopyWith<$Res>? get appTransaction {
    if (_self.appTransaction == null) {
    return null;
  }

  return $AppTransactionCopyWith<$Res>(_self.appTransaction!, (value) {
    return _then(_self.copyWith(appTransaction: value));
  });
}
}


/// @nodoc
mixin _$AppTransaction {

@JsonKey(name: "transaction_reference") int? get transactionReference;@JsonKey(name: "net_amount") double? get netAmount;@JsonKey(name: "transactions") List<Transaction>? get transactions;@JsonKey(name: "app_transaction_reference") int? get appTransactionReference;
/// Create a copy of AppTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppTransactionCopyWith<AppTransaction> get copyWith => _$AppTransactionCopyWithImpl<AppTransaction>(this as AppTransaction, _$identity);

  /// Serializes this AppTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppTransaction&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.appTransactionReference, appTransactionReference) || other.appTransactionReference == appTransactionReference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionReference,netAmount,const DeepCollectionEquality().hash(transactions),appTransactionReference);

@override
String toString() {
  return 'AppTransaction(transactionReference: $transactionReference, netAmount: $netAmount, transactions: $transactions, appTransactionReference: $appTransactionReference)';
}


}

/// @nodoc
abstract mixin class $AppTransactionCopyWith<$Res>  {
  factory $AppTransactionCopyWith(AppTransaction value, $Res Function(AppTransaction) _then) = _$AppTransactionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "transaction_reference") int? transactionReference,@JsonKey(name: "net_amount") double? netAmount,@JsonKey(name: "transactions") List<Transaction>? transactions,@JsonKey(name: "app_transaction_reference") int? appTransactionReference
});




}
/// @nodoc
class _$AppTransactionCopyWithImpl<$Res>
    implements $AppTransactionCopyWith<$Res> {
  _$AppTransactionCopyWithImpl(this._self, this._then);

  final AppTransaction _self;
  final $Res Function(AppTransaction) _then;

/// Create a copy of AppTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionReference = freezed,Object? netAmount = freezed,Object? transactions = freezed,Object? appTransactionReference = freezed,}) {
  return _then(_self.copyWith(
transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as int?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,transactions: freezed == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>?,appTransactionReference: freezed == appTransactionReference ? _self.appTransactionReference : appTransactionReference // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppTransaction].
extension AppTransactionPatterns on AppTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppTransaction value)  $default,){
final _that = this;
switch (_that) {
case _AppTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _AppTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "transaction_reference")  int? transactionReference, @JsonKey(name: "net_amount")  double? netAmount, @JsonKey(name: "transactions")  List<Transaction>? transactions, @JsonKey(name: "app_transaction_reference")  int? appTransactionReference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppTransaction() when $default != null:
return $default(_that.transactionReference,_that.netAmount,_that.transactions,_that.appTransactionReference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "transaction_reference")  int? transactionReference, @JsonKey(name: "net_amount")  double? netAmount, @JsonKey(name: "transactions")  List<Transaction>? transactions, @JsonKey(name: "app_transaction_reference")  int? appTransactionReference)  $default,) {final _that = this;
switch (_that) {
case _AppTransaction():
return $default(_that.transactionReference,_that.netAmount,_that.transactions,_that.appTransactionReference);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "transaction_reference")  int? transactionReference, @JsonKey(name: "net_amount")  double? netAmount, @JsonKey(name: "transactions")  List<Transaction>? transactions, @JsonKey(name: "app_transaction_reference")  int? appTransactionReference)?  $default,) {final _that = this;
switch (_that) {
case _AppTransaction() when $default != null:
return $default(_that.transactionReference,_that.netAmount,_that.transactions,_that.appTransactionReference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppTransaction implements AppTransaction {
  const _AppTransaction({@JsonKey(name: "transaction_reference") this.transactionReference, @JsonKey(name: "net_amount") this.netAmount, @JsonKey(name: "transactions") final  List<Transaction>? transactions, @JsonKey(name: "app_transaction_reference") this.appTransactionReference}): _transactions = transactions;
  factory _AppTransaction.fromJson(Map<String, dynamic> json) => _$AppTransactionFromJson(json);

@override@JsonKey(name: "transaction_reference") final  int? transactionReference;
@override@JsonKey(name: "net_amount") final  double? netAmount;
 final  List<Transaction>? _transactions;
@override@JsonKey(name: "transactions") List<Transaction>? get transactions {
  final value = _transactions;
  if (value == null) return null;
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "app_transaction_reference") final  int? appTransactionReference;

/// Create a copy of AppTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppTransactionCopyWith<_AppTransaction> get copyWith => __$AppTransactionCopyWithImpl<_AppTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppTransaction&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.appTransactionReference, appTransactionReference) || other.appTransactionReference == appTransactionReference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionReference,netAmount,const DeepCollectionEquality().hash(_transactions),appTransactionReference);

@override
String toString() {
  return 'AppTransaction(transactionReference: $transactionReference, netAmount: $netAmount, transactions: $transactions, appTransactionReference: $appTransactionReference)';
}


}

/// @nodoc
abstract mixin class _$AppTransactionCopyWith<$Res> implements $AppTransactionCopyWith<$Res> {
  factory _$AppTransactionCopyWith(_AppTransaction value, $Res Function(_AppTransaction) _then) = __$AppTransactionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "transaction_reference") int? transactionReference,@JsonKey(name: "net_amount") double? netAmount,@JsonKey(name: "transactions") List<Transaction>? transactions,@JsonKey(name: "app_transaction_reference") int? appTransactionReference
});




}
/// @nodoc
class __$AppTransactionCopyWithImpl<$Res>
    implements _$AppTransactionCopyWith<$Res> {
  __$AppTransactionCopyWithImpl(this._self, this._then);

  final _AppTransaction _self;
  final $Res Function(_AppTransaction) _then;

/// Create a copy of AppTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionReference = freezed,Object? netAmount = freezed,Object? transactions = freezed,Object? appTransactionReference = freezed,}) {
  return _then(_AppTransaction(
transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as int?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,transactions: freezed == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>?,appTransactionReference: freezed == appTransactionReference ? _self.appTransactionReference : appTransactionReference // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Transaction {

@JsonKey(name: "transaction_reference") int? get transactionReference;@JsonKey(name: "net_amount") double? get netAmount;@JsonKey(name: "status") String? get status;@JsonKey(name: "beneficiary_name") String? get beneficiaryName;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.beneficiaryName, beneficiaryName) || other.beneficiaryName == beneficiaryName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionReference,netAmount,status,beneficiaryName);

@override
String toString() {
  return 'Transaction(transactionReference: $transactionReference, netAmount: $netAmount, status: $status, beneficiaryName: $beneficiaryName)';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "transaction_reference") int? transactionReference,@JsonKey(name: "net_amount") double? netAmount,@JsonKey(name: "status") String? status,@JsonKey(name: "beneficiary_name") String? beneficiaryName
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionReference = freezed,Object? netAmount = freezed,Object? status = freezed,Object? beneficiaryName = freezed,}) {
  return _then(_self.copyWith(
transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as int?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,beneficiaryName: freezed == beneficiaryName ? _self.beneficiaryName : beneficiaryName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transaction value)  $default,){
final _that = this;
switch (_that) {
case _Transaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transaction value)?  $default,){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "transaction_reference")  int? transactionReference, @JsonKey(name: "net_amount")  double? netAmount, @JsonKey(name: "status")  String? status, @JsonKey(name: "beneficiary_name")  String? beneficiaryName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.transactionReference,_that.netAmount,_that.status,_that.beneficiaryName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "transaction_reference")  int? transactionReference, @JsonKey(name: "net_amount")  double? netAmount, @JsonKey(name: "status")  String? status, @JsonKey(name: "beneficiary_name")  String? beneficiaryName)  $default,) {final _that = this;
switch (_that) {
case _Transaction():
return $default(_that.transactionReference,_that.netAmount,_that.status,_that.beneficiaryName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "transaction_reference")  int? transactionReference, @JsonKey(name: "net_amount")  double? netAmount, @JsonKey(name: "status")  String? status, @JsonKey(name: "beneficiary_name")  String? beneficiaryName)?  $default,) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.transactionReference,_that.netAmount,_that.status,_that.beneficiaryName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Transaction implements Transaction {
  const _Transaction({@JsonKey(name: "transaction_reference") this.transactionReference, @JsonKey(name: "net_amount") this.netAmount, @JsonKey(name: "status") this.status, @JsonKey(name: "beneficiary_name") this.beneficiaryName});
  factory _Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

@override@JsonKey(name: "transaction_reference") final  int? transactionReference;
@override@JsonKey(name: "net_amount") final  double? netAmount;
@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "beneficiary_name") final  String? beneficiaryName;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.beneficiaryName, beneficiaryName) || other.beneficiaryName == beneficiaryName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionReference,netAmount,status,beneficiaryName);

@override
String toString() {
  return 'Transaction(transactionReference: $transactionReference, netAmount: $netAmount, status: $status, beneficiaryName: $beneficiaryName)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "transaction_reference") int? transactionReference,@JsonKey(name: "net_amount") double? netAmount,@JsonKey(name: "status") String? status,@JsonKey(name: "beneficiary_name") String? beneficiaryName
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionReference = freezed,Object? netAmount = freezed,Object? status = freezed,Object? beneficiaryName = freezed,}) {
  return _then(_Transaction(
transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as int?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,beneficiaryName: freezed == beneficiaryName ? _self.beneficiaryName : beneficiaryName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
