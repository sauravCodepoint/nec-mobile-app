// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SupportEvent {

 String get languageCode;
/// Create a copy of SupportEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportEventCopyWith<SupportEvent> get copyWith => _$SupportEventCopyWithImpl<SupportEvent>(this as SupportEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportEvent&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode);

@override
String toString() {
  return 'SupportEvent(languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class $SupportEventCopyWith<$Res>  {
  factory $SupportEventCopyWith(SupportEvent value, $Res Function(SupportEvent) _then) = _$SupportEventCopyWithImpl;
@useResult
$Res call({
 String languageCode
});




}
/// @nodoc
class _$SupportEventCopyWithImpl<$Res>
    implements $SupportEventCopyWith<$Res> {
  _$SupportEventCopyWithImpl(this._self, this._then);

  final SupportEvent _self;
  final $Res Function(SupportEvent) _then;

/// Create a copy of SupportEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageCode = null,}) {
  return _then(_self.copyWith(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportEvent].
extension SupportEventPatterns on SupportEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetContactDetails value)?  getContactDetails,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetContactDetails() when getContactDetails != null:
return getContactDetails(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetContactDetails value)  getContactDetails,}){
final _that = this;
switch (_that) {
case _GetContactDetails():
return getContactDetails(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetContactDetails value)?  getContactDetails,}){
final _that = this;
switch (_that) {
case _GetContactDetails() when getContactDetails != null:
return getContactDetails(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String languageCode)?  getContactDetails,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetContactDetails() when getContactDetails != null:
return getContactDetails(_that.languageCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String languageCode)  getContactDetails,}) {final _that = this;
switch (_that) {
case _GetContactDetails():
return getContactDetails(_that.languageCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String languageCode)?  getContactDetails,}) {final _that = this;
switch (_that) {
case _GetContactDetails() when getContactDetails != null:
return getContactDetails(_that.languageCode);case _:
  return null;

}
}

}

/// @nodoc


class _GetContactDetails implements SupportEvent {
  const _GetContactDetails({required this.languageCode});
  

@override final  String languageCode;

/// Create a copy of SupportEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetContactDetailsCopyWith<_GetContactDetails> get copyWith => __$GetContactDetailsCopyWithImpl<_GetContactDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetContactDetails&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode);

@override
String toString() {
  return 'SupportEvent.getContactDetails(languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class _$GetContactDetailsCopyWith<$Res> implements $SupportEventCopyWith<$Res> {
  factory _$GetContactDetailsCopyWith(_GetContactDetails value, $Res Function(_GetContactDetails) _then) = __$GetContactDetailsCopyWithImpl;
@override @useResult
$Res call({
 String languageCode
});




}
/// @nodoc
class __$GetContactDetailsCopyWithImpl<$Res>
    implements _$GetContactDetailsCopyWith<$Res> {
  __$GetContactDetailsCopyWithImpl(this._self, this._then);

  final _GetContactDetails _self;
  final $Res Function(_GetContactDetails) _then;

/// Create a copy of SupportEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageCode = null,}) {
  return _then(_GetContactDetails(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SupportState {

 SupportContactDto? get contactDto; Option<Either<SupportFailure, SupportContactDto>> get contactFailureOrSuccessOption;
/// Create a copy of SupportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportStateCopyWith<SupportState> get copyWith => _$SupportStateCopyWithImpl<SupportState>(this as SupportState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportState&&(identical(other.contactDto, contactDto) || other.contactDto == contactDto)&&(identical(other.contactFailureOrSuccessOption, contactFailureOrSuccessOption) || other.contactFailureOrSuccessOption == contactFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,contactDto,contactFailureOrSuccessOption);

@override
String toString() {
  return 'SupportState(contactDto: $contactDto, contactFailureOrSuccessOption: $contactFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class $SupportStateCopyWith<$Res>  {
  factory $SupportStateCopyWith(SupportState value, $Res Function(SupportState) _then) = _$SupportStateCopyWithImpl;
@useResult
$Res call({
 SupportContactDto? contactDto, Option<Either<SupportFailure, SupportContactDto>> contactFailureOrSuccessOption
});


$SupportContactDtoCopyWith<$Res>? get contactDto;

}
/// @nodoc
class _$SupportStateCopyWithImpl<$Res>
    implements $SupportStateCopyWith<$Res> {
  _$SupportStateCopyWithImpl(this._self, this._then);

  final SupportState _self;
  final $Res Function(SupportState) _then;

/// Create a copy of SupportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contactDto = freezed,Object? contactFailureOrSuccessOption = null,}) {
  return _then(_self.copyWith(
contactDto: freezed == contactDto ? _self.contactDto : contactDto // ignore: cast_nullable_to_non_nullable
as SupportContactDto?,contactFailureOrSuccessOption: null == contactFailureOrSuccessOption ? _self.contactFailureOrSuccessOption : contactFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SupportFailure, SupportContactDto>>,
  ));
}
/// Create a copy of SupportState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportContactDtoCopyWith<$Res>? get contactDto {
    if (_self.contactDto == null) {
    return null;
  }

  return $SupportContactDtoCopyWith<$Res>(_self.contactDto!, (value) {
    return _then(_self.copyWith(contactDto: value));
  });
}
}


/// Adds pattern-matching-related methods to [SupportState].
extension SupportStatePatterns on SupportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportState value)  $default,){
final _that = this;
switch (_that) {
case _SupportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportState value)?  $default,){
final _that = this;
switch (_that) {
case _SupportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SupportContactDto? contactDto,  Option<Either<SupportFailure, SupportContactDto>> contactFailureOrSuccessOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportState() when $default != null:
return $default(_that.contactDto,_that.contactFailureOrSuccessOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SupportContactDto? contactDto,  Option<Either<SupportFailure, SupportContactDto>> contactFailureOrSuccessOption)  $default,) {final _that = this;
switch (_that) {
case _SupportState():
return $default(_that.contactDto,_that.contactFailureOrSuccessOption);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SupportContactDto? contactDto,  Option<Either<SupportFailure, SupportContactDto>> contactFailureOrSuccessOption)?  $default,) {final _that = this;
switch (_that) {
case _SupportState() when $default != null:
return $default(_that.contactDto,_that.contactFailureOrSuccessOption);case _:
  return null;

}
}

}

/// @nodoc


class _SupportState implements SupportState {
  const _SupportState({this.contactDto, required this.contactFailureOrSuccessOption});
  

@override final  SupportContactDto? contactDto;
@override final  Option<Either<SupportFailure, SupportContactDto>> contactFailureOrSuccessOption;

/// Create a copy of SupportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportStateCopyWith<_SupportState> get copyWith => __$SupportStateCopyWithImpl<_SupportState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportState&&(identical(other.contactDto, contactDto) || other.contactDto == contactDto)&&(identical(other.contactFailureOrSuccessOption, contactFailureOrSuccessOption) || other.contactFailureOrSuccessOption == contactFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,contactDto,contactFailureOrSuccessOption);

@override
String toString() {
  return 'SupportState(contactDto: $contactDto, contactFailureOrSuccessOption: $contactFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class _$SupportStateCopyWith<$Res> implements $SupportStateCopyWith<$Res> {
  factory _$SupportStateCopyWith(_SupportState value, $Res Function(_SupportState) _then) = __$SupportStateCopyWithImpl;
@override @useResult
$Res call({
 SupportContactDto? contactDto, Option<Either<SupportFailure, SupportContactDto>> contactFailureOrSuccessOption
});


@override $SupportContactDtoCopyWith<$Res>? get contactDto;

}
/// @nodoc
class __$SupportStateCopyWithImpl<$Res>
    implements _$SupportStateCopyWith<$Res> {
  __$SupportStateCopyWithImpl(this._self, this._then);

  final _SupportState _self;
  final $Res Function(_SupportState) _then;

/// Create a copy of SupportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contactDto = freezed,Object? contactFailureOrSuccessOption = null,}) {
  return _then(_SupportState(
contactDto: freezed == contactDto ? _self.contactDto : contactDto // ignore: cast_nullable_to_non_nullable
as SupportContactDto?,contactFailureOrSuccessOption: null == contactFailureOrSuccessOption ? _self.contactFailureOrSuccessOption : contactFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SupportFailure, SupportContactDto>>,
  ));
}

/// Create a copy of SupportState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportContactDtoCopyWith<$Res>? get contactDto {
    if (_self.contactDto == null) {
    return null;
  }

  return $SupportContactDtoCopyWith<$Res>(_self.contactDto!, (value) {
    return _then(_self.copyWith(contactDto: value));
  });
}
}

// dart format on
