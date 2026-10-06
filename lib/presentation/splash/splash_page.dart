import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

import '../../application/app_update/app_update_bloc.dart';
import '../../application/otp/otp_bloc.dart';
import '../../application/splash/splash_bloc.dart';
import '../../domain/core/di/injection.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/session/pending_registration.dart';
import '../core/images/app_image.dart';
import '../core/notification_permission/notification_permission_primer.dart';
import '../core/scaffold/app_scaffold.dart';
import '../routes/app_routes.dart';
import '../routes/app_routes.gr.dart';

@RoutePage()
class SplashPage extends HookWidget {
  const SplashPage({super.key});

  // If the security checks don't resolve within this window something has gone
  // badly wrong (deadlock, unhandled exception swallowed before the bloc emits,
  // etc.). Force navigation to login so the user is never stranded.
  static const _kWatchdogDuration = Duration(seconds: 10);

  @override
  Widget build(BuildContext context) {
    final router = useMemoized(() => getIt<AppRouter>());

    // Boot-time snapshot. Read once so watchdog / failure fallbacks can pick
    // OnBoarding over Login for first-time users even if SplashBloc never
    // emits a terminal state.
    final hasOnboardedAtBoot = useMemoized(
      () => getIt<SharedPrefs>().getHasOnboarded(),
    );

    PageRouteInfo fallbackRoute() =>
        hasOnboardedAtBoot ? const LoginRoute() : const OnBoardingRoute();

    // Drives the splash Lottie. Its duration is assigned once the composition
    // loads (see Lottie.onLoaded below). Navigation is gated on this controller
    // reaching completion, so the splash always plays the full animation before
    // moving to the next screen.
    final lottieController = useAnimationController();
    final exit = useAnimationController(
      duration: const Duration(milliseconds: 420),
    );

    // Stores the actual router call, executed once exit completes.
    final pendingRoute = useRef<VoidCallback?>(null);

    // Stores a navigation request that arrived before the Lottie finished.
    // Flushed when the Lottie controller fires AnimationStatus.completed.
    final pendingNavigate = useRef<VoidCallback?>(null);

    // Disarmed by any terminal BLoC state. The watchdog reads this before
    // deciding whether to force-navigate.
    final watchdogDisarmed = useRef(false);

    // When the Lottie completes, flush any navigation that was queued while it
    // was still playing. This makes the Lottie's own duration the natural
    // minimum display time — no Future.delayed needed anywhere.
    useEffect(() {
      void onLottieComplete(AnimationStatus s) {
        if (s != AnimationStatus.completed) return;
        final queued = pendingNavigate.value;
        if (queued != null) {
          pendingNavigate.value = null;
          queued();
        }
      }

      lottieController.addStatusListener(onLottieComplete);
      return () => lottieController.removeStatusListener(onLottieComplete);
    }, const []);

    // ── Exit animation ────────────────────────────────────────────────────
    // Captured before the effect: once the splash route is replaced this
    // element is defunct and context.read/context.locale would throw.
    final appUpdateBloc = context.read<AppUpdateBloc>();
    final languageCode = context.locale.languageCode;
    useEffect(() {
      void onExitComplete(AnimationStatus s) {
        if (s == AnimationStatus.completed) {
          pendingRoute.value?.call();
          // Kick off the update check only after splash has handed off to
          // the first real screen — a dialog shown while the splash route is
          // still on the stack would be torn down by the replaceAll above.
          appUpdateBloc.add(
            AppUpdateEvent.checkRequested(languageCode: languageCode),
          );
        }
      }

      exit.addStatusListener(onExitComplete);
      return () => exit.removeStatusListener(onExitComplete);
    }, const []);

    // ── Watchdog ──────────────────────────────────────────────────────────
    // Guards the orElse path: initial / loadingProgress are legitimately
    // transient and need no action, but if the bloc gets permanently stuck
    // there (extremely rare — uncaught exception before emit, deadlock, etc.)
    // the watchdog fires and sends the user to login after 10 seconds.
    useEffect(() {
      final timer = Timer(_kWatchdogDuration, () {
        if (watchdogDisarmed.value) return;
        // Force past the Lottie gate: if the animation never loaded/completed
        // the user must still be able to leave the splash.
        pendingNavigate.value = null;
        pendingRoute.value = () => router.replaceAll([fallbackRoute()]);
        exit.forward();
      });
      return timer.cancel;
    }, const []);

    // ── Navigation helper ─────────────────────────────────────────────────
    void navigate(
      VoidCallback go, {
      bool awaitingApproval = false,
      bool promptNotifications = true,
    }) {
      _doNavigate(
        gate: lottieController,
        exit: exit,
        pendingRoute: pendingRoute,
        pendingNavigate: pendingNavigate,
        go: () {
          go();
          // Ask for notification permission at application start: right
          // after the replaceAll above, the first safe dialog moment (a
          // dialog over the splash route itself would be torn down — see
          // the app-update note in onExitComplete). The primer's own delay
          // lets the destination screen settle first.
          //
          // Skipped for the MPIN lock screen (promptNotifications: false):
          // that destination auto-invokes Face ID on iOS, so a notification
          // dialog landing over it would collide with the biometric prompt.
          // MainPage re-offers the primer once the user authenticates past
          // the lock screen — the _shownThisSession guard keeps it single.
          if (promptNotifications) {
            NotificationPermissionPrimer.runAtAppStart(
              awaitingApproval: awaitingApproval,
            );
          }
        },
      );
    }

    // ── Animations ────────────────────────────────────────────────────────
    final exitOpacity = useMemoized(
      () => Tween<double>(
        begin: 1.0,
        end: 0.0,
      ).animate(CurvedAnimation(parent: exit, curve: Curves.easeIn)),
      const [],
    );

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        state.maybeWhen(
          loadedSuccessOnBoarding: () {
            watchdogDisarmed.value = true;
            navigate(() => router.replaceAll([const OnBoardingRoute()]));
          },
          loadedSuccessLogin: () {
            watchdogDisarmed.value = true;
            navigate(() => router.replaceAll([const LoginRoute()]));
          },
          loadedSuccessOtpPending: (idType, idNumber, mobileNumber) {
            watchdogDisarmed.value = true;
            // Seed OtpBloc before navigating — OtpPage builds against the
            // already-populated state instead of an empty initial.
            context.read<OtpBloc>().add(
              OtpEvent.initial(
                idType: idType,
                idNumber: idNumber,
                mobileNumber: mobileNumber,
              ),
            );
            // Login is kept at the root of the stack so the user can pop
            // back to it normally if they decide to abandon the OTP.
            navigate(
              () => router.replaceAll([const LoginRoute(), const OtpRoute()]),
            );
          },
          loadedSuccessRegistrationPending: (registration) {
            watchdogDisarmed.value = true;
            registration.when(
              completeProfile: (_, _, _, _, _) {
                // Login at the stack root so back-out lands on Login.
                navigate(
                  () => router.replaceAll([
                    const LoginRoute(),
                    const CompleteProfileRoute(),
                  ]),
                );
              },
            );
          },
          loadedSuccessApprovalPending: () {
            watchdogDisarmed.value = true;
            // Login kept at the stack root so a back-out lands on Login,
            // matching the other pending-resume flows.
            navigate(
              () => router.replaceAll([
                const LoginRoute(),
                const MemberApprovalRoute(),
              ]),
              awaitingApproval: true,
            );
          },
          loadedSuccessSetMpin: () {
            watchdogDisarmed.value = true;
            navigate(() => router.replaceAll([const SetMpinRoute()]));
          },
          loadedSuccessMain: () {
            watchdogDisarmed.value = true;
            // No notification prompt here — the MPIN screen auto-invokes Face
            // ID; MainPage asks once the user is authenticated past it.
            navigate(
              () => router.replaceAll([MpinRoute(autoPromptBiometric: true)]),
              promptNotifications: false,
            );
          },
          loadedFailure: (_) {
            watchdogDisarmed.value = true;
            navigate(() => router.replaceAll([fallbackRoute()]));
          },
          // initial / loadingProgress are expected transient states — watchdog
          // above handles the case where the bloc never leaves them.
          orElse: () {},
        );
      },
      child: FadeTransition(
        opacity: exitOpacity,
        child: AppScaffold(
          onTapOutside: () => FocusScope.of(context).unfocus(),
          body: SizedBox.expand(
            child: Lottie.asset(
              AppImages.splashLottie,
              controller: lottieController,
              fit: BoxFit.cover,
              onLoaded: (composition) {
                lottieController
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Starts the exit animation, gated on the splash Lottie (`gate`) having
/// completed. If the Lottie is still playing, the request is queued and executed
/// the moment it finishes — making the Lottie's duration the natural minimum
/// display time.
void _doNavigate({
  required AnimationController gate,
  required AnimationController exit,
  required ObjectRef<VoidCallback?> pendingRoute,
  required ObjectRef<VoidCallback?> pendingNavigate,
  required VoidCallback go,
}) {
  void startExit() {
    pendingRoute.value = go;
    exit.forward();
  }

  if (gate.isCompleted) {
    startExit();
  } else {
    pendingNavigate.value = startExit;
  }
}
