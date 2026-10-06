part of 'company_info_bloc.dart';

@freezed
sealed class CompanyInfoState with _$CompanyInfoState {
  const factory CompanyInfoState({
    required bool isLoading,
    required Option<Either<CompanyInfoFailure, CompanyInfoDto>>
        companyInfoFailureOrSuccessOption,
  }) = _CompanyInfoState;

  factory CompanyInfoState.initial() => CompanyInfoState(
        isLoading: false,
        companyInfoFailureOrSuccessOption: none(),
      );
}