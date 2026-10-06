import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/device_helper/app_device_helper.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/forgot_mpin/forgot_id_identity_dto.dart';
import '../../domain/forgot_mpin/forgot_mpin_failure.dart';
import '../../domain/forgot_mpin/forgot_mpin_otp_dto.dart';
import '../../domain/forgot_mpin/i_forgot_mpin_facade.dart';
import '../../domain/forgot_mpin/value_validators.dart';

@LazySingleton(as: IForgotMpinFacade)
class ForgotMpinRepository implements IForgotMpinFacade {
  final ApiServices _apiServices;
  final AppDeviceHelper _deviceHelper;
  final SharedPrefs _sharedPrefs;
  ForgotMpinRepository(
    this._apiServices,
    this._deviceHelper,
    this._sharedPrefs,
  );
  @override
  Future<Either<ForgotMpinFailure, ForgotIdIdentityDto>>
  getIdentityTypes() async {
    try {
      final response = await _apiServices.getKycComboList();
      if (response.isSuccessful) {
        final loginIdIdentityDto = ForgotIdIdentityDto.fromJson(response.body);
        return right(loginIdIdentityDto);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(ForgotMpinFailure.unableToFetchIdentityTypes(message));
      }
    } catch (e) {
      return left(const ForgotMpinFailure.serverError());
    }
  }

  @override
  Future<Either<ForgotMpinFailure, Unit>> requestOtp({
    required String identityTypeCode,
    required int countryCode,
    required MobileNumber mobileNumber,
    required IdentityNumber identityNumber,
  }) async {
    final deviceDetails = await _deviceHelper.getDeviceDetailsPayload();
    try {
      final body = {
        'identity_type_code': identityTypeCode,
        'mobile_code': countryCode,
        'mobile_number': mobileNumber.getOrCrash(),
        'id_number': identityNumber.getOrCrash(),
        "resend_otp_status": 1,
        'device_details': deviceDetails,
      };
      final response = await _apiServices.postRequestOtp(body);
      if (response.isSuccessful) {
        return right(unit);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(ForgotMpinFailure.invalidCredentials(message));
      }
    } catch (e) {
      return left(const ForgotMpinFailure.serverError());
    }
  }

  @override
  Future<Either<ForgotMpinFailure, Unit>> resendOtp({
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
        return left(ForgotMpinFailure.unableToSendOtp(message));
      }
    } catch (e) {
      return left(ForgotMpinFailure.serverError());
    }
  }

  @override
  Future<Either<ForgotMpinFailure, ForgotMpinOtpDto>> verifyOtp({
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
        // 202 (HTTP or the envelope's status_code) = OTP accepted but the
        // account is still awaiting back-office approval — no user/session
        // exists to recover an MPIN for. Fail so the flow stops here instead
        // of falling through as an empty "success" and routing to Set-MPIN
        // without a session.
        final bodyMap = response.body as Map<String, dynamic>?;
        final envelopeStatus = (bodyMap?['status_code'] as num?)?.toInt();
        if (response.statusCode == 202 || envelopeStatus == 202) {
          return left(
            ForgotMpinFailure.pendingApproval(bodyMap?['message']?.toString()),
          );
        }
        final dto = ForgotMpinOtpDto.fromJson(response.body);
        final data = dto.data;
        final user = data?.user;
        // No registered user in the body = nothing to recover an MPIN for.
        // Fail instead of returning a sessionless "success" that would
        // route to Set-MPIN with no tokens installed.
        if (user?.isUserRegistered != true) {
          return left(ForgotMpinFailure.userNotRegistered(dto.message));
        }
        await _sharedPrefs.setToken(data?.jwtToken ?? '');
        await _sharedPrefs.setRefreshToken(data?.refreshToken ?? '');
        await _sharedPrefs.setAppMemberCode(user?.appMemberCode ?? 0);
        await _sharedPrefs.setMemberCode(user?.memberCode ?? 0);
        await _sharedPrefs.setUserName(user?.name ?? '');
        await _sharedPrefs.setMobileNumber(user?.mobileNumber ?? '');
        await _sharedPrefs.setMobileNumberWithOutCode(
          user?.mobileNumberWithOutCode ?? '',
        );
        await _sharedPrefs.setIdNumber(user?.idNumber ?? '');
        await _sharedPrefs.setIsLoggedIn(true);
        await _sharedPrefs.setMpin(user?.isMPINCreated ?? false);
        return right(dto);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        // 430 = OTP accepted but this identity was never registered (same
        // contract as the login verify-OTP flow).
        if (response.statusCode == 430) {
          return left(ForgotMpinFailure.userNotRegistered(message));
        }
        return left(ForgotMpinFailure.invalidOtp(message));
      }
    } catch (e) {
      return left(ForgotMpinFailure.serverError());
    }
  }
}
