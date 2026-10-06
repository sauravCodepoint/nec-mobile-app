// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_approval_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberApprovalEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberApprovalEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberApprovalEvent()';
}


}

/// @nodoc
class $MemberApprovalEventCopyWith<$Res>  {
$MemberApprovalEventCopyWith(MemberApprovalEvent _, $Res Function(MemberApprovalEvent) __);
}


/// Adds pattern-matching-related methods to [MemberApprovalEvent].
extension MemberApprovalEventPatterns on MemberApprovalEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ScreenOpened value)?  screenOpened,TResult Function( _PollingStarted value)?  pollingStarted,TResult Function( _PollingStopped value)?  pollingStopped,TResult Function( _CheckRequested value)?  checkRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScreenOpened() when screenOpened != null:
return screenOpened(_that);case _PollingStarted() when pollingStarted != null:
return pollingStarted(_that);case _PollingStopped() when pollingStopped != null:
return pollingStopped(_that);case _CheckRequested() when checkRequested != null:
return checkRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ScreenOpened value)  screenOpened,required TResult Function( _PollingStarted value)  pollingStarted,required TResult Function( _PollingStopped value)  pollingStopped,required TResult Function( _CheckRequested value)  checkRequested,}){
final _that = this;
switch (_that) {
case _ScreenOpened():
return screenOpened(_that);case _PollingStarted():
return pollingStarted(_that);case _PollingStopped():
return pollingStopped(_that);case _CheckRequested():
return checkRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ScreenOpened value)?  screenOpened,TResult? Function( _PollingStarted value)?  pollingStarted,TResult? Function( _PollingStopped value)?  pollingStopped,TResult? Function( _CheckRequested value)?  checkRequested,}){
final _that = this;
switch (_that) {
case _ScreenOpened() when screenOpened != null:
return screenOpened(_that);case _PollingStarted() when pollingStarted != null:
return pollingStarted(_that);case _PollingStopped() when pollingStopped != null:
return pollingStopped(_that);case _CheckRequested() when checkRequested != null:
return checkRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  screenOpened,TResult Function()?  pollingStarted,TResult Function()?  pollingStopped,TResult Function()?  checkRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScreenOpened() when screenOpened != null:
return screenOpened();case _PollingStarted() when pollingStarted != null:
return pollingStarted();case _PollingStopped() when pollingStopped != null:
return pollingStopped();case _CheckRequested() when checkRequested != null:
return checkRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  screenOpened,required TResult Function()  pollingStarted,required TResult Function()  pollingStopped,required TResult Function()  checkRequested,}) {final _that = this;
switch (_that) {
case _ScreenOpened():
return screenOpened();case _PollingStarted():
return pollingStarted();case _PollingStopped():
return pollingStopped();case _CheckRequested():
return checkRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  screenOpened,TResult? Function()?  pollingStarted,TResult? Function()?  pollingStopped,TResult? Function()?  checkRequested,}) {final _that = this;
switch (_that) {
case _ScreenOpened() when screenOpened != null:
return screenOpened();case _PollingStarted() when pollingStarted != null:
return pollingStarted();case _PollingStopped() when pollingStopped != null:
return pollingStopped();case _CheckRequested() when checkRequested != null:
return checkRequested();case _:
  return null;

}
}

}

/// @nodoc


class _ScreenOpened implements MemberApprovalEvent {
  const _ScreenOpened();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScreenOpened);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberApprovalEvent.screenOpened()';
}


}




/// @nodoc


class _PollingStarted implements MemberApprovalEvent {
  const _PollingStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollingStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberApprovalEvent.pollingStarted()';
}


}




/// @nodoc


class _PollingStopped implements MemberApprovalEvent {
  const _PollingStopped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollingStopped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberApprovalEvent.pollingStopped()';
}


}




/// @nodoc


class _CheckRequested implements MemberApprovalEvent {
  const _CheckRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MemberApprovalEvent.checkRequested()';
}


}




/// @nodoc
mixin _$MemberApprovalState {

 bool get isChecking;/// Set when a check found the stored credentials missing — retrying is
/// pointless, so the timer is stopped and the screen stays static.
 bool get isPollingDisabled;/// Terminal: the back office approved the member (200). The page reacts
/// by sending the user to Login with a success toast.
 bool get isApproved;/// Terminal: the back office rejected the registration (403). The page
/// morphs into its rejected variant and polling never re-arms.
 bool get isRejected;/// Backend-authored reason shown on the rejected screen; null falls back
/// to the translated default.
 String? get rejectionReason;/// One-shot result of the latest check. Failures are deliberately never
/// surfaced to the user (they mean "still pending"); the page only reacts
/// to an approved success.
 Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>> get statusFailureOrSuccessOption;
/// Create a copy of MemberApprovalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberApprovalStateCopyWith<MemberApprovalState> get copyWith => _$MemberApprovalStateCopyWithImpl<MemberApprovalState>(this as MemberApprovalState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberApprovalState&&(identical(other.isChecking, isChecking) || other.isChecking == isChecking)&&(identical(other.isPollingDisabled, isPollingDisabled) || other.isPollingDisabled == isPollingDisabled)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.isRejected, isRejected) || other.isRejected == isRejected)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.statusFailureOrSuccessOption, statusFailureOrSuccessOption) || other.statusFailureOrSuccessOption == statusFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,isChecking,isPollingDisabled,isApproved,isRejected,rejectionReason,statusFailureOrSuccessOption);

@override
String toString() {
  return 'MemberApprovalState(isChecking: $isChecking, isPollingDisabled: $isPollingDisabled, isApproved: $isApproved, isRejected: $isRejected, rejectionReason: $rejectionReason, statusFailureOrSuccessOption: $statusFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class $MemberApprovalStateCopyWith<$Res>  {
  factory $MemberApprovalStateCopyWith(MemberApprovalState value, $Res Function(MemberApprovalState) _then) = _$MemberApprovalStateCopyWithImpl;
@useResult
$Res call({
 bool isChecking, bool isPollingDisabled, bool isApproved, bool isRejected, String? rejectionReason, Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>> statusFailureOrSuccessOption
});




}
/// @nodoc
class _$MemberApprovalStateCopyWithImpl<$Res>
    implements $MemberApprovalStateCopyWith<$Res> {
  _$MemberApprovalStateCopyWithImpl(this._self, this._then);

  final MemberApprovalState _self;
  final $Res Function(MemberApprovalState) _then;

/// Create a copy of MemberApprovalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isChecking = null,Object? isPollingDisabled = null,Object? isApproved = null,Object? isRejected = null,Object? rejectionReason = freezed,Object? statusFailureOrSuccessOption = null,}) {
  return _then(_self.copyWith(
isChecking: null == isChecking ? _self.isChecking : isChecking // ignore: cast_nullable_to_non_nullable
as bool,isPollingDisabled: null == isPollingDisabled ? _self.isPollingDisabled : isPollingDisabled // ignore: cast_nullable_to_non_nullable
as bool,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,isRejected: null == isRejected ? _self.isRejected : isRejected // ignore: cast_nullable_to_non_nullable
as bool,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,statusFailureOrSuccessOption: null == statusFailureOrSuccessOption ? _self.statusFailureOrSuccessOption : statusFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>>,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberApprovalState].
extension MemberApprovalStatePatterns on MemberApprovalState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberApprovalState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberApprovalState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberApprovalState value)  $default,){
final _that = this;
switch (_that) {
case _MemberApprovalState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberApprovalState value)?  $default,){
final _that = this;
switch (_that) {
case _MemberApprovalState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isChecking,  bool isPollingDisabled,  bool isApproved,  bool isRejected,  String? rejectionReason,  Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>> statusFailureOrSuccessOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberApprovalState() when $default != null:
return $default(_that.isChecking,_that.isPollingDisabled,_that.isApproved,_that.isRejected,_that.rejectionReason,_that.statusFailureOrSuccessOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isChecking,  bool isPollingDisabled,  bool isApproved,  bool isRejected,  String? rejectionReason,  Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>> statusFailureOrSuccessOption)  $default,) {final _that = this;
switch (_that) {
case _MemberApprovalState():
return $default(_that.isChecking,_that.isPollingDisabled,_that.isApproved,_that.isRejected,_that.rejectionReason,_that.statusFailureOrSuccessOption);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isChecking,  bool isPollingDisabled,  bool isApproved,  bool isRejected,  String? rejectionReason,  Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>> statusFailureOrSuccessOption)?  $default,) {final _that = this;
switch (_that) {
case _MemberApprovalState() when $default != null:
return $default(_that.isChecking,_that.isPollingDisabled,_that.isApproved,_that.isRejected,_that.rejectionReason,_that.statusFailureOrSuccessOption);case _:
  return null;

}
}

}

/// @nodoc


class _MemberApprovalState implements MemberApprovalState {
  const _MemberApprovalState({required this.isChecking, required this.isPollingDisabled, required this.isApproved, required this.isRejected, this.rejectionReason, required this.statusFailureOrSuccessOption});
  

@override final  bool isChecking;
/// Set when a check found the stored credentials missing — retrying is
/// pointless, so the timer is stopped and the screen stays static.
@override final  bool isPollingDisabled;
/// Terminal: the back office approved the member (200). The page reacts
/// by sending the user to Login with a success toast.
@override final  bool isApproved;
/// Terminal: the back office rejected the registration (403). The page
/// morphs into its rejected variant and polling never re-arms.
@override final  bool isRejected;
/// Backend-authored reason shown on the rejected screen; null falls back
/// to the translated default.
@override final  String? rejectionReason;
/// One-shot result of the latest check. Failures are deliberately never
/// surfaced to the user (they mean "still pending"); the page only reacts
/// to an approved success.
@override final  Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>> statusFailureOrSuccessOption;

/// Create a copy of MemberApprovalState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberApprovalStateCopyWith<_MemberApprovalState> get copyWith => __$MemberApprovalStateCopyWithImpl<_MemberApprovalState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberApprovalState&&(identical(other.isChecking, isChecking) || other.isChecking == isChecking)&&(identical(other.isPollingDisabled, isPollingDisabled) || other.isPollingDisabled == isPollingDisabled)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.isRejected, isRejected) || other.isRejected == isRejected)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.statusFailureOrSuccessOption, statusFailureOrSuccessOption) || other.statusFailureOrSuccessOption == statusFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,isChecking,isPollingDisabled,isApproved,isRejected,rejectionReason,statusFailureOrSuccessOption);

@override
String toString() {
  return 'MemberApprovalState(isChecking: $isChecking, isPollingDisabled: $isPollingDisabled, isApproved: $isApproved, isRejected: $isRejected, rejectionReason: $rejectionReason, statusFailureOrSuccessOption: $statusFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class _$MemberApprovalStateCopyWith<$Res> implements $MemberApprovalStateCopyWith<$Res> {
  factory _$MemberApprovalStateCopyWith(_MemberApprovalState value, $Res Function(_MemberApprovalState) _then) = __$MemberApprovalStateCopyWithImpl;
@override @useResult
$Res call({
 bool isChecking, bool isPollingDisabled, bool isApproved, bool isRejected, String? rejectionReason, Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>> statusFailureOrSuccessOption
});




}
/// @nodoc
class __$MemberApprovalStateCopyWithImpl<$Res>
    implements _$MemberApprovalStateCopyWith<$Res> {
  __$MemberApprovalStateCopyWithImpl(this._self, this._then);

  final _MemberApprovalState _self;
  final $Res Function(_MemberApprovalState) _then;

/// Create a copy of MemberApprovalState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isChecking = null,Object? isPollingDisabled = null,Object? isApproved = null,Object? isRejected = null,Object? rejectionReason = freezed,Object? statusFailureOrSuccessOption = null,}) {
  return _then(_MemberApprovalState(
isChecking: null == isChecking ? _self.isChecking : isChecking // ignore: cast_nullable_to_non_nullable
as bool,isPollingDisabled: null == isPollingDisabled ? _self.isPollingDisabled : isPollingDisabled // ignore: cast_nullable_to_non_nullable
as bool,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,isRejected: null == isRejected ? _self.isRejected : isRejected // ignore: cast_nullable_to_non_nullable
as bool,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,statusFailureOrSuccessOption: null == statusFailureOrSuccessOption ? _self.statusFailureOrSuccessOption : statusFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>>,
  ));
}


}

// dart format on
