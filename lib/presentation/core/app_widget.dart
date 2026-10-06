import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../application/app_update/app_update_bloc.dart';
import '../../application/beneficiary/beneficiary_bloc.dart';
import '../../application/company_info/company_info_bloc.dart';
import '../../application/bio_metric/bio_metric_bloc.dart';
import '../../application/update_kyc/update_kyc_bloc.dart';
import '../../application/branches/branches_bloc.dart';
import '../../application/change_mpin/change_mpin_bloc.dart';
import '../../application/forgot_mpin/forgot_mpin_bloc.dart';
import '../../application/home/home_bloc.dart';
import '../../application/login/login_bloc.dart';
import '../../application/member_approval/member_approval_bloc.dart';
import '../../application/mpin/mpin_bloc.dart';
import '../../application/notification/notification_bloc.dart';
import '../../application/on_boarding/on_boarding_bloc.dart';
import '../../application/otp/otp_bloc.dart';
import '../../application/profile/profile_bloc.dart';
import '../../application/complete_profile/complete_profile_bloc.dart';
import '../../application/rate_calculator/rate_calculator_bloc.dart';
import '../../application/set_mpin/set_mpin_bloc.dart';
import '../../application/settings/settings_bloc.dart';
import '../../application/splash/splash_bloc.dart';
import '../../application/summary/summary_bloc.dart';
import '../../application/support/support_bloc.dart';
import '../../application/transaction_history/transaction_history_bloc.dart';
import '../../domain/core/di/injection.dart';
import '../app_update/widgets/app_update_dialog.dart';
import '../routes/app_routes.dart';
import '../security/security_gate.dart';
import 'language/language_switch_animator.dart';
import 'network/network_status_banner.dart';
import 'session/session_timeout_guard.dart';
import 'theme/app_theme.dart';
import 'widgets/keyboard_dismiss_observer.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleText: () => false,
      enableScaleWH: () => true,
      ensureScreenSize: true,
      fontSizeResolver: (fontSize, instance) => fontSize * 1.0,
      rebuildFactor: (old, data) => old != data,
      useInheritedMediaQuery: true,
      builder: (context, child) => SecurityGate(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  getIt<SplashBloc>()
                    ..add(const SplashEvent.checkAuthentication()),
            ),
            BlocProvider(create: (context) => getIt<OnBoardingBloc>()),
            BlocProvider(create: (context) => getIt<LoginBloc>()),
            BlocProvider(create: (context) => getIt<OtpBloc>()),
            BlocProvider(create: (context) => getIt<UpdateKycBloc>()),
            BlocProvider(create: (context) => getIt<CompleteProfileBloc>()),
            BlocProvider(create: (context) => getIt<SetMpinBloc>()),
            BlocProvider(create: (context) => getIt<MpinBloc>()),
            BlocProvider(create: (context) => getIt<ForgotMpinBloc>()),
            BlocProvider(create: (context) => getIt<HomeBloc>()),
            BlocProvider(create: (context) => getIt<NotificationBloc>()),
            BlocProvider(create: (context) => getIt<BeneficiaryBloc>()),
            BlocProvider(create: (context) => getIt<BioMetricBloc>()),
            BlocProvider(create: (context) => getIt<SettingsBloc>()),
            BlocProvider(create: (context) => getIt<SummaryBloc>()),
            BlocProvider(create: (context) => getIt<ProfileBloc>()),
            BlocProvider(create: (context) => getIt<TransactionHistoryBloc>()),
            BlocProvider(create: (context) => getIt<BranchesBloc>()),
            BlocProvider(create: (context) => getIt<ChangeMpinBloc>()),
            BlocProvider(create: (context) => getIt<CompanyInfoBloc>()),
            BlocProvider(create: (context) => getIt<AppUpdateBloc>()),
            BlocProvider(create: (context) => getIt<MemberApprovalBloc>()),
            BlocProvider(create: (context) => getIt<SupportBloc>()),
            BlocProvider(create: (context) => getIt<RateCalculatorBloc>()),
          ],
          // MediaQuery is read INSIDE MaterialApp.router's builder so the IME
          // show/hide rebuild stays scoped to that tiny subtree. Reading it
          // here at AppWidget would rebuild the entire MaterialApp + provider
          // tree on every keystroke that pops the keyboard.
          child: BlocListener<AppUpdateBloc, AppUpdateState>(
            // Sits above the router so the update prompt covers every entry
            // screen the splash can route to. The dialog itself is pushed via
            // the global navigator key, so no Navigator context is needed here.
            listenWhen: (previous, current) =>
                previous.appUpdateFailureOrSuccessOption !=
                current.appUpdateFailureOrSuccessOption,
            listener: (context, state) {
              state.appUpdateFailureOrSuccessOption.fold(
                () {},
                (failureOrSuccess) => failureOrSuccess.fold(
                  // A failed background check must never block app entry.
                  (_) {},
                  (dto) {
                    final data = dto.data;
                    if (data != null && data.isUpdateRequired) {
                      AppUpdateDialog.show(data);
                    }
                  },
                ),
              );
            },
            child: MaterialApp.router(
              routerConfig: appRouter.config(
                navigatorObservers: () => [KeyboardDismissObserver()],
              ),
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              // One theme, pinned: the app has no light theme and does not
              // follow the device setting. `theme` is supplied as well as
              // `darkTheme` so the canvas is identical no matter what the
              // platform reports.
              theme: appDarkTheme,
              darkTheme: appDarkTheme,
              themeMode: ThemeMode.dark,
              builder: (context, routerChild) {
                final mediaQuery = MediaQuery.of(context);
                return MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: TextScaler.noScaling,
                    boldText: false,
                    // Forces every text field onto Flutter's own selection
                    // toolbar instead of the iOS 16+ native context menu.
                    // The framework's default contextMenuBuilder shows a
                    // SystemContextMenu whenever this flag is true, and
                    // SystemContextMenuController.show() asserts
                    // ("Attempted to show while another instance was still
                    // visible") when a second field requests the menu before
                    // the first field's menu has finished hiding — which is
                    // exactly what happens when a tap moves focus between
                    // two fields, or the keyboard opens while a selection
                    // menu is up. Turning the capability off here is the
                    // only app-side switch for that code path and covers
                    // every field, dialog and bottom sheet under the router.
                    supportsShowingSystemContextMenu: false,
                  ),
                  // easy_localization's delegate loads asynchronously, so on
                  // a locale change the framework's Localizations widget (and
                  // its Directionality) lags one frame behind the tr()
                  // strings, which flip immediately — briefly rendering the
                  // new language in the old text direction. Deriving the
                  // direction from context.locale here keeps the RTL↔LTR
                  // flip in the same frame as the re-typeset strings.
                  child: Directionality(
                    textDirection:
                        Bidi.isRtlLanguage(context.locale.languageCode)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    // Wraps the router so a locale switch can play a
                    // blur-dissolve into the new language. Its static key
                    // survives MaterialApp rebuilds, so the frozen overlay
                    // persists while the locale swaps underneath.
                    child: LanguageSwitchAnimator(
                      child: SessionTimeoutGuard(
                        child: NetworkStatusBanner(
                          child: routerChild ?? const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
