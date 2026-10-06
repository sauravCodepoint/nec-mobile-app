import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/session/pending_registration.dart';
import '../../presentation/core/global/app_global.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SharedPrefs _sharedPrefs;

  SplashBloc(this._sharedPrefs) : super(const SplashState.initial()) {
    on<_CheckAuthentication>(_onCheckAuthentication);
  }

  FutureOr<void> _onCheckAuthentication(
      _CheckAuthentication event,
      Emitter<SplashState> emit,
      ) async {
    emit(const SplashState.loadingProgress());

    // Onboarding gate first — cheap, never throws, and must always win.
    // Any downstream failure (corrupted token, etc.) must not be able to
    // route a first-time user past onboarding.
    if (!_sharedPrefs.getHasOnboarded()) {
      emit(const SplashState.loadedSuccessOnBoarding());
      return;
    }

    try {
      final isLoggedIn = _sharedPrefs.getIsLoggedIn();
      final isMpinSet = _sharedPrefs.getMpin();

      // Token decryption is isolated: corrupted ciphertext throws here, but
      // the only sane recovery is to treat the session as gone and send the
      // user to login — not to fall into the outer catch and emit failure.
      String? token;
      try {
        token = _sharedPrefs.getToken();
      } catch (_) {
        token = null;
      }

      // isLoggedIn flag alone is unreliable — token may be missing due to
      // a crash mid-logout, prefs partial write, or secure-storage eviction.
      final hasValidSession = isLoggedIn && token != null && token.isNotEmpty;

      // Repair: flag says logged-in but no actual token exists.
      if (isLoggedIn && !hasValidSession) {
        await _sharedPrefs.setIsLoggedIn(false);
      }

      if (!hasValidSession) {
        // Awaiting-approval wins over every other pre-session resume: it's the
        // furthest along in the flow (registration already submitted). The
        // marker is cleared once a session is installed, so an approved,
        // signed-in user never reaches here.
        if (_sharedPrefs.getMemberApprovalPending()) {
          emit(const SplashState.loadedSuccessApprovalPending());
          return;
        }
        // Registration resume wins over OTP resume — the user is further
        // along in the flow, and we should not send them backwards.
        final pendingRegistration = _sharedPrefs.getPendingRegistration();
        if (pendingRegistration != null) {
          emit(
            SplashState.loadedSuccessRegistrationPending(pendingRegistration),
          );
        } else {
          final pendingOtp = _readPendingOtp();
          if (pendingOtp != null) {
            emit(
              SplashState.loadedSuccessOtpPending(
                idType: pendingOtp.idType,
                idNumber: pendingOtp.idNumber,
                mobileNumber: pendingOtp.mobile,
              ),
            );
          } else {
            emit(const SplashState.loadedSuccessLogin());
          }
        }
      } else if (!isMpinSet) {
        emit(const SplashState.loadedSuccessSetMpin());
      } else {
        emit(const SplashState.loadedSuccessMain());
      }
    } catch (e) {
      emit(SplashState.loadedFailure(e.toString()));
    }
  }

  /// Returns the pending OTP context if it exists AND is still within the
  /// TTL window. Any stale or partial record is purged as a side effect so
  /// the next boot won't have to re-check.
  _PendingOtp? _readPendingOtp() {
    final idType = _sharedPrefs.getPendingOtpIdType();
    final idNumber = _sharedPrefs.getPendingOtpIdNumber();
    final mobile = _sharedPrefs.getPendingOtpMobile();
    final requestedAt = _sharedPrefs.getPendingOtpRequestedAt();

    final isComplete =
        idType != null &&
            idType.isNotEmpty &&
            idNumber != null &&
            idNumber.isNotEmpty &&
            mobile != null &&
            mobile.isNotEmpty &&
            requestedAt != null;

    if (!isComplete) {
      // Fire-and-forget cleanup of partial state — not awaited because the
      // splash decision must not block on prefs.
      unawaited(_sharedPrefs.clearPendingOtp());
      return null;
    }

    final age = DateTime.now().difference(requestedAt);
    if (age >= AppGlobal.pendingOtpTtl) {
      unawaited(_sharedPrefs.clearPendingOtp());
      return null;
    }

    return _PendingOtp(idType: idType, idNumber: idNumber, mobile: mobile);
  }
}

class _PendingOtp {
  final String idType;
  final String idNumber;
  final String mobile;
  const _PendingOtp({
    required this.idType,
    required this.idNumber,
    required this.mobile,
  });
}
