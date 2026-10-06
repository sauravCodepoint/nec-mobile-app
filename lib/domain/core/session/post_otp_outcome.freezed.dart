// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_otp_outcome.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostOtpOutcome {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostOtpOutcome);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PostOtpOutcome()';
}


}

/// @nodoc
class $PostOtpOutcomeCopyWith<$Res>  {
$PostOtpOutcomeCopyWith(PostOtpOutcome _, $Res Function(PostOtpOutcome) __);
}


/// Adds pattern-matching-related methods to [PostOtpOutcome].
extension PostOtpOutcomePatterns on PostOtpOutcome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CompleteSession value)?  completeSession,TResult Function( _PendingMpinSetup value)?  pendingMpinSetup,TResult Function( _PendingProfile value)?  pendingProfile,TResult Function( _PendingApproval value)?  pendingApproval,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteSession() when completeSession != null:
return completeSession(_that);case _PendingMpinSetup() when pendingMpinSetup != null:
return pendingMpinSetup(_that);case _PendingProfile() when pendingProfile != null:
return pendingProfile(_that);case _PendingApproval() when pendingApproval != null:
return pendingApproval(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CompleteSession value)  completeSession,required TResult Function( _PendingMpinSetup value)  pendingMpinSetup,required TResult Function( _PendingProfile value)  pendingProfile,required TResult Function( _PendingApproval value)  pendingApproval,}){
final _that = this;
switch (_that) {
case _CompleteSession():
return completeSession(_that);case _PendingMpinSetup():
return pendingMpinSetup(_that);case _PendingProfile():
return pendingProfile(_that);case _PendingApproval():
return pendingApproval(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CompleteSession value)?  completeSession,TResult? Function( _PendingMpinSetup value)?  pendingMpinSetup,TResult? Function( _PendingProfile value)?  pendingProfile,TResult? Function( _PendingApproval value)?  pendingApproval,}){
final _that = this;
switch (_that) {
case _CompleteSession() when completeSession != null:
return completeSession(_that);case _PendingMpinSetup() when pendingMpinSetup != null:
return pendingMpinSetup(_that);case _PendingProfile() when pendingProfile != null:
return pendingProfile(_that);case _PendingApproval() when pendingApproval != null:
return pendingApproval(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( User user)?  completeSession,TResult Function( User user)?  pendingMpinSetup,TResult Function( User user)?  pendingProfile,TResult Function()?  pendingApproval,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteSession() when completeSession != null:
return completeSession(_that.user);case _PendingMpinSetup() when pendingMpinSetup != null:
return pendingMpinSetup(_that.user);case _PendingProfile() when pendingProfile != null:
return pendingProfile(_that.user);case _PendingApproval() when pendingApproval != null:
return pendingApproval();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( User user)  completeSession,required TResult Function( User user)  pendingMpinSetup,required TResult Function( User user)  pendingProfile,required TResult Function()  pendingApproval,}) {final _that = this;
switch (_that) {
case _CompleteSession():
return completeSession(_that.user);case _PendingMpinSetup():
return pendingMpinSetup(_that.user);case _PendingProfile():
return pendingProfile(_that.user);case _PendingApproval():
return pendingApproval();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( User user)?  completeSession,TResult? Function( User user)?  pendingMpinSetup,TResult? Function( User user)?  pendingProfile,TResult? Function()?  pendingApproval,}) {final _that = this;
switch (_that) {
case _CompleteSession() when completeSession != null:
return completeSession(_that.user);case _PendingMpinSetup() when pendingMpinSetup != null:
return pendingMpinSetup(_that.user);case _PendingProfile() when pendingProfile != null:
return pendingProfile(_that.user);case _PendingApproval() when pendingApproval != null:
return pendingApproval();case _:
  return null;

}
}

}

/// @nodoc


class _CompleteSession implements PostOtpOutcome {
  const _CompleteSession(this.user);
  

 final  User user;

/// Create a copy of PostOtpOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteSessionCopyWith<_CompleteSession> get copyWith => __$CompleteSessionCopyWithImpl<_CompleteSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteSession&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'PostOtpOutcome.completeSession(user: $user)';
}


}

/// @nodoc
abstract mixin class _$CompleteSessionCopyWith<$Res> implements $PostOtpOutcomeCopyWith<$Res> {
  factory _$CompleteSessionCopyWith(_CompleteSession value, $Res Function(_CompleteSession) _then) = __$CompleteSessionCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class __$CompleteSessionCopyWithImpl<$Res>
    implements _$CompleteSessionCopyWith<$Res> {
  __$CompleteSessionCopyWithImpl(this._self, this._then);

  final _CompleteSession _self;
  final $Res Function(_CompleteSession) _then;

/// Create a copy of PostOtpOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_CompleteSession(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of PostOtpOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class _PendingMpinSetup implements PostOtpOutcome {
  const _PendingMpinSetup(this.user);
  

 final  User user;

/// Create a copy of PostOtpOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingMpinSetupCopyWith<_PendingMpinSetup> get copyWith => __$PendingMpinSetupCopyWithImpl<_PendingMpinSetup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingMpinSetup&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'PostOtpOutcome.pendingMpinSetup(user: $user)';
}


}

/// @nodoc
abstract mixin class _$PendingMpinSetupCopyWith<$Res> implements $PostOtpOutcomeCopyWith<$Res> {
  factory _$PendingMpinSetupCopyWith(_PendingMpinSetup value, $Res Function(_PendingMpinSetup) _then) = __$PendingMpinSetupCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class __$PendingMpinSetupCopyWithImpl<$Res>
    implements _$PendingMpinSetupCopyWith<$Res> {
  __$PendingMpinSetupCopyWithImpl(this._self, this._then);

  final _PendingMpinSetup _self;
  final $Res Function(_PendingMpinSetup) _then;

/// Create a copy of PostOtpOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_PendingMpinSetup(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of PostOtpOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class _PendingProfile implements PostOtpOutcome {
  const _PendingProfile(this.user);
  

 final  User user;

/// Create a copy of PostOtpOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingProfileCopyWith<_PendingProfile> get copyWith => __$PendingProfileCopyWithImpl<_PendingProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingProfile&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'PostOtpOutcome.pendingProfile(user: $user)';
}


}

/// @nodoc
abstract mixin class _$PendingProfileCopyWith<$Res> implements $PostOtpOutcomeCopyWith<$Res> {
  factory _$PendingProfileCopyWith(_PendingProfile value, $Res Function(_PendingProfile) _then) = __$PendingProfileCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class __$PendingProfileCopyWithImpl<$Res>
    implements _$PendingProfileCopyWith<$Res> {
  __$PendingProfileCopyWithImpl(this._self, this._then);

  final _PendingProfile _self;
  final $Res Function(_PendingProfile) _then;

/// Create a copy of PostOtpOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_PendingProfile(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of PostOtpOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class _PendingApproval implements PostOtpOutcome {
  const _PendingApproval();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingApproval);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PostOtpOutcome.pendingApproval()';
}


}




// dart format on
