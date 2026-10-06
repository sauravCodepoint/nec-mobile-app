import 'package:freezed_annotation/freezed_annotation.dart';
part 'forgot_mpin_failure.freezed.dart';

@freezed
abstract class ForgotMpinFailure with _$ForgotMpinFailure {
  const factory ForgotMpinFailure.unableToFetchIdentityTypes(String? message) =
      _UnableToFetchIdentityTypes;
  const factory ForgotMpinFailure.invalidCredentials(String? message) =
      _InvalidCredentials;
  const factory ForgotMpinFailure.unableToSendOtp(String? message) =
      _UnableToSendOtp;
  const factory ForgotMpinFailure.invalidOtp(String? message) = _InvalidOtp;

  /// OTP accepted but the account is still awaiting back-office approval
  /// (verify-OTP 202) — there is no session to recover an MPIN for, so the
  /// flow must stop here.
  const factory ForgotMpinFailure.pendingApproval(String? message) =
      _PendingApproval;

  /// OTP accepted but the identity isn't registered (verify-OTP 430, or a
  /// success body without `is_user_registered`) — there is no account, so no
  /// MPIN to recover.
  const factory ForgotMpinFailure.userNotRegistered(String? message) =
      _UserNotRegistered;
  const factory ForgotMpinFailure.serverError() = _ServerError;
}
