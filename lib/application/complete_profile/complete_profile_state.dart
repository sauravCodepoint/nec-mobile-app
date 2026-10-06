part of 'complete_profile_bloc.dart';

@freezed
sealed class CompleteProfileState with _$CompleteProfileState {
  const factory CompleteProfileState({
    required bool isLoading,
    required bool isSubmitting,
    required bool isLoadingCities,
    required bool showErrorMessages,
    required Map<String, DynamicFieldInput> dynamicFieldValues,
    required Map<String, List<CommonSelectableItem>> comboOptions,
    required Set<String> lockedFields,
    String? selfieVideoPath,
    String? selfieVideoThumbnailPath,
    String? selfieVideoEId,
    required bool isSelfieVideoUploading,
    required bool isSelfieVideoDeleting,
    required Option<CompleteProfileFailure> videoFailureOption,
    CommonMemberFieldDto? memberFieldSettingDto,
    required Option<Either<CompleteProfileFailure, CommonMemberFieldDto>>
        memberFieldSettingFailureOrSuccessOption,
    required Option<Either<CompleteProfileFailure, Unit>>
        submitFailureOrSuccessOption,
  }) = _CompleteProfileState;

  factory CompleteProfileState.initial() => CompleteProfileState(
    isLoading: false,
    isSubmitting: false,
    isLoadingCities: false,
    showErrorMessages: false,
    dynamicFieldValues: {},
    comboOptions: {},
    lockedFields: const {},
    isSelfieVideoUploading: false,
    isSelfieVideoDeleting: false,
    videoFailureOption: none(),
    memberFieldSettingFailureOrSuccessOption: none(),
    submitFailureOrSuccessOption: none(),
  );
}