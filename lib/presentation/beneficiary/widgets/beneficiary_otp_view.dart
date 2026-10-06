import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../application/beneficiary/beneficiary_bloc.dart';
import '../../../application/home/home_bloc.dart';
import '../../../application/summary/summary_bloc.dart';
import '../../../domain/beneficiary/beneficiary_failure.dart';
import '../../../domain/core/di/injection.dart';
import '../../../domain/core/failures.dart';
import '../../../domain/beneficiary/value_validators.dart';
import '../../../domain/core/prefs/app_prefs.dart';
import '../../core/notify/app_notify.dart';
import '../../core/otp/app_otp.dart';
import 'beneficiary_form_body.dart';

@RoutePage()
class BeneficiaryOtpView extends HookWidget {
  const BeneficiaryOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = getIt<SharedPrefs>();
    final mobileNumber = prefs.getMobileNumber() ?? '';
    final last4Digits = mobileNumber.length >= 4
        ? mobileNumber.substring(mobileNumber.length - 4)
        : mobileNumber;
    final restartTrigger = useState(0);
    return BlocConsumer<BeneficiaryBloc, BeneficiaryState>(
      // Only react when the one-shot result options actually change. Without
      // this, the listener fires on every emitted state (typing, resend,
      // cooldown ticks) and re-shows the invalid-OTP dialog because the failure
      // option still holds some(left(...)) from the previous attempt.
      listenWhen: (previous, current) =>
          previous.beneficiaryOtpFailureOrSuccessOption !=
              current.beneficiaryOtpFailureOrSuccessOption ||
          previous.resendBeneficiaryOtpFailureOrSuccessOption !=
              current.resendBeneficiaryOtpFailureOrSuccessOption,
      listener: (context, state) {
        state.resendBeneficiaryOtpFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => AppNotify.toast(
              failure.maybeMap(
                unableToSendBeneficiaryVerificationCode: (value) =>
                    value.message.toString(),
                serverError: (_) => 'errors.serverError'.tr(),
                orElse: () => 'errors.orElse'.tr(),
              ),
              type: AppToastType.error,
            ),
            (success) {
              if (success == 200) {
                restartTrigger.value++;
              }
            },
          ),
        );
        state.beneficiaryOtpFailureOrSuccessOption.fold(
          () => null,
          (either) => either.fold(
            (failure) => AppNotify.dialog(
              message: failure.maybeMap(
                unableToVerifyBeneficiaryOtp: (value) =>
                    value.message.toString(),
                serverError: (_) => 'errors.serverError'.tr(),
                orElse: () => 'errors.orElse'.tr(),
              ),
              type: AppDialogType.error,
            ),
            (success) {
              context.router.pop();
              // Refetch the authoritative lists from the backend so the newly
              // added/edited record shows with all server-side fields — both
              // the home send-again list and the standalone manage list.
              context.read<HomeBloc>().add(
                const HomeEvent.getBeneficiaryList(),
              );
              context.read<BeneficiaryBloc>().add(
                const BeneficiaryEvent.getBeneficiaries(),
              );
              if (state.proceedToSummaryAfterSave) {
                // Edit launched from the home mandatory-field check: the now-
                // required fields are saved and OTP-verified, so continue
                // straight to the summary. success is the server-assigned eId.
                continueToSummaryAfterBeneficiarySave(context, success);
              } else {
                // success is the server-assigned eId; the summary refetches the
                // record from the backend if it is the one currently shown.
                context.read<SummaryBloc>().add(
                  SummaryEvent.beneficiaryUpdatedChanged(eId: success),
                );
              }
            },
          ),
        );
      },
      builder: (context, state) {
        return AppOtp(
          restartTrigger: restartTrigger.value,
          isSubmitting: state.isOtpSubmitting,
          autovalidateMode: state.showOtpErrorMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          // Validate the value just typed — not state.beneficiaryOtp, which is
          // one keystroke stale because beneficiaryOtpChanged is dispatched
          // asynchronously right before the validator runs. Reading the stale
          // state left the inline error stuck on after the OTP became valid.
          validator: (value) => BeneficiaryOtp(value ?? '').value.fold(
            (f) => f.maybeMap(
              invalidOtp: (_) => 'otp.validationError'.tr(),
              orElse: () => null,
            ),
            (_) => null,
          ),
          onChanged: (p0) {
            context.read<BeneficiaryBloc>().add(
              BeneficiaryEvent.beneficiaryOtpChanged(p0),
            );
          },
          contentTitle: 'otp.title'.tr(),
          contentSubtitle: 'otp.description'.tr(
            namedArgs: {'mobileNumber': '*****$last4Digits'},
          ),
          onResend: () {
            context.read<BeneficiaryBloc>().add(
              const BeneficiaryEvent.resendBeneficiaryOtp(),
            );
          },
          onTapContinue: () {
            FocusScope.of(context).unfocus();
            context.read<BeneficiaryBloc>().add(
              const BeneficiaryEvent.beneficiaryOtpSubmitted(),
            );
          },
        );
      },
    );
  }
}
