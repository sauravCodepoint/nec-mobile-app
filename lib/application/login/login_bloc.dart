import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/common/common_selectable_dto.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/login/i_login_facade.dart';
import '../../domain/login/login_contact_us_dto.dart';
import '../../domain/login/login_failure.dart';
import '../../domain/login/login_id_identity_dto.dart';
import '../../domain/login/value_validators.dart';
import '../../presentation/core/global/app_global.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ILoginFacade _loginFacade;
  final SharedPrefs _sharedPrefs;
  LoginBloc(this._loginFacade, this._sharedPrefs) : super(LoginState.initial()) {
    on<_GetIdentityTypes>(_onGetIdentityTypes);
    on<_IdentityTypeChanged>(_onIdentityTypeChanged);
    on<_IdentityNumberChanged>(_onIdentityNumberChanged);
    on<_MobileNumberChanged>(_onMobileNumberChanged);
    on<_RequestOtpPressed>(_onRequestOtpPressed);
    on<_Reset>(_onReset);
    on<_GetContactUs>(_onGetContactUs);
  }

  FutureOr<void> _onGetIdentityTypes(
      _GetIdentityTypes event,
      Emitter<LoginState> emit,
      ) async {
    emit(
      LoginState.initial().copyWith(
        isLoading: true,
        identityTypesFailureOrSuccessOption: none(),
      ),
    );

    final failureOrSuccess = await _loginFacade.getIdentityTypes();

    failureOrSuccess.fold(
          (failure) => emit(
        state.copyWith(
          isLoading: false,
          identityTypesFailureOrSuccessOption: some(left(failure)),
        ),
      ),
          (loginIdIdentityDto) {
        emit(
          state.copyWith(
            isLoading: false,
            loginIdIdentityDto: loginIdIdentityDto,
            identityTypesFailureOrSuccessOption: some(
              right(loginIdIdentityDto),
            ),
          ),
        );
        final list = loginIdIdentityDto.data?.identityTypesList ?? [];
        if (list.isNotEmpty && list.length == 1) {
          final identityType = list.first;
          add(
            LoginEvent.identityTypeChanged(
              selectedIdentityType: CommonSelectableItem(
                titleName: identityType.name?.toUpperCase() ?? '',
                titleCode: identityType.code,
              ),
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onIdentityTypeChanged(
      _IdentityTypeChanged event,
      Emitter<LoginState> emit,
      ) async {
    // Re-selecting the SAME identity type must be a no-op. The UI only clears
    // the ID field (via resetMask) when the type's code actually changes, so
    // wiping identityNumber here for an unchanged type would desync the visible
    // (still-populated) field from state and make an already-valid number fail
    // submit validation.
    if (event.selectedIdentityType.titleCode ==
        state.selectedIdentityType?.titleCode) {
      return;
    }

    emit(
      state.copyWith(
        selectedIdentityType: event.selectedIdentityType,
        // Identity number rules depend on the type — drop the previously
        // typed value so the submit guard can't pass with a stale-but-valid
        // number after the UI field has been cleared by resetMask().
        identityNumber: IdentityNumber(
          '',
          event.selectedIdentityType.titleCode ?? '',
        ),
        showErrorMessages: false,
        loginFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onIdentityNumberChanged(
      _IdentityNumberChanged event,
      Emitter<LoginState> emit,
      ) async {
    emit(
      state.copyWith(
        identityNumber: IdentityNumber(
          event.identityNumberStr,
          state.selectedIdentityType?.titleCode ?? '',
        ),
        loginFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onMobileNumberChanged(
      _MobileNumberChanged event,
      Emitter<LoginState> emit,
      ) async {
    emit(
      state.copyWith(
        mobileNumber: MobileNumber(event.mobileNumberStr),
        loginFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onReset(_Reset event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        identityNumber: IdentityNumber(
          '',
          state.selectedIdentityType?.titleCode ?? '',
        ),
        mobileNumber: MobileNumber(''),
        showErrorMessages: false,
        loginFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onRequestOtpPressed(
      _RequestOtpPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(
      state.copyWith(isSubmitting: true, loginFailureOrSuccessOption: none()),
    );
    final identityNumberIsValid = state.identityNumber.isValid();
    final mobileNumberIsValid = state.mobileNumber.isValid();
    if (identityNumberIsValid && mobileNumberIsValid) {
      final failureOrSuccess = await _loginFacade.requestOtp(
        identityTypeCode: state.selectedIdentityType?.titleCode ?? '',
        countryCode: AppGlobal.appCountryCode,
        mobileNumber: state.mobileNumber,
        identityNumber: state.identityNumber,
      );
      // Persist context only on a confirmed OTP dispatch so a failed
      // request never leaves a stale "pending" record behind.
      await failureOrSuccess.fold((_) async {}, (_) async {
        await _sharedPrefs.setPendingOtp(
          idType: state.selectedIdentityType?.titleCode ?? '',
          idNumber: state.identityNumber.getOrCrash(),
          mobile: state.mobileNumber.getOrCrash(),
          requestedAt: DateTime.now(),
        );
      });
      emit(
        state.copyWith(
          isSubmitting: false,
          showErrorMessages: false,
          loginFailureOrSuccessOption: some(failureOrSuccess),
        ),
      );
    } else {
      emit(
        state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          loginFailureOrSuccessOption: none(),
        ),
      );
    }
  }

  FutureOr<void> _onGetContactUs(
      _GetContactUs event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(contactUsFailureOrSuccessOption: none()));

    final failureOrSuccess = await _loginFacade.getContactUs(
      languageCode: event.languageCode,
    );

    emit(
      state.copyWith(
        contactUsDto: failureOrSuccess.fold(
          (_) => state.contactUsDto,
          (dto) => dto,
        ),
        contactUsFailureOrSuccessOption: some(failureOrSuccess),
      ),
    );
  }
}
