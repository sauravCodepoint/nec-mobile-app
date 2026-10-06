import 'package:dartz/dartz.dart';

import '../core/session/post_otp_outcome.dart';
import 'otp_failure.dart';
import 'value_validators.dart';

abstract class IOtpFacade {
  Future<Either<OtpFailure, Unit>> resendOtp({
    required String identityTypeCode,
    required int countryCode,
    required String identityNumber,
    required String phoneNumber,
  });
  Future<Either<OtpFailure, PostOtpOutcome>> verifyOtp({
    required String identityTypeCode,
    required int countryCode,
    required String identityNumber,
    required String phoneNumber,
    required Otp otpCode,
  });
}
