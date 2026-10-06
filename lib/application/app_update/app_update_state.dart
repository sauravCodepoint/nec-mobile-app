part of 'app_update_bloc.dart';

@freezed
sealed class AppUpdateState with _$AppUpdateState {
  const factory AppUpdateState({
    required bool hasChecked,
    required Option<Either<AppUpdateFailure, AppUpdateDto>>
    appUpdateFailureOrSuccessOption,
  }) = _AppUpdateState;

  factory AppUpdateState.initial() => AppUpdateState(
    hasChecked: false,
    appUpdateFailureOrSuccessOption: none(),
  );
}
