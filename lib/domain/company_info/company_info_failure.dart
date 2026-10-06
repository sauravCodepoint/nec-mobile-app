import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info_failure.freezed.dart';

@freezed
sealed class CompanyInfoFailure with _$CompanyInfoFailure {
  const factory CompanyInfoFailure.serverError() = _ServerError;
  const factory CompanyInfoFailure.unableToLoad() = _UnableToLoad;
}