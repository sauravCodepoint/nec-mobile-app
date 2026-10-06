// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_log_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuditLogEntryDto {

@JsonKey(name: "event") String get event;@JsonKey(name: "member_code") int get memberCode;@JsonKey(name: "mobile_number") String? get mobileNumber;@JsonKey(name: "request_id") String? get requestId;@JsonKey(name: "attempt") int get attempt;@JsonKey(name: "method") String get method;@JsonKey(name: "url") String get url;@JsonKey(name: "ts_client_utc") String get tsClientUtc;@JsonKey(name: "app_version") String get appVersion;@JsonKey(name: "device") String get device;@JsonKey(name: "headers") Map<String, String>? get headers;@JsonKey(name: "body") String? get body;@JsonKey(name: "body_sha256") String? get bodySha256;@JsonKey(name: "body_length_bytes") int? get bodyLengthBytes;@JsonKey(name: "status_code") int? get statusCode;@JsonKey(name: "duration_ms") int? get durationMs;@JsonKey(name: "exception_type") String? get exceptionType;@JsonKey(name: "exception") String? get exception;
/// Create a copy of AuditLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditLogEntryDtoCopyWith<AuditLogEntryDto> get copyWith => _$AuditLogEntryDtoCopyWithImpl<AuditLogEntryDto>(this as AuditLogEntryDto, _$identity);

  /// Serializes this AuditLogEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditLogEntryDto&&(identical(other.event, event) || other.event == event)&&(identical(other.memberCode, memberCode) || other.memberCode == memberCode)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.attempt, attempt) || other.attempt == attempt)&&(identical(other.method, method) || other.method == method)&&(identical(other.url, url) || other.url == url)&&(identical(other.tsClientUtc, tsClientUtc) || other.tsClientUtc == tsClientUtc)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.device, device) || other.device == device)&&const DeepCollectionEquality().equals(other.headers, headers)&&(identical(other.body, body) || other.body == body)&&(identical(other.bodySha256, bodySha256) || other.bodySha256 == bodySha256)&&(identical(other.bodyLengthBytes, bodyLengthBytes) || other.bodyLengthBytes == bodyLengthBytes)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.exceptionType, exceptionType) || other.exceptionType == exceptionType)&&(identical(other.exception, exception) || other.exception == exception));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,memberCode,mobileNumber,requestId,attempt,method,url,tsClientUtc,appVersion,device,const DeepCollectionEquality().hash(headers),body,bodySha256,bodyLengthBytes,statusCode,durationMs,exceptionType,exception);

@override
String toString() {
  return 'AuditLogEntryDto(event: $event, memberCode: $memberCode, mobileNumber: $mobileNumber, requestId: $requestId, attempt: $attempt, method: $method, url: $url, tsClientUtc: $tsClientUtc, appVersion: $appVersion, device: $device, headers: $headers, body: $body, bodySha256: $bodySha256, bodyLengthBytes: $bodyLengthBytes, statusCode: $statusCode, durationMs: $durationMs, exceptionType: $exceptionType, exception: $exception)';
}


}

/// @nodoc
abstract mixin class $AuditLogEntryDtoCopyWith<$Res>  {
  factory $AuditLogEntryDtoCopyWith(AuditLogEntryDto value, $Res Function(AuditLogEntryDto) _then) = _$AuditLogEntryDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "event") String event,@JsonKey(name: "member_code") int memberCode,@JsonKey(name: "mobile_number") String? mobileNumber,@JsonKey(name: "request_id") String? requestId,@JsonKey(name: "attempt") int attempt,@JsonKey(name: "method") String method,@JsonKey(name: "url") String url,@JsonKey(name: "ts_client_utc") String tsClientUtc,@JsonKey(name: "app_version") String appVersion,@JsonKey(name: "device") String device,@JsonKey(name: "headers") Map<String, String>? headers,@JsonKey(name: "body") String? body,@JsonKey(name: "body_sha256") String? bodySha256,@JsonKey(name: "body_length_bytes") int? bodyLengthBytes,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "duration_ms") int? durationMs,@JsonKey(name: "exception_type") String? exceptionType,@JsonKey(name: "exception") String? exception
});




}
/// @nodoc
class _$AuditLogEntryDtoCopyWithImpl<$Res>
    implements $AuditLogEntryDtoCopyWith<$Res> {
  _$AuditLogEntryDtoCopyWithImpl(this._self, this._then);

  final AuditLogEntryDto _self;
  final $Res Function(AuditLogEntryDto) _then;

/// Create a copy of AuditLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? memberCode = null,Object? mobileNumber = freezed,Object? requestId = freezed,Object? attempt = null,Object? method = null,Object? url = null,Object? tsClientUtc = null,Object? appVersion = null,Object? device = null,Object? headers = freezed,Object? body = freezed,Object? bodySha256 = freezed,Object? bodyLengthBytes = freezed,Object? statusCode = freezed,Object? durationMs = freezed,Object? exceptionType = freezed,Object? exception = freezed,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,memberCode: null == memberCode ? _self.memberCode : memberCode // ignore: cast_nullable_to_non_nullable
as int,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,tsClientUtc: null == tsClientUtc ? _self.tsClientUtc : tsClientUtc // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as String,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,bodySha256: freezed == bodySha256 ? _self.bodySha256 : bodySha256 // ignore: cast_nullable_to_non_nullable
as String?,bodyLengthBytes: freezed == bodyLengthBytes ? _self.bodyLengthBytes : bodyLengthBytes // ignore: cast_nullable_to_non_nullable
as int?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,exceptionType: freezed == exceptionType ? _self.exceptionType : exceptionType // ignore: cast_nullable_to_non_nullable
as String?,exception: freezed == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditLogEntryDto].
extension AuditLogEntryDtoPatterns on AuditLogEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditLogEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditLogEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditLogEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _AuditLogEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditLogEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _AuditLogEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "event")  String event, @JsonKey(name: "member_code")  int memberCode, @JsonKey(name: "mobile_number")  String? mobileNumber, @JsonKey(name: "request_id")  String? requestId, @JsonKey(name: "attempt")  int attempt, @JsonKey(name: "method")  String method, @JsonKey(name: "url")  String url, @JsonKey(name: "ts_client_utc")  String tsClientUtc, @JsonKey(name: "app_version")  String appVersion, @JsonKey(name: "device")  String device, @JsonKey(name: "headers")  Map<String, String>? headers, @JsonKey(name: "body")  String? body, @JsonKey(name: "body_sha256")  String? bodySha256, @JsonKey(name: "body_length_bytes")  int? bodyLengthBytes, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "duration_ms")  int? durationMs, @JsonKey(name: "exception_type")  String? exceptionType, @JsonKey(name: "exception")  String? exception)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditLogEntryDto() when $default != null:
return $default(_that.event,_that.memberCode,_that.mobileNumber,_that.requestId,_that.attempt,_that.method,_that.url,_that.tsClientUtc,_that.appVersion,_that.device,_that.headers,_that.body,_that.bodySha256,_that.bodyLengthBytes,_that.statusCode,_that.durationMs,_that.exceptionType,_that.exception);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "event")  String event, @JsonKey(name: "member_code")  int memberCode, @JsonKey(name: "mobile_number")  String? mobileNumber, @JsonKey(name: "request_id")  String? requestId, @JsonKey(name: "attempt")  int attempt, @JsonKey(name: "method")  String method, @JsonKey(name: "url")  String url, @JsonKey(name: "ts_client_utc")  String tsClientUtc, @JsonKey(name: "app_version")  String appVersion, @JsonKey(name: "device")  String device, @JsonKey(name: "headers")  Map<String, String>? headers, @JsonKey(name: "body")  String? body, @JsonKey(name: "body_sha256")  String? bodySha256, @JsonKey(name: "body_length_bytes")  int? bodyLengthBytes, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "duration_ms")  int? durationMs, @JsonKey(name: "exception_type")  String? exceptionType, @JsonKey(name: "exception")  String? exception)  $default,) {final _that = this;
switch (_that) {
case _AuditLogEntryDto():
return $default(_that.event,_that.memberCode,_that.mobileNumber,_that.requestId,_that.attempt,_that.method,_that.url,_that.tsClientUtc,_that.appVersion,_that.device,_that.headers,_that.body,_that.bodySha256,_that.bodyLengthBytes,_that.statusCode,_that.durationMs,_that.exceptionType,_that.exception);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "event")  String event, @JsonKey(name: "member_code")  int memberCode, @JsonKey(name: "mobile_number")  String? mobileNumber, @JsonKey(name: "request_id")  String? requestId, @JsonKey(name: "attempt")  int attempt, @JsonKey(name: "method")  String method, @JsonKey(name: "url")  String url, @JsonKey(name: "ts_client_utc")  String tsClientUtc, @JsonKey(name: "app_version")  String appVersion, @JsonKey(name: "device")  String device, @JsonKey(name: "headers")  Map<String, String>? headers, @JsonKey(name: "body")  String? body, @JsonKey(name: "body_sha256")  String? bodySha256, @JsonKey(name: "body_length_bytes")  int? bodyLengthBytes, @JsonKey(name: "status_code")  int? statusCode, @JsonKey(name: "duration_ms")  int? durationMs, @JsonKey(name: "exception_type")  String? exceptionType, @JsonKey(name: "exception")  String? exception)?  $default,) {final _that = this;
switch (_that) {
case _AuditLogEntryDto() when $default != null:
return $default(_that.event,_that.memberCode,_that.mobileNumber,_that.requestId,_that.attempt,_that.method,_that.url,_that.tsClientUtc,_that.appVersion,_that.device,_that.headers,_that.body,_that.bodySha256,_that.bodyLengthBytes,_that.statusCode,_that.durationMs,_that.exceptionType,_that.exception);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditLogEntryDto implements AuditLogEntryDto {
  const _AuditLogEntryDto({@JsonKey(name: "event") required this.event, @JsonKey(name: "member_code") required this.memberCode, @JsonKey(name: "mobile_number") this.mobileNumber, @JsonKey(name: "request_id") this.requestId, @JsonKey(name: "attempt") required this.attempt, @JsonKey(name: "method") required this.method, @JsonKey(name: "url") required this.url, @JsonKey(name: "ts_client_utc") required this.tsClientUtc, @JsonKey(name: "app_version") required this.appVersion, @JsonKey(name: "device") required this.device, @JsonKey(name: "headers") final  Map<String, String>? headers, @JsonKey(name: "body") this.body, @JsonKey(name: "body_sha256") this.bodySha256, @JsonKey(name: "body_length_bytes") this.bodyLengthBytes, @JsonKey(name: "status_code") this.statusCode, @JsonKey(name: "duration_ms") this.durationMs, @JsonKey(name: "exception_type") this.exceptionType, @JsonKey(name: "exception") this.exception}): _headers = headers;
  factory _AuditLogEntryDto.fromJson(Map<String, dynamic> json) => _$AuditLogEntryDtoFromJson(json);

@override@JsonKey(name: "event") final  String event;
@override@JsonKey(name: "member_code") final  int memberCode;
@override@JsonKey(name: "mobile_number") final  String? mobileNumber;
@override@JsonKey(name: "request_id") final  String? requestId;
@override@JsonKey(name: "attempt") final  int attempt;
@override@JsonKey(name: "method") final  String method;
@override@JsonKey(name: "url") final  String url;
@override@JsonKey(name: "ts_client_utc") final  String tsClientUtc;
@override@JsonKey(name: "app_version") final  String appVersion;
@override@JsonKey(name: "device") final  String device;
 final  Map<String, String>? _headers;
@override@JsonKey(name: "headers") Map<String, String>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: "body") final  String? body;
@override@JsonKey(name: "body_sha256") final  String? bodySha256;
@override@JsonKey(name: "body_length_bytes") final  int? bodyLengthBytes;
@override@JsonKey(name: "status_code") final  int? statusCode;
@override@JsonKey(name: "duration_ms") final  int? durationMs;
@override@JsonKey(name: "exception_type") final  String? exceptionType;
@override@JsonKey(name: "exception") final  String? exception;

/// Create a copy of AuditLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditLogEntryDtoCopyWith<_AuditLogEntryDto> get copyWith => __$AuditLogEntryDtoCopyWithImpl<_AuditLogEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditLogEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditLogEntryDto&&(identical(other.event, event) || other.event == event)&&(identical(other.memberCode, memberCode) || other.memberCode == memberCode)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.attempt, attempt) || other.attempt == attempt)&&(identical(other.method, method) || other.method == method)&&(identical(other.url, url) || other.url == url)&&(identical(other.tsClientUtc, tsClientUtc) || other.tsClientUtc == tsClientUtc)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.device, device) || other.device == device)&&const DeepCollectionEquality().equals(other._headers, _headers)&&(identical(other.body, body) || other.body == body)&&(identical(other.bodySha256, bodySha256) || other.bodySha256 == bodySha256)&&(identical(other.bodyLengthBytes, bodyLengthBytes) || other.bodyLengthBytes == bodyLengthBytes)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.exceptionType, exceptionType) || other.exceptionType == exceptionType)&&(identical(other.exception, exception) || other.exception == exception));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,memberCode,mobileNumber,requestId,attempt,method,url,tsClientUtc,appVersion,device,const DeepCollectionEquality().hash(_headers),body,bodySha256,bodyLengthBytes,statusCode,durationMs,exceptionType,exception);

@override
String toString() {
  return 'AuditLogEntryDto(event: $event, memberCode: $memberCode, mobileNumber: $mobileNumber, requestId: $requestId, attempt: $attempt, method: $method, url: $url, tsClientUtc: $tsClientUtc, appVersion: $appVersion, device: $device, headers: $headers, body: $body, bodySha256: $bodySha256, bodyLengthBytes: $bodyLengthBytes, statusCode: $statusCode, durationMs: $durationMs, exceptionType: $exceptionType, exception: $exception)';
}


}

/// @nodoc
abstract mixin class _$AuditLogEntryDtoCopyWith<$Res> implements $AuditLogEntryDtoCopyWith<$Res> {
  factory _$AuditLogEntryDtoCopyWith(_AuditLogEntryDto value, $Res Function(_AuditLogEntryDto) _then) = __$AuditLogEntryDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "event") String event,@JsonKey(name: "member_code") int memberCode,@JsonKey(name: "mobile_number") String? mobileNumber,@JsonKey(name: "request_id") String? requestId,@JsonKey(name: "attempt") int attempt,@JsonKey(name: "method") String method,@JsonKey(name: "url") String url,@JsonKey(name: "ts_client_utc") String tsClientUtc,@JsonKey(name: "app_version") String appVersion,@JsonKey(name: "device") String device,@JsonKey(name: "headers") Map<String, String>? headers,@JsonKey(name: "body") String? body,@JsonKey(name: "body_sha256") String? bodySha256,@JsonKey(name: "body_length_bytes") int? bodyLengthBytes,@JsonKey(name: "status_code") int? statusCode,@JsonKey(name: "duration_ms") int? durationMs,@JsonKey(name: "exception_type") String? exceptionType,@JsonKey(name: "exception") String? exception
});




}
/// @nodoc
class __$AuditLogEntryDtoCopyWithImpl<$Res>
    implements _$AuditLogEntryDtoCopyWith<$Res> {
  __$AuditLogEntryDtoCopyWithImpl(this._self, this._then);

  final _AuditLogEntryDto _self;
  final $Res Function(_AuditLogEntryDto) _then;

/// Create a copy of AuditLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? memberCode = null,Object? mobileNumber = freezed,Object? requestId = freezed,Object? attempt = null,Object? method = null,Object? url = null,Object? tsClientUtc = null,Object? appVersion = null,Object? device = null,Object? headers = freezed,Object? body = freezed,Object? bodySha256 = freezed,Object? bodyLengthBytes = freezed,Object? statusCode = freezed,Object? durationMs = freezed,Object? exceptionType = freezed,Object? exception = freezed,}) {
  return _then(_AuditLogEntryDto(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,memberCode: null == memberCode ? _self.memberCode : memberCode // ignore: cast_nullable_to_non_nullable
as int,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,tsClientUtc: null == tsClientUtc ? _self.tsClientUtc : tsClientUtc // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as String,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,bodySha256: freezed == bodySha256 ? _self.bodySha256 : bodySha256 // ignore: cast_nullable_to_non_nullable
as String?,bodyLengthBytes: freezed == bodyLengthBytes ? _self.bodyLengthBytes : bodyLengthBytes // ignore: cast_nullable_to_non_nullable
as int?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,exceptionType: freezed == exceptionType ? _self.exceptionType : exceptionType // ignore: cast_nullable_to_non_nullable
as String?,exception: freezed == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
