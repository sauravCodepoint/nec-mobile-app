import 'package:freezed_annotation/freezed_annotation.dart';

import '../../otp/otp_dto.dart';

part 'pending_registration.freezed.dart';

/// Resume marker for the CompleteProfile flow, which the user reaches via
/// OTP but has not yet finished. Persisted to prefs so a kill-and-reopen
/// lands the user back on the screen they left instead of forcing a fresh
/// OTP (which costs another SMS).
///
/// The in-app KYC and Registration flows were removed, so CompleteProfile
/// is the only variant left; the union is kept (rather than collapsed to a
/// plain class) so prefs can keep rejecting unknown step markers.
///
/// Lives independently of the authenticated session — these flows don't
/// have a JWT yet, so we cannot use the same install/clear hooks. The
/// marker is cleared on explicit success, on user back-out, or whenever a
/// new OTP flow overwrites it.
@freezed
sealed class PendingRegistration with _$PendingRegistration {
  /// User passed OTP and the server returned an existing record with no
  /// `app_member_code`. They were sent into CompleteProfile with the
  /// returned [User] payload prefilling the form.
  const factory PendingRegistration.completeProfile({
    required String idType,
    required String idNumber,
    required String mobile,
    required int appMemberCode,
    required User user,
  }) = _CompleteProfile;
}
