import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

import '../native/device_identity_service.dart';

/// Builds a stable device fingerprint that survives app reinstalls.
///
/// The same physical device always yields the same [deviceId], [model] and
/// [fingerprint] — including across uninstall/reinstall — so an admin-side
/// device block stays pinned to the device.
///
/// Identity sources:
///  - Android: `Settings.Secure.ANDROID_ID` (`androidInfo.id`) — constant for
///    the app's signing key + user; survives reinstall, changes only on
///    factory reset. No app-managed storage.
///  - iOS: a Keychain-persisted id (via [DeviceIdentityService]) seeded from
///    `identifierForVendor` the first time it is read. The Keychain outlives
///    the app install, so the id survives uninstall/reinstall — raw IDFV
///    alone rotates once the vendor's last app is removed. The item is
///    ThisDeviceOnly and non-syncing, so it can never migrate to a different
///    physical device; only a device erase clears it. Falls back to raw IDFV
///    if the Keychain is unavailable.
///
/// The Keychain id is written once and afterwards only read back — never
/// regenerated while a value exists — so it cannot drift between the app's
/// login/OTP/MPIN flows.
///
/// The [fingerprint] hashes only the stable identity ([deviceId] + [model]);
/// the OS version is reported separately but deliberately excluded from the
/// hash, so an OS update never rotates the fingerprint.
@lazySingleton
class AppDeviceHelper {
  /// Cached result. The values never change for the lifetime of the install,
  /// so the device info is read once and reused for every subsequent call.
  Map<String, String>? _cache;

  Future<Map<String, String>> getDeviceFingerprint() async {
    final cached = _cache;
    if (cached != null) return cached;

    final deviceInfo = DeviceInfoPlugin();
    String deviceId = '';
    String model = '';
    String osVersion = '';

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      model = '${androidInfo.manufacturer} ${androidInfo.model}';
      osVersion = 'Android ${androidInfo.version.release}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      final vendorId = iosInfo.identifierForVendor ?? '';
      deviceId =
          await DeviceIdentityService.getOrCreateDeviceId(seed: vendorId) ??
          vendorId;
      model = iosInfo.utsname.machine;
      osVersion = '${iosInfo.systemName} ${iosInfo.systemVersion}';
    }

    // Hash the stable identity only (id + model) — never the OS version — so
    // the fingerprint stays constant across OS updates.
    final fingerprint = sha256
        .convert(utf8.encode('$deviceId|$model'))
        .toString();

    return _cache = {
      'deviceId': deviceId,
      'model': model,
      'osVersion': osVersion,
      'fingerprint': fingerprint,
    };
  }

  /// The `device_details` object exactly as the backend expects it on the
  /// wire. Single source of truth for the payload shape — every endpoint that
  /// reports the device (login / OTP / MPIN / forgot-MPIN / registration /
  /// complete-profile) must use this instead of hand-building the map.
  Future<Map<String, dynamic>> getDeviceDetailsPayload() async {
    final details = await getDeviceFingerprint();
    return {
      'device_id': details['deviceId'] ?? '',
      'model': details['model'] ?? '',
      'o_s_version': details['osVersion'] ?? '',
      'finger_print': details['fingerprint'] ?? '',
    };
  }
}