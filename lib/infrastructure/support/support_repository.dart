import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/services/api_services.dart';
import '../../domain/support/i_support_facade.dart';
import '../../domain/support/support_contact_dto.dart';
import '../../domain/support/support_failure.dart';

@LazySingleton(as: ISupportFacade)
class SupportRepository implements ISupportFacade {
  final ApiServices _apiServices;
  SupportRepository(this._apiServices);

  @override
  Future<Either<SupportFailure, SupportContactDto>> getContactDetails({
    required String languageCode,
  }) async {
    try {
      final language = languageCode.toLowerCase().trim() == 'ar' ? 'ar' : 'en';
      final response = await _apiServices.getContactUs(
        queryParams: {'language': language},
      );
      if (response.isSuccessful) {
        return right(SupportContactDto.fromJson(response.body));
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(SupportFailure.unableToFetchContact(message));
      }
    } catch (e) {
      return left(const SupportFailure.serverError());
    }
  }
}
