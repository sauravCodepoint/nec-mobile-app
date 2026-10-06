import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../presentation/routes/app_routes.dart';
import '../di/injection.dart';

/// Production-grade runtime permission handler.
///
/// Flow on denial:
///   1. The OS prompt is shown (it carries the localized usage description
///      from `Info.plist` / `AndroidManifest.xml`).
///   2. If the user denies, a localized in-app dialog is shown with an
///      "Open Settings" action so the user always has a recovery path.
///   3. `restricted` (parental controls / MDM) is handled separately because
///      the user cannot resolve it themselves — they see an explanatory
///      dialog instead of a useless Settings shortcut.
///
/// Callers should pair this with a lifecycle observer so the camera/mic can
/// recover automatically when the user returns from Settings.
@lazySingleton
class AppPermissionHandler {
  final AppRouter _router = getIt<AppRouter>();

  /// Requests a single [permission]. Returns true once granted (or `limited`
  /// on iOS photo library), false otherwise. The user is never left with a
  /// dead end: a Settings dialog is always shown on denial.
  Future<bool> requestPermission(
    Permission permission, {
    required String title,
    required String message,
    String? restrictedMessage,
  }) async {
    var status = await permission.status;
    _log(permission, 'pre-request', status);
    if (_isUsable(status)) return true;

    if (status.isRestricted) {
      await _showRestrictedDialog(title, restrictedMessage ?? message);
      return false;
    }

    // On iOS this opens the system sheet only once per app install — once
    // the user has answered (even on a previous install with the same bundle
    // ID), iOS will never show the prompt again and `request()` returns the
    // existing status immediately. On Android it re-prompts until the user
    // picks "Don't ask again".
    status = await permission.request();
    _log(permission, 'post-request', status);
    if (_isUsable(status)) return true;

    if (status.isRestricted) {
      await _showRestrictedDialog(title, restrictedMessage ?? message);
      return false;
    }

    await _showSettingsDialog(title, message);
    return false;
  }

  static void _log(Permission p, String stage, PermissionStatus s) {
    if (!kDebugMode) return;
    debugPrint('[AppPermissionHandler] $p $stage → $s');
  }

  /// Requests several [permissions] in a single OS prompt. Used by flows
  /// that need camera + microphone together (video KYC) so the user sees
  /// one sheet instead of two.
  Future<bool> requestPermissions(
    List<Permission> permissions, {
    required String title,
    required String message,
    String? restrictedMessage,
  }) async {
    var allUsable = true;
    var anyRestricted = false;
    for (final p in permissions) {
      final s = await p.status;
      if (!_isUsable(s)) allUsable = false;
      if (s.isRestricted) anyRestricted = true;
    }
    if (allUsable) return true;
    if (anyRestricted) {
      await _showRestrictedDialog(title, restrictedMessage ?? message);
      return false;
    }

    final statuses = await permissions.request();
    final granted = statuses.values.every(_isUsable);
    if (granted) return true;

    if (statuses.values.any((s) => s.isRestricted)) {
      await _showRestrictedDialog(title, restrictedMessage ?? message);
      return false;
    }

    await _showSettingsDialog(title, message);
    return false;
  }

  /// `granted` and `limited` (iOS photo library partial access) both mean
  /// "the app can proceed", so they're folded into a single predicate.
  static bool _isUsable(PermissionStatus status) =>
      status.isGranted || status.isLimited;

  Future<void> _showSettingsDialog(String title, String message) async {
    final context = _router.navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    if (Platform.isIOS) {
      await showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
          title: Text(title),
          content: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(message),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: _router.pop,
              child: Text(
                'buttons.cancel'.tr(),
                style: const TextStyle(color: CupertinoColors.systemGrey),
              ),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                _router.pop();
                await openAppSettings();
              },
              child: Text(
                'buttons.openSettings'.tr(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Text(message, style: const TextStyle(fontSize: 14)),
          actions: [
            TextButton(
              onPressed: _router.pop,
              child: Text(
                'buttons.cancel'.tr(),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                _router.pop();
                await openAppSettings();
              },
              child: Text(
                'buttons.openSettings'.tr(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _showRestrictedDialog(String title, String message) async {
    final context = _router.navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    if (Platform.isIOS) {
      await showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
          title: Text(title),
          content: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(message),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: _router.pop,
              child: Text(
                'buttons.ok'.tr(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Text(message, style: const TextStyle(fontSize: 14)),
          actions: [
            TextButton(
              onPressed: _router.pop,
              child: Text(
                'buttons.ok'.tr(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}