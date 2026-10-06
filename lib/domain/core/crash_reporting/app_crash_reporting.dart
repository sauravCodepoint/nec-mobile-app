import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../di/injection.dart';
import '../prefs/app_prefs.dart';

/// Routes uncaught errors into Firebase Crashlytics.
///
/// Safe by construction: [init] is a no-op until the client's Firebase config
/// is present (config files are git-ignored per client), handlers are only
/// installed in non-debug builds so local development keeps the standard
/// console output and red error screen, and every step is guarded so crash
/// reporting can never itself break app startup.
class AppCrashReporting {
  AppCrashReporting._();

  /// Installs the global error handlers. Called once from `main.dart`,
  /// right after `Firebase.initializeApp`.
  static Future<void> init() async {
    if (Firebase.apps.isEmpty) return;
    try {
      final crashlytics = FirebaseCrashlytics.instance;

      // Keeps dev-machine crashes out of the client's console. Also covers
      // native crashes, which Crashlytics collects automatically.
      await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
      if (kDebugMode) return;

      // Uncaught Flutter framework errors (build, layout, gesture).
      FlutterError.onError = crashlytics.recordFlutterFatalError;

      // Uncaught errors outside the framework (async gaps, platform
      // channels). Returning true marks them handled so the engine
      // doesn't also dump them to the console.
      PlatformDispatcher.instance.onError = (error, stack) {
        crashlytics.recordError(error, stack, fatal: true);
        return true;
      };

      syncUser();
    } catch (e) {
      debugPrint('Crashlytics init failed: $e');
    }
  }

  /// Tags subsequent reports with the stored member code so crashes can be
  /// looked up user-wise, mirroring the audit log. Called from [init] and
  /// again from MainPage's post-login effect, the choke point every login
  /// path passes through. Only the numeric code is sent — never name,
  /// mobile number, or other PII.
  static void syncUser() {
    if (Firebase.apps.isEmpty) return;
    try {
      final memberCode = getIt<SharedPrefs>().getMemberCode();
      FirebaseCrashlytics.instance.setUserIdentifier(
        memberCode == 0 ? '' : memberCode.toString(),
      );
    } catch (_) {}
  }
}