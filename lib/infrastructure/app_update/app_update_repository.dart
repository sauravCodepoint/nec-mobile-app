import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../domain/app_update/app_update_dto.dart';
import '../../domain/app_update/app_update_failure.dart';
import '../../domain/app_update/i_app_update_facade.dart';
import '../../domain/core/services/api_services.dart';

@LazySingleton(as: IAppUpdateFacade)
class AppUpdateRepository implements IAppUpdateFacade {
  final ApiServices _apiServices;

  AppUpdateRepository(this._apiServices);

  @override
  Future<Either<AppUpdateFailure, AppUpdateDto>> checkForUpdate({
    required String languageCode,
  }) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final body = {
        'platform': Platform.isAndroid ? 'android' : 'ios',
        'version': packageInfo.version.trim(),
        'lang': languageCode.toLowerCase().trim(),
      };
      final response = await _apiServices.postAppVersionCheck(body);
      if (response.isSuccessful) {
        final appUpdateDto = AppUpdateDto.fromJson(response.body);
        return right(appUpdateDto);
      } else {
        return left(const AppUpdateFailure.unableToCheck());
      }
    } catch (e) {
      return left(const AppUpdateFailure.serverError());
    }
  }
}
