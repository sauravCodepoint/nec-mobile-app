// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_kyc_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateKycFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateKycFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateKycFailure()';
}


}

/// @nodoc
class $UpdateKycFailureCopyWith<$Res>  {
$UpdateKycFailureCopyWith(UpdateKycFailure _, $Res Function(UpdateKycFailure) __);
}


/// Adds pattern-matching-related methods to [UpdateKycFailure].
extension UpdateKycFailurePatterns on UpdateKycFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _UnableToFetchIdentityTypes value)?  unableToFetchIdentityTypes,TResult Function( _FrontUploadFailed value)?  frontUploadFailed,TResult Function( _BackUploadFailed value)?  backUploadFailed,TResult Function( _DeleteFailed value)?  deleteFailed,TResult Function( _SubmitFailed value)?  submitFailed,TResult Function( _ServerError value)?  serverError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnableToFetchIdentityTypes() when unableToFetchIdentityTypes != null:
return unableToFetchIdentityTypes(_that);case _FrontUploadFailed() when frontUploadFailed != null:
return frontUploadFailed(_that);case _BackUploadFailed() when backUploadFailed != null:
return backUploadFailed(_that);case _DeleteFailed() when deleteFailed != null:
return deleteFailed(_that);case _SubmitFailed() when submitFailed != null:
return submitFailed(_that);case _ServerError() when serverError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _UnableToFetchIdentityTypes value)  unableToFetchIdentityTypes,required TResult Function( _FrontUploadFailed value)  frontUploadFailed,required TResult Function( _BackUploadFailed value)  backUploadFailed,required TResult Function( _DeleteFailed value)  deleteFailed,required TResult Function( _SubmitFailed value)  submitFailed,required TResult Function( _ServerError value)  serverError,}){
final _that = this;
switch (_that) {
case _UnableToFetchIdentityTypes():
return unableToFetchIdentityTypes(_that);case _FrontUploadFailed():
return frontUploadFailed(_that);case _BackUploadFailed():
return backUploadFailed(_that);case _DeleteFailed():
return deleteFailed(_that);case _SubmitFailed():
return submitFailed(_that);case _ServerError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _UnableToFetchIdentityTypes value)?  unableToFetchIdentityTypes,TResult? Function( _FrontUploadFailed value)?  frontUploadFailed,TResult? Function( _BackUploadFailed value)?  backUploadFailed,TResult? Function( _DeleteFailed value)?  deleteFailed,TResult? Function( _SubmitFailed value)?  submitFailed,TResult? Function( _ServerError value)?  serverError,}){
final _that = this;
switch (_that) {
case _UnableToFetchIdentityTypes() when unableToFetchIdentityTypes != null:
return unableToFetchIdentityTypes(_that);case _FrontUploadFailed() when frontUploadFailed != null:
return frontUploadFailed(_that);case _BackUploadFailed() when backUploadFailed != null:
return backUploadFailed(_that);case _DeleteFailed() when deleteFailed != null:
return deleteFailed(_that);case _SubmitFailed() when submitFailed != null:
return submitFailed(_that);case _ServerError() when serverError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  unableToFetchIdentityTypes,TResult Function( String message)?  frontUploadFailed,TResult Function( String message)?  backUploadFailed,TResult Function( String message)?  deleteFailed,TResult Function( String message)?  submitFailed,TResult Function()?  serverError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnableToFetchIdentityTypes() when unableToFetchIdentityTypes != null:
return unableToFetchIdentityTypes(_that.message);case _FrontUploadFailed() when frontUploadFailed != null:
return frontUploadFailed(_that.message);case _BackUploadFailed() when backUploadFailed != null:
return backUploadFailed(_that.message);case _DeleteFailed() when deleteFailed != null:
return deleteFailed(_that.message);case _SubmitFailed() when submitFailed != null:
return submitFailed(_that.message);case _ServerError() when serverError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  unableToFetchIdentityTypes,required TResult Function( String message)  frontUploadFailed,required TResult Function( String message)  backUploadFailed,required TResult Function( String message)  deleteFailed,required TResult Function( String message)  submitFailed,required TResult Function()  serverError,}) {final _that = this;
switch (_that) {
case _UnableToFetchIdentityTypes():
return unableToFetchIdentityTypes(_that.message);case _FrontUploadFailed():
return frontUploadFailed(_that.message);case _BackUploadFailed():
return backUploadFailed(_that.message);case _DeleteFailed():
return deleteFailed(_that.message);case _SubmitFailed():
return submitFailed(_that.message);case _ServerError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  unableToFetchIdentityTypes,TResult? Function( String message)?  frontUploadFailed,TResult? Function( String message)?  backUploadFailed,TResult? Function( String message)?  deleteFailed,TResult? Function( String message)?  submitFailed,TResult? Function()?  serverError,}) {final _that = this;
switch (_that) {
case _UnableToFetchIdentityTypes() when unableToFetchIdentityTypes != null:
return unableToFetchIdentityTypes(_that.message);case _FrontUploadFailed() when frontUploadFailed != null:
return frontUploadFailed(_that.message);case _BackUploadFailed() when backUploadFailed != null:
return backUploadFailed(_that.message);case _DeleteFailed() when deleteFailed != null:
return deleteFailed(_that.message);case _SubmitFailed() when submitFailed != null:
return submitFailed(_that.message);case _ServerError() when serverError != null:
return serverError();case _:
  return null;

}
}

}

/// @nodoc


class _UnableToFetchIdentityTypes implements UpdateKycFailure {
  const _UnableToFetchIdentityTypes(this.message);
  

 final  String message;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnableToFetchIdentityTypesCopyWith<_UnableToFetchIdentityTypes> get copyWith => __$UnableToFetchIdentityTypesCopyWithImpl<_UnableToFetchIdentityTypes>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnableToFetchIdentityTypes&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UpdateKycFailure.unableToFetchIdentityTypes(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UnableToFetchIdentityTypesCopyWith<$Res> implements $UpdateKycFailureCopyWith<$Res> {
  factory _$UnableToFetchIdentityTypesCopyWith(_UnableToFetchIdentityTypes value, $Res Function(_UnableToFetchIdentityTypes) _then) = __$UnableToFetchIdentityTypesCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$UnableToFetchIdentityTypesCopyWithImpl<$Res>
    implements _$UnableToFetchIdentityTypesCopyWith<$Res> {
  __$UnableToFetchIdentityTypesCopyWithImpl(this._self, this._then);

  final _UnableToFetchIdentityTypes _self;
  final $Res Function(_UnableToFetchIdentityTypes) _then;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_UnableToFetchIdentityTypes(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FrontUploadFailed implements UpdateKycFailure {
  const _FrontUploadFailed(this.message);
  

 final  String message;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrontUploadFailedCopyWith<_FrontUploadFailed> get copyWith => __$FrontUploadFailedCopyWithImpl<_FrontUploadFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FrontUploadFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UpdateKycFailure.frontUploadFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FrontUploadFailedCopyWith<$Res> implements $UpdateKycFailureCopyWith<$Res> {
  factory _$FrontUploadFailedCopyWith(_FrontUploadFailed value, $Res Function(_FrontUploadFailed) _then) = __$FrontUploadFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FrontUploadFailedCopyWithImpl<$Res>
    implements _$FrontUploadFailedCopyWith<$Res> {
  __$FrontUploadFailedCopyWithImpl(this._self, this._then);

  final _FrontUploadFailed _self;
  final $Res Function(_FrontUploadFailed) _then;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_FrontUploadFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BackUploadFailed implements UpdateKycFailure {
  const _BackUploadFailed(this.message);
  

 final  String message;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackUploadFailedCopyWith<_BackUploadFailed> get copyWith => __$BackUploadFailedCopyWithImpl<_BackUploadFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackUploadFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UpdateKycFailure.backUploadFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$BackUploadFailedCopyWith<$Res> implements $UpdateKycFailureCopyWith<$Res> {
  factory _$BackUploadFailedCopyWith(_BackUploadFailed value, $Res Function(_BackUploadFailed) _then) = __$BackUploadFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$BackUploadFailedCopyWithImpl<$Res>
    implements _$BackUploadFailedCopyWith<$Res> {
  __$BackUploadFailedCopyWithImpl(this._self, this._then);

  final _BackUploadFailed _self;
  final $Res Function(_BackUploadFailed) _then;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_BackUploadFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeleteFailed implements UpdateKycFailure {
  const _DeleteFailed(this.message);
  

 final  String message;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteFailedCopyWith<_DeleteFailed> get copyWith => __$DeleteFailedCopyWithImpl<_DeleteFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UpdateKycFailure.deleteFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$DeleteFailedCopyWith<$Res> implements $UpdateKycFailureCopyWith<$Res> {
  factory _$DeleteFailedCopyWith(_DeleteFailed value, $Res Function(_DeleteFailed) _then) = __$DeleteFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$DeleteFailedCopyWithImpl<$Res>
    implements _$DeleteFailedCopyWith<$Res> {
  __$DeleteFailedCopyWithImpl(this._self, this._then);

  final _DeleteFailed _self;
  final $Res Function(_DeleteFailed) _then;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_DeleteFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SubmitFailed implements UpdateKycFailure {
  const _SubmitFailed(this.message);
  

 final  String message;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitFailedCopyWith<_SubmitFailed> get copyWith => __$SubmitFailedCopyWithImpl<_SubmitFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UpdateKycFailure.submitFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SubmitFailedCopyWith<$Res> implements $UpdateKycFailureCopyWith<$Res> {
  factory _$SubmitFailedCopyWith(_SubmitFailed value, $Res Function(_SubmitFailed) _then) = __$SubmitFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SubmitFailedCopyWithImpl<$Res>
    implements _$SubmitFailedCopyWith<$Res> {
  __$SubmitFailedCopyWithImpl(this._self, this._then);

  final _SubmitFailed _self;
  final $Res Function(_SubmitFailed) _then;

/// Create a copy of UpdateKycFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SubmitFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ServerError implements UpdateKycFailure {
  const _ServerError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateKycFailure.serverError()';
}


}




// dart format on
