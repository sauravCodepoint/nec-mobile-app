// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_info_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyInfoEvent {

 CompanyInfoType get companyInfoType;
/// Create a copy of CompanyInfoEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyInfoEventCopyWith<CompanyInfoEvent> get copyWith => _$CompanyInfoEventCopyWithImpl<CompanyInfoEvent>(this as CompanyInfoEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyInfoEvent&&(identical(other.companyInfoType, companyInfoType) || other.companyInfoType == companyInfoType));
}


@override
int get hashCode => Object.hash(runtimeType,companyInfoType);

@override
String toString() {
  return 'CompanyInfoEvent(companyInfoType: $companyInfoType)';
}


}

/// @nodoc
abstract mixin class $CompanyInfoEventCopyWith<$Res>  {
  factory $CompanyInfoEventCopyWith(CompanyInfoEvent value, $Res Function(CompanyInfoEvent) _then) = _$CompanyInfoEventCopyWithImpl;
@useResult
$Res call({
 CompanyInfoType companyInfoType
});




}
/// @nodoc
class _$CompanyInfoEventCopyWithImpl<$Res>
    implements $CompanyInfoEventCopyWith<$Res> {
  _$CompanyInfoEventCopyWithImpl(this._self, this._then);

  final CompanyInfoEvent _self;
  final $Res Function(CompanyInfoEvent) _then;

/// Create a copy of CompanyInfoEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? companyInfoType = null,}) {
  return _then(_self.copyWith(
companyInfoType: null == companyInfoType ? _self.companyInfoType : companyInfoType // ignore: cast_nullable_to_non_nullable
as CompanyInfoType,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyInfoEvent].
extension CompanyInfoEventPatterns on CompanyInfoEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetCompanyInfo value)?  getCompanyInfo,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetCompanyInfo() when getCompanyInfo != null:
return getCompanyInfo(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetCompanyInfo value)  getCompanyInfo,}){
final _that = this;
switch (_that) {
case _GetCompanyInfo():
return getCompanyInfo(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetCompanyInfo value)?  getCompanyInfo,}){
final _that = this;
switch (_that) {
case _GetCompanyInfo() when getCompanyInfo != null:
return getCompanyInfo(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CompanyInfoType companyInfoType)?  getCompanyInfo,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetCompanyInfo() when getCompanyInfo != null:
return getCompanyInfo(_that.companyInfoType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CompanyInfoType companyInfoType)  getCompanyInfo,}) {final _that = this;
switch (_that) {
case _GetCompanyInfo():
return getCompanyInfo(_that.companyInfoType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CompanyInfoType companyInfoType)?  getCompanyInfo,}) {final _that = this;
switch (_that) {
case _GetCompanyInfo() when getCompanyInfo != null:
return getCompanyInfo(_that.companyInfoType);case _:
  return null;

}
}

}

/// @nodoc


class _GetCompanyInfo implements CompanyInfoEvent {
  const _GetCompanyInfo(this.companyInfoType);
  

@override final  CompanyInfoType companyInfoType;

/// Create a copy of CompanyInfoEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetCompanyInfoCopyWith<_GetCompanyInfo> get copyWith => __$GetCompanyInfoCopyWithImpl<_GetCompanyInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetCompanyInfo&&(identical(other.companyInfoType, companyInfoType) || other.companyInfoType == companyInfoType));
}


@override
int get hashCode => Object.hash(runtimeType,companyInfoType);

@override
String toString() {
  return 'CompanyInfoEvent.getCompanyInfo(companyInfoType: $companyInfoType)';
}


}

/// @nodoc
abstract mixin class _$GetCompanyInfoCopyWith<$Res> implements $CompanyInfoEventCopyWith<$Res> {
  factory _$GetCompanyInfoCopyWith(_GetCompanyInfo value, $Res Function(_GetCompanyInfo) _then) = __$GetCompanyInfoCopyWithImpl;
@override @useResult
$Res call({
 CompanyInfoType companyInfoType
});




}
/// @nodoc
class __$GetCompanyInfoCopyWithImpl<$Res>
    implements _$GetCompanyInfoCopyWith<$Res> {
  __$GetCompanyInfoCopyWithImpl(this._self, this._then);

  final _GetCompanyInfo _self;
  final $Res Function(_GetCompanyInfo) _then;

/// Create a copy of CompanyInfoEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? companyInfoType = null,}) {
  return _then(_GetCompanyInfo(
null == companyInfoType ? _self.companyInfoType : companyInfoType // ignore: cast_nullable_to_non_nullable
as CompanyInfoType,
  ));
}


}

/// @nodoc
mixin _$CompanyInfoState {

 bool get isLoading; Option<Either<CompanyInfoFailure, CompanyInfoDto>> get companyInfoFailureOrSuccessOption;
/// Create a copy of CompanyInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyInfoStateCopyWith<CompanyInfoState> get copyWith => _$CompanyInfoStateCopyWithImpl<CompanyInfoState>(this as CompanyInfoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyInfoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.companyInfoFailureOrSuccessOption, companyInfoFailureOrSuccessOption) || other.companyInfoFailureOrSuccessOption == companyInfoFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,companyInfoFailureOrSuccessOption);

@override
String toString() {
  return 'CompanyInfoState(isLoading: $isLoading, companyInfoFailureOrSuccessOption: $companyInfoFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class $CompanyInfoStateCopyWith<$Res>  {
  factory $CompanyInfoStateCopyWith(CompanyInfoState value, $Res Function(CompanyInfoState) _then) = _$CompanyInfoStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Option<Either<CompanyInfoFailure, CompanyInfoDto>> companyInfoFailureOrSuccessOption
});




}
/// @nodoc
class _$CompanyInfoStateCopyWithImpl<$Res>
    implements $CompanyInfoStateCopyWith<$Res> {
  _$CompanyInfoStateCopyWithImpl(this._self, this._then);

  final CompanyInfoState _self;
  final $Res Function(CompanyInfoState) _then;

/// Create a copy of CompanyInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? companyInfoFailureOrSuccessOption = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,companyInfoFailureOrSuccessOption: null == companyInfoFailureOrSuccessOption ? _self.companyInfoFailureOrSuccessOption : companyInfoFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<CompanyInfoFailure, CompanyInfoDto>>,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyInfoState].
extension CompanyInfoStatePatterns on CompanyInfoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyInfoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyInfoState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyInfoState value)  $default,){
final _that = this;
switch (_that) {
case _CompanyInfoState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyInfoState value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyInfoState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  Option<Either<CompanyInfoFailure, CompanyInfoDto>> companyInfoFailureOrSuccessOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyInfoState() when $default != null:
return $default(_that.isLoading,_that.companyInfoFailureOrSuccessOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  Option<Either<CompanyInfoFailure, CompanyInfoDto>> companyInfoFailureOrSuccessOption)  $default,) {final _that = this;
switch (_that) {
case _CompanyInfoState():
return $default(_that.isLoading,_that.companyInfoFailureOrSuccessOption);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  Option<Either<CompanyInfoFailure, CompanyInfoDto>> companyInfoFailureOrSuccessOption)?  $default,) {final _that = this;
switch (_that) {
case _CompanyInfoState() when $default != null:
return $default(_that.isLoading,_that.companyInfoFailureOrSuccessOption);case _:
  return null;

}
}

}

/// @nodoc


class _CompanyInfoState implements CompanyInfoState {
  const _CompanyInfoState({required this.isLoading, required this.companyInfoFailureOrSuccessOption});
  

@override final  bool isLoading;
@override final  Option<Either<CompanyInfoFailure, CompanyInfoDto>> companyInfoFailureOrSuccessOption;

/// Create a copy of CompanyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyInfoStateCopyWith<_CompanyInfoState> get copyWith => __$CompanyInfoStateCopyWithImpl<_CompanyInfoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyInfoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.companyInfoFailureOrSuccessOption, companyInfoFailureOrSuccessOption) || other.companyInfoFailureOrSuccessOption == companyInfoFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,companyInfoFailureOrSuccessOption);

@override
String toString() {
  return 'CompanyInfoState(isLoading: $isLoading, companyInfoFailureOrSuccessOption: $companyInfoFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class _$CompanyInfoStateCopyWith<$Res> implements $CompanyInfoStateCopyWith<$Res> {
  factory _$CompanyInfoStateCopyWith(_CompanyInfoState value, $Res Function(_CompanyInfoState) _then) = __$CompanyInfoStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Option<Either<CompanyInfoFailure, CompanyInfoDto>> companyInfoFailureOrSuccessOption
});




}
/// @nodoc
class __$CompanyInfoStateCopyWithImpl<$Res>
    implements _$CompanyInfoStateCopyWith<$Res> {
  __$CompanyInfoStateCopyWithImpl(this._self, this._then);

  final _CompanyInfoState _self;
  final $Res Function(_CompanyInfoState) _then;

/// Create a copy of CompanyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? companyInfoFailureOrSuccessOption = null,}) {
  return _then(_CompanyInfoState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,companyInfoFailureOrSuccessOption: null == companyInfoFailureOrSuccessOption ? _self.companyInfoFailureOrSuccessOption : companyInfoFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<CompanyInfoFailure, CompanyInfoDto>>,
  ));
}


}

// dart format on
