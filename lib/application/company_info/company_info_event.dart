part of 'company_info_bloc.dart';

@freezed
sealed class CompanyInfoEvent with _$CompanyInfoEvent {
  const factory CompanyInfoEvent.getCompanyInfo(
    CompanyInfoType companyInfoType,
  ) = _GetCompanyInfo;
}