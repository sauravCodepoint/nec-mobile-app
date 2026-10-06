/// Global, synchronous signal that a *force* update is in effect for this
/// session.
///
/// A force-update dialog is non-dismissible, but it is pushed imperatively on
/// the root navigator (via `AppRouter.navigatorKey`). On iOS the MPIN screen
/// can auto-invoke Face ID the instant biometric support resolves; a
/// successful auth then `replaceAll`s to `MainRoute`, which tears that dialog
/// off the navigator and drops the user on Home without ever updating.
///
/// This gate is flipped the moment a force-update dialog is shown so the auth
/// flow can refuse to auto-prompt biometrics and refuse to leave the lock
/// screen while it is set. It is intentionally never reset within a session —
/// a force update only clears by actually updating, i.e. a fresh launch.
class AppUpdateGate {
  AppUpdateGate._();

  static bool forceUpdateActive = false;
}
