import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:nec_mobile_app/domain/core/prefs/app_prefs.dart';
import 'package:nec_mobile_app/presentation/splash/splash_page.dart';
import 'package:nec_mobile_app/presentation/on_boarding/on_boarding_page.dart';
import 'package:nec_mobile_app/presentation/login/login_page.dart';

import '../../support/app_harness.dart';

/// Run-app automation for the splash screen.
///
/// These boot the real [AppWidget] via [AppHarness] and assert where the splash
/// hands off, based purely on persisted `SharedPreferences` state — no backend,
/// no login. The splash always plays its full Lottie before navigating, so each
/// test pumps frames until the destination page appears (see
/// [AppHarness.pumpUntilFound]).
///
/// Requires the security gate off on emulators/rooted devices:
///   flutter test integration_test/presentation/splash/splash_page_test.dart \
///     --dart-define=SECURITY_GATE_ENABLED=false
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('SplashPage', () {
    testWidgets('shows the splash on launch', (tester) async {
      await AppHarness.launchApp(tester);

      // The splash is the first Flutter screen every cold start renders.
      expect(find.byType(SplashPage), findsOneWidget);

      // Then let it play through to its destination so the splash disposes —
      // ending here would leave its 10s watchdog Timer and Lottie/exit
      // animations live, which flutter_test flags as a pending-timer failure.
      await AppHarness.pumpUntilFound(tester, find.byType(OnBoardingPage));
    });

    testWidgets('a first-time install routes to on-boarding', (tester) async {
      // Empty prefs == pristine install: hasOnboarded is false, so the splash's
      // on-boarding gate must win before any auth/session check.
      await AppHarness.launchApp(tester);

      await AppHarness.pumpUntilFound(tester, find.byType(OnBoardingPage));

      expect(find.byType(OnBoardingPage), findsOneWidget);
      expect(find.byType(SplashPage), findsNothing);
    });

    testWidgets('an onboarded, signed-out user routes to login', (tester) async {
      // hasOnboarded true but no session/token: the splash falls through the
      // pending-resume checks to the plain login screen.
      await AppHarness.launchApp(
        tester,
        initialPrefs: const {SharedPrefs.hasOnboardedKey: true},
      );

      await AppHarness.pumpUntilFound(tester, find.byType(LoginPage));

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(OnBoardingPage), findsNothing);
    });
  });
}