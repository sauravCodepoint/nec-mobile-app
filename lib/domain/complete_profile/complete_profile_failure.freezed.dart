// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_profile_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompleteProfileFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteProfileFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileFailure()';
}


}

/// @nodoc
class $CompleteProfileFailureCopyWith<$Res>  {
$CompleteProfileFailureCopyWith(CompleteProfileFailure _, $Res Function(CompleteProfileFailure) __);
}


/// Adds pattern-matching-related methods to [CompleteProfileFailure].
extension CompleteProfileFailurePatterns on CompleteProfileFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _UnableToGetFieldSettings value)?  unableToGetFieldSettings,TResult Function( _UnableToGetStates value)?  unableToGetStates,TResult Function( _UnableToGetCities value)?  unableToGetCities,TResult Function( _UnableToSubmit value)?  unableToSubmit,TResult Function( _UnexpectedServerState value)?  unexpectedServerState,TResult Function( _SelfieVideoUploadFailed value)?  selfieVideoUploadFailed,TResult Function( _SelfieVideoDeleteFailed value)?  selfieVideoDeleteFailed,TResult Function( _ServerError value)?  serverError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnableToGetFieldSettings() when unableToGetFieldSettings != null:
return unableToGetFieldSettings(_that);case _UnableToGetStates() when unableToGetStates != null:
return unableToGetStates(_that);case _UnableToGetCities() when unableToGetCities != null:
return unableToGetCities(_that);case _UnableToSubmit() when unableToSubmit != null:
return unableToSubmit(_that);case _UnexpectedServerState() when unexpectedServerState != null:
return unexpectedServerState(_that);case _SelfieVideoUploadFailed() when selfieVideoUploadFailed != null:
return selfieVideoUploadFailed(_that);case _SelfieVideoDeleteFailed() when selfieVideoDeleteFailed != null:
return selfieVideoDeleteFailed(_that);case _ServerError() when serverError != null:
return serverError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _UnableToGetFieldSettings value)  unableToGetFieldSettings,required TResult Function( _UnableToGetStates value)  unableToGetStates,required TResult Function( _UnableToGetCities value)  unableToGetCities,required TResult Function( _UnableToSubmit value)  unableToSubmit,required TResult Function( _UnexpectedServerState value)  unexpectedServerState,required TResult Function( _SelfieVideoUploadFailed value)  selfieVideoUploadFailed,required TResult Function( _SelfieVideoDeleteFailed value)  selfieVideoDeleteFailed,required TResult Function( _ServerError value)  serverError,}){
final _that = this;
switch (_that) {
case _UnableToGetFieldSettings():
return unableToGetFieldSettings(_that);case _UnableToGetStates():
return unableToGetStates(_that);case _UnableToGetCities():
return unableToGetCities(_that);case _UnableToSubmit():
return unableToSubmit(_that);case _UnexpectedServerState():
return unexpectedServerState(_that);case _SelfieVideoUploadFailed():
return selfieVideoUploadFailed(_that);case _SelfieVideoDeleteFailed():
return selfieVideoDeleteFailed(_that);case _ServerError():
return serverError(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _UnableToGetFieldSettings value)?  unableToGetFieldSettings,TResult? Function( _UnableToGetStates value)?  unableToGetStates,TResult? Function( _UnableToGetCities value)?  unableToGetCities,TResult? Function( _UnableToSubmit value)?  unableToSubmit,TResult? Function( _UnexpectedServerState value)?  unexpectedServerState,TResult? Function( _SelfieVideoUploadFailed value)?  selfieVideoUploadFailed,TResult? Function( _SelfieVideoDeleteFailed value)?  selfieVideoDeleteFailed,TResult? Function( _ServerError value)?  serverError,}){
final _that = this;
switch (_that) {
case _UnableToGetFieldSettings() when unableToGetFieldSettings != null:
return unableToGetFieldSettings(_that);case _UnableToGetStates() when unableToGetStates != null:
return unableToGetStates(_that);case _UnableToGetCities() when unableToGetCities != null:
return unableToGetCities(_that);case _UnableToSubmit() when unableToSubmit != null:
return unableToSubmit(_that);case _UnexpectedServerState() when unexpectedServerState != null:
return unexpectedServerState(_that);case _SelfieVideoUploadFailed() when selfieVideoUploadFailed != null:
return selfieVideoUploadFailed(_that);case _SelfieVideoDeleteFailed() when selfieVideoDeleteFailed != null:
return selfieVideoDeleteFailed(_that);case _ServerError() when serverError != null:
return serverError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unableToGetFieldSettings,TResult Function()?  unableToGetStates,TResult Function()?  unableToGetCities,TResult Function( String message)?  unableToSubmit,TResult Function( String errorId)?  unexpectedServerState,TResult Function( String message)?  selfieVideoUploadFailed,TResult Function( String message)?  selfieVideoDeleteFailed,TResult Function()?  serverError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnableToGetFieldSettings() when unableToGetFieldSettings != null:
return unableToGetFieldSettings();case _UnableToGetStates() when unableToGetStates != null:
return unableToGetStates();case _UnableToGetCities() when unableToGetCities != null:
return unableToGetCities();case _UnableToSubmit() when unableToSubmit != null:
return unableToSubmit(_that.message);case _UnexpectedServerState() when unexpectedServerState != null:
return unexpectedServerState(_that.errorId);case _SelfieVideoUploadFailed() when selfieVideoUploadFailed != null:
return selfieVideoUploadFailed(_that.message);case _SelfieVideoDeleteFailed() when selfieVideoDeleteFailed != null:
return selfieVideoDeleteFailed(_that.message);case _ServerError() when serverError != null:
return serverError();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unableToGetFieldSettings,required TResult Function()  unableToGetStates,required TResult Function()  unableToGetCities,required TResult Function( String message)  unableToSubmit,required TResult Function( String errorId)  unexpectedServerState,required TResult Function( String message)  selfieVideoUploadFailed,required TResult Function( String message)  selfieVideoDeleteFailed,required TResult Function()  serverError,}) {final _that = this;
switch (_that) {
case _UnableToGetFieldSettings():
return unableToGetFieldSettings();case _UnableToGetStates():
return unableToGetStates();case _UnableToGetCities():
return unableToGetCities();case _UnableToSubmit():
return unableToSubmit(_that.message);case _UnexpectedServerState():
return unexpectedServerState(_that.errorId);case _SelfieVideoUploadFailed():
return selfieVideoUploadFailed(_that.message);case _SelfieVideoDeleteFailed():
return selfieVideoDeleteFailed(_that.message);case _ServerError():
return serverError();case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unableToGetFieldSettings,TResult? Function()?  unableToGetStates,TResult? Function()?  unableToGetCities,TResult? Function( String message)?  unableToSubmit,TResult? Function( String errorId)?  unexpectedServerState,TResult? Function( String message)?  selfieVideoUploadFailed,TResult? Function( String message)?  selfieVideoDeleteFailed,TResult? Function()?  serverError,}) {final _that = this;
switch (_that) {
case _UnableToGetFieldSettings() when unableToGetFieldSettings != null:
return unableToGetFieldSettings();case _UnableToGetStates() when unableToGetStates != null:
return unableToGetStates();case _UnableToGetCities() when unableToGetCities != null:
return unableToGetCities();case _UnableToSubmit() when unableToSubmit != null:
return unableToSubmit(_that.message);case _UnexpectedServerState() when unexpectedServerState != null:
return unexpectedServerState(_that.errorId);case _SelfieVideoUploadFailed() when selfieVideoUploadFailed != null:
return selfieVideoUploadFailed(_that.message);case _SelfieVideoDeleteFailed() when selfieVideoDeleteFailed != null:
return selfieVideoDeleteFailed(_that.message);case _ServerError() when serverError != null:
return serverError();case _:
  return null;

}
}

}

/// @nodoc


class _UnableToGetFieldSettings implements CompleteProfileFailure {
  const _UnableToGetFieldSettings();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnableToGetFieldSettings);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileFailure.unableToGetFieldSettings()';
}


}




/// @nodoc


class _UnableToGetStates implements CompleteProfileFailure {
  const _UnableToGetStates();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnableToGetStates);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileFailure.unableToGetStates()';
}


}




/// @nodoc


class _UnableToGetCities implements CompleteProfileFailure {
  const _UnableToGetCities();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnableToGetCities);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileFailure.unableToGetCities()';
}


}




/// @nodoc


class _UnableToSubmit implements CompleteProfileFailure {
  const _UnableToSubmit(this.message);
  

 final  String message;

/// Create a copy of CompleteProfileFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnableToSubmitCopyWith<_UnableToSubmit> get copyWith => __$UnableToSubmitCopyWithImpl<_UnableToSubmit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnableToSubmit&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CompleteProfileFailure.unableToSubmit(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UnableToSubmitCopyWith<$Res> implements $CompleteProfileFailureCopyWith<$Res> {
  factory _$UnableToSubmitCopyWith(_UnableToSubmit value, $Res Function(_UnableToSubmit) _then) = __$UnableToSubmitCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$UnableToSubmitCopyWithImpl<$Res>
    implements _$UnableToSubmitCopyWith<$Res> {
  __$UnableToSubmitCopyWithImpl(this._self, this._then);

  final _UnableToSubmit _self;
  final $Res Function(_UnableToSubmit) _then;

/// Create a copy of CompleteProfileFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_UnableToSubmit(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UnexpectedServerState implements CompleteProfileFailure {
  const _UnexpectedServerState(this.errorId);
  

 final  String errorId;

/// Create a copy of CompleteProfileFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnexpectedServerStateCopyWith<_UnexpectedServerState> get copyWith => __$UnexpectedServerStateCopyWithImpl<_UnexpectedServerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnexpectedServerState&&(identical(other.errorId, errorId) || other.errorId == errorId));
}


@override
int get hashCode => Object.hash(runtimeType,errorId);

@override
String toString() {
  return 'CompleteProfileFailure.unexpectedServerState(errorId: $errorId)';
}


}

/// @nodoc
abstract mixin class _$UnexpectedServerStateCopyWith<$Res> implements $CompleteProfileFailureCopyWith<$Res> {
  factory _$UnexpectedServerStateCopyWith(_UnexpectedServerState value, $Res Function(_UnexpectedServerState) _then) = __$UnexpectedServerStateCopyWithImpl;
@useResult
$Res call({
 String errorId
});




}
/// @nodoc
class __$UnexpectedServerStateCopyWithImpl<$Res>
    implements _$UnexpectedServerStateCopyWith<$Res> {
  __$UnexpectedServerStateCopyWithImpl(this._self, this._then);

  final _UnexpectedServerState _self;
  final $Res Function(_UnexpectedServerState) _then;

/// Create a copy of CompleteProfileFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorId = null,}) {
  return _then(_UnexpectedServerState(
null == errorId ? _self.errorId : errorId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SelfieVideoUploadFailed implements CompleteProfileFailure {
  const _SelfieVideoUploadFailed(this.message);
  

 final  String message;

/// Create a copy of CompleteProfileFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfieVideoUploadFailedCopyWith<_SelfieVideoUploadFailed> get copyWith => __$SelfieVideoUploadFailedCopyWithImpl<_SelfieVideoUploadFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfieVideoUploadFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CompleteProfileFailure.selfieVideoUploadFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SelfieVideoUploadFailedCopyWith<$Res> implements $CompleteProfileFailureCopyWith<$Res> {
  factory _$SelfieVideoUploadFailedCopyWith(_SelfieVideoUploadFailed value, $Res Function(_SelfieVideoUploadFailed) _then) = __$SelfieVideoUploadFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SelfieVideoUploadFailedCopyWithImpl<$Res>
    implements _$SelfieVideoUploadFailedCopyWith<$Res> {
  __$SelfieVideoUploadFailedCopyWithImpl(this._self, this._then);

  final _SelfieVideoUploadFailed _self;
  final $Res Function(_SelfieVideoUploadFailed) _then;

/// Create a copy of CompleteProfileFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SelfieVideoUploadFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SelfieVideoDeleteFailed implements CompleteProfileFailure {
  const _SelfieVideoDeleteFailed(this.message);
  

 final  String message;

/// Create a copy of CompleteProfileFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfieVideoDeleteFailedCopyWith<_SelfieVideoDeleteFailed> get copyWith => __$SelfieVideoDeleteFailedCopyWithImpl<_SelfieVideoDeleteFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfieVideoDeleteFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CompleteProfileFailure.selfieVideoDeleteFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SelfieVideoDeleteFailedCopyWith<$Res> implements $CompleteProfileFailureCopyWith<$Res> {
  factory _$SelfieVideoDeleteFailedCopyWith(_SelfieVideoDeleteFailed value, $Res Function(_SelfieVideoDeleteFailed) _then) = __$SelfieVideoDeleteFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SelfieVideoDeleteFailedCopyWithImpl<$Res>
    implements _$SelfieVideoDeleteFailedCopyWith<$Res> {
  __$SelfieVideoDeleteFailedCopyWithImpl(this._self, this._then);

  final _SelfieVideoDeleteFailed _self;
  final $Res Function(_SelfieVideoDeleteFailed) _then;

/// Create a copy of CompleteProfileFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SelfieVideoDeleteFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ServerError implements CompleteProfileFailure {
  const _ServerError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileFailure.serverError()';
}


}




// dart format on
