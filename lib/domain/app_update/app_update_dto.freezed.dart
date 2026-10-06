// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_update_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUpdateDto {

@JsonKey(name: 'success') String? get success;@JsonKey(name: 'status_code') int? get statusCode;@JsonKey(name: 'message') String? get message;@JsonKey(name: 'data') AppUpdateDataDto? get data;
/// Create a copy of AppUpdateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUpdateDtoCopyWith<AppUpdateDto> get copyWith => _$AppUpdateDtoCopyWithImpl<AppUpdateDto>(this as AppUpdateDto, _$identity);

  /// Serializes this AppUpdateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUpdateDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data);

@override
String toString() {
  return 'AppUpdateDto(success: $success, statusCode: $statusCode, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $AppUpdateDtoCopyWith<$Res>  {
  factory $AppUpdateDtoCopyWith(AppUpdateDto value, $Res Function(AppUpdateDto) _then) = _$AppUpdateDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'success') String? success,@JsonKey(name: 'status_code') int? statusCode,@JsonKey(name: 'message') String? message,@JsonKey(name: 'data') AppUpdateDataDto? data
});


$AppUpdateDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class _$AppUpdateDtoCopyWithImpl<$Res>
    implements $AppUpdateDtoCopyWith<$Res> {
  _$AppUpdateDtoCopyWithImpl(this._self, this._then);

  final AppUpdateDto _self;
  final $Res Function(AppUpdateDto) _then;

/// Create a copy of AppUpdateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AppUpdateDataDto?,
  ));
}
/// Create a copy of AppUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUpdateDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AppUpdateDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppUpdateDto].
extension AppUpdateDtoPatterns on AppUpdateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUpdateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUpdateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUpdateDto value)  $default,){
final _that = this;
switch (_that) {
case _AppUpdateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUpdateDto value)?  $default,){
final _that = this;
switch (_that) {
case _AppUpdateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  String? success, @JsonKey(name: 'status_code')  int? statusCode, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'data')  AppUpdateDataDto? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUpdateDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  String? success, @JsonKey(name: 'status_code')  int? statusCode, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'data')  AppUpdateDataDto? data)  $default,) {final _that = this;
switch (_that) {
case _AppUpdateDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'success')  String? success, @JsonKey(name: 'status_code')  int? statusCode, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'data')  AppUpdateDataDto? data)?  $default,) {final _that = this;
switch (_that) {
case _AppUpdateDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppUpdateDto implements AppUpdateDto {
  const _AppUpdateDto({@JsonKey(name: 'success') this.success, @JsonKey(name: 'status_code') this.statusCode, @JsonKey(name: 'message') this.message, @JsonKey(name: 'data') this.data});
  factory _AppUpdateDto.fromJson(Map<String, dynamic> json) => _$AppUpdateDtoFromJson(json);

@override@JsonKey(name: 'success') final  String? success;
@override@JsonKey(name: 'status_code') final  int? statusCode;
@override@JsonKey(name: 'message') final  String? message;
@override@JsonKey(name: 'data') final  AppUpdateDataDto? data;

/// Create a copy of AppUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUpdateDtoCopyWith<_AppUpdateDto> get copyWith => __$AppUpdateDtoCopyWithImpl<_AppUpdateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUpdateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUpdateDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,message,data);

@override
String toString() {
  return 'AppUpdateDto(success: $success, statusCode: $statusCode, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AppUpdateDtoCopyWith<$Res> implements $AppUpdateDtoCopyWith<$Res> {
  factory _$AppUpdateDtoCopyWith(_AppUpdateDto value, $Res Function(_AppUpdateDto) _then) = __$AppUpdateDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'success') String? success,@JsonKey(name: 'status_code') int? statusCode,@JsonKey(name: 'message') String? message,@JsonKey(name: 'data') AppUpdateDataDto? data
});


@override $AppUpdateDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class __$AppUpdateDtoCopyWithImpl<$Res>
    implements _$AppUpdateDtoCopyWith<$Res> {
  __$AppUpdateDtoCopyWithImpl(this._self, this._then);

  final _AppUpdateDto _self;
  final $Res Function(_AppUpdateDto) _then;

/// Create a copy of AppUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? statusCode = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_AppUpdateDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AppUpdateDataDto?,
  ));
}

/// Create a copy of AppUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUpdateDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AppUpdateDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$AppUpdateDataDto {

@JsonKey(name: 'update_required') bool? get updateRequired;@JsonKey(name: 'update_type') String? get updateType;@JsonKey(name: 'latest_version') String? get latestVersion;@JsonKey(name: 'minimum_supported_version') String? get minimumSupportedVersion;@JsonKey(name: 'update_url') String? get updateUrl;@JsonKey(name: 'title') String? get title;@JsonKey(name: 'message') String? get message;
/// Create a copy of AppUpdateDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUpdateDataDtoCopyWith<AppUpdateDataDto> get copyWith => _$AppUpdateDataDtoCopyWithImpl<AppUpdateDataDto>(this as AppUpdateDataDto, _$identity);

  /// Serializes this AppUpdateDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUpdateDataDto&&(identical(other.updateRequired, updateRequired) || other.updateRequired == updateRequired)&&(identical(other.updateType, updateType) || other.updateType == updateType)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.minimumSupportedVersion, minimumSupportedVersion) || other.minimumSupportedVersion == minimumSupportedVersion)&&(identical(other.updateUrl, updateUrl) || other.updateUrl == updateUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updateRequired,updateType,latestVersion,minimumSupportedVersion,updateUrl,title,message);

@override
String toString() {
  return 'AppUpdateDataDto(updateRequired: $updateRequired, updateType: $updateType, latestVersion: $latestVersion, minimumSupportedVersion: $minimumSupportedVersion, updateUrl: $updateUrl, title: $title, message: $message)';
}


}

/// @nodoc
abstract mixin class $AppUpdateDataDtoCopyWith<$Res>  {
  factory $AppUpdateDataDtoCopyWith(AppUpdateDataDto value, $Res Function(AppUpdateDataDto) _then) = _$AppUpdateDataDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'update_required') bool? updateRequired,@JsonKey(name: 'update_type') String? updateType,@JsonKey(name: 'latest_version') String? latestVersion,@JsonKey(name: 'minimum_supported_version') String? minimumSupportedVersion,@JsonKey(name: 'update_url') String? updateUrl,@JsonKey(name: 'title') String? title,@JsonKey(name: 'message') String? message
});




}
/// @nodoc
class _$AppUpdateDataDtoCopyWithImpl<$Res>
    implements $AppUpdateDataDtoCopyWith<$Res> {
  _$AppUpdateDataDtoCopyWithImpl(this._self, this._then);

  final AppUpdateDataDto _self;
  final $Res Function(AppUpdateDataDto) _then;

/// Create a copy of AppUpdateDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? updateRequired = freezed,Object? updateType = freezed,Object? latestVersion = freezed,Object? minimumSupportedVersion = freezed,Object? updateUrl = freezed,Object? title = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
updateRequired: freezed == updateRequired ? _self.updateRequired : updateRequired // ignore: cast_nullable_to_non_nullable
as bool?,updateType: freezed == updateType ? _self.updateType : updateType // ignore: cast_nullable_to_non_nullable
as String?,latestVersion: freezed == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String?,minimumSupportedVersion: freezed == minimumSupportedVersion ? _self.minimumSupportedVersion : minimumSupportedVersion // ignore: cast_nullable_to_non_nullable
as String?,updateUrl: freezed == updateUrl ? _self.updateUrl : updateUrl // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUpdateDataDto].
extension AppUpdateDataDtoPatterns on AppUpdateDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUpdateDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUpdateDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUpdateDataDto value)  $default,){
final _that = this;
switch (_that) {
case _AppUpdateDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUpdateDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _AppUpdateDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'update_required')  bool? updateRequired, @JsonKey(name: 'update_type')  String? updateType, @JsonKey(name: 'latest_version')  String? latestVersion, @JsonKey(name: 'minimum_supported_version')  String? minimumSupportedVersion, @JsonKey(name: 'update_url')  String? updateUrl, @JsonKey(name: 'title')  String? title, @JsonKey(name: 'message')  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUpdateDataDto() when $default != null:
return $default(_that.updateRequired,_that.updateType,_that.latestVersion,_that.minimumSupportedVersion,_that.updateUrl,_that.title,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'update_required')  bool? updateRequired, @JsonKey(name: 'update_type')  String? updateType, @JsonKey(name: 'latest_version')  String? latestVersion, @JsonKey(name: 'minimum_supported_version')  String? minimumSupportedVersion, @JsonKey(name: 'update_url')  String? updateUrl, @JsonKey(name: 'title')  String? title, @JsonKey(name: 'message')  String? message)  $default,) {final _that = this;
switch (_that) {
case _AppUpdateDataDto():
return $default(_that.updateRequired,_that.updateType,_that.latestVersion,_that.minimumSupportedVersion,_that.updateUrl,_that.title,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'update_required')  bool? updateRequired, @JsonKey(name: 'update_type')  String? updateType, @JsonKey(name: 'latest_version')  String? latestVersion, @JsonKey(name: 'minimum_supported_version')  String? minimumSupportedVersion, @JsonKey(name: 'update_url')  String? updateUrl, @JsonKey(name: 'title')  String? title, @JsonKey(name: 'message')  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AppUpdateDataDto() when $default != null:
return $default(_that.updateRequired,_that.updateType,_that.latestVersion,_that.minimumSupportedVersion,_that.updateUrl,_that.title,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppUpdateDataDto extends AppUpdateDataDto {
  const _AppUpdateDataDto({@JsonKey(name: 'update_required') this.updateRequired, @JsonKey(name: 'update_type') this.updateType, @JsonKey(name: 'latest_version') this.latestVersion, @JsonKey(name: 'minimum_supported_version') this.minimumSupportedVersion, @JsonKey(name: 'update_url') this.updateUrl, @JsonKey(name: 'title') this.title, @JsonKey(name: 'message') this.message}): super._();
  factory _AppUpdateDataDto.fromJson(Map<String, dynamic> json) => _$AppUpdateDataDtoFromJson(json);

@override@JsonKey(name: 'update_required') final  bool? updateRequired;
@override@JsonKey(name: 'update_type') final  String? updateType;
@override@JsonKey(name: 'latest_version') final  String? latestVersion;
@override@JsonKey(name: 'minimum_supported_version') final  String? minimumSupportedVersion;
@override@JsonKey(name: 'update_url') final  String? updateUrl;
@override@JsonKey(name: 'title') final  String? title;
@override@JsonKey(name: 'message') final  String? message;

/// Create a copy of AppUpdateDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUpdateDataDtoCopyWith<_AppUpdateDataDto> get copyWith => __$AppUpdateDataDtoCopyWithImpl<_AppUpdateDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUpdateDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUpdateDataDto&&(identical(other.updateRequired, updateRequired) || other.updateRequired == updateRequired)&&(identical(other.updateType, updateType) || other.updateType == updateType)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.minimumSupportedVersion, minimumSupportedVersion) || other.minimumSupportedVersion == minimumSupportedVersion)&&(identical(other.updateUrl, updateUrl) || other.updateUrl == updateUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updateRequired,updateType,latestVersion,minimumSupportedVersion,updateUrl,title,message);

@override
String toString() {
  return 'AppUpdateDataDto(updateRequired: $updateRequired, updateType: $updateType, latestVersion: $latestVersion, minimumSupportedVersion: $minimumSupportedVersion, updateUrl: $updateUrl, title: $title, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AppUpdateDataDtoCopyWith<$Res> implements $AppUpdateDataDtoCopyWith<$Res> {
  factory _$AppUpdateDataDtoCopyWith(_AppUpdateDataDto value, $Res Function(_AppUpdateDataDto) _then) = __$AppUpdateDataDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'update_required') bool? updateRequired,@JsonKey(name: 'update_type') String? updateType,@JsonKey(name: 'latest_version') String? latestVersion,@JsonKey(name: 'minimum_supported_version') String? minimumSupportedVersion,@JsonKey(name: 'update_url') String? updateUrl,@JsonKey(name: 'title') String? title,@JsonKey(name: 'message') String? message
});




}
/// @nodoc
class __$AppUpdateDataDtoCopyWithImpl<$Res>
    implements _$AppUpdateDataDtoCopyWith<$Res> {
  __$AppUpdateDataDtoCopyWithImpl(this._self, this._then);

  final _AppUpdateDataDto _self;
  final $Res Function(_AppUpdateDataDto) _then;

/// Create a copy of AppUpdateDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? updateRequired = freezed,Object? updateType = freezed,Object? latestVersion = freezed,Object? minimumSupportedVersion = freezed,Object? updateUrl = freezed,Object? title = freezed,Object? message = freezed,}) {
  return _then(_AppUpdateDataDto(
updateRequired: freezed == updateRequired ? _self.updateRequired : updateRequired // ignore: cast_nullable_to_non_nullable
as bool?,updateType: freezed == updateType ? _self.updateType : updateType // ignore: cast_nullable_to_non_nullable
as String?,latestVersion: freezed == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String?,minimumSupportedVersion: freezed == minimumSupportedVersion ? _self.minimumSupportedVersion : minimumSupportedVersion // ignore: cast_nullable_to_non_nullable
as String?,updateUrl: freezed == updateUrl ? _self.updateUrl : updateUrl // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
