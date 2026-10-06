import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../presentation/routes/app_routes.dart';
import '../../../presentation/routes/app_routes.gr.dart';
import '../../notification/i_notification_facade.dart';
import '../di/injection.dart';
import '../prefs/app_prefs.dart';

/// Background FCM messages are delivered on a separate isolate. This handler
/// must stay top-level and keep the vm:entry-point annotation or release
/// builds crash when a background message arrives (tree shaking removes it).
@pragma('vm:entry-point')
Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  // Notification-bearing messages are shown by the OS in background and
  // terminated state — never show them again here. Data-only payloads could
  // be processed here if the backend ever sends them.
}

/// Taps on local-notification actions can be delivered on a background
/// isolate, which has no navigator — so this handler stays top-level,
/// annotated, and intentionally does nothing.
@pragma('vm:entry-point')
void _backgroundNotificationTap(NotificationResponse response) {}

/// Manages push notifications using Firebase Messaging and
/// Flutter Local Notifications.
///
/// Safe by construction: [init] is a no-op until the client's Firebase config
/// is present (config files are git-ignored per client), every step is
/// guarded so notification failures can never block app startup, and
/// notification taps never deep-link past the auth flow.
class AppPushNotification {
  AppPushNotification._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Mirrored by com.google.firebase.messaging.default_notification_channel_id
  // in AndroidManifest.xml so background FCM notifications land on the same
  // high-importance channel as foreground ones.
  static const String _channelId = 'high_importance_channel';
  static const String _channelName = 'Transaction & Account Alerts';
  static const String _channelDescription =
      'Transaction updates and account alerts';

  static bool _initialized = false;
  static int _notificationId = 0;

  /// Initializes push notifications. Called once from `main.dart`; safe to
  /// call again (subsequent calls are no-ops).
  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    try {
      // Local notifications are independent of Firebase — app-generated
      // alerts (e.g. the welcome message) work without any cloud config.
      // Permission is deliberately NOT requested here: the OS prompt is a
      // scarce resource (once per install on iOS), so it is spent only via
      // NotificationPermissionPrimer after login, with context.
      await _initLocalNotifications();

      // Remote (FCM) push stays a no-op until the client's Firebase config
      // is present.
      if (Firebase.apps.isNotEmpty) {
        await _configureFirebaseMessaging();
      }
    } catch (e) {
      debugPrint('Push notification init failed: $e');
    }
  }

  /// Shows the one-time localized welcome notification, personalised with the
  /// stored user name. Fires only on the first launch it is reached — a
  /// persistent flag suppresses it on every subsequent login. Purely local;
  /// works without Firebase.
  static Future<void> showWelcomeNotification() async {
    try {
      final prefs = getIt<SharedPrefs>();
      if (prefs.getWelcomeNotificationShown()) return;

      // Without permission the OS suppresses the banner while show() still
      // "succeeds" — bail out so the one-time flag isn't burned unseen.
      if (!(await Permission.notification.status).isGranted) return;

      final fullName = prefs.getUserName()?.trim() ?? '';
      final firstName = fullName.split(' ').first;
      final title = firstName.isEmpty
          ? 'notifications.welcome.title'.tr()
          : 'notifications.welcome.titleWithName'.tr(
              namedArgs: {'name': firstName},
            );
      await showSimpleNotification(
        title: title,
        body: 'notifications.welcome.body'.tr(),
        payload: jsonEncode({'type': 'welcome'}),
      );
      // Marked only after a successful show, so a failure retries next launch
      // instead of silently consuming the one-time welcome.
      await prefs.setWelcomeNotificationShown();
    } catch (e) {
      debugPrint('Failed to show welcome notification: $e');
    }
  }

  /// Returns the FCM device token, or null when Firebase is not configured.
  /// [syncDeviceToken] registers this value with the backend.
  static Future<String?> getToken() async {
    if (Firebase.apps.isEmpty) return null;
    try {
      final token = await _messaging.getToken();
      if (kDebugMode) debugPrint('FCM token: $token');
      return token;
    } catch (_) {
      return null;
    }
  }

  // Last successfully registered "member|token" pair for this process. Set
  // only on success so a failed attempt retries on the next trigger, and a
  // cold start always re-sends once — self-healing without a persistent flag.
  static String? _lastSyncedTokenKey;

  // Collapses overlapping triggers (login mount, resume, rotation, language
  // change) into one request at a time.
  static bool _syncInFlight = false;

  /// The live app language code — authoritative over the SharedPrefs copy,
  /// which is written only at cold start and goes stale after an in-app
  /// language switch.
  static String get currentLanguageCode =>
      getIt<AppRouter>().navigatorKey.currentContext?.locale.languageCode ??
      'en';

  /// Registers the current FCM token with the backend so it can push to this
  /// device. Fire-and-forget: never throws, and a no-op while logged out,
  /// locked, or when Firebase is not configured. Triggered from MainPage
  /// (login and app resume), token rotation, and language changes. (A user
  /// awaiting member approval is covered separately: the registration submit
  /// payload carries this device's token.)
  static Future<void> syncDeviceToken() async {
    if (_syncInFlight) return;
    _syncInFlight = true;
    try {
      final prefs = getIt<SharedPrefs>();
      if (!prefs.getIsLoggedIn()) return;
      final appMemberCode = prefs.getAppMemberCode();
      if (appMemberCode == 0) return;

      // Never call out from behind the MPIN lock: an expired session would
      // ride the 401 → refresh → logout flow and race the user's unlock.
      // A rotation before unlock is registered by the MainPage sync instead.
      final onMain = getIt<AppRouter>().stack.any(
        (page) => page.routeData.name == MainRoute.name,
      );
      if (!onMain) return;

      final token = await getToken();
      if (token == null || token.isEmpty) return;

      final languageCode = currentLanguageCode;

      final key = '$appMemberCode|$token|$languageCode';
      if (_lastSyncedTokenKey == key) return;

      final result = await getIt<INotificationFacade>().registerDeviceToken(
        deviceToken: token,
        languageCode: languageCode,
      );
      result.fold(
        (failure) => debugPrint('Device token registration failed: $failure'),
        (_) => _lastSyncedTokenKey = key,
      );
    } catch (e) {
      debugPrint('Device token sync failed: $e');
    } finally {
      _syncInFlight = false;
    }
  }

  /// Displays a local notification. Used for foreground FCM messages and
  /// available to app code for locally-generated alerts.
  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        // Expands long transaction messages instead of truncating them.
        styleInformation: BigTextStyleInformation(body),
      ),
      iOS: const DarwinNotificationDetails(
        presentSound: true,
        presentAlert: true,
        presentBadge: true,
        presentBanner: true,
        presentList: true,
      ),
    );

    await _localNotifications.show(
      // Unique id per notification — a fixed id makes each new notification
      // silently replace the previous one in the tray.
      id: _nextNotificationId(),
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: payload,
    );
  }

  // ─── Setup ────────────────────────────────────────────────────────────────

  // NOTE: `_messaging` must never be touched while Firebase.apps is empty —
  // FirebaseMessaging.instance throws without an initialized app. Everything
  // FCM lives behind _configureFirebaseMessaging.

  static Future<void> _configureFirebaseMessaging() async {
    // Permission is requested by NotificationPermissionPrimer, not here.

    // Foreground FCM notifications are presented manually via the local
    // notifications plugin; keep the OS from presenting them a second time.
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    _wireMessageHandlers();
    if (kDebugMode) await getToken();
  }

  static Future<void> _initLocalNotifications() async {
    // The channel is created up front with max importance so heads-up
    // display works from the very first notification.
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            _channelName,
            description: _channelDescription,
            importance: Importance.max,
          ),
        );

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      // Permissions were already requested through Firebase Messaging above —
      // don't trigger a second system prompt here.
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _backgroundNotificationTap,
    );
  }

  static void _wireMessageHandlers() {
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

    // Foreground: the OS shows nothing, so present a local notification.
    FirebaseMessaging.onMessage.listen(_showForegroundNotification);

    // App in background, user tapped the system-tray notification.
    FirebaseMessaging.onMessageOpenedApp.listen((_) => _openNotifications());

    // Token rotation: re-register the fresh token with the backend. No-op
    // while logged out or locked — the post-login sync covers those cases.
    _messaging.onTokenRefresh.listen((_) => syncDeviceToken());

    // Cold-start taps (terminated app) are deliberately NOT deep-linked: the
    // app must walk through splash → security gate → MPIN first. The message
    // is retrievable via getInitialMessage() if a post-login pending-intent
    // flow is ever added.
  }

  // ─── Handlers ─────────────────────────────────────────────────────────────

  static Future<void> _showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;
    try {
      await showSimpleNotification(
        title: notification.title ?? 'NEC Exchange',
        body: notification.body ?? '',
        payload: jsonEncode(message.data),
      );
    } catch (e) {
      debugPrint('Failed to present foreground notification: $e');
    }
  }

  static void _onLocalNotificationTap(NotificationResponse response) {
    _openNotifications();
  }

  static void _openNotifications() {
    try {
      final router = getIt<AppRouter>();
      // Never deep-link past the auth flow: navigate only when the user has
      // an authenticated session on screen (MainRoute — pushed after MPIN
      // success — is in the stack). Otherwise a tap from the MPIN screen
      // would expose the notification list without authentication.
      final isLoggedInArea = router.stack.any(
        (page) => page.routeData.name == MainRoute.name,
      );
      if (!isLoggedInArea) return;
      if (router.current.name == NotificationRoute.name) return;
      router.push(const NotificationRoute());
    } catch (e) {
      debugPrint('Notification tap navigation failed: $e');
    }
  }

  static int _nextNotificationId() {
    _notificationId = (_notificationId + 1) & 0x7fffffff;
    return _notificationId;
  }
}
