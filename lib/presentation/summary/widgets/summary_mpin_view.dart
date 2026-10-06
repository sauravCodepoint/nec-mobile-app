import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/mpin/mpin_bloc.dart';
import '../../../domain/mpin/mpin_failure.dart';
import '../../core/mpin/app_mpin.dart';
import '../../core/notify/app_notify.dart';

/// Full-screen MPIN re-authentication gate shown right before a payment is
/// created — after the user says "yes" to the confirm dialog, for every
/// payment method.
///
/// Biometric is intentionally disabled here: a payment must be authorised with
/// the MPIN the user knows, never a stored fingerprint/face. The login/forgot
/// action row is hidden too — that flow belongs to the lock screen, not to a
/// payment confirmation. Returns `true` only once the backend verifies the
/// entered MPIN; a back-gesture / app-bar back resolves to `false`.
class SummaryMpinView extends StatelessWidget {
  const SummaryMpinView({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          // Reuse the app-wide MpinBloc so verification hits the same facade
          // the lock screen uses; value-provide it so it survives the push
          // onto a fresh route context.
          value: context.read<MpinBloc>(),
          child: const SummaryMpinView(),
        ),
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AppMpin(
      title: 'summary.mpin.title'.tr(),
      isShowingBiometricOption: false,
      isShowActionRow: false,
      onMpinCompleted: (mpin) async {
        final bloc = context.read<MpinBloc>();
        bloc.add(MpinEvent.verifyMpin(mpin: mpin));
        // Mirror the lock screen: wait for the one-shot verification result to
        // land, then translate it into the bool AppMpin expects.
        final result = await bloc.stream.firstWhere(
          (state) => state.mpinFailureOrSuccessOption.isSome(),
        );
        final isValid = result.mpinFailureOrSuccessOption.fold(
          () => false,
          (either) => either.fold(
            (failure) {
              HapticFeedback.heavyImpact();
              final msg = failure.maybeMap(
                invalidMpin: (value) => value.errorMessage,
                serverError: (_) => 'errors.serverError'.tr(),
                orElse: () => 'errors.orElse'.tr(),
              );
              AppNotify.toast(msg, type: AppToastType.error);
              return false;
            },
            (_) => true,
          ),
        );
        if (isValid && context.mounted) {
          HapticFeedback.lightImpact();
          Navigator.of(context).pop(true);
        }
        return isValid;
      },
    );
  }
}