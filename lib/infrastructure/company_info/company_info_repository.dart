import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/company_info/i_company_info_facade.dart';
import '../../domain/company_info/company_info_type.dart';
import '../../domain/company_info/company_info_dto.dart';
import '../../domain/company_info/company_info_failure.dart';
import '../../domain/core/services/api_services.dart';

@LazySingleton(as: ICompanyInfoFacade)
class CompanyInfoRepository implements ICompanyInfoFacade {
  final ApiServices _apiServices;

  CompanyInfoRepository(this._apiServices);

  @override
  Future<Either<CompanyInfoFailure, CompanyInfoDto>> getCompanyInfo(
    CompanyInfoType type,
  ) async {
    try {
      final response = await _apiServices.getCompanyInfo(
        queryParams: {'type': type.queryValue},
      );
      if (response.isSuccessful) {
        // response.body decodes as Latin-1 per HTTP spec default, corrupting
        // multibyte UTF-8 characters (e.g. " U+201C → â□□). Decode raw bytes
        // as UTF-8 to get the correct characters.
        final html = utf8.decode(response.bodyBytes, allowMalformed: true);
        return right(CompanyInfoDto(data: html));
      } else {
        return left(const CompanyInfoFailure.unableToLoad());
      }
    } catch (e) {
      return left(const CompanyInfoFailure.serverError());
    }
  }
}