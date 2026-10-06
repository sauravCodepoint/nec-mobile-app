// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_update_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppUpdateEvent {

 String get languageCode;
/// Create a copy of AppUpdateEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUpdateEventCopyWith<AppUpdateEvent> get copyWith => _$AppUpdateEventCopyWithImpl<AppUpdateEvent>(this as AppUpdateEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUpdateEvent&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode);

@override
String toString() {
  return 'AppUpdateEvent(languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class $AppUpdateEventCopyWith<$Res>  {
  factory $AppUpdateEventCopyWith(AppUpdateEvent value, $Res Function(AppUpdateEvent) _then) = _$AppUpdateEventCopyWithImpl;
@useResult
$Res call({
 String languageCode
});




}
/// @nodoc
class _$AppUpdateEventCopyWithImpl<$Res>
    implements $AppUpdateEventCopyWith<$Res> {
  _$AppUpdateEventCopyWithImpl(this._self, this._then);

  final AppUpdateEvent _self;
  final $Res Function(AppUpdateEvent) _then;

/// Create a copy of AppUpdateEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageCode = null,}) {
  return _then(_self.copyWith(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUpdateEvent].
extension AppUpdateEventPatterns on AppUpdateEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CheckRequested value)?  checkRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckRequested() when checkRequested != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CheckRequested value)  checkRequested,}){
final _that = this;
switch (_that) {
case _CheckRequested():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CheckRequested value)?  checkRequested,}){
final _that = this;
switch (_that) {
case _CheckRequested() when checkRequested != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String languageCode)?  checkRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckRequested() when checkRequested != null:
return checkRequested(_that.languageCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String languageCode)  checkRequested,}) {final _that = this;
switch (_that) {
case _CheckRequested():
return checkRequested(_that.languageCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String languageCode)?  checkRequested,}) {final _that = this;
switch (_that) {
case _CheckRequested() when checkRequested != null:
return checkRequested(_that.languageCode);case _:
  return null;

}
}

}

/// @nodoc


class _CheckRequested implements AppUpdateEvent {
  const _CheckRequested({required this.languageCode});
  

@override final  String languageCode;

/// Create a copy of AppUpdateEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckRequestedCopyWith<_CheckRequested> get copyWith => __$CheckRequestedCopyWithImpl<_CheckRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckRequested&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode);

@override
String toString() {
  return 'AppUpdateEvent.checkRequested(languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class _$CheckRequestedCopyWith<$Res> implements $AppUpdateEventCopyWith<$Res> {
  factory _$CheckRequestedCopyWith(_CheckRequested value, $Res Function(_CheckRequested) _then) = __$CheckRequestedCopyWithImpl;
@override @useResult
$Res call({
 String languageCode
});




}
/// @nodoc
class __$CheckRequestedCopyWithImpl<$Res>
    implements _$CheckRequestedCopyWith<$Res> {
  __$CheckRequestedCopyWithImpl(this._self, this._then);

  final _CheckRequested _self;
  final $Res Function(_CheckRequested) _then;

/// Create a copy of AppUpdateEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageCode = null,}) {
  return _then(_CheckRequested(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AppUpdateState {

 bool get hasChecked; Option<Either<AppUpdateFailure, AppUpdateDto>> get appUpdateFailureOrSuccessOption;
/// Create a copy of AppUpdateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUpdateStateCopyWith<AppUpdateState> get copyWith => _$AppUpdateStateCopyWithImpl<AppUpdateState>(this as AppUpdateState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUpdateState&&(identical(other.hasChecked, hasChecked) || other.hasChecked == hasChecked)&&(identical(other.appUpdateFailureOrSuccessOption, appUpdateFailureOrSuccessOption) || other.appUpdateFailureOrSuccessOption == appUpdateFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,hasChecked,appUpdateFailureOrSuccessOption);

@override
String toString() {
  return 'AppUpdateState(hasChecked: $hasChecked, appUpdateFailureOrSuccessOption: $appUpdateFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class $AppUpdateStateCopyWith<$Res>  {
  factory $AppUpdateStateCopyWith(AppUpdateState value, $Res Function(AppUpdateState) _then) = _$AppUpdateStateCopyWithImpl;
@useResult
$Res call({
 bool hasChecked, Option<Either<AppUpdateFailure, AppUpdateDto>> appUpdateFailureOrSuccessOption
});




}
/// @nodoc
class _$AppUpdateStateCopyWithImpl<$Res>
    implements $AppUpdateStateCopyWith<$Res> {
  _$AppUpdateStateCopyWithImpl(this._self, this._then);

  final AppUpdateState _self;
  final $Res Function(AppUpdateState) _then;

/// Create a copy of AppUpdateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasChecked = null,Object? appUpdateFailureOrSuccessOption = null,}) {
  return _then(_self.copyWith(
hasChecked: null == hasChecked ? _self.hasChecked : hasChecked // ignore: cast_nullable_to_non_nullable
as bool,appUpdateFailureOrSuccessOption: null == appUpdateFailureOrSuccessOption ? _self.appUpdateFailureOrSuccessOption : appUpdateFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<AppUpdateFailure, AppUpdateDto>>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUpdateState].
extension AppUpdateStatePatterns on AppUpdateState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUpdateState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUpdateState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUpdateState value)  $default,){
final _that = this;
switch (_that) {
case _AppUpdateState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUpdateState value)?  $default,){
final _that = this;
switch (_that) {
case _AppUpdateState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasChecked,  Option<Either<AppUpdateFailure, AppUpdateDto>> appUpdateFailureOrSuccessOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUpdateState() when $default != null:
return $default(_that.hasChecked,_that.appUpdateFailureOrSuccessOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasChecked,  Option<Either<AppUpdateFailure, AppUpdateDto>> appUpdateFailureOrSuccessOption)  $default,) {final _that = this;
switch (_that) {
case _AppUpdateState():
return $default(_that.hasChecked,_that.appUpdateFailureOrSuccessOption);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasChecked,  Option<Either<AppUpdateFailure, AppUpdateDto>> appUpdateFailureOrSuccessOption)?  $default,) {final _that = this;
switch (_that) {
case _AppUpdateState() when $default != null:
return $default(_that.hasChecked,_that.appUpdateFailureOrSuccessOption);case _:
  return null;

}
}

}

/// @nodoc


class _AppUpdateState implements AppUpdateState {
  const _AppUpdateState({required this.hasChecked, required this.appUpdateFailureOrSuccessOption});
  

@override final  bool hasChecked;
@override final  Option<Either<AppUpdateFailure, AppUpdateDto>> appUpdateFailureOrSuccessOption;

/// Create a copy of AppUpdateState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUpdateStateCopyWith<_AppUpdateState> get copyWith => __$AppUpdateStateCopyWithImpl<_AppUpdateState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUpdateState&&(identical(other.hasChecked, hasChecked) || other.hasChecked == hasChecked)&&(identical(other.appUpdateFailureOrSuccessOption, appUpdateFailureOrSuccessOption) || other.appUpdateFailureOrSuccessOption == appUpdateFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,hasChecked,appUpdateFailureOrSuccessOption);

@override
String toString() {
  return 'AppUpdateState(hasChecked: $hasChecked, appUpdateFailureOrSuccessOption: $appUpdateFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class _$AppUpdateStateCopyWith<$Res> implements $AppUpdateStateCopyWith<$Res> {
  factory _$AppUpdateStateCopyWith(_AppUpdateState value, $Res Function(_AppUpdateState) _then) = __$AppUpdateStateCopyWithImpl;
@override @useResult
$Res call({
 bool hasChecked, Option<Either<AppUpdateFailure, AppUpdateDto>> appUpdateFailureOrSuccessOption
});




}
/// @nodoc
class __$AppUpdateStateCopyWithImpl<$Res>
    implements _$AppUpdateStateCopyWith<$Res> {
  __$AppUpdateStateCopyWithImpl(this._self, this._then);

  final _AppUpdateState _self;
  final $Res Function(_AppUpdateState) _then;

/// Create a copy of AppUpdateState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasChecked = null,Object? appUpdateFailureOrSuccessOption = null,}) {
  return _then(_AppUpdateState(
hasChecked: null == hasChecked ? _self.hasChecked : hasChecked // ignore: cast_nullable_to_non_nullable
as bool,appUpdateFailureOrSuccessOption: null == appUpdateFailureOrSuccessOption ? _self.appUpdateFailureOrSuccessOption : appUpdateFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<AppUpdateFailure, AppUpdateDto>>,
  ));
}


}

// dart format on
