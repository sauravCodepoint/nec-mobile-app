import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/otp/otp_bloc.dart';
import '../../domain/core/di/injection.dart';
import '../../domain/core/failures.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/session/post_otp_outcome.dart';
import '../../domain/otp/otp_failure.dart';
import '../core/global/app_global.dart';
import '../core/images/app_image.dart';
import '../core/notify/app_notify.dart';
import '../core/otp/app_otp.dart';
import '../core/overlay_loading/app_overlay_loading.dart';
import '../core/theme/app_theme_ext.dart';
import '../core/widgets/confirm_pop_scope.dart';
import '../routes/app_navigation_guard.dart';
import '../routes/app_routes.gr.dart';

@RoutePage()
class OtpPage extends HookWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final restartTrigger = useState(0);

    return ConfirmPopScope(
      title: 'otp.exitDialog.title'.tr(),
      message: 'otp.exitDialog.message'.tr(),
      type: AppDialogType.warning,
      onConfirm: () {
        // User abandoned the OTP screen — drop the pending-OTP record so a
        // later cold-start lands on Login, not back on a screen they left.
        getIt<SharedPrefs>().clearPendingOtp();
        context.router.pop();
      },
      child: BlocConsumer<OtpBloc, OtpState>(
        listenWhen: (prev, curr) =>
            prev.resendOtpFailureOrSuccessOption !=
                curr.resendOtpFailureOrSuccessOption ||
            prev.otpFailureOrSuccessOption != curr.otpFailureOrSuccessOption,
        listener: (context, state) {
          state.resendOtpFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) => AppNotify.toast(
                failure.maybeMap(
                  unableToSendOtp: (value) => value.message.toString(),
                  serverError: (_) => 'errors.serverError'.tr(),
                  orElse: () => 'errors.orElse'.tr(),
                ),
                type: AppToastType.error,
              ),
              (_) {
                restartTrigger.value++;
              },
            ),
          );
          state.otpFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) => failure.maybeMap(
                userIsNotRegistered: (value) => AppNotify.dialog(
                  isTitleWidget: true,
                  titleWidget: Container(
                    width: 72.w,
                    height: 72.w,
                    margin: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: context.appColors.shadowInk.withValues(
                            alpha: 0.22,
                          ),
                          blurRadius: 18,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(AppImages.icon, fit: BoxFit.cover),
                  ),
                  showIcon: false,
                  message: value.message,
                  type: AppDialogType.warning,
                  buttonText: 'buttons.cancel'.tr(),
                  secondButtonText: 'buttons.register'.tr(),
                  showTwoButtons: true,
                  onPressed: () {
                    context.router.popUntilRouteWithName(LoginRoute.name);
                  },
                  // In-app registration was removed: there is no KYC /
                  // Registration flow to send the user into, so the second
                  // button only dismisses the dialog. Cancel still unwinds
                  // to Login.
                  onSecondPressed: () => context.router.pop(),
                ),
                invalidOtp: (value) => AppNotify.toast(
                  value.message.toString(),
                  type: AppToastType.error,
                ),
                serverError: (_) => AppNotify.toast(
                  'errors.serverError'.tr(),
                  type: AppToastType.error,
                ),
                unexpectedServerState: (value) => AppNotify.dialog(
                  title: 'otp.unexpectedStateDialog.title'.tr(),
                  message: 'otp.unexpectedStateDialog.message'.tr(
                    namedArgs: {'errorId': value.message ?? '-'},
                  ),
                  type: AppDialogType.error,
                ),
                orElse: () => AppNotify.toast(
                  'errors.orElse'.tr(),
                  type: AppToastType.error,
                ),
              ),
              (outcome) => outcome.when(
                completeSession: (_) =>
                    context.router.replaceAll([MainRoute()]),
                pendingMpinSetup: (_) =>
                    context.router.replaceAll([SetMpinRoute()]),
                pendingProfile: (_) =>
                    context.popAndPushIfActive(const CompleteProfileRoute()),
                // Same stack shape as the post-registration and cold-start
                // entries: Login at the root so a back-out lands on Login.
                pendingApproval: () => context.router.replaceAll([
                  const LoginRoute(),
                  const MemberApprovalRoute(),
                ]),
              ),
            ),
          );
        },
        builder: (context, state) {
          final mobileNumber = state.mobileNumber;
          final last4Digits = mobileNumber.length >= 4
              ? mobileNumber.substring(mobileNumber.length - 4)
              : mobileNumber;

          return Stack(
            children: [
              AppOtp(
                restartTrigger: restartTrigger.value,
                requestedAt: state.requestedAt,
                isSubmitting: state.isSubmitting,
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                validator: (_) => context.read<OtpBloc>().state.otp.value.fold(
                  (f) => f.maybeMap(
                    invalidOtp: (_) => 'otp.validationError'.tr(),
                    orElse: () => null,
                  ),
                  (_) => null,
                ),
                onChanged: (p0) {
                  context.read<OtpBloc>().add(OtpEvent.otpChanged(p0));
                },
                contentTitle: 'otp.title'.tr(),
                contentSubtitle: 'otp.description'.tr(
                  namedArgs: {'mobileNumber': '*****$last4Digits'},
                ),
                onResend: () {
                  context.read<OtpBloc>().add(const OtpEvent.resendOtp());
                },
                onTapContinue: () {
                  // Platform-level hide, not FocusScope.of(context).unfocus():
                  // this route is about to be popped (popAndPush on the
                  // pending-profile outcome), and a scoped unfocus that hasn't
                  // reached the engine before the route is torn down leaves the
                  // soft keyboard up on the destination. The next page then
                  // resizes for an inset it never asked for and its bottom CTA
                  // lands mid-screen.
                  AppGlobal.dismissKeyboard();
                  context.read<OtpBloc>().add(const OtpEvent.otpSubmitted());
                },
              ),
              if (state.isLoading || state.isSubmitting)
                const AppOverlayLoading(),
            ],
          );
        },
      ),
    );
  }
}
