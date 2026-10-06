import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';
import 'domain/core/crash_reporting/app_crash_reporting.dart';
import 'domain/core/di/injection.dart';
import 'domain/core/push_notification/app_push_notification.dart';
import 'presentation/core/app_widget.dart';
import 'presentation/core/global/app_global.dart';

/// The entry point of the application.
///
/// This function initializes necessary dependencies, performs security checks,
/// and runs the Flutter application.
Future<void> main() async {
  // Ensures that the Flutter framework is properly initialized.
  final binding = WidgetsFlutterBinding.ensureInitialized();

  // Hold the native launch screen in place across the async init below and
  // until the first Flutter frame is drawn, so there is no white window
  // between the OS launch screen and the Dart SplashPage.
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  // Initializes the EasyLocalization package for localization support.
  await EasyLocalization.ensureInitialized();

  // Configures dependency injection for the application using the production environment.
  await configureInjection(Environment.prod);

  // Firebase backs the cloud audit log for critical transaction APIs (and,
  // later, FCM). On Android/iOS, initializeApp() reads the native config files
  // (google-services.json / GoogleService-Info.plist) automatically, so no
  // generated `firebase_options.dart` is needed here. Those config files are
  // git-ignored and may be absent from a checkout; without them initialization
  // fails and the app simply runs with auditing as a no-op.
  try {
    await Firebase.initializeApp();
  } catch (_) {}

  // Crash reporting: no-op until Firebase is configured (guard inside).
  // Must run before runApp so the error handlers catch everything.
  await AppCrashReporting.init();

  // Push notifications: no-op until Firebase is configured (guard inside).
  await AppPushNotification.init();

  final locale = await AppGlobal.getInitialLocale();

  runApp(
    EasyLocalization(
      supportedLocales: AppGlobal.supportedLocales,
      path: AppGlobal.translationsPath,
      fallbackLocale: AppGlobal.supportedLocales.first,
      startLocale: locale,
      child: const AppWidget(
      ),
    ),
  );

  // Remove the native splash only after the first frame is rendered — by then
  // the SplashPage's brand gradient is painted, so the hand-off is seamless.
  binding.addPostFrameCallback((_) => FlutterNativeSplash.remove());
}
