part of 'otp_bloc.dart';

@freezed
sealed class OtpState with _$OtpState {
  const factory OtpState({
    required bool isLoading,
    required bool showErrorMessages,
    required bool isSubmitting,
    required String identityType,
    required String identityNumber,
    required String mobileNumber,
    required Otp otp,
    // When the current OTP was dispatched. Drives the resend countdown so it
    // survives kill-and-reopen instead of resetting to a fresh 60s each time.
    required DateTime? requestedAt,
    required Option<Either<OtpFailure, Unit>> resendOtpFailureOrSuccessOption,
    required Option<Either<OtpFailure, PostOtpOutcome>>
    otpFailureOrSuccessOption,
  }) = _OtpState;

  factory OtpState.initial() => OtpState(
    isLoading: false,
    showErrorMessages: false,
    isSubmitting: false,
    identityType: '',
    identityNumber: '',
    mobileNumber: '',
    otp: Otp(''),
    requestedAt: null,
    resendOtpFailureOrSuccessOption: none(),
    otpFailureOrSuccessOption: none(),
  );
}
