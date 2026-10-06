import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/support/i_support_facade.dart';
import '../../domain/support/support_contact_dto.dart';
import '../../domain/support/support_failure.dart';

part 'support_event.dart';
part 'support_state.dart';
part 'support_bloc.freezed.dart';

@injectable
class SupportBloc extends Bloc<SupportEvent, SupportState> {
  final ISupportFacade _supportFacade;
  SupportBloc(this._supportFacade) : super(SupportState.initial()) {
    on<_GetContactDetails>(_onGetContactDetails);
  }

  FutureOr<void> _onGetContactDetails(
    _GetContactDetails event,
    Emitter<SupportState> emit,
  ) async {
    emit(state.copyWith(contactFailureOrSuccessOption: none()));

    final failureOrSuccess = await _supportFacade.getContactDetails(
      languageCode: event.languageCode,
    );

    emit(
      state.copyWith(
        contactDto: failureOrSuccess.fold(
          (_) => state.contactDto,
          (dto) => dto,
        ),
        contactFailureOrSuccessOption: some(failureOrSuccess),
      ),
    );
  }
}