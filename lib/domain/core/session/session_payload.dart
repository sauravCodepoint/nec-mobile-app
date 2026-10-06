import '../../otp/otp_dto.dart';

/// Single-shot bundle describing everything needed to install an
/// authenticated session into local storage. Constructed by whichever
/// auth flow produced the credentials (OTP verify, MPIN verify, biometric
/// verify, registration, etc.) and consumed by
/// [SharedPrefs.installSession].
///
/// Centralising the field list here means callers can never forget a write
/// (or write fields in inconsistent combinations), which was the source
/// of the half-installed-session bugs the splash bloc currently self-heals.
class SessionPayload {
  final String token;
  final String refreshToken;
  final int appMemberCode;
  final int memberCode;
  final String userName;
  final String mobileNumber;
  final String mobileNumberWithOutCode;
  final String idNumber;
  final bool isMpinCreated;
  final User user;

  const SessionPayload({
    required this.token,
    required this.refreshToken,
    required this.appMemberCode,
    required this.memberCode,
    required this.userName,
    required this.mobileNumber,
    required this.mobileNumberWithOutCode,
    required this.idNumber,
    required this.isMpinCreated,
    required this.user,
  });
}
