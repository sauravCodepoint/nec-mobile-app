// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_contact_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SupportContactDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "status_code") int? get statusCode;@JsonKey(name: "data") SupportContactData? get data;@JsonKey(name: "time_stamp") String? get timeStamp;@JsonKey(name: "version") String? get version;
/// Create a copy of SupportContactDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportContactDtoCopyWith<SupportContactDto> get copyWith => _$SupportContactDtoCopyWithImpl<SupportContactDto>(this as SupportContactDto, _$identity);

  /// Serializes this SupportContactDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportContactDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,data,timeStamp,version);

@override
String toString() {
  return 'SupportContactDto(success: $success, statusCode: $statusCode, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class $SupportContactDtoCopyWith<$Res>  {
  factory $SupportContactDtoCopyWith(SupportContactDto value, $Res Function(SupportContactDto) _then) = _$SupportContactDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "data") SupportContactData? data,@JsonKey(name: "time_stamp") String? timeStamp,@JsonKey(name: "version") String? version
});


$SupportContactDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$SupportContactDtoCopyWithImpl<$Res>
    implements $SupportContactDtoCopyWith<$Res> {
  _$SupportContactDtoCopyWithImpl(this._self, this._then);

  final SupportContactDto _self;
  final $Res Function(SupportContactDto) _then;

/// Create a copy of SupportContactDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? statusCode = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SupportContactData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SupportContactDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportContactDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SupportContactDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SupportContactDto].
extension SupportContactDtoPatterns on SupportContactDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportContactDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportContactDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportContactDto value)  $default,){
final _that = this;
switch (_that) {
case _SupportContactDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportContactDto value)?  $default,){
final _that = this;
switch (_that) {
case _SupportContactDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "data")  SupportContactData? data, @JsonKey(name: "time_stamp")  String? timeStamp, @JsonKey(name: "version")  String? version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportContactDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "data")  SupportContactData? data, @JsonKey(name: "time_stamp")  String? timeStamp, @JsonKey(name: "version")  String? version)  $default,) {final _that = this;
switch (_that) {
case _SupportContactDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "data")  SupportContactData? data, @JsonKey(name: "time_stamp")  String? timeStamp, @JsonKey(name: "version")  String? version)?  $default,) {final _that = this;
switch (_that) {
case _SupportContactDto() when $default != null:
return $default(_that.success,_that.statusCode,_that.data,_that.timeStamp,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportContactDto implements SupportContactDto {
  const _SupportContactDto({@JsonKey(name: "success") this.success, @JsonKey(name: "status_code") this.statusCode, @JsonKey(name: "data") this.data, @JsonKey(name: "time_stamp") this.timeStamp, @JsonKey(name: "version") this.version});
  factory _SupportContactDto.fromJson(Map<String, dynamic> json) => _$SupportContactDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "status_code") final  int? statusCode;
@override@JsonKey(name: "data") final  SupportContactData? data;
@override@JsonKey(name: "time_stamp") final  String? timeStamp;
@override@JsonKey(name: "version") final  String? version;

/// Create a copy of SupportContactDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportContactDtoCopyWith<_SupportContactDto> get copyWith => __$SupportContactDtoCopyWithImpl<_SupportContactDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportContactDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportContactDto&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.data, data) || other.data == data)&&(identical(other.timeStamp, timeStamp) || other.timeStamp == timeStamp)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,statusCode,data,timeStamp,version);

@override
String toString() {
  return 'SupportContactDto(success: $success, statusCode: $statusCode, data: $data, timeStamp: $timeStamp, version: $version)';
}


}

/// @nodoc
abstract mixin class _$SupportContactDtoCopyWith<$Res> implements $SupportContactDtoCopyWith<$Res> {
  factory _$SupportContactDtoCopyWith(_SupportContactDto value, $Res Function(_SupportContactDto) _then) = __$SupportContactDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "data") SupportContactData? data,@JsonKey(name: "time_stamp") String? timeStamp,@JsonKey(name: "version") String? version
});


@override $SupportContactDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$SupportContactDtoCopyWithImpl<$Res>
    implements _$SupportContactDtoCopyWith<$Res> {
  __$SupportContactDtoCopyWithImpl(this._self, this._then);

  final _SupportContactDto _self;
  final $Res Function(_SupportContactDto) _then;

/// Create a copy of SupportContactDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? statusCode = freezed,Object? data = freezed,Object? timeStamp = freezed,Object? version = freezed,}) {
  return _then(_SupportContactDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SupportContactData?,timeStamp: freezed == timeStamp ? _self.timeStamp : timeStamp // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SupportContactDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportContactDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SupportContactDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SupportContactData {

@JsonKey(name: "screen_title") String? get screenTitle;@JsonKey(name: "section_title") String? get sectionTitle;@JsonKey(name: "header") SupportContactHeader? get header;@JsonKey(name: "channels") List<SupportContactChannel>? get channels;@JsonKey(name: "footer") String? get footer;
/// Create a copy of SupportContactData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportContactDataCopyWith<SupportContactData> get copyWith => _$SupportContactDataCopyWithImpl<SupportContactData>(this as SupportContactData, _$identity);

  /// Serializes this SupportContactData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportContactData&&(identical(other.screenTitle, screenTitle) || other.screenTitle == screenTitle)&&(identical(other.sectionTitle, sectionTitle) || other.sectionTitle == sectionTitle)&&(identical(other.header, header) || other.header == header)&&const DeepCollectionEquality().equals(other.channels, channels)&&(identical(other.footer, footer) || other.footer == footer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,screenTitle,sectionTitle,header,const DeepCollectionEquality().hash(channels),footer);

@override
String toString() {
  return 'SupportContactData(screenTitle: $screenTitle, sectionTitle: $sectionTitle, header: $header, channels: $channels, footer: $footer)';
}


}

/// @nodoc
abstract mixin class $SupportContactDataCopyWith<$Res>  {
  factory $SupportContactDataCopyWith(SupportContactData value, $Res Function(SupportContactData) _then) = _$SupportContactDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "screen_title") String? screenTitle,@JsonKey(name: "section_title") String? sectionTitle,@JsonKey(name: "header") SupportContactHeader? header,@JsonKey(name: "channels") List<SupportContactChannel>? channels,@JsonKey(name: "footer") String? footer
});


$SupportContactHeaderCopyWith<$Res>? get header;

}
/// @nodoc
class _$SupportContactDataCopyWithImpl<$Res>
    implements $SupportContactDataCopyWith<$Res> {
  _$SupportContactDataCopyWithImpl(this._self, this._then);

  final SupportContactData _self;
  final $Res Function(SupportContactData) _then;

/// Create a copy of SupportContactData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? screenTitle = freezed,Object? sectionTitle = freezed,Object? header = freezed,Object? channels = freezed,Object? footer = freezed,}) {
  return _then(_self.copyWith(
screenTitle: freezed == screenTitle ? _self.screenTitle : screenTitle // ignore: cast_nullable_to_non_nullable
as String?,sectionTitle: freezed == sectionTitle ? _self.sectionTitle : sectionTitle // ignore: cast_nullable_to_non_nullable
as String?,header: freezed == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as SupportContactHeader?,channels: freezed == channels ? _self.channels : channels // ignore: cast_nullable_to_non_nullable
as List<SupportContactChannel>?,footer: freezed == footer ? _self.footer : footer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SupportContactData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportContactHeaderCopyWith<$Res>? get header {
    if (_self.header == null) {
    return null;
  }

  return $SupportContactHeaderCopyWith<$Res>(_self.header!, (value) {
    return _then(_self.copyWith(header: value));
  });
}
}


/// Adds pattern-matching-related methods to [SupportContactData].
extension SupportContactDataPatterns on SupportContactData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportContactData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportContactData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportContactData value)  $default,){
final _that = this;
switch (_that) {
case _SupportContactData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportContactData value)?  $default,){
final _that = this;
switch (_that) {
case _SupportContactData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "screen_title")  String? screenTitle, @JsonKey(name: "section_title")  String? sectionTitle, @JsonKey(name: "header")  SupportContactHeader? header, @JsonKey(name: "channels")  List<SupportContactChannel>? channels, @JsonKey(name: "footer")  String? footer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportContactData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "screen_title")  String? screenTitle, @JsonKey(name: "section_title")  String? sectionTitle, @JsonKey(name: "header")  SupportContactHeader? header, @JsonKey(name: "channels")  List<SupportContactChannel>? channels, @JsonKey(name: "footer")  String? footer)  $default,) {final _that = this;
switch (_that) {
case _SupportContactData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "screen_title")  String? screenTitle, @JsonKey(name: "section_title")  String? sectionTitle, @JsonKey(name: "header")  SupportContactHeader? header, @JsonKey(name: "channels")  List<SupportContactChannel>? channels, @JsonKey(name: "footer")  String? footer)?  $default,) {final _that = this;
switch (_that) {
case _SupportContactData() when $default != null:
return $default(_that.screenTitle,_that.sectionTitle,_that.header,_that.channels,_that.footer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportContactData implements SupportContactData {
  const _SupportContactData({@JsonKey(name: "screen_title") this.screenTitle, @JsonKey(name: "section_title") this.sectionTitle, @JsonKey(name: "header") this.header, @JsonKey(name: "channels") final  List<SupportContactChannel>? channels, @JsonKey(name: "footer") this.footer}): _channels = channels;
  factory _SupportContactData.fromJson(Map<String, dynamic> json) => _$SupportContactDataFromJson(json);

@override@JsonKey(name: "screen_title") final  String? screenTitle;
@override@JsonKey(name: "section_title") final  String? sectionTitle;
@override@JsonKey(name: "header") final  SupportContactHeader? header;
 final  List<SupportContactChannel>? _channels;
@override@JsonKey(name: "channels") List<SupportContactChannel>? get channels {
  final value = _channels;
  if (value == null) return null;
  if (_channels is EqualUnmodifiableListView) return _channels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "footer") final  String? footer;

/// Create a copy of SupportContactData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportContactDataCopyWith<_SupportContactData> get copyWith => __$SupportContactDataCopyWithImpl<_SupportContactData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportContactDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportContactData&&(identical(other.screenTitle, screenTitle) || other.screenTitle == screenTitle)&&(identical(other.sectionTitle, sectionTitle) || other.sectionTitle == sectionTitle)&&(identical(other.header, header) || other.header == header)&&const DeepCollectionEquality().equals(other._channels, _channels)&&(identical(other.footer, footer) || other.footer == footer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,screenTitle,sectionTitle,header,const DeepCollectionEquality().hash(_channels),footer);

@override
String toString() {
  return 'SupportContactData(screenTitle: $screenTitle, sectionTitle: $sectionTitle, header: $header, channels: $channels, footer: $footer)';
}


}

/// @nodoc
abstract mixin class _$SupportContactDataCopyWith<$Res> implements $SupportContactDataCopyWith<$Res> {
  factory _$SupportContactDataCopyWith(_SupportContactData value, $Res Function(_SupportContactData) _then) = __$SupportContactDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "screen_title") String? screenTitle,@JsonKey(name: "section_title") String? sectionTitle,@JsonKey(name: "header") SupportContactHeader? header,@JsonKey(name: "channels") List<SupportContactChannel>? channels,@JsonKey(name: "footer") String? footer
});


@override $SupportContactHeaderCopyWith<$Res>? get header;

}
/// @nodoc
class __$SupportContactDataCopyWithImpl<$Res>
    implements _$SupportContactDataCopyWith<$Res> {
  __$SupportContactDataCopyWithImpl(this._self, this._then);

  final _SupportContactData _self;
  final $Res Function(_SupportContactData) _then;

/// Create a copy of SupportContactData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? screenTitle = freezed,Object? sectionTitle = freezed,Object? header = freezed,Object? channels = freezed,Object? footer = freezed,}) {
  return _then(_SupportContactData(
screenTitle: freezed == screenTitle ? _self.screenTitle : screenTitle // ignore: cast_nullable_to_non_nullable
as String?,sectionTitle: freezed == sectionTitle ? _self.sectionTitle : sectionTitle // ignore: cast_nullable_to_non_nullable
as String?,header: freezed == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as SupportContactHeader?,channels: freezed == channels ? _self._channels : channels // ignore: cast_nullable_to_non_nullable
as List<SupportContactChannel>?,footer: freezed == footer ? _self.footer : footer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SupportContactData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportContactHeaderCopyWith<$Res>? get header {
    if (_self.header == null) {
    return null;
  }

  return $SupportContactHeaderCopyWith<$Res>(_self.header!, (value) {
    return _then(_self.copyWith(header: value));
  });
}
}


/// @nodoc
mixin _$SupportContactHeader {

@JsonKey(name: "title") String? get title;@JsonKey(name: "subtitle") String? get subtitle;@JsonKey(name: "is_online") bool? get isOnline;@JsonKey(name: "online_label") String? get onlineLabel;
/// Create a copy of SupportContactHeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportContactHeaderCopyWith<SupportContactHeader> get copyWith => _$SupportContactHeaderCopyWithImpl<SupportContactHeader>(this as SupportContactHeader, _$identity);

  /// Serializes this SupportContactHeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportContactHeader&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.onlineLabel, onlineLabel) || other.onlineLabel == onlineLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,subtitle,isOnline,onlineLabel);

@override
String toString() {
  return 'SupportContactHeader(title: $title, subtitle: $subtitle, isOnline: $isOnline, onlineLabel: $onlineLabel)';
}


}

/// @nodoc
abstract mixin class $SupportContactHeaderCopyWith<$Res>  {
  factory $SupportContactHeaderCopyWith(SupportContactHeader value, $Res Function(SupportContactHeader) _then) = _$SupportContactHeaderCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "title") String? title,@JsonKey(name: "subtitle") String? subtitle,@JsonKey(name: "is_online") bool? isOnline,@JsonKey(name: "online_label") String? onlineLabel
});




}
/// @nodoc
class _$SupportContactHeaderCopyWithImpl<$Res>
    implements $SupportContactHeaderCopyWith<$Res> {
  _$SupportContactHeaderCopyWithImpl(this._self, this._then);

  final SupportContactHeader _self;
  final $Res Function(SupportContactHeader) _then;

/// Create a copy of SupportContactHeader
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


/// Adds pattern-matching-related methods to [SupportContactHeader].
extension SupportContactHeaderPatterns on SupportContactHeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportContactHeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportContactHeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportContactHeader value)  $default,){
final _that = this;
switch (_that) {
case _SupportContactHeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportContactHeader value)?  $default,){
final _that = this;
switch (_that) {
case _SupportContactHeader() when $default != null:
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
case _SupportContactHeader() when $default != null:
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
case _SupportContactHeader():
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
case _SupportContactHeader() when $default != null:
return $default(_that.title,_that.subtitle,_that.isOnline,_that.onlineLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportContactHeader implements SupportContactHeader {
  const _SupportContactHeader({@JsonKey(name: "title") this.title, @JsonKey(name: "subtitle") this.subtitle, @JsonKey(name: "is_online") this.isOnline, @JsonKey(name: "online_label") this.onlineLabel});
  factory _SupportContactHeader.fromJson(Map<String, dynamic> json) => _$SupportContactHeaderFromJson(json);

@override@JsonKey(name: "title") final  String? title;
@override@JsonKey(name: "subtitle") final  String? subtitle;
@override@JsonKey(name: "is_online") final  bool? isOnline;
@override@JsonKey(name: "online_label") final  String? onlineLabel;

/// Create a copy of SupportContactHeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportContactHeaderCopyWith<_SupportContactHeader> get copyWith => __$SupportContactHeaderCopyWithImpl<_SupportContactHeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportContactHeaderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportContactHeader&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.onlineLabel, onlineLabel) || other.onlineLabel == onlineLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,subtitle,isOnline,onlineLabel);

@override
String toString() {
  return 'SupportContactHeader(title: $title, subtitle: $subtitle, isOnline: $isOnline, onlineLabel: $onlineLabel)';
}


}

/// @nodoc
abstract mixin class _$SupportContactHeaderCopyWith<$Res> implements $SupportContactHeaderCopyWith<$Res> {
  factory _$SupportContactHeaderCopyWith(_SupportContactHeader value, $Res Function(_SupportContactHeader) _then) = __$SupportContactHeaderCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "title") String? title,@JsonKey(name: "subtitle") String? subtitle,@JsonKey(name: "is_online") bool? isOnline,@JsonKey(name: "online_label") String? onlineLabel
});




}
/// @nodoc
class __$SupportContactHeaderCopyWithImpl<$Res>
    implements _$SupportContactHeaderCopyWith<$Res> {
  __$SupportContactHeaderCopyWithImpl(this._self, this._then);

  final _SupportContactHeader _self;
  final $Res Function(_SupportContactHeader) _then;

/// Create a copy of SupportContactHeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? subtitle = freezed,Object? isOnline = freezed,Object? onlineLabel = freezed,}) {
  return _then(_SupportContactHeader(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool?,onlineLabel: freezed == onlineLabel ? _self.onlineLabel : onlineLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SupportContactChannel {

@JsonKey(name: "id") String? get id;@JsonKey(name: "type") String? get type;@JsonKey(name: "action_type") String? get actionType;@JsonKey(name: "title") String? get title;@JsonKey(name: "subtitle") String? get subtitle;@JsonKey(name: "value") List<String>? get value;@JsonKey(name: "display_value") List<String>? get displayValue;@JsonKey(name: "prefilled_message") String? get prefilledMessage;@JsonKey(name: "email_subject") String? get emailSubject;@JsonKey(name: "is_enabled") bool? get isEnabled;@JsonKey(name: "order") int? get order;
/// Create a copy of SupportContactChannel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportContactChannelCopyWith<SupportContactChannel> get copyWith => _$SupportContactChannelCopyWithImpl<SupportContactChannel>(this as SupportContactChannel, _$identity);

  /// Serializes this SupportContactChannel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportContactChannel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other.value, value)&&const DeepCollectionEquality().equals(other.displayValue, displayValue)&&(identical(other.prefilledMessage, prefilledMessage) || other.prefilledMessage == prefilledMessage)&&(identical(other.emailSubject, emailSubject) || other.emailSubject == emailSubject)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,actionType,title,subtitle,const DeepCollectionEquality().hash(value),const DeepCollectionEquality().hash(displayValue),prefilledMessage,emailSubject,isEnabled,order);

@override
String toString() {
  return 'SupportContactChannel(id: $id, type: $type, actionType: $actionType, title: $title, subtitle: $subtitle, value: $value, displayValue: $displayValue, prefilledMessage: $prefilledMessage, emailSubject: $emailSubject, isEnabled: $isEnabled, order: $order)';
}


}

/// @nodoc
abstract mixin class $SupportContactChannelCopyWith<$Res>  {
  factory $SupportContactChannelCopyWith(SupportContactChannel value, $Res Function(SupportContactChannel) _then) = _$SupportContactChannelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") String? id,@JsonKey(name: "type") String? type,@JsonKey(name: "action_type") String? actionType,@JsonKey(name: "title") String? title,@JsonKey(name: "subtitle") String? subtitle,@JsonKey(name: "value") List<String>? value,@JsonKey(name: "display_value") List<String>? displayValue,@JsonKey(name: "prefilled_message") String? prefilledMessage,@JsonKey(name: "email_subject") String? emailSubject,@JsonKey(name: "is_enabled") bool? isEnabled,@JsonKey(name: "order") int? order
});




}
/// @nodoc
class _$SupportContactChannelCopyWithImpl<$Res>
    implements $SupportContactChannelCopyWith<$Res> {
  _$SupportContactChannelCopyWithImpl(this._self, this._then);

  final SupportContactChannel _self;
  final $Res Function(SupportContactChannel) _then;

/// Create a copy of SupportContactChannel
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


/// Adds pattern-matching-related methods to [SupportContactChannel].
extension SupportContactChannelPatterns on SupportContactChannel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportContactChannel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportContactChannel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportContactChannel value)  $default,){
final _that = this;
switch (_that) {
case _SupportContactChannel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportContactChannel value)?  $default,){
final _that = this;
switch (_that) {
case _SupportContactChannel() when $default != null:
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
case _SupportContactChannel() when $default != null:
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
case _SupportContactChannel():
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
case _SupportContactChannel() when $default != null:
return $default(_that.id,_that.type,_that.actionType,_that.title,_that.subtitle,_that.value,_that.displayValue,_that.prefilledMessage,_that.emailSubject,_that.isEnabled,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportContactChannel implements SupportContactChannel {
  const _SupportContactChannel({@JsonKey(name: "id") this.id, @JsonKey(name: "type") this.type, @JsonKey(name: "action_type") this.actionType, @JsonKey(name: "title") this.title, @JsonKey(name: "subtitle") this.subtitle, @JsonKey(name: "value") final  List<String>? value, @JsonKey(name: "display_value") final  List<String>? displayValue, @JsonKey(name: "prefilled_message") this.prefilledMessage, @JsonKey(name: "email_subject") this.emailSubject, @JsonKey(name: "is_enabled") this.isEnabled, @JsonKey(name: "order") this.order}): _value = value,_displayValue = displayValue;
  factory _SupportContactChannel.fromJson(Map<String, dynamic> json) => _$SupportContactChannelFromJson(json);

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

/// Create a copy of SupportContactChannel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportContactChannelCopyWith<_SupportContactChannel> get copyWith => __$SupportContactChannelCopyWithImpl<_SupportContactChannel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportContactChannelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportContactChannel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other._value, _value)&&const DeepCollectionEquality().equals(other._displayValue, _displayValue)&&(identical(other.prefilledMessage, prefilledMessage) || other.prefilledMessage == prefilledMessage)&&(identical(other.emailSubject, emailSubject) || other.emailSubject == emailSubject)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,actionType,title,subtitle,const DeepCollectionEquality().hash(_value),const DeepCollectionEquality().hash(_displayValue),prefilledMessage,emailSubject,isEnabled,order);

@override
String toString() {
  return 'SupportContactChannel(id: $id, type: $type, actionType: $actionType, title: $title, subtitle: $subtitle, value: $value, displayValue: $displayValue, prefilledMessage: $prefilledMessage, emailSubject: $emailSubject, isEnabled: $isEnabled, order: $order)';
}


}

/// @nodoc
abstract mixin class _$SupportContactChannelCopyWith<$Res> implements $SupportContactChannelCopyWith<$Res> {
  factory _$SupportContactChannelCopyWith(_SupportContactChannel value, $Res Function(_SupportContactChannel) _then) = __$SupportContactChannelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") String? id,@JsonKey(name: "type") String? type,@JsonKey(name: "action_type") String? actionType,@JsonKey(name: "title") String? title,@JsonKey(name: "subtitle") String? subtitle,@JsonKey(name: "value") List<String>? value,@JsonKey(name: "display_value") List<String>? displayValue,@JsonKey(name: "prefilled_message") String? prefilledMessage,@JsonKey(name: "email_subject") String? emailSubject,@JsonKey(name: "is_enabled") bool? isEnabled,@JsonKey(name: "order") int? order
});




}
/// @nodoc
class __$SupportContactChannelCopyWithImpl<$Res>
    implements _$SupportContactChannelCopyWith<$Res> {
  __$SupportContactChannelCopyWithImpl(this._self, this._then);

  final _SupportContactChannel _self;
  final $Res Function(_SupportContactChannel) _then;

/// Create a copy of SupportContactChannel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = freezed,Object? actionType = freezed,Object? title = freezed,Object? subtitle = freezed,Object? value = freezed,Object? displayValue = freezed,Object? prefilledMessage = freezed,Object? emailSubject = freezed,Object? isEnabled = freezed,Object? order = freezed,}) {
  return _then(_SupportContactChannel(
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
