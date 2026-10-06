import 'package:freezed_annotation/freezed_annotation.dart';
part 'otp_failure.freezed.dart';

@freezed
sealed class OtpFailure with _$OtpFailure {
  const factory OtpFailure.mpinNotCreated({String? message}) = MpinNotCreated;
  const factory OtpFailure.invalidOtp({String? message}) = InvalidOtp;
  const factory OtpFailure.userIsNotRegistered(String? message) =
      UserIsNotRegistered;
  const factory OtpFailure.unableToSendOtp(String? message) = UnableToSendOtp;
  const factory OtpFailure.serverError(String? message) = ServerError;
  // Emitted when the verify-OTP response is technically successful but its
  // boolean flags describe a combination the client cannot route from
  // (e.g. registered + no app_member_code). Lets the UI show a recoverable
  // error instead of silently doing nothing.
  const factory OtpFailure.unexpectedServerState(String? message) =
      UnexpectedServerState;
}
