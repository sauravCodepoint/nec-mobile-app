import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/session/post_otp_outcome.dart';
import '../../domain/otp/i_otp_facade.dart';
import '../../domain/otp/otp_failure.dart';
import '../../domain/otp/value_validators.dart';
import '../../presentation/core/global/app_global.dart';

part 'otp_event.dart';
part 'otp_state.dart';
part 'otp_bloc.freezed.dart';

@injectable
class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final IOtpFacade _otpFacade;
  final SharedPrefs _sharedPrefs;
  OtpBloc(this._otpFacade, this._sharedPrefs) : super(OtpState.initial()) {
    on<_Initial>(_onInitial);
    on<_ResendOtp>(_onResendOtp);
    on<_OtpChanged>(_onOtpChanged);
    on<_OtpSubmitted>(_onOtpSubmitted);
  }

  FutureOr<void> _onInitial(_Initial event, Emitter<OtpState> emit) async {
    // Source of truth for "when was this OTP dispatched" is prefs — set by
    // LoginBloc on the original request. Falling back to now() ensures the
    // countdown always starts somewhere sensible even on first install
    // edge cases or if the pref write lagged.
    final requestedAt =
        _sharedPrefs.getPendingOtpRequestedAt() ?? DateTime.now();
    emit(
      state.copyWith(
        identityType: event.idType,
        identityNumber: event.idNumber,
        mobileNumber: event.mobileNumber,
        requestedAt: requestedAt,
        resendOtpFailureOrSuccessOption: none(),
        otpFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onResendOtp(_ResendOtp event, Emitter<OtpState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
        otpFailureOrSuccessOption: none(),
        resendOtpFailureOrSuccessOption: none(),
      ),
    );
    final failureOrSuccess = await _otpFacade.resendOtp(
      identityTypeCode: state.identityType,
      countryCode: AppGlobal.appCountryCode,
      identityNumber: state.identityNumber,
      phoneNumber: state.mobileNumber,
    );
    await failureOrSuccess.fold(
      (failure) async {
        emit(
          state.copyWith(
            isLoading: false,
            resendOtpFailureOrSuccessOption: some(left(failure)),
          ),
        );
      },
      (success) async {
        // Bump the pending-OTP timestamp so a subsequent reopen resumes
        // against the freshly-issued code's TTL, not the original one.
        final now = DateTime.now();
        await _sharedPrefs.setPendingOtp(
          idType: state.identityType,
          idNumber: state.identityNumber,
          mobile: state.mobileNumber,
          requestedAt: now,
        );
        emit(
          state.copyWith(
            isLoading: false,
            requestedAt: now,
            resendOtpFailureOrSuccessOption: some(right(success)),
          ),
        );
      },
    );
  }

  FutureOr<void> _onOtpChanged(
    _OtpChanged event,
    Emitter<OtpState> emit,
  ) async {
    emit(
      state.copyWith(
        otp: Otp(event.otpStr),
        resendOtpFailureOrSuccessOption: none(),
        otpFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onOtpSubmitted(
    _OtpSubmitted event,
    Emitter<OtpState> emit,
  ) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        resendOtpFailureOrSuccessOption: none(),
        otpFailureOrSuccessOption: none(),
      ),
    );
    final otpIsValid = state.otp.isValid();
    if (otpIsValid) {
      final failureOrSuccess = await _otpFacade.verifyOtp(
        identityTypeCode: state.identityType,
        countryCode: AppGlobal.appCountryCode,
        identityNumber: state.identityNumber,
        phoneNumber: state.mobileNumber,
        otpCode: state.otp,
      );
      // Clear the pending OTP record on any terminal outcome — success
      // (user moves on) or `userIsNotRegistered` (user leaves OTP for
      // KYC or back to login). Only retryable failures (invalidOtp,
      // serverError) keep the record so a kill-and-reopen still resumes.
      final shouldClear = failureOrSuccess.fold(
        (failure) => failure.maybeMap(
          userIsNotRegistered: (_) => true,
          orElse: () => false,
        ),
        (_) => true,
      );
      if (shouldClear) {
        await _sharedPrefs.clearPendingOtp();
      }
      emit(
        state.copyWith(
          isSubmitting: false,
          showErrorMessages: false,
          otpFailureOrSuccessOption: some(failureOrSuccess),
        ),
      );
    } else {
      emit(
        state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          otpFailureOrSuccessOption: none(),
        ),
      );
    }
  }
}
