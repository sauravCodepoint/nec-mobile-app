part of 'complete_profile_bloc.dart';

@freezed
class CompleteProfileEvent with _$CompleteProfileEvent {
  const factory CompleteProfileEvent.getMemberFieldSettings() =
      _GetMemberFieldSettings;
  const factory CompleteProfileEvent.getStates() = _GetStates;
  const factory CompleteProfileEvent.getCities({required String stateCode}) =
      _GetCities;
  const factory CompleteProfileEvent.fieldChanged({
    required String fieldName,
    required String value,
    required MemberFieldSetting field,
  }) = _FieldChanged;
  const factory CompleteProfileEvent.selfieVideoConfirmed({
    required String videoPath,
    String? thumbnailPath,
  }) = _SelfieVideoConfirmed;
  const factory CompleteProfileEvent.selfieVideoRemoved() = _SelfieVideoRemoved;
  const factory CompleteProfileEvent.submitPressed() = _SubmitPressed;
}