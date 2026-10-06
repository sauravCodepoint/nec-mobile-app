import 'package:dartz/dartz.dart';

import 'support_contact_dto.dart';
import 'support_failure.dart';

abstract class ISupportFacade {
  Future<Either<SupportFailure, SupportContactDto>> getContactDetails({
    required String languageCode,
  });
}