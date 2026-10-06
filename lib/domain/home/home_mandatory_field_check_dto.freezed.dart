// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_mandatory_field_check_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeMandatoryFieldCheckDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "status_code") int? get statusCode;@JsonKey(name: "message") String? get message;@JsonKey(name: "data") HomeMandatoryFieldCheckData? get data;@JsonKey(name: "time_stamp") DateTime? get timeStamp;@JsonKey(name: "version") String? get version;
/// Create a copy of HomeMandatoryFieldCheckDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeMandatoryFieldCheckDtoCopyWith<HomeMandatoryFieldCheckDto> get copyWith => _$HomeMandatoryFieldCheckDtoCopyWithImpl<HomeMandatoryFieldCheckDto>(this as HomeMandatoryFieldCheckDto, _$identity);

  /// Serializes this HomeMandatoryFieldCheckDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeMandatoryFieldCheckDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data,timeStamp,version);

@override
String toString() {
  return 'HomeMandatoryFieldCheckDto(success: $success, statusCode: $statusCode, message: $message, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class $HomeMandatoryFieldCheckDtoCopyWith<$Res>  {
  factory $HomeMandatoryFieldCheckDtoCopyWith(HomeMandatoryFieldCheckDto value, $Res Function(HomeMandatoryFieldCheckDto) _then) = _$HomeMandatoryFieldCheckDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") HomeMandatoryFieldCheckData? data,@JsonKey(name: "time_stamp") DateTime? timeStamp,@JsonKey(name: "version") String? version
});


$HomeMandatoryFieldCheckDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$HomeMandatoryFieldCheckDtoCopyWithImpl<$Res>
    implements $HomeMandatoryFieldCheckDtoCopyWith<$Res> {
  _$HomeMandatoryFieldCheckDtoCopyWithImpl(this._self, this._then);

  final HomeMandatoryFieldCheckDto _self;
  final $Res Function(HomeMandatoryFieldCheckDto) _then;

/// Create a copy of HomeMandatoryFieldCheckDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeMandatoryFieldCheckData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of HomeMandatoryFieldCheckDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMandatoryFieldCheckDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $HomeMandatoryFieldCheckDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeMandatoryFieldCheckDto].
extension HomeMandatoryFieldCheckDtoPatterns on HomeMandatoryFieldCheckDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeMandatoryFieldCheckDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeMandatoryFieldCheckDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeMandatoryFieldCheckDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  HomeMandatoryFieldCheckData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  HomeMandatoryFieldCheckData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)  $default,) {final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  HomeMandatoryFieldCheckData? data, @JsonKey(name: "time_stamp")  DateTime? timeStamp, @JsonKey(name: "version")  String? version)?  $default,) {final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.message,_that.data,_that.timeStamp,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeMandatoryFieldCheckDto implements HomeMandatoryFieldCheckDto {
  const _HomeMandatoryFieldCheckDto({@JsonKey(name: "success") this.success, @JsonKey(name: "status_code") this.statusCode, @JsonKey(name: "message") this.message, @JsonKey(name: "data") this.data, @JsonKey(name: "time_stamp") this.timeStamp, @JsonKey(name: "version") this.version});
  factory _HomeMandatoryFieldCheckDto.fromJson(Map<String, dynamic> json) => _$HomeMandatoryFieldCheckDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "status_code") final  int? statusCode;
@override@JsonKey(name: "message") final  String? message;
@override@JsonKey(name: "data") final  HomeMandatoryFieldCheckData? data;
@override@JsonKey(name: "time_stamp") final  DateTime? timeStamp;
@override@JsonKey(name: "version") final  String? version;

/// Create a copy of HomeMandatoryFieldCheckDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeMandatoryFieldCheckDtoCopyWith<_HomeMandatoryFieldCheckDto> get copyWith => __$HomeMandatoryFieldCheckDtoCopyWithImpl<_HomeMandatoryFieldCheckDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeMandatoryFieldCheckDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeMandatoryFieldCheckDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data,timeStamp,version);

@override
String toString() {
  return 'HomeMandatoryFieldCheckDto(success: $success, statusCode: $statusCode, message: $message, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class _$HomeMandatoryFieldCheckDtoCopyWith<$Res> implements $HomeMandatoryFieldCheckDtoCopyWith<$Res> {
  factory _$HomeMandatoryFieldCheckDtoCopyWith(_HomeMandatoryFieldCheckDto value, $Res Function(_HomeMandatoryFieldCheckDto) _then) = __$HomeMandatoryFieldCheckDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "message") String? message,@JsonKey(name: "data") HomeMandatoryFieldCheckData? data,@JsonKey(name: "time_stamp") DateTime? timeStamp,@JsonKey(name: "version") String? version
});


@override $HomeMandatoryFieldCheckDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$HomeMandatoryFieldCheckDtoCopyWithImpl<$Res>
    implements _$HomeMandatoryFieldCheckDtoCopyWith<$Res> {
  __$HomeMandatoryFieldCheckDtoCopyWithImpl(this._self, this._then);

  final _HomeMandatoryFieldCheckDto _self;
  final $Res Function(_HomeMandatoryFieldCheckDto) _then;

/// Create a copy of HomeMandatoryFieldCheckDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_HomeMandatoryFieldCheckDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeMandatoryFieldCheckData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of HomeMandatoryFieldCheckDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMandatoryFieldCheckDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $HomeMandatoryFieldCheckDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$HomeMandatoryFieldCheckData {

@JsonKey(name: "product") HomeMandatoryFieldProduct? get product;
/// Create a copy of HomeMandatoryFieldCheckData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeMandatoryFieldCheckDataCopyWith<HomeMandatoryFieldCheckData> get copyWith => _$HomeMandatoryFieldCheckDataCopyWithImpl<HomeMandatoryFieldCheckData>(this as HomeMandatoryFieldCheckData, _$identity);

  /// Serializes this HomeMandatoryFieldCheckData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeMandatoryFieldCheckData&&(identical(other.product, product) || other.product == product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'HomeMandatoryFieldCheckData(product: $product)';
}


}

/// @nodoc
abstract mixin class $HomeMandatoryFieldCheckDataCopyWith<$Res>  {
  factory $HomeMandatoryFieldCheckDataCopyWith(HomeMandatoryFieldCheckData value, $Res Function(HomeMandatoryFieldCheckData) _then) = _$HomeMandatoryFieldCheckDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "product") HomeMandatoryFieldProduct? product
});


$HomeMandatoryFieldProductCopyWith<$Res>? get product;

}
/// @nodoc
class _$HomeMandatoryFieldCheckDataCopyWithImpl<$Res>
    implements $HomeMandatoryFieldCheckDataCopyWith<$Res> {
  _$HomeMandatoryFieldCheckDataCopyWithImpl(this._self, this._then);

  final HomeMandatoryFieldCheckData _self;
  final $Res Function(HomeMandatoryFieldCheckData) _then;

/// Create a copy of HomeMandatoryFieldCheckData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? product = freezed,}) {
  return _then(_self.copyWith(
product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as HomeMandatoryFieldProduct?,
  ));
}
/// Create a copy of HomeMandatoryFieldCheckData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMandatoryFieldProductCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $HomeMandatoryFieldProductCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeMandatoryFieldCheckData].
extension HomeMandatoryFieldCheckDataPatterns on HomeMandatoryFieldCheckData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeMandatoryFieldCheckData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeMandatoryFieldCheckData value)  $default,){
final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeMandatoryFieldCheckData value)?  $default,){
final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "product")  HomeMandatoryFieldProduct? product)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckData() when $default != null:
return $default(_that.product);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "product")  HomeMandatoryFieldProduct? product)  $default,) {final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckData():
return $default(_that.product);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "product")  HomeMandatoryFieldProduct? product)?  $default,) {final _that = this;
switch (_that) {
case _HomeMandatoryFieldCheckData() when $default != null:
return $default(_that.product);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeMandatoryFieldCheckData implements HomeMandatoryFieldCheckData {
  const _HomeMandatoryFieldCheckData({@JsonKey(name: "product") this.product});
  factory _HomeMandatoryFieldCheckData.fromJson(Map<String, dynamic> json) => _$HomeMandatoryFieldCheckDataFromJson(json);

@override@JsonKey(name: "product") final  HomeMandatoryFieldProduct? product;

/// Create a copy of HomeMandatoryFieldCheckData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeMandatoryFieldCheckDataCopyWith<_HomeMandatoryFieldCheckData> get copyWith => __$HomeMandatoryFieldCheckDataCopyWithImpl<_HomeMandatoryFieldCheckData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeMandatoryFieldCheckDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeMandatoryFieldCheckData&&(identical(other.product, product) || other.product == product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'HomeMandatoryFieldCheckData(product: $product)';
}


}

/// @nodoc
abstract mixin class _$HomeMandatoryFieldCheckDataCopyWith<$Res> implements $HomeMandatoryFieldCheckDataCopyWith<$Res> {
  factory _$HomeMandatoryFieldCheckDataCopyWith(_HomeMandatoryFieldCheckData value, $Res Function(_HomeMandatoryFieldCheckData) _then) = __$HomeMandatoryFieldCheckDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "product") HomeMandatoryFieldProduct? product
});


@override $HomeMandatoryFieldProductCopyWith<$Res>? get product;

}
/// @nodoc
class __$HomeMandatoryFieldCheckDataCopyWithImpl<$Res>
    implements _$HomeMandatoryFieldCheckDataCopyWith<$Res> {
  __$HomeMandatoryFieldCheckDataCopyWithImpl(this._self, this._then);

  final _HomeMandatoryFieldCheckData _self;
  final $Res Function(_HomeMandatoryFieldCheckData) _then;

/// Create a copy of HomeMandatoryFieldCheckData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? product = freezed,}) {
  return _then(_HomeMandatoryFieldCheckData(
product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as HomeMandatoryFieldProduct?,
  ));
}

/// Create a copy of HomeMandatoryFieldCheckData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMandatoryFieldProductCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $HomeMandatoryFieldProductCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}


/// @nodoc
mixin _$HomeMandatoryFieldProduct {

@JsonKey(name: "code") int? get code;@JsonKey(name: "name") String? get name;
/// Create a copy of HomeMandatoryFieldProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeMandatoryFieldProductCopyWith<HomeMandatoryFieldProduct> get copyWith => _$HomeMandatoryFieldProductCopyWithImpl<HomeMandatoryFieldProduct>(this as HomeMandatoryFieldProduct, _$identity);

  /// Serializes this HomeMandatoryFieldProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeMandatoryFieldProduct&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'HomeMandatoryFieldProduct(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $HomeMandatoryFieldProductCopyWith<$Res>  {
  factory $HomeMandatoryFieldProductCopyWith(HomeMandatoryFieldProduct value, $Res Function(HomeMandatoryFieldProduct) _then) = _$HomeMandatoryFieldProductCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "code") int? code,@JsonKey(name: "name") String? name
});




}
/// @nodoc
class _$HomeMandatoryFieldProductCopyWithImpl<$Res>
    implements $HomeMandatoryFieldProductCopyWith<$Res> {
  _$HomeMandatoryFieldProductCopyWithImpl(this._self, this._then);

  final HomeMandatoryFieldProduct _self;
  final $Res Function(HomeMandatoryFieldProduct) _then;

/// Create a copy of HomeMandatoryFieldProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeMandatoryFieldProduct].
extension HomeMandatoryFieldProductPatterns on HomeMandatoryFieldProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeMandatoryFieldProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeMandatoryFieldProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeMandatoryFieldProduct value)  $default,){
final _that = this;
switch (_that) {
case _HomeMandatoryFieldProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeMandatoryFieldProduct value)?  $default,){
final _that = this;
switch (_that) {
case _HomeMandatoryFieldProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "name")  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeMandatoryFieldProduct() when $default != null:
return $default(_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "name")  String? name)  $default,) {final _that = this;
switch (_that) {
case _HomeMandatoryFieldProduct():
return $default(_that.code,_that.name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "name")  String? name)?  $default,) {final _that = this;
switch (_that) {
case _HomeMandatoryFieldProduct() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeMandatoryFieldProduct implements HomeMandatoryFieldProduct {
  const _HomeMandatoryFieldProduct({@JsonKey(name: "code") this.code, @JsonKey(name: "name") this.name});
  factory _HomeMandatoryFieldProduct.fromJson(Map<String, dynamic> json) => _$HomeMandatoryFieldProductFromJson(json);

@override@JsonKey(name: "code") final  int? code;
@override@JsonKey(name: "name") final  String? name;

/// Create a copy of HomeMandatoryFieldProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeMandatoryFieldProductCopyWith<_HomeMandatoryFieldProduct> get copyWith => __$HomeMandatoryFieldProductCopyWithImpl<_HomeMandatoryFieldProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeMandatoryFieldProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeMandatoryFieldProduct&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'HomeMandatoryFieldProduct(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$HomeMandatoryFieldProductCopyWith<$Res> implements $HomeMandatoryFieldProductCopyWith<$Res> {
  factory _$HomeMandatoryFieldProductCopyWith(_HomeMandatoryFieldProduct value, $Res Function(_HomeMandatoryFieldProduct) _then) = __$HomeMandatoryFieldProductCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "code") int? code,@JsonKey(name: "name") String? name
});




}
/// @nodoc
class __$HomeMandatoryFieldProductCopyWithImpl<$Res>
    implements _$HomeMandatoryFieldProductCopyWith<$Res> {
  __$HomeMandatoryFieldProductCopyWithImpl(this._self, this._then);

  final _HomeMandatoryFieldProduct _self;
  final $Res Function(_HomeMandatoryFieldProduct) _then;

/// Create a copy of HomeMandatoryFieldProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? name = freezed,}) {
  return _then(_HomeMandatoryFieldProduct(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
