import 'dart:io';

import 'package:dartz/dartz.dart';

import 'complete_profile_city_dto.dart';
import 'complete_profile_failure.dart';
import '../common/common_member_field_dto.dart';
import 'complete_profile_state_dto.dart';

abstract class ICompleteProfileFacade {
  Future<Either<CompleteProfileFailure, CommonMemberFieldDto>>
      getMemberFieldSettings();
  Future<Either<CompleteProfileFailure, CompleteProfileStateDto>> getStates();
  Future<Either<CompleteProfileFailure, CompleteProfileCityDto>> getCities(
    String stateCode,
  );
  Future<Either<CompleteProfileFailure, String>> uploadSelfieVideo({
    required File file,
  });
  Future<Either<CompleteProfileFailure, Unit>> deleteSelfieVideo({
    required String eId,
  });
  Future<Either<CompleteProfileFailure, Unit>> submitProfile(
    Map<String, dynamic> data,
  );
}