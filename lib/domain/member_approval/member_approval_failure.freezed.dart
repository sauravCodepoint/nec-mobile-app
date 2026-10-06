// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_approval_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberApprovalFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberApprovalFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberApprovalFailure()';
}


}

/// @nodoc
class $MemberApprovalFailureCopyWith<$Res>  {
$MemberApprovalFailureCopyWith(MemberApprovalFailure _, $Res Function(MemberApprovalFailure) __);
}


/// Adds pattern-matching-related methods to [MemberApprovalFailure].
extension MemberApprovalFailurePatterns on MemberApprovalFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ServerError value)?  serverError,TResult Function( _MissingCredentials value)?  missingCredentials,TResult Function( _UnexpectedServerState value)?  unexpectedServerState,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that);case _MissingCredentials() when missingCredentials != null:
return missingCredentials(_that);case _UnexpectedServerState() when unexpectedServerState != null:
return unexpectedServerState(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ServerError value)  serverError,required TResult Function( _MissingCredentials value)  missingCredentials,required TResult Function( _UnexpectedServerState value)  unexpectedServerState,}){
final _that = this;
switch (_that) {
case _ServerError():
return serverError(_that);case _MissingCredentials():
return missingCredentials(_that);case _UnexpectedServerState():
return unexpectedServerState(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ServerError value)?  serverError,TResult? Function( _MissingCredentials value)?  missingCredentials,TResult? Function( _UnexpectedServerState value)?  unexpectedServerState,}){
final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError(_that);case _MissingCredentials() when missingCredentials != null:
return missingCredentials(_that);case _UnexpectedServerState() when unexpectedServerState != null:
return unexpectedServerState(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  serverError,TResult Function()?  missingCredentials,TResult Function( String message)?  unexpectedServerState,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError();case _MissingCredentials() when missingCredentials != null:
return missingCredentials();case _UnexpectedServerState() when unexpectedServerState != null:
return unexpectedServerState(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  serverError,required TResult Function()  missingCredentials,required TResult Function( String message)  unexpectedServerState,}) {final _that = this;
switch (_that) {
case _ServerError():
return serverError();case _MissingCredentials():
return missingCredentials();case _UnexpectedServerState():
return unexpectedServerState(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  serverError,TResult? Function()?  missingCredentials,TResult? Function( String message)?  unexpectedServerState,}) {final _that = this;
switch (_that) {
case _ServerError() when serverError != null:
return serverError();case _MissingCredentials() when missingCredentials != null:
return missingCredentials();case _UnexpectedServerState() when unexpectedServerState != null:
return unexpectedServerState(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ServerError implements MemberApprovalFailure {
  const _ServerError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberApprovalFailure.serverError()';
}


}




/// @nodoc


class _MissingCredentials implements MemberApprovalFailure {
  const _MissingCredentials();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissingCredentials);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberApprovalFailure.missingCredentials()';
}


}




/// @nodoc


class _UnexpectedServerState implements MemberApprovalFailure {
  const _UnexpectedServerState(this.message);
  

 final  String message;

/// Create a copy of MemberApprovalFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnexpectedServerStateCopyWith<_UnexpectedServerState> get copyWith => __$UnexpectedServerStateCopyWithImpl<_UnexpectedServerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnexpectedServerState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MemberApprovalFailure.unexpectedServerState(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UnexpectedServerStateCopyWith<$Res> implements $MemberApprovalFailureCopyWith<$Res> {
  factory _$UnexpectedServerStateCopyWith(_UnexpectedServerState value, $Res Function(_UnexpectedServerState) _then) = __$UnexpectedServerStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$UnexpectedServerStateCopyWithImpl<$Res>
    implements _$UnexpectedServerStateCopyWith<$Res> {
  __$UnexpectedServerStateCopyWithImpl(this._self, this._then);

  final _UnexpectedServerState _self;
  final $Res Function(_UnexpectedServerState) _then;

/// Create a copy of MemberApprovalFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_UnexpectedServerState(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
