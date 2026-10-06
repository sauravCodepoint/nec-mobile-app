import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/company_info/company_info_type.dart';
import '../../domain/company_info/company_info_dto.dart';
import '../../domain/company_info/company_info_failure.dart';
import '../../domain/company_info/i_company_info_facade.dart';

part 'company_info_event.dart';
part 'company_info_state.dart';
part 'company_info_bloc.freezed.dart';

@injectable
class CompanyInfoBloc extends Bloc<CompanyInfoEvent, CompanyInfoState> {
  final ICompanyInfoFacade _companyInfoFacade;

  CompanyInfoBloc(this._companyInfoFacade) : super(CompanyInfoState.initial()) {
    on<_GetCompanyInfo>(_onGetCompanyInfo);
  }

  FutureOr<void> _onGetCompanyInfo(
    _GetCompanyInfo event,
    Emitter<CompanyInfoState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        companyInfoFailureOrSuccessOption: none(),
      ),
    );
    final failureOrSuccess = await _companyInfoFacade.getCompanyInfo(
      event.companyInfoType,
    );
    emit(
      state.copyWith(
        isLoading: false,
        companyInfoFailureOrSuccessOption: some(failureOrSuccess),
      ),
    );
  }
}