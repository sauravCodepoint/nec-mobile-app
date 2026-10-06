import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../presentation/core/notify/app_notify.dart';
import '../../../presentation/routes/app_routes.dart';
import '../../../presentation/routes/app_routes.gr.dart';
import '../prefs/app_prefs.dart';

/// Owns the server-initiated ("force") logout: the backend answers **428** on
/// every endpoint once it has repudiated the current session — signed in on
/// another device, blocked by the back office, credentials changed server-side.
///
/// Unlike the soft MPIN lock (drawer logout, inactivity timeout) this is not
/// recoverable on-device: the stored token is dead, so the session is wiped
/// with [SharedPrefs.resetSession] and the user is sent back to login rather
/// than to the MPIN screen, which would only offer an unlock that can't work.
///
/// The whole event is idempotent — a screen typically has several requests in
/// flight and every one of them sees the 428, but only the first triggers a
/// logout; the rest are swallowed by [_isLoggingOut].
@lazySingleton
class ForceLogoutHandler {
  ForceLogoutHandler(this._prefs, this._router);

  final SharedPrefs _prefs;
  final AppRouter _router;

  /// The status code the backend uses to signal "this session is gone".
  static const int statusCode = 428;

  /// How long toasts stay suppressed after the user has been moved to login,
  /// covering the tail of sibling requests that resolve just after the wipe.
  static const _suppressTail = Duration(seconds: 2);

  bool _isLoggingOut = false;
  DateTime? _suppressUntil;

  /// True while the logout is being handled (dialog up, navigation pending)
  /// and for a short tail afterwards. Error toasts are dropped during this
  /// window so the queued failures of the abandoned screen don't stack up on
  /// top of the dialog and the login screen.
  bool get isLoggingOut {
    if (_isLoggingOut) return true;
    final until = _suppressUntil;
    return until != null && DateTime.now().isBefore(until);
  }

  /// Whether there is anything to log out of. A 428 received before sign-in
  /// (login, OTP, registration) must not wipe prefs — that would destroy the
  /// pending-registration / pending-OTP resume state of a user who never had
  /// a session; the repository maps it to an ordinary failure instead.
  bool get hasSession {
    if (_prefs.getIsLoggedIn()) return true;
    try {
      final token = _prefs.getToken();
      return token != null && token.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Pulls the backend-authored reason out of a 428 body, so the user is told
  /// why (e.g. "You have been signed in on another device") instead of reading
  /// a generic message. Returns null for empty/non-JSON/unlabelled bodies.
  String? messageFromBody(String body) {
    if (body.isEmpty) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is! Map<String, dynamic>) return null;
      for (final key in const ['message', 'Message', 'msg', 'error']) {
        final value = decoded[key];
        if (value is String && value.trim().isNotEmpty) return value.trim();
      }
    } catch (_) {
      // Not JSON — fall back to the localized default.
    }
    return null;
  }

  /// Wipes the session, then tells the user once. Navigation to login happens
  /// when they acknowledge the dialog (or immediately, if no navigator is
  /// available to show one), so they are never silently teleported mid-task.
  Future<void> trigger({String? serverMessage}) async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    // Wipe first: the token is already worthless, and clearing it now stops
    // any later request from re-triggering the whole flow.
    await _prefs.resetSession();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigatorState = _router.navigatorKey.currentState;
      if (navigatorState == null) {
        _goToLogin();
        return;
      }

      AppNotify.dialog(
        type: AppDialogType.warning,
        title: 'core.forceLogout.title'.tr(),
        message: serverMessage ?? 'core.forceLogout.message'.tr(),
        buttonText: 'buttons.login'.tr(),
        buttonWidth: 120,
        onPressed: () => navigatorState.pop(),
      ).whenComplete(_goToLogin);
    });
  }

  // replaceAll resets the stack so no back gesture can return to the
  // authenticated screens of the session that was just revoked.
  void _goToLogin() {
    _suppressUntil = DateTime.now().add(_suppressTail);
    _isLoggingOut = false;
    _router.replaceAll([const LoginRoute()]);
  }
}
