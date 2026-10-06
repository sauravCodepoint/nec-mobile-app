import 'package:freezed_annotation/freezed_annotation.dart';

import '../../otp/otp_dto.dart';

part 'post_otp_outcome.freezed.dart';

/// The canonical post-OTP-verification decision, derived from the server
/// response. Owning this in the domain layer (rather than reinspecting DTO
/// booleans inside the UI) means presentation code only has to map an
/// outcome to a route — never to interpret server state.
@freezed
sealed class PostOtpOutcome with _$PostOtpOutcome {
  /// Fully registered user with an MPIN already set. Session has been
  /// installed; the next step is the authenticated home shell.
  const factory PostOtpOutcome.completeSession(User user) = _CompleteSession;

  /// Registered user but no MPIN yet. Session has been installed so the
  /// user can submit the MPIN setup request.
  const factory PostOtpOutcome.pendingMpinSetup(User user) = _PendingMpinSetup;

  /// Profile incomplete (no app_member_code). No session installed — the
  /// user must finish registration before tokens can be trusted.
  const factory PostOtpOutcome.pendingProfile(User user) = _PendingProfile;

  /// Registration submitted but the back office hasn't approved the member
  /// yet (verify-OTP 406) — e.g. the user reinstalled the app while waiting.
  /// No session installed; the approval-resume markers have been re-persisted
  /// and the next stop is the awaiting-approval screen.
  const factory PostOtpOutcome.pendingApproval() = _PendingApproval;
}
