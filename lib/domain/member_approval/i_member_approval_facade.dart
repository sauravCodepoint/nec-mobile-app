import 'package:dartz/dartz.dart';

import 'member_approval_failure.dart';
import 'member_approval_status_dto.dart';

abstract class IMemberApprovalFacade {
  /// Asks the backend whether the back office has approved the member yet,
  /// authenticating with the stored app_member_code + already-verified OTP
  /// (no JWT session exists while approval is pending). On an approved
  /// response the approval-resume markers are cleared before returning, so
  /// the next cold start follows normal session routing.
  Future<Either<MemberApprovalFailure, MemberApprovalStatusDto>>
  checkApprovalStatus();
}
