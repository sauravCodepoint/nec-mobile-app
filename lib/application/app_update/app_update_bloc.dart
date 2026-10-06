import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/app_update/app_update_dto.dart';
import '../../domain/app_update/app_update_failure.dart';
import '../../domain/app_update/i_app_update_facade.dart';

part 'app_update_event.dart';
part 'app_update_state.dart';
part 'app_update_bloc.freezed.dart';

@injectable
class AppUpdateBloc extends Bloc<AppUpdateEvent, AppUpdateState> {
  final IAppUpdateFacade _appUpdateFacade;

  AppUpdateBloc(this._appUpdateFacade) : super(AppUpdateState.initial()) {
    on<_CheckRequested>(_onCheckRequested);
  }

  FutureOr<void> _onCheckRequested(
    _CheckRequested event,
    Emitter<AppUpdateState> emit,
  ) async {
    // The check runs at most once per app session — re-entries (e.g. a
    // second splash pass after logout) must not re-show the dialog.
    if (state.hasChecked) return;

    emit(
      state.copyWith(hasChecked: true, appUpdateFailureOrSuccessOption: none()),
    );
    final failureOrSuccess = await _appUpdateFacade.checkForUpdate(
      languageCode: event.languageCode,
    );
    emit(
      state.copyWith(appUpdateFailureOrSuccessOption: some(failureOrSuccess)),
    );
  }
}
