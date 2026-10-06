part of 'settings_bloc.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool isUserLoading,
    /// True until [_CheckBiometricSupport] resolves — availability is unknown,
    /// so the page holds a skeleton in the biometric row's place instead of
    /// letting the real tile pop in and push the list down.
    required bool isBiometricChecking,
    required bool isBiometricAvailable,
    required bool isBiometricEnabled,
    required bool isAuthenticating,
    SettingsUserDto? settingsUserInfo,
    required Option<Either<SettingsFailure, SettingsUserDto>>
        userInfoFailureOrSuccessOption,
  }) = _SettingsState;

  factory SettingsState.initial() => SettingsState(
    isUserLoading: false,
    isBiometricChecking: true,
    isBiometricAvailable: false,
    isBiometricEnabled: false,
    isAuthenticating: false,
    userInfoFailureOrSuccessOption: none(),
  );
}