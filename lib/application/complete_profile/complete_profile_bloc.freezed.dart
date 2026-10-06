// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompleteProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileEvent()';
}


}

/// @nodoc
class $CompleteProfileEventCopyWith<$Res>  {
$CompleteProfileEventCopyWith(CompleteProfileEvent _, $Res Function(CompleteProfileEvent) __);
}


/// Adds pattern-matching-related methods to [CompleteProfileEvent].
extension CompleteProfileEventPatterns on CompleteProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetMemberFieldSettings value)?  getMemberFieldSettings,TResult Function( _GetStates value)?  getStates,TResult Function( _GetCities value)?  getCities,TResult Function( _FieldChanged value)?  fieldChanged,TResult Function( _SelfieVideoConfirmed value)?  selfieVideoConfirmed,TResult Function( _SelfieVideoRemoved value)?  selfieVideoRemoved,TResult Function( _SubmitPressed value)?  submitPressed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetMemberFieldSettings() when getMemberFieldSettings != null:
return getMemberFieldSettings(_that);case _GetStates() when getStates != null:
return getStates(_that);case _GetCities() when getCities != null:
return getCities(_that);case _FieldChanged() when fieldChanged != null:
return fieldChanged(_that);case _SelfieVideoConfirmed() when selfieVideoConfirmed != null:
return selfieVideoConfirmed(_that);case _SelfieVideoRemoved() when selfieVideoRemoved != null:
return selfieVideoRemoved(_that);case _SubmitPressed() when submitPressed != null:
return submitPressed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetMemberFieldSettings value)  getMemberFieldSettings,required TResult Function( _GetStates value)  getStates,required TResult Function( _GetCities value)  getCities,required TResult Function( _FieldChanged value)  fieldChanged,required TResult Function( _SelfieVideoConfirmed value)  selfieVideoConfirmed,required TResult Function( _SelfieVideoRemoved value)  selfieVideoRemoved,required TResult Function( _SubmitPressed value)  submitPressed,}){
final _that = this;
switch (_that) {
case _GetMemberFieldSettings():
return getMemberFieldSettings(_that);case _GetStates():
return getStates(_that);case _GetCities():
return getCities(_that);case _FieldChanged():
return fieldChanged(_that);case _SelfieVideoConfirmed():
return selfieVideoConfirmed(_that);case _SelfieVideoRemoved():
return selfieVideoRemoved(_that);case _SubmitPressed():
return submitPressed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetMemberFieldSettings value)?  getMemberFieldSettings,TResult? Function( _GetStates value)?  getStates,TResult? Function( _GetCities value)?  getCities,TResult? Function( _FieldChanged value)?  fieldChanged,TResult? Function( _SelfieVideoConfirmed value)?  selfieVideoConfirmed,TResult? Function( _SelfieVideoRemoved value)?  selfieVideoRemoved,TResult? Function( _SubmitPressed value)?  submitPressed,}){
final _that = this;
switch (_that) {
case _GetMemberFieldSettings() when getMemberFieldSettings != null:
return getMemberFieldSettings(_that);case _GetStates() when getStates != null:
return getStates(_that);case _GetCities() when getCities != null:
return getCities(_that);case _FieldChanged() when fieldChanged != null:
return fieldChanged(_that);case _SelfieVideoConfirmed() when selfieVideoConfirmed != null:
return selfieVideoConfirmed(_that);case _SelfieVideoRemoved() when selfieVideoRemoved != null:
return selfieVideoRemoved(_that);case _SubmitPressed() when submitPressed != null:
return submitPressed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  getMemberFieldSettings,TResult Function()?  getStates,TResult Function( String stateCode)?  getCities,TResult Function( String fieldName,  String value,  MemberFieldSetting field)?  fieldChanged,TResult Function( String videoPath,  String? thumbnailPath)?  selfieVideoConfirmed,TResult Function()?  selfieVideoRemoved,TResult Function()?  submitPressed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetMemberFieldSettings() when getMemberFieldSettings != null:
return getMemberFieldSettings();case _GetStates() when getStates != null:
return getStates();case _GetCities() when getCities != null:
return getCities(_that.stateCode);case _FieldChanged() when fieldChanged != null:
return fieldChanged(_that.fieldName,_that.value,_that.field);case _SelfieVideoConfirmed() when selfieVideoConfirmed != null:
return selfieVideoConfirmed(_that.videoPath,_that.thumbnailPath);case _SelfieVideoRemoved() when selfieVideoRemoved != null:
return selfieVideoRemoved();case _SubmitPressed() when submitPressed != null:
return submitPressed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  getMemberFieldSettings,required TResult Function()  getStates,required TResult Function( String stateCode)  getCities,required TResult Function( String fieldName,  String value,  MemberFieldSetting field)  fieldChanged,required TResult Function( String videoPath,  String? thumbnailPath)  selfieVideoConfirmed,required TResult Function()  selfieVideoRemoved,required TResult Function()  submitPressed,}) {final _that = this;
switch (_that) {
case _GetMemberFieldSettings():
return getMemberFieldSettings();case _GetStates():
return getStates();case _GetCities():
return getCities(_that.stateCode);case _FieldChanged():
return fieldChanged(_that.fieldName,_that.value,_that.field);case _SelfieVideoConfirmed():
return selfieVideoConfirmed(_that.videoPath,_that.thumbnailPath);case _SelfieVideoRemoved():
return selfieVideoRemoved();case _SubmitPressed():
return submitPressed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  getMemberFieldSettings,TResult? Function()?  getStates,TResult? Function( String stateCode)?  getCities,TResult? Function( String fieldName,  String value,  MemberFieldSetting field)?  fieldChanged,TResult? Function( String videoPath,  String? thumbnailPath)?  selfieVideoConfirmed,TResult? Function()?  selfieVideoRemoved,TResult? Function()?  submitPressed,}) {final _that = this;
switch (_that) {
case _GetMemberFieldSettings() when getMemberFieldSettings != null:
return getMemberFieldSettings();case _GetStates() when getStates != null:
return getStates();case _GetCities() when getCities != null:
return getCities(_that.stateCode);case _FieldChanged() when fieldChanged != null:
return fieldChanged(_that.fieldName,_that.value,_that.field);case _SelfieVideoConfirmed() when selfieVideoConfirmed != null:
return selfieVideoConfirmed(_that.videoPath,_that.thumbnailPath);case _SelfieVideoRemoved() when selfieVideoRemoved != null:
return selfieVideoRemoved();case _SubmitPressed() when submitPressed != null:
return submitPressed();case _:
  return null;

}
}

}

/// @nodoc


class _GetMemberFieldSettings implements CompleteProfileEvent {
  const _GetMemberFieldSettings();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetMemberFieldSettings);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileEvent.getMemberFieldSettings()';
}


}




/// @nodoc


class _GetStates implements CompleteProfileEvent {
  const _GetStates();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetStates);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileEvent.getStates()';
}


}




/// @nodoc


class _GetCities implements CompleteProfileEvent {
  const _GetCities({required this.stateCode});
  

 final  String stateCode;

/// Create a copy of CompleteProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetCitiesCopyWith<_GetCities> get copyWith => __$GetCitiesCopyWithImpl<_GetCities>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetCities&&(identical(other.stateCode, stateCode) || other.stateCode == stateCode));
}


@override
int get hashCode => Object.hash(runtimeType,stateCode);

@override
String toString() {
  return 'CompleteProfileEvent.getCities(stateCode: $stateCode)';
}


}

/// @nodoc
abstract mixin class _$GetCitiesCopyWith<$Res> implements $CompleteProfileEventCopyWith<$Res> {
  factory _$GetCitiesCopyWith(_GetCities value, $Res Function(_GetCities) _then) = __$GetCitiesCopyWithImpl;
@useResult
$Res call({
 String stateCode
});




}
/// @nodoc
class __$GetCitiesCopyWithImpl<$Res>
    implements _$GetCitiesCopyWith<$Res> {
  __$GetCitiesCopyWithImpl(this._self, this._then);

  final _GetCities _self;
  final $Res Function(_GetCities) _then;

/// Create a copy of CompleteProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stateCode = null,}) {
  return _then(_GetCities(
stateCode: null == stateCode ? _self.stateCode : stateCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FieldChanged implements CompleteProfileEvent {
  const _FieldChanged({required this.fieldName, required this.value, required this.field});
  

 final  String fieldName;
 final  String value;
 final  MemberFieldSetting field;

/// Create a copy of CompleteProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldChangedCopyWith<_FieldChanged> get copyWith => __$FieldChangedCopyWithImpl<_FieldChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldChanged&&(identical(other.fieldName, fieldName) || other.fieldName == fieldName)&&(identical(other.value, value) || other.value == value)&&(identical(other.field, field) || other.field == field));
}


@override
int get hashCode => Object.hash(runtimeType,fieldName,value,field);

@override
String toString() {
  return 'CompleteProfileEvent.fieldChanged(fieldName: $fieldName, value: $value, field: $field)';
}


}

/// @nodoc
abstract mixin class _$FieldChangedCopyWith<$Res> implements $CompleteProfileEventCopyWith<$Res> {
  factory _$FieldChangedCopyWith(_FieldChanged value, $Res Function(_FieldChanged) _then) = __$FieldChangedCopyWithImpl;
@useResult
$Res call({
 String fieldName, String value, MemberFieldSetting field
});


$MemberFieldSettingCopyWith<$Res> get field;

}
/// @nodoc
class __$FieldChangedCopyWithImpl<$Res>
    implements _$FieldChangedCopyWith<$Res> {
  __$FieldChangedCopyWithImpl(this._self, this._then);

  final _FieldChanged _self;
  final $Res Function(_FieldChanged) _then;

/// Create a copy of CompleteProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fieldName = null,Object? value = null,Object? field = null,}) {
  return _then(_FieldChanged(
fieldName: null == fieldName ? _self.fieldName : fieldName // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as MemberFieldSetting,
  ));
}

/// Create a copy of CompleteProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberFieldSettingCopyWith<$Res> get field {
  
  return $MemberFieldSettingCopyWith<$Res>(_self.field, (value) {
    return _then(_self.copyWith(field: value));
  });
}
}

/// @nodoc


class _SelfieVideoConfirmed implements CompleteProfileEvent {
  const _SelfieVideoConfirmed({required this.videoPath, this.thumbnailPath});
  

 final  String videoPath;
 final  String? thumbnailPath;

/// Create a copy of CompleteProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfieVideoConfirmedCopyWith<_SelfieVideoConfirmed> get copyWith => __$SelfieVideoConfirmedCopyWithImpl<_SelfieVideoConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfieVideoConfirmed&&(identical(other.videoPath, videoPath) || other.videoPath == videoPath)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath));
}


@override
int get hashCode => Object.hash(runtimeType,videoPath,thumbnailPath);

@override
String toString() {
  return 'CompleteProfileEvent.selfieVideoConfirmed(videoPath: $videoPath, thumbnailPath: $thumbnailPath)';
}


}

/// @nodoc
abstract mixin class _$SelfieVideoConfirmedCopyWith<$Res> implements $CompleteProfileEventCopyWith<$Res> {
  factory _$SelfieVideoConfirmedCopyWith(_SelfieVideoConfirmed value, $Res Function(_SelfieVideoConfirmed) _then) = __$SelfieVideoConfirmedCopyWithImpl;
@useResult
$Res call({
 String videoPath, String? thumbnailPath
});




}
/// @nodoc
class __$SelfieVideoConfirmedCopyWithImpl<$Res>
    implements _$SelfieVideoConfirmedCopyWith<$Res> {
  __$SelfieVideoConfirmedCopyWithImpl(this._self, this._then);

  final _SelfieVideoConfirmed _self;
  final $Res Function(_SelfieVideoConfirmed) _then;

/// Create a copy of CompleteProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? videoPath = null,Object? thumbnailPath = freezed,}) {
  return _then(_SelfieVideoConfirmed(
videoPath: null == videoPath ? _self.videoPath : videoPath // ignore: cast_nullable_to_non_nullable
as String,thumbnailPath: freezed == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SelfieVideoRemoved implements CompleteProfileEvent {
  const _SelfieVideoRemoved();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfieVideoRemoved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileEvent.selfieVideoRemoved()';
}


}




/// @nodoc


class _SubmitPressed implements CompleteProfileEvent {
  const _SubmitPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteProfileEvent.submitPressed()';
}


}




/// @nodoc
mixin _$CompleteProfileState {

 bool get isLoading; bool get isSubmitting; bool get isLoadingCities; bool get showErrorMessages; Map<String, DynamicFieldInput> get dynamicFieldValues; Map<String, List<CommonSelectableItem>> get comboOptions; Set<String> get lockedFields; String? get selfieVideoPath; String? get selfieVideoThumbnailPath; String? get selfieVideoEId; bool get isSelfieVideoUploading; bool get isSelfieVideoDeleting; Option<CompleteProfileFailure> get videoFailureOption; CommonMemberFieldDto? get memberFieldSettingDto; Option<Either<CompleteProfileFailure, CommonMemberFieldDto>> get memberFieldSettingFailureOrSuccessOption; Option<Either<CompleteProfileFailure, Unit>> get submitFailureOrSuccessOption;
/// Create a copy of CompleteProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteProfileStateCopyWith<CompleteProfileState> get copyWith => _$CompleteProfileStateCopyWithImpl<CompleteProfileState>(this as CompleteProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteProfileState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoadingCities, isLoadingCities) || other.isLoadingCities == isLoadingCities)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&const DeepCollectionEquality().equals(other.dynamicFieldValues, dynamicFieldValues)&&const DeepCollectionEquality().equals(other.comboOptions, comboOptions)&&const DeepCollectionEquality().equals(other.lockedFields, lockedFields)&&(identical(other.selfieVideoPath, selfieVideoPath) || other.selfieVideoPath == selfieVideoPath)&&(identical(other.selfieVideoThumbnailPath, selfieVideoThumbnailPath) || other.selfieVideoThumbnailPath == selfieVideoThumbnailPath)&&(identical(other.selfieVideoEId, selfieVideoEId) || other.selfieVideoEId == selfieVideoEId)&&(identical(other.isSelfieVideoUploading, isSelfieVideoUploading) || other.isSelfieVideoUploading == isSelfieVideoUploading)&&(identical(other.isSelfieVideoDeleting, isSelfieVideoDeleting) || other.isSelfieVideoDeleting == isSelfieVideoDeleting)&&(identical(other.videoFailureOption, videoFailureOption) || other.videoFailureOption == videoFailureOption)&&(identical(other.memberFieldSettingDto, memberFieldSettingDto) || other.memberFieldSettingDto == memberFieldSettingDto)&&(identical(other.memberFieldSettingFailureOrSuccessOption, memberFieldSettingFailureOrSuccessOption) || other.memberFieldSettingFailureOrSuccessOption == memberFieldSettingFailureOrSuccessOption)&&(identical(other.submitFailureOrSuccessOption, submitFailureOrSuccessOption) || other.submitFailureOrSuccessOption == submitFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSubmitting,isLoadingCities,showErrorMessages,const DeepCollectionEquality().hash(dynamicFieldValues),const DeepCollectionEquality().hash(comboOptions),const DeepCollectionEquality().hash(lockedFields),selfieVideoPath,selfieVideoThumbnailPath,selfieVideoEId,isSelfieVideoUploading,isSelfieVideoDeleting,videoFailureOption,memberFieldSettingDto,memberFieldSettingFailureOrSuccessOption,submitFailureOrSuccessOption);

@override
String toString() {
  return 'CompleteProfileState(isLoading: $isLoading, isSubmitting: $isSubmitting, isLoadingCities: $isLoadingCities, showErrorMessages: $showErrorMessages, dynamicFieldValues: $dynamicFieldValues, comboOptions: $comboOptions, lockedFields: $lockedFields, selfieVideoPath: $selfieVideoPath, selfieVideoThumbnailPath: $selfieVideoThumbnailPath, selfieVideoEId: $selfieVideoEId, isSelfieVideoUploading: $isSelfieVideoUploading, isSelfieVideoDeleting: $isSelfieVideoDeleting, videoFailureOption: $videoFailureOption, memberFieldSettingDto: $memberFieldSettingDto, memberFieldSettingFailureOrSuccessOption: $memberFieldSettingFailureOrSuccessOption, submitFailureOrSuccessOption: $submitFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class $CompleteProfileStateCopyWith<$Res>  {
  factory $CompleteProfileStateCopyWith(CompleteProfileState value, $Res Function(CompleteProfileState) _then) = _$CompleteProfileStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSubmitting, bool isLoadingCities, bool showErrorMessages, Map<String, DynamicFieldInput> dynamicFieldValues, Map<String, List<CommonSelectableItem>> comboOptions, Set<String> lockedFields, String? selfieVideoPath, String? selfieVideoThumbnailPath, String? selfieVideoEId, bool isSelfieVideoUploading, bool isSelfieVideoDeleting, Option<CompleteProfileFailure> videoFailureOption, CommonMemberFieldDto? memberFieldSettingDto, Option<Either<CompleteProfileFailure, CommonMemberFieldDto>> memberFieldSettingFailureOrSuccessOption, Option<Either<CompleteProfileFailure, Unit>> submitFailureOrSuccessOption
});


$CommonMemberFieldDtoCopyWith<$Res>? get memberFieldSettingDto;

}
/// @nodoc
class _$CompleteProfileStateCopyWithImpl<$Res>
    implements $CompleteProfileStateCopyWith<$Res> {
  _$CompleteProfileStateCopyWithImpl(this._self, this._then);

  final CompleteProfileState _self;
  final $Res Function(CompleteProfileState) _then;

/// Create a copy of CompleteProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSubmitting = null,Object? isLoadingCities = null,Object? showErrorMessages = null,Object? dynamicFieldValues = null,Object? comboOptions = null,Object? lockedFields = null,Object? selfieVideoPath = freezed,Object? selfieVideoThumbnailPath = freezed,Object? selfieVideoEId = freezed,Object? isSelfieVideoUploading = null,Object? isSelfieVideoDeleting = null,Object? videoFailureOption = null,Object? memberFieldSettingDto = freezed,Object? memberFieldSettingFailureOrSuccessOption = null,Object? submitFailureOrSuccessOption = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoadingCities: null == isLoadingCities ? _self.isLoadingCities : isLoadingCities // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,dynamicFieldValues: null == dynamicFieldValues ? _self.dynamicFieldValues : dynamicFieldValues // ignore: cast_nullable_to_non_nullable
as Map<String, DynamicFieldInput>,comboOptions: null == comboOptions ? _self.comboOptions : comboOptions // ignore: cast_nullable_to_non_nullable
as Map<String, List<CommonSelectableItem>>,lockedFields: null == lockedFields ? _self.lockedFields : lockedFields // ignore: cast_nullable_to_non_nullable
as Set<String>,selfieVideoPath: freezed == selfieVideoPath ? _self.selfieVideoPath : selfieVideoPath // ignore: cast_nullable_to_non_nullable
as String?,selfieVideoThumbnailPath: freezed == selfieVideoThumbnailPath ? _self.selfieVideoThumbnailPath : selfieVideoThumbnailPath // ignore: cast_nullable_to_non_nullable
as String?,selfieVideoEId: freezed == selfieVideoEId ? _self.selfieVideoEId : selfieVideoEId // ignore: cast_nullable_to_non_nullable
as String?,isSelfieVideoUploading: null == isSelfieVideoUploading ? _self.isSelfieVideoUploading : isSelfieVideoUploading // ignore: cast_nullable_to_non_nullable
as bool,isSelfieVideoDeleting: null == isSelfieVideoDeleting ? _self.isSelfieVideoDeleting : isSelfieVideoDeleting // ignore: cast_nullable_to_non_nullable
as bool,videoFailureOption: null == videoFailureOption ? _self.videoFailureOption : videoFailureOption // ignore: cast_nullable_to_non_nullable
as Option<CompleteProfileFailure>,memberFieldSettingDto: freezed == memberFieldSettingDto ? _self.memberFieldSettingDto : memberFieldSettingDto // ignore: cast_nullable_to_non_nullable
as CommonMemberFieldDto?,memberFieldSettingFailureOrSuccessOption: null == memberFieldSettingFailureOrSuccessOption ? _self.memberFieldSettingFailureOrSuccessOption : memberFieldSettingFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<CompleteProfileFailure, CommonMemberFieldDto>>,submitFailureOrSuccessOption: null == submitFailureOrSuccessOption ? _self.submitFailureOrSuccessOption : submitFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<CompleteProfileFailure, Unit>>,
  ));
}
/// Create a copy of CompleteProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonMemberFieldDtoCopyWith<$Res>? get memberFieldSettingDto {
    if (_self.memberFieldSettingDto == null) {
    return null;
  }

  return $CommonMemberFieldDtoCopyWith<$Res>(_self.memberFieldSettingDto!, (value) {
    return _then(_self.copyWith(memberFieldSettingDto: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompleteProfileState].
extension CompleteProfileStatePatterns on CompleteProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompleteProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompleteProfileState value)  $default,){
final _that = this;
switch (_that) {
case _CompleteProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompleteProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _CompleteProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSubmitting,  bool isLoadingCities,  bool showErrorMessages,  Map<String, DynamicFieldInput> dynamicFieldValues,  Map<String, List<CommonSelectableItem>> comboOptions,  Set<String> lockedFields,  String? selfieVideoPath,  String? selfieVideoThumbnailPath,  String? selfieVideoEId,  bool isSelfieVideoUploading,  bool isSelfieVideoDeleting,  Option<CompleteProfileFailure> videoFailureOption,  CommonMemberFieldDto? memberFieldSettingDto,  Option<Either<CompleteProfileFailure, CommonMemberFieldDto>> memberFieldSettingFailureOrSuccessOption,  Option<Either<CompleteProfileFailure, Unit>> submitFailureOrSuccessOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteProfileState() when $default != null:
return $default(_that.isLoading,_that.isSubmitting,_that.isLoadingCities,_that.showErrorMessages,_that.dynamicFieldValues,_that.comboOptions,_that.lockedFields,_that.selfieVideoPath,_that.selfieVideoThumbnailPath,_that.selfieVideoEId,_that.isSelfieVideoUploading,_that.isSelfieVideoDeleting,_that.videoFailureOption,_that.memberFieldSettingDto,_that.memberFieldSettingFailureOrSuccessOption,_that.submitFailureOrSuccessOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSubmitting,  bool isLoadingCities,  bool showErrorMessages,  Map<String, DynamicFieldInput> dynamicFieldValues,  Map<String, List<CommonSelectableItem>> comboOptions,  Set<String> lockedFields,  String? selfieVideoPath,  String? selfieVideoThumbnailPath,  String? selfieVideoEId,  bool isSelfieVideoUploading,  bool isSelfieVideoDeleting,  Option<CompleteProfileFailure> videoFailureOption,  CommonMemberFieldDto? memberFieldSettingDto,  Option<Either<CompleteProfileFailure, CommonMemberFieldDto>> memberFieldSettingFailureOrSuccessOption,  Option<Either<CompleteProfileFailure, Unit>> submitFailureOrSuccessOption)  $default,) {final _that = this;
switch (_that) {
case _CompleteProfileState():
return $default(_that.isLoading,_that.isSubmitting,_that.isLoadingCities,_that.showErrorMessages,_that.dynamicFieldValues,_that.comboOptions,_that.lockedFields,_that.selfieVideoPath,_that.selfieVideoThumbnailPath,_that.selfieVideoEId,_that.isSelfieVideoUploading,_that.isSelfieVideoDeleting,_that.videoFailureOption,_that.memberFieldSettingDto,_that.memberFieldSettingFailureOrSuccessOption,_that.submitFailureOrSuccessOption);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSubmitting,  bool isLoadingCities,  bool showErrorMessages,  Map<String, DynamicFieldInput> dynamicFieldValues,  Map<String, List<CommonSelectableItem>> comboOptions,  Set<String> lockedFields,  String? selfieVideoPath,  String? selfieVideoThumbnailPath,  String? selfieVideoEId,  bool isSelfieVideoUploading,  bool isSelfieVideoDeleting,  Option<CompleteProfileFailure> videoFailureOption,  CommonMemberFieldDto? memberFieldSettingDto,  Option<Either<CompleteProfileFailure, CommonMemberFieldDto>> memberFieldSettingFailureOrSuccessOption,  Option<Either<CompleteProfileFailure, Unit>> submitFailureOrSuccessOption)?  $default,) {final _that = this;
switch (_that) {
case _CompleteProfileState() when $default != null:
return $default(_that.isLoading,_that.isSubmitting,_that.isLoadingCities,_that.showErrorMessages,_that.dynamicFieldValues,_that.comboOptions,_that.lockedFields,_that.selfieVideoPath,_that.selfieVideoThumbnailPath,_that.selfieVideoEId,_that.isSelfieVideoUploading,_that.isSelfieVideoDeleting,_that.videoFailureOption,_that.memberFieldSettingDto,_that.memberFieldSettingFailureOrSuccessOption,_that.submitFailureOrSuccessOption);case _:
  return null;

}
}

}

/// @nodoc


class _CompleteProfileState implements CompleteProfileState {
  const _CompleteProfileState({required this.isLoading, required this.isSubmitting, required this.isLoadingCities, required this.showErrorMessages, required final  Map<String, DynamicFieldInput> dynamicFieldValues, required final  Map<String, List<CommonSelectableItem>> comboOptions, required final  Set<String> lockedFields, this.selfieVideoPath, this.selfieVideoThumbnailPath, this.selfieVideoEId, required this.isSelfieVideoUploading, required this.isSelfieVideoDeleting, required this.videoFailureOption, this.memberFieldSettingDto, required this.memberFieldSettingFailureOrSuccessOption, required this.submitFailureOrSuccessOption}): _dynamicFieldValues = dynamicFieldValues,_comboOptions = comboOptions,_lockedFields = lockedFields;
  

@override final  bool isLoading;
@override final  bool isSubmitting;
@override final  bool isLoadingCities;
@override final  bool showErrorMessages;
 final  Map<String, DynamicFieldInput> _dynamicFieldValues;
@override Map<String, DynamicFieldInput> get dynamicFieldValues {
  if (_dynamicFieldValues is EqualUnmodifiableMapView) return _dynamicFieldValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dynamicFieldValues);
}

 final  Map<String, List<CommonSelectableItem>> _comboOptions;
@override Map<String, List<CommonSelectableItem>> get comboOptions {
  if (_comboOptions is EqualUnmodifiableMapView) return _comboOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_comboOptions);
}

 final  Set<String> _lockedFields;
@override Set<String> get lockedFields {
  if (_lockedFields is EqualUnmodifiableSetView) return _lockedFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_lockedFields);
}

@override final  String? selfieVideoPath;
@override final  String? selfieVideoThumbnailPath;
@override final  String? selfieVideoEId;
@override final  bool isSelfieVideoUploading;
@override final  bool isSelfieVideoDeleting;
@override final  Option<CompleteProfileFailure> videoFailureOption;
@override final  CommonMemberFieldDto? memberFieldSettingDto;
@override final  Option<Either<CompleteProfileFailure, CommonMemberFieldDto>> memberFieldSettingFailureOrSuccessOption;
@override final  Option<Either<CompleteProfileFailure, Unit>> submitFailureOrSuccessOption;

/// Create a copy of CompleteProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteProfileStateCopyWith<_CompleteProfileState> get copyWith => __$CompleteProfileStateCopyWithImpl<_CompleteProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteProfileState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoadingCities, isLoadingCities) || other.isLoadingCities == isLoadingCities)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&const DeepCollectionEquality().equals(other._dynamicFieldValues, _dynamicFieldValues)&&const DeepCollectionEquality().equals(other._comboOptions, _comboOptions)&&const DeepCollectionEquality().equals(other._lockedFields, _lockedFields)&&(identical(other.selfieVideoPath, selfieVideoPath) || other.selfieVideoPath == selfieVideoPath)&&(identical(other.selfieVideoThumbnailPath, selfieVideoThumbnailPath) || other.selfieVideoThumbnailPath == selfieVideoThumbnailPath)&&(identical(other.selfieVideoEId, selfieVideoEId) || other.selfieVideoEId == selfieVideoEId)&&(identical(other.isSelfieVideoUploading, isSelfieVideoUploading) || other.isSelfieVideoUploading == isSelfieVideoUploading)&&(identical(other.isSelfieVideoDeleting, isSelfieVideoDeleting) || other.isSelfieVideoDeleting == isSelfieVideoDeleting)&&(identical(other.videoFailureOption, videoFailureOption) || other.videoFailureOption == videoFailureOption)&&(identical(other.memberFieldSettingDto, memberFieldSettingDto) || other.memberFieldSettingDto == memberFieldSettingDto)&&(identical(other.memberFieldSettingFailureOrSuccessOption, memberFieldSettingFailureOrSuccessOption) || other.memberFieldSettingFailureOrSuccessOption == memberFieldSettingFailureOrSuccessOption)&&(identical(other.submitFailureOrSuccessOption, submitFailureOrSuccessOption) || other.submitFailureOrSuccessOption == submitFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSubmitting,isLoadingCities,showErrorMessages,const DeepCollectionEquality().hash(_dynamicFieldValues),const DeepCollectionEquality().hash(_comboOptions),const DeepCollectionEquality().hash(_lockedFields),selfieVideoPath,selfieVideoThumbnailPath,selfieVideoEId,isSelfieVideoUploading,isSelfieVideoDeleting,videoFailureOption,memberFieldSettingDto,memberFieldSettingFailureOrSuccessOption,submitFailureOrSuccessOption);

@override
String toString() {
  return 'CompleteProfileState(isLoading: $isLoading, isSubmitting: $isSubmitting, isLoadingCities: $isLoadingCities, showErrorMessages: $showErrorMessages, dynamicFieldValues: $dynamicFieldValues, comboOptions: $comboOptions, lockedFields: $lockedFields, selfieVideoPath: $selfieVideoPath, selfieVideoThumbnailPath: $selfieVideoThumbnailPath, selfieVideoEId: $selfieVideoEId, isSelfieVideoUploading: $isSelfieVideoUploading, isSelfieVideoDeleting: $isSelfieVideoDeleting, videoFailureOption: $videoFailureOption, memberFieldSettingDto: $memberFieldSettingDto, memberFieldSettingFailureOrSuccessOption: $memberFieldSettingFailureOrSuccessOption, submitFailureOrSuccessOption: $submitFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class _$CompleteProfileStateCopyWith<$Res> implements $CompleteProfileStateCopyWith<$Res> {
  factory _$CompleteProfileStateCopyWith(_CompleteProfileState value, $Res Function(_CompleteProfileState) _then) = __$CompleteProfileStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSubmitting, bool isLoadingCities, bool showErrorMessages, Map<String, DynamicFieldInput> dynamicFieldValues, Map<String, List<CommonSelectableItem>> comboOptions, Set<String> lockedFields, String? selfieVideoPath, String? selfieVideoThumbnailPath, String? selfieVideoEId, bool isSelfieVideoUploading, bool isSelfieVideoDeleting, Option<CompleteProfileFailure> videoFailureOption, CommonMemberFieldDto? memberFieldSettingDto, Option<Either<CompleteProfileFailure, CommonMemberFieldDto>> memberFieldSettingFailureOrSuccessOption, Option<Either<CompleteProfileFailure, Unit>> submitFailureOrSuccessOption
});


@override $CommonMemberFieldDtoCopyWith<$Res>? get memberFieldSettingDto;

}
/// @nodoc
class __$CompleteProfileStateCopyWithImpl<$Res>
    implements _$CompleteProfileStateCopyWith<$Res> {
  __$CompleteProfileStateCopyWithImpl(this._self, this._then);

  final _CompleteProfileState _self;
  final $Res Function(_CompleteProfileState) _then;

/// Create a copy of CompleteProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSubmitting = null,Object? isLoadingCities = null,Object? showErrorMessages = null,Object? dynamicFieldValues = null,Object? comboOptions = null,Object? lockedFields = null,Object? selfieVideoPath = freezed,Object? selfieVideoThumbnailPath = freezed,Object? selfieVideoEId = freezed,Object? isSelfieVideoUploading = null,Object? isSelfieVideoDeleting = null,Object? videoFailureOption = null,Object? memberFieldSettingDto = freezed,Object? memberFieldSettingFailureOrSuccessOption = null,Object? submitFailureOrSuccessOption = null,}) {
  return _then(_CompleteProfileState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoadingCities: null == isLoadingCities ? _self.isLoadingCities : isLoadingCities // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,dynamicFieldValues: null == dynamicFieldValues ? _self._dynamicFieldValues : dynamicFieldValues // ignore: cast_nullable_to_non_nullable
as Map<String, DynamicFieldInput>,comboOptions: null == comboOptions ? _self._comboOptions : comboOptions // ignore: cast_nullable_to_non_nullable
as Map<String, List<CommonSelectableItem>>,lockedFields: null == lockedFields ? _self._lockedFields : lockedFields // ignore: cast_nullable_to_non_nullable
as Set<String>,selfieVideoPath: freezed == selfieVideoPath ? _self.selfieVideoPath : selfieVideoPath // ignore: cast_nullable_to_non_nullable
as String?,selfieVideoThumbnailPath: freezed == selfieVideoThumbnailPath ? _self.selfieVideoThumbnailPath : selfieVideoThumbnailPath // ignore: cast_nullable_to_non_nullable
as String?,selfieVideoEId: freezed == selfieVideoEId ? _self.selfieVideoEId : selfieVideoEId // ignore: cast_nullable_to_non_nullable
as String?,isSelfieVideoUploading: null == isSelfieVideoUploading ? _self.isSelfieVideoUploading : isSelfieVideoUploading // ignore: cast_nullable_to_non_nullable
as bool,isSelfieVideoDeleting: null == isSelfieVideoDeleting ? _self.isSelfieVideoDeleting : isSelfieVideoDeleting // ignore: cast_nullable_to_non_nullable
as bool,videoFailureOption: null == videoFailureOption ? _self.videoFailureOption : videoFailureOption // ignore: cast_nullable_to_non_nullable
as Option<CompleteProfileFailure>,memberFieldSettingDto: freezed == memberFieldSettingDto ? _self.memberFieldSettingDto : memberFieldSettingDto // ignore: cast_nullable_to_non_nullable
as CommonMemberFieldDto?,memberFieldSettingFailureOrSuccessOption: null == memberFieldSettingFailureOrSuccessOption ? _self.memberFieldSettingFailureOrSuccessOption : memberFieldSettingFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<CompleteProfileFailure, CommonMemberFieldDto>>,submitFailureOrSuccessOption: null == submitFailureOrSuccessOption ? _self.submitFailureOrSuccessOption : submitFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<CompleteProfileFailure, Unit>>,
  ));
}

/// Create a copy of CompleteProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonMemberFieldDtoCopyWith<$Res>? get memberFieldSettingDto {
    if (_self.memberFieldSettingDto == null) {
    return null;
  }

  return $CommonMemberFieldDtoCopyWith<$Res>(_self.memberFieldSettingDto!, (value) {
    return _then(_self.copyWith(memberFieldSettingDto: value));
  });
}
}

// dart format on
