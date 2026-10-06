// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_contact_us_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContactUsDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "status_code") int? get statusCode;@JsonKey(name: "data") ContactUsData? get data;@JsonKey(name: "time_stamp") String? get timeStamp;@JsonKey(name: "version") String? get version;
/// Create a copy of ContactUsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactUsDtoCopyWith<ContactUsDto> get copyWith => _$ContactUsDtoCopyWithImpl<ContactUsDto>(this as ContactUsDto, _$identity);

  /// Serializes this ContactUsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactUsDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,data,timeStamp,version);

@override
String toString() {
  return 'ContactUsDto(success: $success, statusCode: $statusCode, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class $ContactUsDtoCopyWith<$Res>  {
  factory $ContactUsDtoCopyWith(ContactUsDto value, $Res Function(ContactUsDto) _then) = _$ContactUsDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "data") ContactUsData? data,@JsonKey(name: "time_stamp") String? timeStamp,@JsonKey(name: "version") String? version
});


$ContactUsDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$ContactUsDtoCopyWithImpl<$Res>
    implements $ContactUsDtoCopyWith<$Res> {
  _$ContactUsDtoCopyWithImpl(this._self, this._then);

  final ContactUsDto _self;
  final $Res Function(ContactUsDto) _then;

/// Create a copy of ContactUsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? statusCode = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ContactUsData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ContactUsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContactUsDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ContactUsDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContactUsDto].
extension ContactUsDtoPatterns on ContactUsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactUsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactUsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactUsDto value)  $default,){
final _that = this;
switch (_that) {
case _ContactUsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactUsDto value)?  $default,){
final _that = this;
switch (_that) {
case _ContactUsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "data")  ContactUsData? data, @JsonKey(name: "time_stamp")  String? timeStamp, @JsonKey(name: "version")  String? version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactUsDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.data,_that.timeStamp,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "data")  ContactUsData? data, @JsonKey(name: "time_stamp")  String? timeStamp, @JsonKey(name: "version")  String? version)  $default,) {final _that = this;
switch (_that) {
case _ContactUsDto():
return $default(_that.success,_that.statusCode,_that.data,_that.timeStamp,_that.version);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "data")  ContactUsData? data, @JsonKey(name: "time_stamp")  String? timeStamp, @JsonKey(name: "version")  String? version)?  $default,) {final _that = this;
switch (_that) {
case _ContactUsDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.data,_that.timeStamp,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactUsDto implements ContactUsDto {
  const _ContactUsDto({@JsonKey(name: "success") this.success, @JsonKey(name: "status_code") this.statusCode, @JsonKey(name: "data") this.data, @JsonKey(name: "time_stamp") this.timeStamp, @JsonKey(name: "version") this.version});
  factory _ContactUsDto.fromJson(Map<String, dynamic> json) => _$ContactUsDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "status_code") final  int? statusCode;
@override@JsonKey(name: "data") final  ContactUsData? data;
@override@JsonKey(name: "time_stamp") final  String? timeStamp;
@override@JsonKey(name: "version") final  String? version;

/// Create a copy of ContactUsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactUsDtoCopyWith<_ContactUsDto> get copyWith => __$ContactUsDtoCopyWithImpl<_ContactUsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactUsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactUsDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,data,timeStamp,version);

@override
String toString() {
  return 'ContactUsDto(success: $success, statusCode: $statusCode, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class _$ContactUsDtoCopyWith<$Res> implements $ContactUsDtoCopyWith<$Res> {
  factory _$ContactUsDtoCopyWith(_ContactUsDto value, $Res Function(_ContactUsDto) _then) = __$ContactUsDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "data") ContactUsData? data,@JsonKey(name: "time_stamp") String? timeStamp,@JsonKey(name: "version") String? version
});


@override $ContactUsDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$ContactUsDtoCopyWithImpl<$Res>
    implements _$ContactUsDtoCopyWith<$Res> {
  __$ContactUsDtoCopyWithImpl(this._self, this._then);

  final _ContactUsDto _self;
  final $Res Function(_ContactUsDto) _then;

/// Create a copy of ContactUsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? statusCode = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_ContactUsDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ContactUsData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ContactUsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContactUsDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ContactUsDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ContactUsData {

@JsonKey(name: "screen_title") String? get screenTitle;@JsonKey(name: "section_title") String? get sectionTitle;@JsonKey(name: "header") ContactUsHeader? get header;@JsonKey(name: "channels") List<ContactChannel>? get channels;@JsonKey(name: "footer") String? get footer;
/// Create a copy of ContactUsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactUsDataCopyWith<ContactUsData> get copyWith => _$ContactUsDataCopyWithImpl<ContactUsData>(this as ContactUsData, _$identity);

  /// Serializes this ContactUsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactUsData&&(identical(other.screenTitle, screenTitle) || other.screenTitle == screenTitle)&&(identical(other.sectionTitle, sectionTitle) || other.sectionTitle == sectionTitle)&&(identical(other.header, header) || other.header == header)&&const DeepCollectionEquality().equals(other.channels, channels)&&(identical(other.footer, footer) || other.footer == footer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,screenTitle,sectionTitle,header,const DeepCollectionEquality().hash(channels),footer);

@override
String toString() {
  return 'ContactUsData(screenTitle: $screenTitle, sectionTitle: $sectionTitle, header: $header, channels: $channels, footer: $footer)';
}


}

/// @nodoc
abstract mixin class $ContactUsDataCopyWith<$Res>  {
  factory $ContactUsDataCopyWith(ContactUsData value, $Res Function(ContactUsData) _then) = _$ContactUsDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "screen_title") String? screenTitle,@JsonKey(name: "section_title") String? sectionTitle,@JsonKey(name: "header") ContactUsHeader? header,@JsonKey(name: "channels") List<ContactChannel>? channels,@JsonKey(name: "footer") String? footer
});


$ContactUsHeaderCopyWith<$Res>? get header;

}
/// @nodoc
class _$ContactUsDataCopyWithImpl<$Res>
    implements $ContactUsDataCopyWith<$Res> {
  _$ContactUsDataCopyWithImpl(this._self, this._then);

  final ContactUsData _self;
  final $Res Function(ContactUsData) _then;

/// Create a copy of ContactUsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? screenTitle = freezed,Object? sectionTitle = freezed,Object? header = freezed,Object? channels = freezed,Object? footer = freezed,}) {
  return _then(_self.copyWith(
screenTitle: freezed == screenTitle ? _self.screenTitle : screenTitle // ignore: cast_nullable_to_non_nullable
as String?,sectionTitle: freezed == sectionTitle ? _self.sectionTitle : sectionTitle // ignore: cast_nullable_to_non_nullable
as String?,header: freezed == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as ContactUsHeader?,channels: freezed == channels ? _self.channels : channels // ignore: cast_nullable_to_non_nullable
as List<ContactChannel>?,footer: freezed == footer ? _self.footer : footer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ContactUsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContactUsHeaderCopyWith<$Res>? get header {
    if (_self.header == null) {
    return null;
  }

  return $ContactUsHeaderCopyWith<$Res>(_self.header!, (value) {
    return _then(_self.copyWith(header: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContactUsData].
extension ContactUsDataPatterns on ContactUsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactUsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactUsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactUsData value)  $default,){
final _that = this;
switch (_that) {
case _ContactUsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactUsData value)?  $default,){
final _that = this;
switch (_that) {
case _ContactUsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "screen_title")  String? screenTitle, @JsonKey(name: "section_title")  String? sectionTitle, @JsonKey(name: "header")  ContactUsHeader? header, @JsonKey(name: "channels")  List<ContactChannel>? channels, @JsonKey(name: "footer")  String? footer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactUsData() when $default != null:
return $default(_that.screenTitle,_that.sectionTitle,_that.header,_that.channels,_that.footer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "screen_title")  String? screenTitle, @JsonKey(name: "section_title")  String? sectionTitle, @JsonKey(name: "header")  ContactUsHeader? header, @JsonKey(name: "channels")  List<ContactChannel>? channels, @JsonKey(name: "footer")  String? footer)  $default,) {final _that = this;
switch (_that) {
case _ContactUsData():
return $default(_that.screenTitle,_that.sectionTitle,_that.header,_that.channels,_that.footer);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "screen_title")  String? screenTitle, @JsonKey(name: "section_title")  String? sectionTitle, @JsonKey(name: "header")  ContactUsHeader? header, @JsonKey(name: "channels")  List<ContactChannel>? channels, @JsonKey(name: "footer")  String? footer)?  $default,) {final _that = this;
switch (_that) {
case _ContactUsData() when $default != null:
return $default(_that.screenTitle,_that.sectionTitle,_that.header,_that.channels,_that.footer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactUsData implements ContactUsData {
  const _ContactUsData({@JsonKey(name: "screen_title") this.screenTitle, @JsonKey(name: "section_title") this.sectionTitle, @JsonKey(name: "header") this.header, @JsonKey(name: "channels") final  List<ContactChannel>? channels, @JsonKey(name: "footer") this.footer}): _channels = channels;
  factory _ContactUsData.fromJson(Map<String, dynamic> json) => _$ContactUsDataFromJson(json);

@override@JsonKey(name: "screen_title") final  String? screenTitle;
@override@JsonKey(name: "section_title") final  String? sectionTitle;
@override@JsonKey(name: "header") final  ContactUsHeader? header;
 final  List<ContactChannel>? _channels;
@override@JsonKey(name: "channels") List<ContactChannel>? get channels {
  final value = _channels;
  if (value == null) return null;
  if (_channels is EqualUnmodifiableListView) return _channels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "footer") final  String? footer;

/// Create a copy of ContactUsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactUsDataCopyWith<_ContactUsData> get copyWith => __$ContactUsDataCopyWithImpl<_ContactUsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactUsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactUsData&&(identical(other.screenTitle, screenTitle) || other.screenTitle == screenTitle)&&(identical(other.sectionTitle, sectionTitle) || other.sectionTitle == sectionTitle)&&(identical(other.header, header) || other.header == header)&&const DeepCollectionEquality().equals(other._channels, _channels)&&(identical(other.footer, footer) || other.footer == footer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,screenTitle,sectionTitle,header,const DeepCollectionEquality().hash(_channels),footer);

@override
String toString() {
  return 'ContactUsData(screenTitle: $screenTitle, sectionTitle: $sectionTitle, header: $header, channels: $channels, footer: $footer)';
}


}

/// @nodoc
abstract mixin class _$ContactUsDataCopyWith<$Res> implements $ContactUsDataCopyWith<$Res> {
  factory _$ContactUsDataCopyWith(_ContactUsData value, $Res Function(_ContactUsData) _then) = __$ContactUsDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "screen_title") String? screenTitle,@JsonKey(name: "section_title") String? sectionTitle,@JsonKey(name: "header") ContactUsHeader? header,@JsonKey(name: "channels") List<ContactChannel>? channels,@JsonKey(name: "footer") String? footer
});


@override $ContactUsHeaderCopyWith<$Res>? get header;

}
/// @nodoc
class __$ContactUsDataCopyWithImpl<$Res>
    implements _$ContactUsDataCopyWith<$Res> {
  __$ContactUsDataCopyWithImpl(this._self, this._then);

  final _ContactUsData _self;
  final $Res Function(_ContactUsData) _then;

/// Create a copy of ContactUsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? screenTitle = freezed,Object? sectionTitle = freezed,Object? header = freezed,Object? channels = freezed,Object? footer = freezed,}) {
  return _then(_ContactUsData(
screenTitle: freezed == screenTitle ? _self.screenTitle : screenTitle // ignore: cast_nullable_to_non_nullable
as String?,sectionTitle: freezed == sectionTitle ? _self.sectionTitle : sectionTitle // ignore: cast_nullable_to_non_nullable
as String?,header: freezed == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as ContactUsHeader?,channels: freezed == channels ? _self._channels : channels // ignore: cast_nullable_to_non_nullable
as List<ContactChannel>?,footer: freezed == footer ? _self.footer : footer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ContactUsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContactUsHeaderCopyWith<$Res>? get header {
    if (_self.header == null) {
    return null;
  }

  return $ContactUsHeaderCopyWith<$Res>(_self.header!, (value) {
    return _then(_self.copyWith(header: value));
  });
}
}


/// @nodoc
mixin _$ContactUsHeader {

@JsonKey(name: "title") String? get title;@JsonKey(name: "subtitle") String? get subtitle;@JsonKey(name: "is_online") bool? get isOnline;@JsonKey(name: "online_label") String? get onlineLabel;
/// Create a copy of ContactUsHeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactUsHeaderCopyWith<ContactUsHeader> get copyWith => _$ContactUsHeaderCopyWithImpl<ContactUsHeader>(this as ContactUsHeader, _$identity);

  /// Serializes this ContactUsHeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactUsHeader&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.onlineLabel, onlineLabel) || other.onlineLabel == onlineLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,subtitle,isOnline,onlineLabel);

@override
String toString() {
  return 'ContactUsHeader(title: $title, subtitle: $subtitle, isOnline: $isOnline, onlineLabel: $onlineLabel)';
}


}

/// @nodoc
abstract mixin class $ContactUsHeaderCopyWith<$Res>  {
  factory $ContactUsHeaderCopyWith(ContactUsHeader value, $Res Function(ContactUsHeader) _then) = _$ContactUsHeaderCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "title") String? title,@JsonKey(name: "subtitle") String? subtitle,@JsonKey(name: "is_online") bool? isOnline,@JsonKey(name: "online_label") String? onlineLabel
});




}
/// @nodoc
class _$ContactUsHeaderCopyWithImpl<$Res>
    implements $ContactUsHeaderCopyWith<$Res> {
  _$ContactUsHeaderCopyWithImpl(this._self, this._then);

  final ContactUsHeader _self;
  final $Res Function(ContactUsHeader) _then;

/// Create a copy of ContactUsHeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? subtitle = freezed,Object? isOnline = freezed,Object? onlineLabel = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool?,onlineLabel: freezed == onlineLabel ? _self.onlineLabel : onlineLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactUsHeader].
extension ContactUsHeaderPatterns on ContactUsHeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactUsHeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactUsHeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactUsHeader value)  $default,){
final _that = this;
switch (_that) {
case _ContactUsHeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactUsHeader value)?  $default,){
final _that = this;
switch (_that) {
case _ContactUsHeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "title")  String? title, @JsonKey(name: "subtitle")  String? subtitle, @JsonKey(name: "is_online")  bool? isOnline, @JsonKey(name: "online_label")  String? onlineLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactUsHeader() when $default != null:
return $default(_that.title,_that.subtitle,_that.isOnline,_that.onlineLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "title")  String? title, @JsonKey(name: "subtitle")  String? subtitle, @JsonKey(name: "is_online")  bool? isOnline, @JsonKey(name: "online_label")  String? onlineLabel)  $default,) {final _that = this;
switch (_that) {
case _ContactUsHeader():
return $default(_that.title,_that.subtitle,_that.isOnline,_that.onlineLabel);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "title")  String? title, @JsonKey(name: "subtitle")  String? subtitle, @JsonKey(name: "is_online")  bool? isOnline, @JsonKey(name: "online_label")  String? onlineLabel)?  $default,) {final _that = this;
switch (_that) {
case _ContactUsHeader() when $default != null:
return $default(_that.title,_that.subtitle,_that.isOnline,_that.onlineLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactUsHeader implements ContactUsHeader {
  const _ContactUsHeader({@JsonKey(name: "title") this.title, @JsonKey(name: "subtitle") this.subtitle, @JsonKey(name: "is_online") this.isOnline, @JsonKey(name: "online_label") this.onlineLabel});
  factory _ContactUsHeader.fromJson(Map<String, dynamic> json) => _$ContactUsHeaderFromJson(json);

@override@JsonKey(name: "title") final  String? title;
@override@JsonKey(name: "subtitle") final  String? subtitle;
@override@JsonKey(name: "is_online") final  bool? isOnline;
@override@JsonKey(name: "online_label") final  String? onlineLabel;

/// Create a copy of ContactUsHeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactUsHeaderCopyWith<_ContactUsHeader> get copyWith => __$ContactUsHeaderCopyWithImpl<_ContactUsHeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactUsHeaderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactUsHeader&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.onlineLabel, onlineLabel) || other.onlineLabel == onlineLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,subtitle,isOnline,onlineLabel);

@override
String toString() {
  return 'ContactUsHeader(title: $title, subtitle: $subtitle, isOnline: $isOnline, onlineLabel: $onlineLabel)';
}


}

/// @nodoc
abstract mixin class _$ContactUsHeaderCopyWith<$Res> implements $ContactUsHeaderCopyWith<$Res> {
  factory _$ContactUsHeaderCopyWith(_ContactUsHeader value, $Res Function(_ContactUsHeader) _then) = __$ContactUsHeaderCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "title") String? title,@JsonKey(name: "subtitle") String? subtitle,@JsonKey(name: "is_online") bool? isOnline,@JsonKey(name: "online_label") String? onlineLabel
});




}
/// @nodoc
class __$ContactUsHeaderCopyWithImpl<$Res>
    implements _$ContactUsHeaderCopyWith<$Res> {
  __$ContactUsHeaderCopyWithImpl(this._self, this._then);

  final _ContactUsHeader _self;
  final $Res Function(_ContactUsHeader) _then;

/// Create a copy of ContactUsHeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? subtitle = freezed,Object? isOnline = freezed,Object? onlineLabel = freezed,}) {
  return _then(_ContactUsHeader(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool?,onlineLabel: freezed == onlineLabel ? _self.onlineLabel : onlineLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ContactChannel {

@JsonKey(name: "id") String? get id;@JsonKey(name: "type") String? get type;@JsonKey(name: "action_type") String? get actionType;@JsonKey(name: "title") String? get title;@JsonKey(name: "subtitle") String? get subtitle;@JsonKey(name: "value") List<String>? get value;@JsonKey(name: "display_value") List<String>? get displayValue;@JsonKey(name: "prefilled_message") String? get prefilledMessage;@JsonKey(name: "email_subject") String? get emailSubject;@JsonKey(name: "is_enabled") bool? get isEnabled;@JsonKey(name: "order") int? get order;
/// Create a copy of ContactChannel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactChannelCopyWith<ContactChannel> get copyWith => _$ContactChannelCopyWithImpl<ContactChannel>(this as ContactChannel, _$identity);

  /// Serializes this ContactChannel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactChannel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other.value, value)&&const DeepCollectionEquality().equals(other.displayValue, displayValue)&&(identical(other.prefilledMessage, prefilledMessage) || other.prefilledMessage == prefilledMessage)&&(identical(other.emailSubject, emailSubject) || other.emailSubject == emailSubject)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,actionType,title,subtitle,const DeepCollectionEquality().hash(value),const DeepCollectionEquality().hash(displayValue),prefilledMessage,emailSubject,isEnabled,order);

@override
String toString() {
  return 'ContactChannel(id: $id, type: $type, actionType: $actionType, title: $title, subtitle: $subtitle, value: $value, displayValue: $displayValue, prefilledMessage: $prefilledMessage, emailSubject: $emailSubject, isEnabled: $isEnabled, order: $order)';
}


}

/// @nodoc
abstract mixin class $ContactChannelCopyWith<$Res>  {
  factory $ContactChannelCopyWith(ContactChannel value, $Res Function(ContactChannel) _then) = _$ContactChannelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") String? id,@JsonKey(name: "type") String? type,@JsonKey(name: "action_type") String? actionType,@JsonKey(name: "title") String? title,@JsonKey(name: "subtitle") String? subtitle,@JsonKey(name: "value") List<String>? value,@JsonKey(name: "display_value") List<String>? displayValue,@JsonKey(name: "prefilled_message") String? prefilledMessage,@JsonKey(name: "email_subject") String? emailSubject,@JsonKey(name: "is_enabled") bool? isEnabled,@JsonKey(name: "order") int? order
});




}
/// @nodoc
class _$ContactChannelCopyWithImpl<$Res>
    implements $ContactChannelCopyWith<$Res> {
  _$ContactChannelCopyWithImpl(this._self, this._then);

  final ContactChannel _self;
  final $Res Function(ContactChannel) _then;

/// Create a copy of ContactChannel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? type = freezed,Object? actionType = freezed,Object? title = freezed,Object? subtitle = freezed,Object? value = freezed,Object? displayValue = freezed,Object? prefilledMessage = freezed,Object? emailSubject = freezed,Object? isEnabled = freezed,Object? order = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,actionType: freezed == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as List<String>?,displayValue: freezed == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as List<String>?,prefilledMessage: freezed == prefilledMessage ? _self.prefilledMessage : prefilledMessage // ignore: cast_nullable_to_non_nullable
as String?,emailSubject: freezed == emailSubject ? _self.emailSubject : emailSubject // ignore: cast_nullable_to_non_nullable
as String?,isEnabled: freezed == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactChannel].
extension ContactChannelPatterns on ContactChannel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactChannel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactChannel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactChannel value)  $default,){
final _that = this;
switch (_that) {
case _ContactChannel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactChannel value)?  $default,){
final _that = this;
switch (_that) {
case _ContactChannel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  String? id, @JsonKey(name: "type")  String? type, @JsonKey(name: "action_type")  String? actionType, @JsonKey(name: "title")  String? title, @JsonKey(name: "subtitle")  String? subtitle, @JsonKey(name: "value")  List<String>? value, @JsonKey(name: "display_value")  List<String>? displayValue, @JsonKey(name: "prefilled_message")  String? prefilledMessage, @JsonKey(name: "email_subject")  String? emailSubject, @JsonKey(name: "is_enabled")  bool? isEnabled, @JsonKey(name: "order")  int? order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactChannel() when $default != null:
return $default(_that.id,_that.type,_that.actionType,_that.title,_that.subtitle,_that.value,_that.displayValue,_that.prefilledMessage,_that.emailSubject,_that.isEnabled,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  String? id, @JsonKey(name: "type")  String? type, @JsonKey(name: "action_type")  String? actionType, @JsonKey(name: "title")  String? title, @JsonKey(name: "subtitle")  String? subtitle, @JsonKey(name: "value")  List<String>? value, @JsonKey(name: "display_value")  List<String>? displayValue, @JsonKey(name: "prefilled_message")  String? prefilledMessage, @JsonKey(name: "email_subject")  String? emailSubject, @JsonKey(name: "is_enabled")  bool? isEnabled, @JsonKey(name: "order")  int? order)  $default,) {final _that = this;
switch (_that) {
case _ContactChannel():
return $default(_that.id,_that.type,_that.actionType,_that.title,_that.subtitle,_that.value,_that.displayValue,_that.prefilledMessage,_that.emailSubject,_that.isEnabled,_that.order);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  String? id, @JsonKey(name: "type")  String? type, @JsonKey(name: "action_type")  String? actionType, @JsonKey(name: "title")  String? title, @JsonKey(name: "subtitle")  String? subtitle, @JsonKey(name: "value")  List<String>? value, @JsonKey(name: "display_value")  List<String>? displayValue, @JsonKey(name: "prefilled_message")  String? prefilledMessage, @JsonKey(name: "email_subject")  String? emailSubject, @JsonKey(name: "is_enabled")  bool? isEnabled, @JsonKey(name: "order")  int? order)?  $default,) {final _that = this;
switch (_that) {
case _ContactChannel() when $default != null:
return $default(_that.id,_that.type,_that.actionType,_that.title,_that.subtitle,_that.value,_that.displayValue,_that.prefilledMessage,_that.emailSubject,_that.isEnabled,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactChannel implements ContactChannel {
  const _ContactChannel({@JsonKey(name: "id") this.id, @JsonKey(name: "type") this.type, @JsonKey(name: "action_type") this.actionType, @JsonKey(name: "title") this.title, @JsonKey(name: "subtitle") this.subtitle, @JsonKey(name: "value") final  List<String>? value, @JsonKey(name: "display_value") final  List<String>? displayValue, @JsonKey(name: "prefilled_message") this.prefilledMessage, @JsonKey(name: "email_subject") this.emailSubject, @JsonKey(name: "is_enabled") this.isEnabled, @JsonKey(name: "order") this.order}): _value = value,_displayValue = displayValue;
  factory _ContactChannel.fromJson(Map<String, dynamic> json) => _$ContactChannelFromJson(json);

@override@JsonKey(name: "id") final  String? id;
@override@JsonKey(name: "type") final  String? type;
@override@JsonKey(name: "action_type") final  String? actionType;
@override@JsonKey(name: "title") final  String? title;
@override@JsonKey(name: "subtitle") final  String? subtitle;
 final  List<String>? _value;
@override@JsonKey(name: "value") List<String>? get value {
  final value = _value;
  if (value == null) return null;
  if (_value is EqualUnmodifiableListView) return _value;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _displayValue;
@override@JsonKey(name: "display_value") List<String>? get displayValue {
  final value = _displayValue;
  if (value == null) return null;
  if (_displayValue is EqualUnmodifiableListView) return _displayValue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "prefilled_message") final  String? prefilledMessage;
@override@JsonKey(name: "email_subject") final  String? emailSubject;
@override@JsonKey(name: "is_enabled") final  bool? isEnabled;
@override@JsonKey(name: "order") final  int? order;

/// Create a copy of ContactChannel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactChannelCopyWith<_ContactChannel> get copyWith => __$ContactChannelCopyWithImpl<_ContactChannel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactChannelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactChannel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other._value, _value)&&const DeepCollectionEquality().equals(other._displayValue, _displayValue)&&(identical(other.prefilledMessage, prefilledMessage) || other.prefilledMessage == prefilledMessage)&&(identical(other.emailSubject, emailSubject) || other.emailSubject == emailSubject)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,actionType,title,subtitle,const DeepCollectionEquality().hash(_value),const DeepCollectionEquality().hash(_displayValue),prefilledMessage,emailSubject,isEnabled,order);

@override
String toString() {
  return 'ContactChannel(id: $id, type: $type, actionType: $actionType, title: $title, subtitle: $subtitle, value: $value, displayValue: $displayValue, prefilledMessage: $prefilledMessage, emailSubject: $emailSubject, isEnabled: $isEnabled, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ContactChannelCopyWith<$Res> implements $ContactChannelCopyWith<$Res> {
  factory _$ContactChannelCopyWith(_ContactChannel value, $Res Function(_ContactChannel) _then) = __$ContactChannelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") String? id,@JsonKey(name: "type") String? type,@JsonKey(name: "action_type") String? actionType,@JsonKey(name: "title") String? title,@JsonKey(name: "subtitle") String? subtitle,@JsonKey(name: "value") List<String>? value,@JsonKey(name: "display_value") List<String>? displayValue,@JsonKey(name: "prefilled_message") String? prefilledMessage,@JsonKey(name: "email_subject") String? emailSubject,@JsonKey(name: "is_enabled") bool? isEnabled,@JsonKey(name: "order") int? order
});




}
/// @nodoc
class __$ContactChannelCopyWithImpl<$Res>
    implements _$ContactChannelCopyWith<$Res> {
  __$ContactChannelCopyWithImpl(this._self, this._then);

  final _ContactChannel _self;
  final $Res Function(_ContactChannel) _then;

/// Create a copy of ContactChannel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = freezed,Object? actionType = freezed,Object? title = freezed,Object? subtitle = freezed,Object? value = freezed,Object? displayValue = freezed,Object? prefilledMessage = freezed,Object? emailSubject = freezed,Object? isEnabled = freezed,Object? order = freezed,}) {
  return _then(_ContactChannel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,actionType: freezed == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self._value : value // ignore: cast_nullable_to_non_nullable
as List<String>?,displayValue: freezed == displayValue ? _self._displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as List<String>?,prefilledMessage: freezed == prefilledMessage ? _self.prefilledMessage : prefilledMessage // ignore: cast_nullable_to_non_nullable
as String?,emailSubject: freezed == emailSubject ? _self.emailSubject : emailSubject // ignore: cast_nullable_to_non_nullable
as String?,isEnabled: freezed == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool?,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
