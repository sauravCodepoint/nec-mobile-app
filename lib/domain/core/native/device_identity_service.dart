import 'package:flutter/services.dart';

/// Bridge to the iOS Keychain-persisted device identity
/// (`DeviceIdentityChannel.swift` in the Runner project).
///
/// The Keychain is the only app-accessible store on iOS that survives
/// uninstall/reinstall, which keeps the device fingerprint — and any
/// admin-side device block keyed on it — pinned to the physical device.
///
/// Static, swallows platform errors and returns null so a missing native
/// implementation (Android, tests) never crashes Dart. Sole consumer:
/// `AppDeviceHelper`.
class DeviceIdentityService {
  static const _channel = MethodChannel('general.device_identity');

  /// Returns the Keychain-persisted device id, storing [seed] first if no
  /// value exists yet. Returns null on any error or when nothing could be
  /// stored (empty seed), letting the caller fall back to a
  /// per-install-chain id such as `identifierForVendor`.
  static Future<String?> getOrCreateDeviceId({required String seed}) async {
    try {
      final id = await _channel.invokeMethod<String>('getOrCreateDeviceId', {
        'seed': seed,
      });
      return (id == null || id.isEmpty) ? null : id;
    } catch (_) {
      return null;
    }
  }
}
