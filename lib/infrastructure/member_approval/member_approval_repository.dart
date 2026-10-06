import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/core/session/session_payload.dart';
import '../../domain/member_approval/i_member_approval_facade.dart';
import '../../domain/member_approval/member_approval_failure.dart';
import '../../domain/member_approval/member_approval_status_dto.dart';
import '../../domain/otp/otp_dto.dart';

@LazySingleton(as: IMemberApprovalFacade)
class MemberApprovalRepository implements IMemberApprovalFacade {
  final ApiServices _apiServices;
  final SharedPrefs _sharedPrefs;

  MemberApprovalRepository(this._apiServices, this._sharedPrefs);

  /// Envelope status codes of the registration-status contract:
  /// 200 = approved, 403 = rejected, 430 = still pending.
  static const _approvedStatusCode = 200;
  static const _rejectedStatusCode = 403;

  // Stable error IDs for the approved-payload session install, mirroring
  // OtpRepository's verify-OTP guard. Every field persisted by
  // [_installSessionFromDto] is required for the app to operate (API auth,
  // token refresh, member-scoped endpoints, MPIN routing), so an approved
  // response that omits one must be refused instead of installing a broken
  // session that only breaks later.
  static const _errMissingUser = 'APR-V01';
  static const _errMissingJwtToken = 'APR-V02';
  static const _errMissingRefreshToken = 'APR-V03';
  static const _errMissingAppMemberCode = 'APR-V04';
  static const _errMissingMemberCode = 'APR-V05';
  static const _errMissingUserName = 'APR-V06';
  static const _errMissingMobileNumber = 'APR-V07';
  static const _errMissingMobileWithoutCode = 'APR-V08';
  static const _errMissingIdNumber = 'APR-V09';
  static const _errMissingMpinFlag = 'APR-V10';

  @override
  Future<Either<MemberApprovalFailure, MemberApprovalStatusDto>>
  checkApprovalStatus() async {
    final appMemberCode = _sharedPrefs.getAppMemberCode();
    // The OTP is stored as the digits the backend verified; a non-numeric or
    // absent value is as unusable as a missing one.
    final otp = int.tryParse(_sharedPrefs.getMemberApprovalOtp() ?? '');
    if (appMemberCode <= 0 || otp == null) {
      return left(const MemberApprovalFailure.missingCredentials());
    }
    try {
      final body = {'app_member_code': appMemberCode, 'o_t_p': otp};
      final response = await _apiServices.postMemberApprovalStatus(body);

      if (response.isSuccessful) {
        final dto = MemberApprovalStatusDto.fromJson(response.body);
        if (dto.statusCode == _approvedStatusCode) {
          // Refuse to install a session with gaps: a missing token or
          // member code would only surface later as opaque 401s or failing
          // member-scoped calls. Failing keeps the awaiting state (marker
          // intact, isApproved never flips), so polling simply tries again.
          final missing = _missingSessionData(dto.data);
          if (missing.isNotEmpty) {
            return left(
              MemberApprovalFailure.unexpectedServerState(missing.join(', ')),
            );
          }
          // Approved — the envelope carries the same session payload as a
          // successful verify-OTP, so persist it the same way. The install
          // also drops the resume marker (and the stored OTP with it) so
          // the next cold start follows normal session routing.
          await _installSessionFromDto(dto);
        }
        return right(dto);
      }

      // Non-2xx still carries the business answer in the error body:
      // 430 = still pending (data.registration_status e.g. "Pending
      // Verification"), 403 = rejected. Anything that isn't the JSON
      // envelope (HTML 5xx, timeouts) fails the cast and is a real error.
      final errorMap = response.error as Map<String, dynamic>?;
      if (errorMap == null) {
        return left(const MemberApprovalFailure.serverError());
      }
      final dto = MemberApprovalStatusDto.fromJson(errorMap);
      if (dto.statusCode == _rejectedStatusCode) {
        // Rejected is terminal too — clear the marker so the user is not
        // routed back here. The stored app_member_code is kept: a
        // re-registration after rejection overwrites it via the KYC flow.
        await _sharedPrefs.clearMemberApprovalPending();
      }
      return right(dto);
    } catch (e) {
      return left(const MemberApprovalFailure.serverError());
    }
  }

  /// Returns the error IDs of every response field required by
  /// [_installSessionFromDto] that the backend omitted, in a stable order.
  /// Empty means the session payload is complete and safe to persist.
  List<String> _missingSessionData(MemberApprovalStatusDataDto? data) {
    final user = data?.user;
    if (data == null || user == null) return const [_errMissingUser];
    return [
      if ((data.jwtToken ?? '').isEmpty) _errMissingJwtToken,
      if ((data.refreshToken ?? '').isEmpty) _errMissingRefreshToken,
      if ((user.appMemberCode ?? 0) <= 0) _errMissingAppMemberCode,
      if ((user.memberCode ?? 0) <= 0) _errMissingMemberCode,
      if ((user.name ?? '').isEmpty) _errMissingUserName,
      if ((user.mobileNumber ?? '').isEmpty) _errMissingMobileNumber,
      if ((user.mobileNumberWithOutCode ?? '').isEmpty)
        _errMissingMobileWithoutCode,
      if ((user.idNumber ?? '').isEmpty) _errMissingIdNumber,
      if (user.isMPINCreated == null) _errMissingMpinFlag,
    ];
  }

  /// Persists the approved session exactly like the verify-OTP flow does.
  /// The wire user is re-parsed into the shared session [User] model — the
  /// JSON contract is identical — because [SessionPayload] is common to
  /// every auth flow. The payload has already been validated by
  /// [_missingSessionData].
  Future<void> _installSessionFromDto(MemberApprovalStatusDto dto) async {
    final data = dto.data!;
    final user = User.fromJson(data.user!.toJson());
    await _sharedPrefs.installSession(
      SessionPayload(
        token: data.jwtToken ?? '',
        refreshToken: data.refreshToken ?? '',
        appMemberCode: user.appMemberCode ?? 0,
        memberCode: user.memberCode ?? 0,
        userName: user.name ?? '',
        mobileNumber: user.mobileNumber ?? '',
        mobileNumberWithOutCode: user.mobileNumberWithOutCode ?? '',
        idNumber: user.idNumber ?? '',
        isMpinCreated: user.isMPINCreated ?? false,
        user: user,
      ),
    );
  }
}
