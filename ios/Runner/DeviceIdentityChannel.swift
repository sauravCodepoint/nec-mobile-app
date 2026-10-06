import Flutter
import Foundation
import Security

/// Persists the app's device identity in the iOS Keychain so it survives
/// app uninstall/reinstall — unlike `identifierForVendor`, which the OS
/// rotates once the vendor's last app is removed.
class DeviceIdentityChannel {
    /// Fixed service/account so the exact same Keychain item is found again
    /// after a reinstall (items are already namespaced to this app's
    /// keychain access group by the OS).
    private static let service = "com.nec.remittance.device_identity"
    private static let account = "device_id"

    static func setup(binaryMessenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(
            name: "general.device_identity",
            binaryMessenger: binaryMessenger
        )
        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "getOrCreateDeviceId":
                let args = call.arguments as? [String: Any]
                let seed = args?["seed"] as? String ?? ""
                result(Self.getOrCreateDeviceId(seed: seed))
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    /// Returns the stored id if one exists; otherwise stores [seed] and
    /// returns it. An empty seed is never stored. Returns nil on Keychain
    /// failure so Dart can fall back to `identifierForVendor`.
    private static func getOrCreateDeviceId(seed: String) -> String? {
        if let existing = read() { return existing }
        guard !seed.isEmpty else { return nil }

        // AfterFirstUnlockThisDeviceOnly: outlives the app install, but is
        // excluded from device backups so the id can never migrate to a
        // different physical device. Not synchronizable (no iCloud Keychain).
        let add: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
            kSecValueData as String: Data(seed.utf8),
        ]
        let status = SecItemAdd(add as CFDictionary, nil)
        if status == errSecSuccess { return seed }
        // Lost a race with a concurrent add — the stored value wins.
        if status == errSecDuplicateItem { return read() }
        return nil
    }

    private static func read() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]
        var item: CFTypeRef?
        guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess,
              let data = item as? Data,
              let value = String(data: data, encoding: .utf8),
              !value.isEmpty
        else { return nil }
        return value
    }
}