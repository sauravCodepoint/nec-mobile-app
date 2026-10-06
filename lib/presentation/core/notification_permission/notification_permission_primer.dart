import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

import 'notification_permission_dialog.dart';

/// Notification-permission soft prompt, fired once per app session by
/// `SplashPage` the moment splash hands off to the first screen — so
/// permission is requested at application start, before any login. The
/// awaiting-member-approval destination swaps in approval-specific wording.
///
/// The OS permission dialog is a scarce resource — iOS shows it exactly once
/// per install and Android 13+ roughly twice; after that only system Settings
/// can enable notifications. So the OS prompt is never fired cold: the user
/// first sees a branded in-app dialog. Declining costs nothing and the offer
/// returns on the next app launch. Once the OS prompt is spent (permanently
/// denied), the dialog deep-links to system Settings instead.
///
/// Runs on every cold start until permission is granted — there is no
/// persistent snooze, so a decline is re-offered after each app restart.
/// (The one-time welcome notification is not this class's concern:
/// `MainPage` calls `AppPushNotification.showWelcomeNotification` directly.)
class NotificationPermissionPrimer {
  NotificationPermissionPrimer._();

  // Lets the destination screen's transition settle before the dialog
  // appears over it.
  static const Duration _settleDelay = Duration(milliseconds: 600);

  // Guards against a second offer within one app session (e.g. hot reload
  // or a watchdog re-entry) — reset naturally on process restart.
  static bool _shownThisSession = false;

  /// Offers the primer over whatever screen splash routed to. Safe to call
  /// fire-and-forget; a no-op when permission is already granted.
  static Future<void> runAtAppStart({bool awaitingApproval = false}) async {
    if (_shownThisSession) return;
    _shownThisSession = true;

    try {
      final status = await Permission.notification.status;
      if (status.isGranted) return;

      await Future<void>.delayed(_settleDelay);
      if (status.isPermanentlyDenied || status.isRestricted) {
        await _offerSettings();
      } else {
        await _offerSystemPrompt(awaitingApproval: awaitingApproval);
      }
    } catch (_) {
      // Permission prompting must never disturb app startup.
    }
  }

  // Permission still requestable: explain the value, then fire the real OS
  // prompt only on agreement.
  static Future<void> _offerSystemPrompt({
    required bool awaitingApproval,
  }) async {
    final accepted = await NotificationPermissionDialog.show(
      openSettings: false,
      messageKey: awaitingApproval
          ? 'notifications.permission.approvalMessage'
          : null,
    );
    if (!accepted) return;

    await Permission.notification.request();
  }

  // The OS prompt can no longer be shown — offer the system settings page.
  static Future<void> _offerSettings() async {
    final accepted = await NotificationPermissionDialog.show(
      openSettings: true,
    );
    if (accepted) {
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }
}
