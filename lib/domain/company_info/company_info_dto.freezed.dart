// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_info_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompanyInfoDto {

@JsonKey(name: 'success') String? get success; int? get statusCode;@JsonKey(name: 'message') String? get message;@JsonKey(name: 'data') String? get data;
/// Create a copy of CompanyInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyInfoDtoCopyWith<CompanyInfoDto> get copyWith => _$CompanyInfoDtoCopyWithImpl<CompanyInfoDto>(this as CompanyInfoDto, _$identity);

  /// Serializes this CompanyInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyInfoDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data);

@override
String toString() {
  return 'CompanyInfoDto(success: $success, statusCode: $statusCode, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $CompanyInfoDtoCopyWith<$Res>  {
  factory $CompanyInfoDtoCopyWith(CompanyInfoDto value, $Res Function(CompanyInfoDto) _then) = _$CompanyInfoDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'success') String? success, int? statusCode,@JsonKey(name: 'message') String? message,@JsonKey(name: 'data') String? data
});




}
/// @nodoc
class _$CompanyInfoDtoCopyWithImpl<$Res>
    implements $CompanyInfoDtoCopyWith<$Res> {
  _$CompanyInfoDtoCopyWithImpl(this._self, this._then);

  final CompanyInfoDto _self;
  final $Res Function(CompanyInfoDto) _then;

/// Create a copy of CompanyInfoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyInfoDto].
extension CompanyInfoDtoPatterns on CompanyInfoDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyInfoDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _CompanyInfoDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyInfoDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  String? success,  int? statusCode, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'data')  String? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyInfoDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  String? success,  int? statusCode, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'data')  String? data)  $default,) {final _that = this;
switch (_that) {
case _CompanyInfoDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'success')  String? success,  int? statusCode, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'data')  String? data)?  $default,) {final _that = this;
switch (_that) {
case _CompanyInfoDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanyInfoDto implements CompanyInfoDto {
  const _CompanyInfoDto({@JsonKey(name: 'success') this.success, this.statusCode, @JsonKey(name: 'message') this.message, @JsonKey(name: 'data') this.data});
  factory _CompanyInfoDto.fromJson(Map<String, dynamic> json) => _$CompanyInfoDtoFromJson(json);

@override@JsonKey(name: 'success') final  String? success;
@override final  int? statusCode;
@override@JsonKey(name: 'message') final  String? message;
@override@JsonKey(name: 'data') final  String? data;

/// Create a copy of CompanyInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyInfoDtoCopyWith<_CompanyInfoDto> get copyWith => __$CompanyInfoDtoCopyWithImpl<_CompanyInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanyInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyInfoDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data);

@override
String toString() {
  return 'CompanyInfoDto(success: $success, statusCode: $statusCode, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CompanyInfoDtoCopyWith<$Res> implements $CompanyInfoDtoCopyWith<$Res> {
  factory _$CompanyInfoDtoCopyWith(_CompanyInfoDto value, $Res Function(_CompanyInfoDto) _then) = __$CompanyInfoDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'success') String? success, int? statusCode,@JsonKey(name: 'message') String? message,@JsonKey(name: 'data') String? data
});




}
/// @nodoc
class __$CompanyInfoDtoCopyWithImpl<$Res>
    implements _$CompanyInfoDtoCopyWith<$Res> {
  __$CompanyInfoDtoCopyWithImpl(this._self, this._then);

  final _CompanyInfoDto _self;
  final $Res Function(_CompanyInfoDto) _then;

/// Create a copy of CompanyInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_CompanyInfoDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
