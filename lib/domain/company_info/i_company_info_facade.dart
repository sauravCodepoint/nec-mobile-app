import 'package:dartz/dartz.dart';

import 'company_info_dto.dart';
import 'company_info_failure.dart';
import 'company_info_type.dart';

abstract class ICompanyInfoFacade {
  Future<Either<CompanyInfoFailure, CompanyInfoDto>> getCompanyInfo(
    CompanyInfoType type,
  );
}