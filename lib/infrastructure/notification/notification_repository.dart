import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/device_helper/app_device_helper.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/notification/i_notification_facade.dart';
import '../../domain/notification/notification_dto.dart';
import '../../domain/notification/notification_failure.dart';

@LazySingleton(as: INotificationFacade)
class NotificationRepository implements INotificationFacade {
  final ApiServices _apiServices;
  final SharedPrefs _appPrefs;
  final AppDeviceHelper _deviceHelper;
  NotificationRepository(this._apiServices, this._appPrefs, this._deviceHelper);
  @override
  Future<Either<NotificationFailure, NotificationDto>> getNotifications({
    required int pageIndex,
  }) async {
    try {
      final token = _appPrefs.getToken();
      final appMemberCode = _appPrefs.getAppMemberCode();
      final queryParams = {
        'app_member_code': appMemberCode,
        'page_index': pageIndex,
      };
      final response = await _apiServices.getNotifications(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final dto = NotificationDto.fromJson(response.body);
        return right(dto);
      } else {
        return left(const NotificationFailure.unableToGetNotifications());
      }
    } catch (e) {
      return left(const NotificationFailure.serverError());
    }
  }

  @override
  Future<Either<NotificationFailure, Unit>> registerDeviceToken({
    required String deviceToken,
    required String languageCode,
  }) async {
    try {
      final deviceDetails = await _deviceHelper.getDeviceDetailsPayload();
      final body = {
        'app_member_code': _appPrefs.getAppMemberCode(),
        'device_token': deviceToken,
        'platform': Platform.isAndroid ? 'android' : 'ios',
        'lang': languageCode.toLowerCase().trim(),
        'device_details': deviceDetails,
      };
      final response = await _apiServices.postUpdateDeviceToken(
        token: _appPrefs.getToken(),
        body: body,
      );
      if (response.isSuccessful) {
        return right(unit);
      } else {
        return left(const NotificationFailure.unableToRegisterDeviceToken());
      }
    } catch (e) {
      return left(const NotificationFailure.serverError());
    }
  }
}
