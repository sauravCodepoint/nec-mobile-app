import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/device_helper/app_device_helper.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/mpin/i_mpin_facade.dart';
import '../../domain/mpin/mpin_dto.dart';
import '../../domain/mpin/mpin_failure.dart';

@LazySingleton(as: IMpinFacade)
class MpinRepository implements IMpinFacade {
  final ApiServices _apiServices;
  final SharedPrefs _sharedPrefs;
  final AppDeviceHelper _deviceHelper;
  MpinRepository(this._apiServices, this._sharedPrefs, this._deviceHelper);
  @override
  Future<Either<MpinFailure, MpinDto>> verifyMpin({
    required String mpin,
  }) async {
    try {
      final appMemberCode = _sharedPrefs.getAppMemberCode();
      final deviceDetails = await _deviceHelper.getDeviceDetailsPayload();
      final body = {
        'app_member_code': appMemberCode,
        'm_p_i_n': int.parse(mpin),
        'device_details': deviceDetails,
      };
      final response = await _apiServices.postVerifyMpin(body);
      if (response.isSuccessful) {
        final dto = MpinDto.fromJson(response.body);
        await _sharedPrefs.setToken(dto.data?.jwtToken ?? '');
        await _sharedPrefs.setRefreshToken(dto.data?.refreshToken ?? '');
        // Refresh the cached display name from the verify response so the MPIN
        // screen greets the current user. Only overwrite when the server sends
        // a non-empty name, never blanking a previously stored value.
        final userName = dto.data?.user?.name;
        if (userName != null && userName.isNotEmpty) {
          await _sharedPrefs.setUserName(userName);
        }
        return right(dto);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(MpinFailure.invalidMpin(message));
      }
    } catch (e) {
      return left(MpinFailure.serverError());
    }
  }

  @override
  Future<Either<MpinFailure, MpinDto>> verifyBiometric() async {
    try {
      final appMemberCode = _sharedPrefs.getAppMemberCode();
      final refreshToken = _sharedPrefs.getRefreshToken();
      final deviceDetails = await _deviceHelper.getDeviceDetailsPayload();
      final body = {
        'app_member_code': appMemberCode,
        'refresh_token': refreshToken,
        'device_details': deviceDetails,
      };
      final response = await _apiServices.postVerifyBiometric(body);
      if (response.isSuccessful) {
        final dto = MpinDto.fromJson(response.body);
        await _sharedPrefs.setToken(dto.data?.jwtToken ?? '');
        await _sharedPrefs.setRefreshToken(dto.data?.refreshToken ?? '');
        // Refresh the cached display name from the verify response so the MPIN
        // screen greets the current user. Only overwrite when the server sends
        // a non-empty name, never blanking a previously stored value.
        final userName = dto.data?.user?.name;
        if (userName != null && userName.isNotEmpty) {
          await _sharedPrefs.setUserName(userName);
        }
        return right(dto);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(MpinFailure.invalidBiometric(message));
      }
    } catch (e) {
      return left(MpinFailure.serverError());
    }
  }
}
