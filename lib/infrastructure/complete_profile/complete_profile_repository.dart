import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../domain/complete_profile/complete_profile_city_dto.dart';
import '../../domain/complete_profile/complete_profile_failure.dart';
import '../../domain/common/common_member_field_dto.dart';
import '../../domain/complete_profile/complete_profile_state_dto.dart';
import '../../domain/complete_profile/i_complete_profile_facade.dart';
import '../../domain/core/compressor/media_compressor.dart';
import '../../domain/core/device_helper/app_device_helper.dart';
import '../../domain/core/multipdart/multipart_service.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/core/session/pending_registration.dart';
import '../../domain/core/session/session_payload.dart';
import '../../domain/complete_profile/complete_profile_submit_dto.dart';
import '../../presentation/core/global/app_global.dart';
import '../../presentation/routes/app_routes.dart';

@LazySingleton(as: ICompleteProfileFacade)
class CompleteProfileRepository implements ICompleteProfileFacade {
  final ApiServices _apiServices;
  final SharedPrefs _sharedPrefs;
  final AppRouter _appRouter;
  final AppDeviceHelper _deviceHelper;

  CompleteProfileRepository(
    this._apiServices,
    this._sharedPrefs,
    this._appRouter,
    this._deviceHelper,
  );

  /// ISO country code for Oman — the only country this app registers states /
  /// cities for.
  static const _countryCode = 'OM';

  // Stable error IDs for the submit-profile flow. On success the backend
  // returns a fresh session (same envelope as verify-OTP); every field
  // persisted by [_installSessionFromDto] is required for the app to
  // operate (API auth, token refresh, member-scoped endpoints, MPIN
  // routing), so a response that omits one must fail fast with the
  // matching ID instead of installing a broken session that only breaks
  // later. The ID is shown in the failure dialog, so a user report
  // pinpoints the exact missing field.
  static const _errMissingUser = 'CPR-V01';
  static const _errMissingJwtToken = 'CPR-V02';
  static const _errMissingRefreshToken = 'CPR-V03';
  static const _errMissingAppMemberCode = 'CPR-V04';
  static const _errMissingMemberCode = 'CPR-V05';
  static const _errMissingUserName = 'CPR-V06';
  static const _errMissingMobileNumber = 'CPR-V07';
  static const _errMissingMobileWithoutCode = 'CPR-V08';
  static const _errMissingIdNumber = 'CPR-V09';
  static const _errMissingMpinFlag = 'CPR-V10';

  @override
  Future<Either<CompleteProfileFailure, CommonMemberFieldDto>>
  getMemberFieldSettings() async {
    try {
      final locale =
          _appRouter.navigatorKey.currentContext?.locale.languageCode;
      final language = locale == 'ar' ? 'ar' : 'en';
      // The member codes tell the backend this is a profile-completion fetch:
      // it returns each field's default_value prefilled with the member's
      // saved data (registration sends no codes and gets blank defaults).
      // Sourced from the per-flow resume marker — the authoritative value
      // captured at OTP time — falling back to the global prefs only when no
      // marker is present (see submitProfile).
      final pending = _sharedPrefs.getPendingRegistration();
      final token = _sharedPrefs.getToken();
      final (idType, idNumber, mobile, memberCode) =
          pending?.maybeWhen<(String, String, String, int)?>(
            completeProfile: (idType, idNumber, mobile, _, user) =>
                (idType, idNumber, mobile, user.memberCode ?? 0),
            orElse: () => null,
          ) ??
          // No marker (e.g. resumed from an installed session): the global
          // prefs hold the same identity, except the identity type, which
          // is never persisted outside the marker.
          (
            '',
            _sharedPrefs.getIdNumber() ?? '',
            _sharedPrefs.getMobileNumberWithOutCode() ?? '',
            _sharedPrefs.getMemberCode(),
          );
      final response = await _apiServices.getMemberFieldSettingsWithData(
        token: token,
        queryParams: {
          'mobile_code': AppGlobal.appCountryCode,
          'member_code': memberCode,
          'mobile_number': mobile,
          'id_number': idNumber,
          'identity_type_code': idType,
          'language': language,
        },
      );
      if (response.isSuccessful) {
        final dto = CommonMemberFieldDto.fromJson(response.body);
        return right(dto);
      }
      return left(const CompleteProfileFailure.unableToGetFieldSettings());
    } catch (e) {
      return left(const CompleteProfileFailure.serverError());
    }
  }

  @override
  Future<Either<CompleteProfileFailure, CompleteProfileStateDto>>
  getStates() async {
    try {
      final response = await _apiServices.getStateCombo(
        queryParams: {'CountryCode': _countryCode},
      );
      if (response.isSuccessful) {
        final dto = CompleteProfileStateDto.fromJson(response.body);
        return right(dto);
      }
      return left(const CompleteProfileFailure.unableToGetStates());
    } catch (e) {
      return left(const CompleteProfileFailure.serverError());
    }
  }

  @override
  Future<Either<CompleteProfileFailure, CompleteProfileCityDto>> getCities(
    String stateCode,
  ) async {
    try {
      final response = await _apiServices.getCityCombo(
        queryParams: {'CountryCode': _countryCode, 'StateCode': stateCode},
      );
      if (response.isSuccessful) {
        final dto = CompleteProfileCityDto.fromJson(response.body);
        return right(dto);
      }
      return left(const CompleteProfileFailure.unableToGetCities());
    } catch (e) {
      return left(const CompleteProfileFailure.serverError());
    }
  }

  @override
  Future<Either<CompleteProfileFailure, String>> uploadSelfieVideo({
    required File file,
  }) async {
    try {
      final compressed = await MediaCompressor.compressVideo(file);
      final multipart = await MultipartService.convertFile(
        'file',
        compressed.path,
      );
      final response = await _apiServices.uploadDocs(
        module: 'KYC Video',
        moduleCode: 5020,
        docName: 'Profile Selfie ${file.uri.pathSegments.last}',
        file: multipart,
      );
      if (compressed.path != file.path) compressed.delete().ignore();
      if (response.isSuccessful) {
        final eId = response.body['data']['e_id']?.toString() ?? '';
        file.delete().ignore();
        return right(eId);
      }
      final errorMap = response.error as Map<String, dynamic>?;
      final message =
          errorMap?['message']?.toString() ?? 'Selfie video upload failed';
      return left(CompleteProfileFailure.selfieVideoUploadFailed(message));
    } catch (e) {
      return left(const CompleteProfileFailure.serverError());
    }
  }

  @override
  Future<Either<CompleteProfileFailure, Unit>> deleteSelfieVideo({
    required String eId,
  }) async {
    try {
      final response = await _apiServices.deleteDocs(body: {'e_id': eId});
      if (response.isSuccessful) return right(unit);
      final errorMap = response.error as Map<String, dynamic>?;
      final message =
          errorMap?['message']?.toString() ?? 'Failed to delete selfie video';
      return left(CompleteProfileFailure.selfieVideoDeleteFailed(message));
    } catch (e) {
      return left(const CompleteProfileFailure.serverError());
    }
  }

  @override
  Future<Either<CompleteProfileFailure, Unit>> submitProfile(
    Map<String, dynamic> data,
  ) async {
    try {
      // Source the member code from the per-flow resume marker — the
      // authoritative value captured for this user at OTP time — rather than
      // the global pref, which on a shared device can still hold a previous
      // user's app_member_code (it is only overwritten by a full login or KYC).
      final pending = _sharedPrefs.getPendingRegistration();
      final appMemberCode =
          pending?.maybeWhen(
            completeProfile: (_, _, _, code, _) => code,
            orElse: () => _sharedPrefs.getAppMemberCode(),
          ) ??
          _sharedPrefs.getAppMemberCode();
      // member_code comes from the same OTP-time user payload captured in the
      // resume marker — the authoritative value for this user — falling back to
      // the global pref only when no marker is present.
      final memberCode =
          pending?.maybeWhen(
            completeProfile: (_, _, _, _, user) => user.memberCode ?? 0,
            orElse: () => _sharedPrefs.getMemberCode(),
          ) ??
          _sharedPrefs.getMemberCode();
      // Submit issues a fresh session (same envelope as verify-OTP), so it
      // reports the device like every other session-issuing call. Spread
      // after `data` so nothing can clobber it.
      final deviceDetails = await _deviceHelper.getDeviceDetailsPayload();
      final body = {
        'app_member_code': appMemberCode,
        'member_code': memberCode,
        ...data,
        'device_details': deviceDetails,
      };
      final response = await _apiServices.postCompleteProfile(body);
      if (response.isSuccessful) {
        final dto = CompleteProfileSubmitDto.fromJson(response.body);
        return _installSessionFromSubmit(dto);
      }
      final errorMap = response.error as Map<String, dynamic>?;
      final message = errorMap?['message']?.toString() ?? '';
      return left(CompleteProfileFailure.unableToSubmit(message));
    } catch (e) {
      return left(const CompleteProfileFailure.serverError());
    }
  }

  /// Validates the session credentials returned by the submit call and, if
  /// complete, installs them so the user can proceed straight to MPIN setup
  /// without a separate login. Mirrors OtpRepository's registered branch:
  /// refuse to install a session with gaps — a missing token or member code
  /// would only surface later as opaque 401s or failing member-scoped calls.
  /// On failure the pending-registration marker is kept so a re-login via
  /// OTP can still install the session and resume the flow.
  Future<Either<CompleteProfileFailure, Unit>> _installSessionFromSubmit(
    CompleteProfileSubmitDto dto,
  ) async {
    final data = dto.data;
    final user = data?.user;
    // The failure carries only the error ID(s); the CompleteProfile page
    // wraps them in a translated, user-friendly dialog message.
    if (user == null) {
      return left(
        const CompleteProfileFailure.unexpectedServerState(_errMissingUser),
      );
    }

    final missing = _missingSessionData(data!, user);
    if (missing.isNotEmpty) {
      return left(
        CompleteProfileFailure.unexpectedServerState(missing.join(', ')),
      );
    }

    // Profile is complete and the session is about to be installed — drop
    // the resume marker so a cold-start follows normal session routing
    // (isMpinCreated=false → SetMpin) instead of bringing the user back here.
    await _sharedPrefs.clearPendingRegistration();
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
        user: user.toSessionUser(),
      ),
    );
    return right(unit);
  }

  /// Returns the error IDs of every response field required to install the
  /// session that the backend omitted, in a stable order. Empty means the
  /// session payload is complete and safe to persist.
  List<String> _missingSessionData(
    CompleteProfileSubmitData data,
    CompleteProfileSubmitUser user,
  ) => [
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
