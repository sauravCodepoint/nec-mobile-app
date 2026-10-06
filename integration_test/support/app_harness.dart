import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nec_mobile_app/domain/core/di/injection.dart';
import 'package:nec_mobile_app/presentation/core/app_widget.dart';
import 'package:nec_mobile_app/presentation/core/global/app_global.dart';

/// Shared bootstrap for run-app automation tests.
///
/// Mirrors the real [main] in `lib/main.dart` — same localization init, same
/// dependency-injection container, same [AppWidget] root — so a test drives the
/// production widget tree, not a stand-in. What it deliberately drops are the
/// Firebase / crash-reporting / push-notification steps: those are no-ops
/// without per-client config and only touch platform channels the splash flow
/// never needs.
///
/// The security gate ([AppConfig.securityGateEnabled]) is a compile-time const,
/// so on a rooted device or emulator it will block the app. Run these tests
/// with the gate disabled:
///
/// ```
/// flutter test integration_test/presentation/splash/splash_page_test.dart \
///   --dart-define=SECURITY_GATE_ENABLED=false
/// ```
class AppHarness {
  const AppHarness._();

  /// Boots the app inside [tester] exactly as [main] would.
  ///
  /// [initialPrefs] seeds `SharedPreferences` before DI resolves it. The
  /// default — an empty map — is a pristine first-launch install, which the
  /// splash routes to the on-boarding screen. Pass overrides to drive other
  /// branches (e.g. `{'hasOnboarded': true}` to land on login instead).
  static Future<void> launchApp(
    WidgetTester tester, {
    Map<String, Object> initialPrefs = const {},
  }) async {
    // Seed prefs on the mock channel BEFORE DI resolves SharedPreferences
    // (registered @preResolve via SharedPreferences.getInstance()). This keeps
    // the run deterministic and never touches the device's real prefs store.
    SharedPreferences.setMockInitialValues(initialPrefs);

    // A fresh container per test — configureInjection registers singletons
    // (AppRouter, SharedPrefs) that would throw "already registered" on a
    // second boot otherwise.
    await getIt.reset();

    await EasyLocalization.ensureInitialized();
    await configureInjection(Environment.prod);

    final locale = await AppGlobal.getInitialLocale();

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: AppGlobal.supportedLocales,
        path: AppGlobal.translationsPath,
        fallbackLocale: AppGlobal.supportedLocales.first,
        startLocale: locale,
        child: const AppWidget(),
      ),
    );

    // Let EasyLocalization's async delegate load and the first frame settle.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  /// Pumps frames until [finder] matches or [timeout] elapses.
  ///
  /// [WidgetTester.pumpAndSettle] can't be used across the splash: the Lottie
  /// animation schedules frames continuously, so the tree never "settles" until
  /// it finishes. This drives explicit frames and checks after each.
  static Future<void> pumpUntilFound(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 15),
    Duration step = const Duration(milliseconds: 100),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      await tester.pump(step);
      if (finder.evaluate().isNotEmpty) return;
    }
    throw TestFailure(
      'Timed out after ${timeout.inSeconds}s waiting for: '
      '${finder.describeMatch(Plurality.many)}',
    );
  }
}