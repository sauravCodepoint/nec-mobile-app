import 'package:dartz/dartz.dart';

import 'app_update_dto.dart';
import 'app_update_failure.dart';

abstract class IAppUpdateFacade {
  /// Asks the backend whether the installed version needs an update.
  /// Platform and installed version are resolved by the implementation;
  /// [languageCode] localizes the server-authored title/message.
  Future<Either<AppUpdateFailure, AppUpdateDto>> checkForUpdate({
    required String languageCode,
  });
}
