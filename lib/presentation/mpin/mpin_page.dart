import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../application/mpin/mpin_bloc.dart';
import '../../domain/core/di/injection.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/mpin/mpin_failure.dart';
import '../app_update/app_update_gate.dart';
import '../core/mpin/app_mpin.dart';
import '../core/notify/app_notify.dart';
import '../routes/app_routes.dart';
import '../routes/app_routes.gr.dart';

@RoutePage()
class MpinPage extends HookWidget {
  const MpinPage({super.key, this.autoPromptBiometric = false});

  /// Whether to auto-invoke the iOS biometric prompt on entry. True only on a
  /// genuine cold start (splash → MainRoute). In-session returns to this page —
  /// logout, session expiry/timeout — leave it false so biometric is only
  /// invoked when the user taps the biometric button. The manual button is
  /// always available regardless of this flag.
  final bool autoPromptBiometric;

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();

    // A force update is a hard gate: a valid MPIN/biometric must not slip past
    // it. The force-update dialog is pushed on the root navigator, so a
    // replaceAll to Home here would tear it off and land the user on Home
    // without updating. Refuse to leave the lock screen while the gate is set.
    void goToMain() {
      if (AppUpdateGate.forceUpdateActive) return;
      router.replaceAll([const MainRoute()]);
    }

    useEffect(() {
      final bloc = context.read<MpinBloc>();
      bloc.add(const MpinEvent.checkBiometricSupport());

      if (!autoPromptBiometric || !Platform.isIOS) return null;

      // On iOS cold start: auto-trigger biometric once the support check
      // resolves. One-shot subscription — cancels after the first settled
      // state. Transient states from an mpin/biometric flow already underway
      // are ignored: MpinBloc is a long-lived singleton whose biometric flags
      // stay set across visits, so a quick MPIN entry that lands before the
      // support check resolves must not be mistaken for its result and
      // spuriously re-trigger biometric.
      StreamSubscription<MpinState>? sub;
      sub = bloc.stream.listen((state) {
        if (state.isLoading || state.isAuthenticating) return;
        sub?.cancel();
        sub = null;
        // Don't pop Face ID under a mandatory update dialog — the user must
        // update, not authenticate past it.
        if (state.isBiometricAvailable &&
            state.isBiometricEnabled &&
            !AppUpdateGate.forceUpdateActive) {
          bloc.add(
            MpinEvent.verifyBiometric(
              localizedReason: 'core.mpin.biometricReason'.tr(),
            ),
          );
        }
      });
      return () => sub?.cancel();
    }, const []);
    return BlocConsumer<MpinBloc, MpinState>(
      listenWhen: (previous, current) =>
          previous.mpinFailureOrSuccessOption !=
              current.mpinFailureOrSuccessOption ||
          previous.biometricFailureOrSuccessOption !=
              current.biometricFailureOrSuccessOption,
      listener: (context, state) {
        state.mpinFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              HapticFeedback.heavyImpact();
              final msg = failure.maybeMap(
                invalidMpin: (value) => value.errorMessage,
                serverError: (value) => 'errors.serverError'.tr(),
                orElse: () => 'errors.orElse'.tr(),
              );
              AppNotify.toast(msg, type: AppToastType.error);
            },
            (_) {
              HapticFeedback.lightImpact();
              goToMain();
            },
          ),
        );
        state.biometricFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              HapticFeedback.heavyImpact();
              final msg = failure.maybeMap(
                invalidBiometric: (value) => value.errorMessage,
                biometricNotEnrolled: (_) => 'errors.biometricNotEnrolled'.tr(),
                serverError: (_) => 'errors.serverError'.tr(),
                orElse: () => 'errors.orElse'.tr(),
              );
              AppNotify.toast(msg, type: AppToastType.error);
            },
            (_) {
              HapticFeedback.lightImpact();
              goToMain();
            },
          ),
        );
      },
      builder: (context, state) {
        return AppMpin(
          // The manual biometric button is shown on every entry whenever
          // biometric is available and enabled — only the iOS cold-start
          // auto-trigger above is gated by [autoPromptBiometric].
          isShowingBiometricOption:
              state.isBiometricAvailable && state.isBiometricEnabled,
          isBiometricAuthenticating: state.isAuthenticating,
          onBiometricPressed: () {
            context.read<MpinBloc>().add(
              MpinEvent.verifyBiometric(
                localizedReason: 'core.mpin.biometricReason'.tr(),
              ),
            );
          },
          onLoginOrRegister: () async {
            // Signing out to use another account wipes the locked user's
            // session and forces a fresh OTP to get back in — confirm first so
            // an accidental tap isn't destructive.
            final confirmed = await AppNotify.confirm(
              title: 'core.mpin.loginWithOtpDialog.title'.tr(),
              message: 'core.mpin.loginWithOtpDialog.message'.tr(),
              confirmText: 'core.mpin.loginWithOtpDialog.confirm'.tr(),
              cancelText: 'core.mpin.loginWithOtpDialog.cancel'.tr(),
              type: AppDialogType.warning,
            );
            if (!confirmed) return;
            // Switching accounts: wipe the previous user's session, identity
            // and any registration-resume markers so the new login can't read
            // stale prefs (e.g. another member's app_member_code). replaceAll
            // resets the stack so the locked user's routes can't be returned
            // to with the back gesture.
            await getIt<SharedPrefs>().resetSession();
            if (!context.mounted) return;
            context.router.replaceAll([const LoginRoute()]);
          },
          onForgotMpin: () {
            context.router.push(const ForgotMpinRoute());
          },
          onMpinCompleted: (mpin) async {
            context.read<MpinBloc>().add(MpinEvent.verifyMpin(mpin: mpin));
            final result = await context.read<MpinBloc>().stream.firstWhere(
              (state) => state.mpinFailureOrSuccessOption.isSome(),
            );
            return result.mpinFailureOrSuccessOption.fold(
              () => false,
              (a) => a.isRight(),
            );
          },
        );
      },
    );
  }
}
