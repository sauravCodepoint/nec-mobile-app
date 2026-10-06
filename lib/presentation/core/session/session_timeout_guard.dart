import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/core/di/injection.dart';
import '../../routes/app_routes.dart';
import '../../routes/app_routes.gr.dart';
import '../notify/app_notify.dart';

/// Locks the app behind the MPIN screen after [_timeout] of user inactivity.
///
/// Wraps the router (installed in `app_widget.dart`) in a translucent
/// [Listener], so every raw pointer-down anywhere in the app counts as
/// activity — no per-screen wiring. The timer is armed only while an
/// authenticated session is on screen: every login path enters via
/// `replaceAll([MainRoute()])` and every exit is a `replaceAll` without
/// [MainRoute], so listening to the router arms/disarms exactly at session
/// boundaries and the dialog can never appear on login/OTP/MPIN screens.
///
/// Wall-clock timestamps — not the timer — decide expiry across
/// backgrounding: Dart timers don't tick while the OS suspends the app, so
/// the timer is dropped on pause and the elapsed time re-checked on resume,
/// locking immediately if the session is overdue.
class SessionTimeoutGuard extends HookWidget {
  const SessionTimeoutGuard({super.key, required this.child});

  static const _timeout = Duration(minutes: 3);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final router = useMemoized(() => getIt<AppRouter>());
    final timer = useRef<Timer?>(null);
    final lastActivity = useRef(DateTime.now());
    // True from expiry until the dialog is dismissed; suppresses re-arming
    // from taps on the dialog itself and duplicate expirations.
    final locking = useRef(false);

    bool inSession() =>
        router.stack.any((page) => page.routeData.name == MainRoute.name);

    void disarm() {
      timer.value?.cancel();
      timer.value = null;
    }

    void expire() {
      if (locking.value || !inSession()) return;
      locking.value = true;
      disarm();
      AppNotify.dialog(
        type: AppDialogType.warning,
        title: 'core.sessionTimeout.title'.tr(),
        message: 'core.sessionTimeout.message'.tr(),
        onPressed: () => router.navigatorKey.currentState?.pop(),
      ).whenComplete(() {
        // Runs on OK and on any other dismissal (e.g. Android back key): the
        // session locks either way. Skip the navigation only if something
        // else (401 logout) already left the session while the dialog was up.
        locking.value = false;
        if (inSession()) router.replaceAll([MpinRoute()]);
      });
    }

    void arm([Duration remaining = _timeout]) {
      timer.value?.cancel();
      timer.value = Timer(remaining, expire);
    }

    void touch() {
      if (locking.value || !inSession()) return;
      lastActivity.value = DateTime.now();
      arm();
    }

    useEffect(() {
      // Navigating is activity too, and entering/leaving the session must
      // start/stop the countdown even without a touch (e.g. auto-login).
      void onRouteChanged() => inSession() ? touch() : disarm();

      router.addListener(onRouteChanged);
      onRouteChanged();
      return () {
        router.removeListener(onRouteChanged);
        disarm();
      };
    }, const []);

    useOnAppLifecycleStateChange((_, state) {
      if (locking.value || !inSession()) return;
      switch (state) {
        case AppLifecycleState.paused:
          disarm();
        case AppLifecycleState.resumed:
          final idle = DateTime.now().difference(lastActivity.value);
          idle >= _timeout ? expire() : arm(_timeout - idle);
        default:
          break;
      }
    });

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => touch(),
      child: child,
    );
  }
}