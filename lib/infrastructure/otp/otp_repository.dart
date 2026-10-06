import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/device_helper/app_device_helper.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/core/session/pending_registration.dart';
import '../../domain/core/session/post_otp_outcome.dart';
import '../../domain/core/session/session_payload.dart';
import '../../domain/otp/i_otp_facade.dart';
import '../../domain/otp/otp_dto.dart';
import '../../domain/otp/otp_failure.dart';
import '../../domain/otp/value_validators.dart';

@LazySingleton(as: IOtpFacade)
class OtpRepository implements IOtpFacade {
  final ApiServices _apiServices;
  final SharedPrefs _sharedPrefs;
  final AppDeviceHelper _deviceHelper;
  OtpRepository(this._apiServices, this._sharedPrefs, this._deviceHelper);

  // Stable error IDs for the verify-OTP flow. Every field persisted by
  // [_installSessionFromDto] is required for the app to operate (API auth,
  // token refresh, member-scoped endpoints, MPIN routing), so a response
  // that omits one must fail fast with the matching ID instead of
  // installing a broken session that only breaks later. The ID is shown in
  // the failure dialog, so a user report pinpoints the exact missing field.
  static const _errMissingUser = 'OTP-V01';
  static const _errMissingJwtToken = 'OTP-V02';
  static const _errMissingRefreshToken = 'OTP-V03';
  static const _errMissingAppMemberCode = 'OTP-V04';
  static const _errMissingMemberCode = 'OTP-V05';
  static const _errMissingUserName = 'OTP-V06';
  static const _errMissingMobileNumber = 'OTP-V07';
  static const _errMissingMobileWithoutCode = 'OTP-V08';
  static const _errMissingIdNumber = 'OTP-V09';
  static const _errMissingMpinFlag = 'OTP-V10';
  static const _errUnregisteredMember = 'OTP-V11';

  @override
  Future<Either<OtpFailure, Unit>> resendOtp({
    required String identityTypeCode,
    required int countryCode,
    required String identityNumber,
    required String phoneNumber,
  }) async {
    try {
      final deviceDetails = await _deviceHelper.getDeviceDetailsPayload();
      final body = {
        'identity_type_code': identityTypeCode,
        'mobile_code': countryCode,
        'mobile_number': phoneNumber,
        'id_number': identityNumber,
        "resend_otp_status": 1,
        'device_details': deviceDetails,
      };
      final response = await _apiServices.postRequestOtp(body);
      if (response.isSuccessful) {
        return right(unit);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(OtpFailure.unableToSendOtp(message));
      }
    } catch (e) {
      return left(OtpFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<OtpFailure, PostOtpOutcome>> verifyOtp({
    required String identityTypeCode,
    required int countryCode,
    required String identityNumber,
    required String phoneNumber,
    required Otp otpCode,
  }) async {
    try {
      final body = {
        'identity_type_code': identityTypeCode,
        'mobile_code': countryCode,
        'mobile_number': phoneNumber,
        'id_number': identityNumber,
        'o_t_p': int.parse(otpCode.getOrCrash()),
      };
      final response = await _apiServices.postVerifyOtp(body);

      if (response.isSuccessful) {
        final bodyMap = response.body as Map<String, dynamic>?;
        // 202 (HTTP or the envelope's status_code) = OTP accepted but the
        // account is still awaiting back-office approval — typically a
        // re-login after the app was uninstalled while pending, which wiped
        // the approval-resume state. Rebuild it: the marker (so cold starts
        // route back to the awaiting screen) and the freshly verified OTP the
        // status-polling API requires. The body carries no user/session —
        // only data.app_member_code — so this must be intercepted before the
        // normal outcome resolution.
        final envelopeStatus = (bodyMap?['status_code'] as num?)?.toInt();
        if (response.statusCode == 202 || envelopeStatus == 202) {
          final appMemberCode = _appMemberCodeFromBody(bodyMap);
          if (appMemberCode > 0) {
            await _sharedPrefs.setAppMemberCode(appMemberCode);
          }
          await _sharedPrefs.setMemberApprovalOtp(otpCode.getOrCrash());
          await _sharedPrefs.setMemberApprovalPending(true);
          return right(const PostOtpOutcome.pendingApproval());
        }
        final otpDto = OtpDto.fromJson(response.body);
        return _resolveOutcome(
          otpDto,
          requestIdType: identityTypeCode,
          requestIdNumber: identityNumber,
          requestMobile: phoneNumber,
        );
      }

      final errorMap = response.error as Map<String, dynamic>?;
      final message = errorMap?['message']?.toString() ?? '';
      if (response.statusCode == 430) {
        // 430 = OTP accepted but the user isn't registered yet — they now head
        // into KYC → Registration. The member-approval status API that follows
        // registration needs this exact (already-consumed) OTP again, and the
        // in-memory copy won't survive a cold start, so persist it here.
        await _sharedPrefs.setMemberApprovalOtp(otpCode.getOrCrash());
        return left(OtpFailure.userIsNotRegistered(message));
      }
      return left(OtpFailure.invalidOtp(message: message));
    } catch (e) {
      return left(OtpFailure.serverError(e.toString()));
    }
  }

  /// Pulls `app_member_code` out of a 202 pending-approval body, tolerating
  /// the flat `data.app_member_code` the contract uses, the standard
  /// envelope (`data.user.app_member_code`), or a top-level field. Returns 0
  /// when absent — the approval screen then degrades to its static form
  /// instead of polling.
  int _appMemberCodeFromBody(Map<String, dynamic>? bodyMap) {
    final data = bodyMap?['data'];
    final user = data is Map<String, dynamic> ? data['user'] : null;
    final candidates = [
      if (data is Map<String, dynamic>) data['app_member_code'],
      if (user is Map<String, dynamic>) user['app_member_code'],
      bodyMap?['app_member_code'],
    ];
    for (final candidate in candidates) {
      if (candidate is num && candidate > 0) return candidate.toInt();
    }
    return 0;
  }

  /// Maps the verify-OTP response onto exactly one [PostOtpOutcome] and
  /// installs the session if the outcome warrants it. Centralising the
  /// decision here means OtpBloc and OtpPage never read DTO booleans
  /// directly and can never miss an edge combination.
  ///
  /// Request fields are passed in so the resume marker for the
  /// CompleteProfile branch carries the original identity (the response
  /// is the authoritative source for everything except the mobile/id the
  /// user just typed, which we need verbatim for downstream API calls).
  Future<Either<OtpFailure, PostOtpOutcome>> _resolveOutcome(
    OtpDto dto, {
    required String requestIdType,
    required String requestIdNumber,
    required String requestMobile,
  }) async {
    final data = dto.data;
    final user = data?.user;
    // The failure carries only the error ID(s); the OTP page wraps them in
    // a translated, user-friendly dialog message.
    if (user == null) {
      return left(const OtpFailure.unexpectedServerState(_errMissingUser));
    }

    final hasAppMemberCode = (user.appMemberCode ?? 0) > 0;
    final isRegistered = user.isUserRegistered ?? false;
    final hasMpin = user.isMPINCreated ?? false;

    // Profile incomplete — no app_member_code means downstream APIs that
    // key off it (MPIN, home, beneficiary) would fail. Do not install a
    // session; the user must finish registration first.
    if (!hasAppMemberCode) {
      // A successful OTP supersedes any older pending-OTP record.
      await _sharedPrefs.clearPendingOtp();
      // The profile-completion endpoints (member-field settings with user
      // data) are authenticated even though no full session exists yet, so
      // persist just the tokens from this response. isLoggedIn stays false,
      // so splash keeps routing by the marker — this is not a session
      // install.
      final jwtToken = data?.jwtToken ?? '';
      if (jwtToken.isNotEmpty) await _sharedPrefs.setToken(jwtToken);
      final refreshToken = data?.refreshToken ?? '';
      if (refreshToken.isNotEmpty) {
        await _sharedPrefs.setRefreshToken(refreshToken);
      }
      await _sharedPrefs.setPendingRegistration(
        PendingRegistration.completeProfile(
          idType: requestIdType,
          idNumber: requestIdNumber,
          mobile: requestMobile,
          appMemberCode: user.appMemberCode ?? 0,
          user: user,
        ),
      );
      return right(PostOtpOutcome.pendingProfile(user));
    }

    // Fully registered — install session and pick MPIN-setup vs. main
    // shell based on whether they've already set an MPIN.
    if (isRegistered) {
      // Refuse to install a session with gaps: a missing token or member
      // code would only surface later as opaque 401s or failing
      // member-scoped calls. Failing here keeps any pending-registration
      // record intact so a retry can still resume.
      final missing = _missingSessionData(data!, user);
      if (missing.isNotEmpty) {
        return left(OtpFailure.unexpectedServerState(missing.join(', ')));
      }
      // Any stale registration-resume record is moot now.
      await _sharedPrefs.clearPendingRegistration();
      await _installSessionFromDto(data, user);
      return right(
        hasMpin
            ? PostOtpOutcome.completeSession(user)
            : PostOtpOutcome.pendingMpinSetup(user),
      );
    }

    // Has an app_member_code but isn't flagged as registered. Should not
    // happen against a healthy backend — surface it as a recoverable
    // failure rather than silently doing nothing.
    return left(const OtpFailure.unexpectedServerState(_errUnregisteredMember));
  }

  /// Returns the error IDs of every response field required by
  /// [_installSessionFromDto] that the backend omitted, in a stable order.
  /// Empty means the session payload is complete and safe to persist.
  List<String> _missingSessionData(Data data, User user) => [
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

  Future<void> _installSessionFromDto(Data data, User user) async {
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
