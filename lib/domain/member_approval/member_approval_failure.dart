import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_approval_failure.freezed.dart';

@freezed
sealed class MemberApprovalFailure with _$MemberApprovalFailure {
  const factory MemberApprovalFailure.serverError() = _ServerError;

  /// The stored app_member_code or verified OTP the status API requires is
  /// missing (e.g. partially cleared prefs). Polling must stop — the screen
  /// degrades to its static form; retrying cannot succeed.
  const factory MemberApprovalFailure.missingCredentials() =
      _MissingCredentials;

  /// An approved (200) response omitted fields the session install requires
  /// — installing would only break later as opaque 401s, so the session is
  /// refused and the awaiting state kept. [message] carries the error ID(s)
  /// of the missing fields.
  const factory MemberApprovalFailure.unexpectedServerState(String message) =
      _UnexpectedServerState;
}
