import 'dart:io';

import 'package:dartz/dartz.dart';

import '../login/login_id_identity_dto.dart';
import 'update_kyc_failure.dart';

abstract class IUpdateKycFacade {
  Future<Either<UpdateKycFailure, LoginIdIdentityDto>> getIdentityTypes();

  Future<Either<UpdateKycFailure, String>> uploadFrontDocument({
    required File file,
  });

  Future<Either<UpdateKycFailure, String>> uploadBackDocument({
    required File file,
  });

  Future<Either<UpdateKycFailure, Unit>> deleteDocument({required String eId});

  /// Reads app_member_code from SharedPrefs internally.
  Future<Either<UpdateKycFailure, Unit>> postUpdateKyc({
    required String idTypeCode,
    required String idNumber,
    required String issueDate,
    required String expiryDate,
    required String remarks,
    required String frontDocEId,
    required String backDocEId,
  });
}