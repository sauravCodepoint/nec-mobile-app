// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_registration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PendingRegistration {

 String get idType; String get idNumber; String get mobile; int get appMemberCode; User get user;
/// Create a copy of PendingRegistration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingRegistrationCopyWith<PendingRegistration> get copyWith => _$PendingRegistrationCopyWithImpl<PendingRegistration>(this as PendingRegistration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingRegistration&&(identical(other.idType, idType) || other.idType == idType)&&(identical(other.idNumber, idNumber) || other.idNumber == idNumber)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.appMemberCode, appMemberCode) || other.appMemberCode == appMemberCode)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,idType,idNumber,mobile,appMemberCode,user);

@override
String toString() {
  return 'PendingRegistration(idType: $idType, idNumber: $idNumber, mobile: $mobile, appMemberCode: $appMemberCode, user: $user)';
}


}

/// @nodoc
abstract mixin class $PendingRegistrationCopyWith<$Res>  {
  factory $PendingRegistrationCopyWith(PendingRegistration value, $Res Function(PendingRegistration) _then) = _$PendingRegistrationCopyWithImpl;
@useResult
$Res call({
 String idType, String idNumber, String mobile, int appMemberCode, User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$PendingRegistrationCopyWithImpl<$Res>
    implements $PendingRegistrationCopyWith<$Res> {
  _$PendingRegistrationCopyWithImpl(this._self, this._then);

  final PendingRegistration _self;
  final $Res Function(PendingRegistration) _then;

/// Create a copy of PendingRegistration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idType = null,Object? idNumber = null,Object? mobile = null,Object? appMemberCode = null,Object? user = null,}) {
  return _then(_self.copyWith(
idType: null == idType ? _self.idType : idType // ignore: cast_nullable_to_non_nullable
as String,idNumber: null == idNumber ? _self.idNumber : idNumber // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,appMemberCode: null == appMemberCode ? _self.appMemberCode : appMemberCode // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}
/// Create a copy of PendingRegistration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [PendingRegistration].
extension PendingRegistrationPatterns on PendingRegistration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CompleteProfile value)?  completeProfile,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteProfile() when completeProfile != null:
return completeProfile(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CompleteProfile value)  completeProfile,}){
final _that = this;
switch (_that) {
case _CompleteProfile():
return completeProfile(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CompleteProfile value)?  completeProfile,}){
final _that = this;
switch (_that) {
case _CompleteProfile() when completeProfile != null:
return completeProfile(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String idType,  String idNumber,  String mobile,  int appMemberCode,  User user)?  completeProfile,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteProfile() when completeProfile != null:
return completeProfile(_that.idType,_that.idNumber,_that.mobile,_that.appMemberCode,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String idType,  String idNumber,  String mobile,  int appMemberCode,  User user)  completeProfile,}) {final _that = this;
switch (_that) {
case _CompleteProfile():
return completeProfile(_that.idType,_that.idNumber,_that.mobile,_that.appMemberCode,_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String idType,  String idNumber,  String mobile,  int appMemberCode,  User user)?  completeProfile,}) {final _that = this;
switch (_that) {
case _CompleteProfile() when completeProfile != null:
return completeProfile(_that.idType,_that.idNumber,_that.mobile,_that.appMemberCode,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _CompleteProfile implements PendingRegistration {
  const _CompleteProfile({required this.idType, required this.idNumber, required this.mobile, required this.appMemberCode, required this.user});
  

@override final  String idType;
@override final  String idNumber;
@override final  String mobile;
@override final  int appMemberCode;
@override final  User user;

/// Create a copy of PendingRegistration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteProfileCopyWith<_CompleteProfile> get copyWith => __$CompleteProfileCopyWithImpl<_CompleteProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteProfile&&(identical(other.idType, idType) || other.idType == idType)&&(identical(other.idNumber, idNumber) || other.idNumber == idNumber)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.appMemberCode, appMemberCode) || other.appMemberCode == appMemberCode)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,idType,idNumber,mobile,appMemberCode,user);

@override
String toString() {
  return 'PendingRegistration.completeProfile(idType: $idType, idNumber: $idNumber, mobile: $mobile, appMemberCode: $appMemberCode, user: $user)';
}


}

/// @nodoc
abstract mixin class _$CompleteProfileCopyWith<$Res> implements $PendingRegistrationCopyWith<$Res> {
  factory _$CompleteProfileCopyWith(_CompleteProfile value, $Res Function(_CompleteProfile) _then) = __$CompleteProfileCopyWithImpl;
@override @useResult
$Res call({
 String idType, String idNumber, String mobile, int appMemberCode, User user
});


@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$CompleteProfileCopyWithImpl<$Res>
    implements _$CompleteProfileCopyWith<$Res> {
  __$CompleteProfileCopyWithImpl(this._self, this._then);

  final _CompleteProfile _self;
  final $Res Function(_CompleteProfile) _then;

/// Create a copy of PendingRegistration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idType = null,Object? idNumber = null,Object? mobile = null,Object? appMemberCode = null,Object? user = null,}) {
  return _then(_CompleteProfile(
idType: null == idType ? _self.idType : idType // ignore: cast_nullable_to_non_nullable
as String,idNumber: null == idNumber ? _self.idNumber : idNumber // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,appMemberCode: null == appMemberCode ? _self.appMemberCode : appMemberCode // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of PendingRegistration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
