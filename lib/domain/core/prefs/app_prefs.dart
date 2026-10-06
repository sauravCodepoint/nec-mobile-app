import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../otp/otp_dto.dart';
import '../encryption_helper/app_encryption_helper.dart';
import '../session/pending_registration.dart';
import '../session/session_payload.dart';

/// A class for managing shared preferences in the application.
///
/// This class provides methods to store and retrieve various types of data
/// including encrypted token and MPIN using SharedPreferences.
@lazySingleton
class SharedPrefs {
  /// The instance of `SharedPreferences` used for storing data.
  final SharedPreferences _prefs;

  /// The instance of `AppEncryptionHelper` used for encrypting and decrypting sensitive data.
  final AppEncryptionHelper _encryptionHelper;

  /// Creates an instance of `SharedPrefs`.
  ///
  /// - `_prefs`: The `SharedPreferences` instance.
  /// - `_encryptionHelper`: The `AppEncryptionHelper` instance.
  SharedPrefs(this._prefs, this._encryptionHelper);

  // Keys
  /// The key used to store the translation locale.
  static const String translationLocale = 'translation_locale';

  /// The key used to store the onboarding status.
  static const String hasOnboardedKey = 'has_onboarded';

  /// Prefix for one-time guided-tour (showcase) completion flags. The tour id
  /// is appended to form the full key, e.g. `showcase_seen_home`.
  static const String showcaseSeenPrefix = 'showcase_seen_';

  /// The key used to store the login status.
  static const String isLoggedInKey = 'is_logged_in';

  /// The key used to store the set mpin status.
  static const String isMpinSetKey = 'is_mpin_set';

  /// The key used to store the User Name.
  static const String userNameKey = 'user_name';

  /// The key used to store the biometric authentication status.
  static const String isBiometricAuthenticatedKey =
      'is_biometric_authenticated';

  /// The key used to store the encrypted user token.
  static const String tokenKey = 'user_token';

  /// The key used to store the encrypted user refresh token.
  static const String refreshTokenKey = 'user_refresh_token';

  /// The key used to store the member code.
  static const String appMemberCodeKey = 'app_member_code';

  /// The key used to store the member code.
  static const String memberCodeKey = 'member_code';

  /// The key used to store the mobile number.
  static const String mobileNumberKey = 'mobile_number';

  /// The key used to store the mobile code.
  static const String mobileCodeKey = 'mobile_code';

  /// The key used to store the ID number.
  static const String idNumberKey = 'id_number';

  /// The key used to store the mobile number without code.
  static const String mobileNumberWithOutCodeKey = 'mobile_without_code';

  /// The key used to store the full authenticated user as a JSON string.
  /// Lets features that need rich user fields (KYC, profile, home greeting)
  /// read everything on cold start without a re-fetch.
  static const String userJsonKey = 'user_json';

  // Pending OTP resume context — see [setPendingOtp].
  static const String pendingOtpIdTypeKey = 'pending_otp_id_type';
  static const String pendingOtpIdNumberKey = 'pending_otp_id_number';
  static const String pendingOtpMobileKey = 'pending_otp_mobile';
  static const String pendingOtpRequestedAtKey = 'pending_otp_requested_at';

  // Pending registration resume context — see [setPendingRegistration].
  static const String pendingRegStepKey = 'pending_reg_step';
  static const String pendingRegIdTypeKey = 'pending_reg_id_type';
  static const String pendingRegIdNumberKey = 'pending_reg_id_number';
  static const String pendingRegMobileKey = 'pending_reg_mobile';
  static const String pendingRegAppMemberCodeKey = 'pending_reg_app_member';
  static const String pendingRegUserJsonKey = 'pending_reg_user_json';

  // Member-approval resume marker — set once registration is submitted, while
  // the back office reviews the account. Kept independent of the authenticated
  // session (there's no JWT yet); cleared when a session is installed
  // (approved → logged in) or on reset. See [setMemberApprovalPending].
  static const String memberApprovalPendingKey = 'member_approval_pending';

  // The already-verified OTP the approval-status API requires alongside
  // app_member_code. See [setMemberApprovalOtp].
  static const String memberApprovalOtpKey = 'member_approval_otp';

  /// The key used to record that the one-time welcome notification has been
  /// shown, so it never fires again after the first launch.
  static const String welcomeNotificationShownKey =
      'welcome_notification_shown';

  // Marker value for the CompleteProfile variant — the only pending-registration
  // step left now that the in-app KYC and Registration flows are gone.
  static const String _pendingRegStepCompleteProfile = 'complete_profile';

  // Locale
  /// Sets the translation locale in shared preferences.
  ///
  /// - `locale`: The locale to be stored.
  Future<void> setTranslationLocale(String locale) async {
    await _prefs.setString(translationLocale, locale);
  }

  /// Retrieves the translation locale from shared preferences.
  ///
  /// - Returns: The stored locale, or `null` if not set.
  String? getTranslationLocale() => _prefs.getString(translationLocale);

  // Onboarding
  /// Sets the onboarding status in shared preferences.
  ///
  /// - `value`: `true` if the user has onboarded, `false` otherwise.
  /// - Returns: `true` if the write was persisted, `false` otherwise.
  Future<bool> setHasOnboarded(bool value) async {
    return _prefs.setBool(hasOnboardedKey, value);
  }

  /// Retrieves the onboarding status from shared preferences.
  ///
  /// - Returns: `true` if the user has onboarded, `false` otherwise.
  bool getHasOnboarded() => _prefs.getBool(hasOnboardedKey) ?? false;

  // Showcase (guided tours)
  /// Whether the one-time guided tour identified by [tourId] has already been
  /// shown to the user. Used to ensure a coach-mark tour runs only once.
  bool hasSeenShowcase(String tourId) =>
      _prefs.getBool('$showcaseSeenPrefix$tourId') ?? false;

  /// Marks the guided tour identified by [tourId] as seen so it is not shown
  /// again on subsequent visits.
  Future<void> setShowcaseSeen(String tourId) async {
    await _prefs.setBool('$showcaseSeenPrefix$tourId', true);
  }

  /// Clears the seen flag for [tourId] so the tour can be replayed (e.g. from a
  /// "Show app tour again" settings entry).
  Future<void> resetShowcase(String tourId) async {
    await _prefs.remove('$showcaseSeenPrefix$tourId');
  }

  // Login Status
  /// Sets the login status in shared preferences.
  ///
  /// - `value`: `true` if the user is logged in, `false` otherwise.
  Future<void> setIsLoggedIn(bool value) async {
    await _prefs.setBool(isLoggedInKey, value);
  }

  /// Retrieves the login status from shared preferences.
  ///
  /// - Returns: `true` if the user is logged in, `false` otherwise.
  bool getIsLoggedIn() => _prefs.getBool(isLoggedInKey) ?? false;

  // MPIN Status
  /// Sets the MPIN set status in shared preferences.
  ///
  /// - `value`: `true` if the user has set an MPIN, `false` otherwise.
  Future<void> setMpin(bool value) async {
    await _prefs.setBool(isMpinSetKey, value);
  }

  /// Retrieves the MPIN set status from shared preferences.
  ///
  /// - Returns: `true` if the user has set an MPIN, `false` otherwise.
  bool getMpin() => _prefs.getBool(isMpinSetKey) ?? false;

  /// Sets the user name in shared preferences.
  ///
  /// - `userName`: The user name to be stored.
  Future<void> setUserName(String userName) async {
    await _prefs.setString(userNameKey, userName);
  }

  /// Retrieves the user name from shared preferences.
  ///
  /// - Returns: The stored user name, or `null` if not set.
  String? getUserName() => _prefs.getString(userNameKey);

  /// Sets the biometric authentication status in shared preferences.
  ///
  /// - `value`: `true` if the user is authenticated with biometrics, `false` otherwise.
  Future<void> setIsBiometricAuthenticated(bool value) async {
    await _prefs.setBool(isBiometricAuthenticatedKey, value);
  }

  /// Retrieves the biometric authentication status from shared preferences.
  ///
  /// - Returns: `true` if the user is authenticated with biometrics, `false` otherwise.
  bool getIsBiometricAuthenticated() =>
      _prefs.getBool(isBiometricAuthenticatedKey) ?? false;

  // 🔐 Secure Token Storage
  /// Sets the encrypted user token in shared preferences.
  ///
  /// - `token`: The user token to be encrypted and stored.
  Future<void> setToken(String token) async {
    final encrypted = _encryptionHelper.encrypt(token);
    await _prefs.setString(tokenKey, encrypted);
  }

  /// Retrieves the decrypted user token from shared preferences.
  ///
  /// - Returns: The decrypted user token, or `null` if not set.
  String? getToken() {
    final encrypted = _prefs.getString(tokenKey);
    if (encrypted == null) return null;
    return _encryptionHelper.decrypt(encrypted);
  }

  /// Deletes the user token from shared preferences.
  ///
  /// // - Returns: `true` if the token was successfully deleted, `false` otherwise.
  Future<bool> deleteToken() async {
    return await _prefs.remove(tokenKey);
  }

  /// Sets the encrypted user refresh token in shared preferences.
  ///
  /// - `refreshToken`: The user refresh token to be encrypted and stored.
  Future<void> setRefreshToken(String refreshToken) async {
    final encrypted = _encryptionHelper.encrypt(refreshToken);
    await _prefs.setString(refreshTokenKey, encrypted);
  }

  /// Retrieves the decrypted user refresh token from shared preferences.
  ///
  /// - Returns: The decrypted user refresh token, or `null` if not set.
  String? getRefreshToken() {
    final encrypted = _prefs.getString(refreshTokenKey);
    if (encrypted == null) return null;
    return _encryptionHelper.decrypt(encrypted);
  }

  // Member Code
  /// Sets the member code in shared preferences.
  ///
  /// - `memberCode`: The member code to be stored.
  Future<void> setAppMemberCode(int memberCode) async {
    await _prefs.setInt(appMemberCodeKey, memberCode);
  }

  /// Retrieves the member code from shared preferences.
  ///
  /// - Returns: The stored member code, or `0` if not set.
  int getAppMemberCode() => _prefs.getInt(appMemberCodeKey) ?? 0;

  /// Sets the member code in shared preferences.
  ///
  /// - `memberCode`: The member code to be stored.
  Future<void> setMemberCode(int memberCode) async {
    await _prefs.setInt(memberCodeKey, memberCode);
  }

  /// Retrieves the member code from shared preferences.
  ///
  /// - Returns: The stored member code, or `0` if not set.
  int getMemberCode() => _prefs.getInt(memberCodeKey) ?? 0;

  /// Whether the one-time welcome notification has already been shown.
  bool getWelcomeNotificationShown() =>
      _prefs.getBool(welcomeNotificationShownKey) ?? false;

  /// Marks the one-time welcome notification as shown.
  Future<void> setWelcomeNotificationShown() async {
    await _prefs.setBool(welcomeNotificationShownKey, true);
  }

  /// Sets the mobile number in shared preferences.
  ///
  /// - `mobileNumber`: The mobile number to be stored.
  Future<void> setMobileNumber(String mobileNumber) async {
    await _prefs.setString(mobileNumberKey, mobileNumber);
  }

  /// Retrieves the mobile number from shared preferences.
  ///
  /// - Returns: The stored mobile number, or `null` if not set.
  String? getMobileNumber() => _prefs.getString(mobileNumberKey);

  /// Sets the mobile code in shared preferences.
  ///
  /// - `mobileCode`: The mobile code to be stored.
  Future<void> setMobileCode(int mobileCode) async {
    await _prefs.setInt(mobileCodeKey, mobileCode);
  }

  /// Retrieves the mobile code from shared preferences.
  ///
  /// - Returns: The stored mobile code, or `0` if not set.
  int getMobileCode() => _prefs.getInt(mobileCodeKey) ?? 0;

  /// Sets the ID number in shared preferences.
  ///
  /// - `idNumber`: The ID number to be stored.
  Future<void> setIdNumber(String idNumber) async {
    await _prefs.setString(idNumberKey, idNumber);
  }

  /// Retrieves the ID number from shared preferences.
  ///
  /// - Returns: The stored ID number, or `null` if not set.
  String? getIdNumber() => _prefs.getString(idNumberKey);

  /// Sets the mobile number without code in shared preferences.
  ///
  /// - `mobileNumber`: The mobile number to be stored.
  Future<void> setMobileNumberWithOutCode(String mobileNumber) async {
    await _prefs.setString(mobileNumberWithOutCodeKey, mobileNumber);
  }

  /// Retrieves the mobile number without code from shared preferences.
  ///
  /// - Returns: The stored mobile number without code, or `null` if not set.
  String? getMobileNumberWithOutCode() =>
      _prefs.getString(mobileNumberWithOutCodeKey);

  // Session
  /// Installs an authenticated session in a single batch — token,
  /// identifiers, scalar user fields, the full user JSON, MPIN flag and the
  /// logged-in marker. Centralised so callers can't write inconsistent
  /// subsets, which used to leave the splash bloc to self-heal mismatches.
  Future<void> installSession(SessionPayload payload) async {
    await setToken(payload.token);
    await setRefreshToken(payload.refreshToken);
    await setAppMemberCode(payload.appMemberCode);
    await setMemberCode(payload.memberCode);
    await setUserName(payload.userName);
    await setMobileNumber(payload.mobileNumber);
    await setMobileNumberWithOutCode(payload.mobileNumberWithOutCode);
    await setIdNumber(payload.idNumber);
    await setUser(payload.user);
    await setMpin(payload.isMpinCreated);
    await setIsLoggedIn(true);
    // The member is now authenticated (i.e. approved and signed in), so any
    // lingering awaiting-approval marker is stale — drop it.
    await clearMemberApprovalPending();
  }

  /// Stores the full authenticated [User] as JSON.
  Future<void> setUser(User user) async {
    await _prefs.setString(userJsonKey, jsonEncode(user.toJson()));
  }

  /// Returns the cached [User], or `null` if no session has been installed
  /// or the stored payload is corrupt / from an incompatible schema.
  User? getUser() {
    final raw = _prefs.getString(userJsonKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      return User.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  // Pending OTP
  /// Persists the in-flight OTP request so that, if the user kills the app,
  /// reopening within the TTL can resume the OTP screen instead of forcing
  /// a fresh request (which would cost another SMS).
  ///
  /// The OTP code itself is never stored while it is still live — only enough
  /// context to rehydrate the OtpBloc and a timestamp to enforce the TTL. (An
  /// already-consumed OTP is a different matter — see [setMemberApprovalOtp].)
  Future<void> setPendingOtp({
    required String idType,
    required String idNumber,
    required String mobile,
    required DateTime requestedAt,
  }) async {
    await _prefs.setString(pendingOtpIdTypeKey, idType);
    await _prefs.setString(pendingOtpIdNumberKey, idNumber);
    await _prefs.setString(pendingOtpMobileKey, mobile);
    await _prefs.setString(
      pendingOtpRequestedAtKey,
      requestedAt.toIso8601String(),
    );
  }

  String? getPendingOtpIdType() => _prefs.getString(pendingOtpIdTypeKey);

  String? getPendingOtpIdNumber() => _prefs.getString(pendingOtpIdNumberKey);

  String? getPendingOtpMobile() => _prefs.getString(pendingOtpMobileKey);

  DateTime? getPendingOtpRequestedAt() {
    final raw = _prefs.getString(pendingOtpRequestedAtKey);
    if (raw == null) return null;
    return DateTime.tryParse(raw);
  }

  Future<void> clearPendingOtp() async {
    await _prefs.remove(pendingOtpIdTypeKey);
    await _prefs.remove(pendingOtpIdNumberKey);
    await _prefs.remove(pendingOtpMobileKey);
    await _prefs.remove(pendingOtpRequestedAtKey);
  }

  // Pending registration
  /// Persists where the user is in a registration flow they reached via
  /// OTP but have not yet completed. Read by splash so a cold-start lands
  /// the user back on CompleteProfile instead of forcing a new OTP.
  ///
  /// No TTL — these endpoints don't require a backend session, so the
  /// marker stays valid until the user finishes, explicitly backs out, or
  /// runs through OTP again with different details (which overwrites it).
  Future<void> setPendingRegistration(PendingRegistration registration) async {
    await registration.when(
      completeProfile: (idType, idNumber, mobile, appMemberCode, user) async {
        await _prefs.setString(
          pendingRegStepKey,
          _pendingRegStepCompleteProfile,
        );
        await _prefs.setString(pendingRegIdTypeKey, idType);
        await _prefs.setString(pendingRegIdNumberKey, idNumber);
        await _prefs.setString(pendingRegMobileKey, mobile);
        await _prefs.setInt(pendingRegAppMemberCodeKey, appMemberCode);
        await _prefs.setString(
          pendingRegUserJsonKey,
          jsonEncode(user.toJson()),
        );
      },
    );
  }

  /// Returns the persisted registration resume marker if one exists and is
  /// well-formed, otherwise `null`. Partial or corrupt records are purged.
  PendingRegistration? getPendingRegistration() {
    final step = _prefs.getString(pendingRegStepKey);
    final idType = _prefs.getString(pendingRegIdTypeKey);
    final idNumber = _prefs.getString(pendingRegIdNumberKey);
    final mobile = _prefs.getString(pendingRegMobileKey);

    final hasCore =
        step != null &&
            step.isNotEmpty &&
            idType != null &&
            idType.isNotEmpty &&
            idNumber != null &&
            idNumber.isNotEmpty &&
            mobile != null &&
            mobile.isNotEmpty;

    if (!hasCore) {
      // Best-effort cleanup; splash callers don't await this.
      unawaited(clearPendingRegistration());
      return null;
    }

    switch (step) {
      case _pendingRegStepCompleteProfile:
        final appMemberCode = _prefs.getInt(pendingRegAppMemberCodeKey);
        final userJson = _prefs.getString(pendingRegUserJsonKey);
        if (appMemberCode == null || userJson == null || userJson.isEmpty) {
          unawaited(clearPendingRegistration());
          return null;
        }
        try {
          final user = User.fromJson(
            jsonDecode(userJson) as Map<String, dynamic>,
          );
          return PendingRegistration.completeProfile(
            idType: idType,
            idNumber: idNumber,
            mobile: mobile,
            appMemberCode: appMemberCode,
            user: user,
          );
        } catch (_) {
          unawaited(clearPendingRegistration());
          return null;
        }
      default:
        unawaited(clearPendingRegistration());
        return null;
    }
  }

  Future<void> clearPendingRegistration() async {
    await _prefs.remove(pendingRegStepKey);
    await _prefs.remove(pendingRegIdTypeKey);
    await _prefs.remove(pendingRegIdNumberKey);
    await _prefs.remove(pendingRegMobileKey);
    await _prefs.remove(pendingRegAppMemberCodeKey);
    await _prefs.remove(pendingRegUserJsonKey);
  }

  // Member-approval resume marker
  /// Records that the user submitted registration and is awaiting back-office
  /// approval. Persisted so a cold-start returns them to the awaiting-approval
  /// screen instead of the login screen until they're approved and sign in.
  Future<void> setMemberApprovalPending(bool value) async {
    await _prefs.setBool(memberApprovalPendingKey, value);
  }

  /// Whether the user is awaiting member approval. `false` when unset.
  bool getMemberApprovalPending() =>
      _prefs.getBool(memberApprovalPendingKey) ?? false;

  Future<void> clearMemberApprovalPending() async {
    await _prefs.remove(memberApprovalPendingKey);
    await _prefs.remove(memberApprovalOtpKey);
  }

  /// Persists the OTP the backend just verified for a not-yet-approved member,
  /// because the member-approval status API
  /// requires it again — alongside [getAppMemberCode] — and after a cold start
  /// the in-memory copy in OtpBloc is gone.
  ///
  /// This is the sole exception to the "never store the OTP" rule (see
  /// [setPendingOtp]): by this point the code has already been consumed by
  /// verify-OTP, so it no longer grants login — it only proves this device made
  /// the original request. Overwritten on every re-verify; removed together
  /// with the approval marker in [clearMemberApprovalPending].
  Future<void> setMemberApprovalOtp(String otp) async {
    await _prefs.setString(memberApprovalOtpKey, otp);
  }

  /// The verified OTP for approval-status polling, or `null` if none was
  /// stored (callers must degrade to the static awaiting screen, not error).
  String? getMemberApprovalOtp() => _prefs.getString(memberApprovalOtpKey);

  // Session reset
  /// Wipes all authenticated-session, identity and registration-resume state
  /// so a different user can sign in cleanly on the same device. The
  /// counterpart to [installSession].
  ///
  /// Deliberately preserves device-level preferences that are not tied to the
  /// signed-in user — theme, locale and the onboarding-completed flag — so
  /// switching accounts never re-shows onboarding or resets the language.
  Future<void> resetSession() async {
    await deleteToken();
    await _prefs.remove(refreshTokenKey);
    await _prefs.remove(appMemberCodeKey);
    await _prefs.remove(memberCodeKey);
    await _prefs.remove(mobileNumberKey);
    await _prefs.remove(mobileCodeKey);
    await _prefs.remove(idNumberKey);
    await _prefs.remove(mobileNumberWithOutCodeKey);
    await _prefs.remove(userNameKey);
    await _prefs.remove(userJsonKey);
    await _prefs.remove(isMpinSetKey);
    await _prefs.remove(isBiometricAuthenticatedKey);
    await setIsLoggedIn(false);
    await clearPendingOtp();
    await clearPendingRegistration();
    await clearMemberApprovalPending();
  }

  // Clear all
  /// Clears all data from shared preferences.
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
