part of 'splash_bloc.dart';

/// Represents the various states of the `SplashBloc`.
///
/// These states are used to manage the splash screen logic, such as tracking
/// the progress of authentication checks and determining the next screen to navigate to.
@freezed
sealed class SplashState with _$SplashState {
  /// Represents the initial state of the splash screen.
  const factory SplashState.initial() = _Initial;

  /// Represents the state when the authentication check is in progress.
  const factory SplashState.loadingProgress() = _LoadingProgress;

  /// Represents the state when the onboarding screen should be displayed.
  const factory SplashState.loadedSuccessOnBoarding() =
  _LoadedSuccessOnBoarding;

  /// Represents the state when the login screen should be displayed.
  const factory SplashState.loadedSuccessLogin() = _LoadedSuccessLogin;

  /// Represents the state when a previously requested OTP is still within
  /// its TTL window, so the user can resume the OTP screen instead of
  /// triggering a new SMS.
  const factory SplashState.loadedSuccessOtpPending({
    required String idType,
    required String idNumber,
    required String mobileNumber,
  }) = _LoadedSuccessOtpPending;

  /// User passed OTP into a registration flow but didn't finish before
  /// killing the app. Splash routes them back to the screen they left
  /// (KYC or CompleteProfile) instead of forcing a fresh OTP.
  const factory SplashState.loadedSuccessRegistrationPending(
      PendingRegistration registration,
      ) = _LoadedSuccessRegistrationPending;

  /// User submitted registration and is awaiting back-office approval. Splash
  /// routes them back to the awaiting-approval screen on every cold-start
  /// until they're approved and sign in.
  const factory SplashState.loadedSuccessApprovalPending() =
  _LoadedSuccessApprovalPending;

  /// Represents the state when the MPIN setup screen should be displayed.
  const factory SplashState.loadedSuccessSetMpin() = _LoadedSuccessSetMpin;

  /// Represents the state when the main application screen should be displayed.
  const factory SplashState.loadedSuccessMain() = _LoadedSuccessMain;

  /// Represents the state when an error occurs during the authentication check.
  ///
  /// - `message`: A string describing the error that occurred.
  const factory SplashState.loadedFailure(String message) = _LoadedFailure;
}
