import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../domain/core/audit/audit_log_entry_dto.dart';
import '../../../domain/core/audit/i_audit_log_facade.dart';
import '../../../domain/core/prefs/app_prefs.dart';

@LazySingleton(as: IAuditLogFacade)
class AuditLogRepository implements IAuditLogFacade {
  final SharedPrefs _sharedPrefs;

  AuditLogRepository(this._sharedPrefs);

  static const String _collection = 'api_audit_logs';

  // Firestore's TTL policy on `expire_at` may lag up to ~72h behind expiry;
  // 28 days keeps the guaranteed worst case within the 30-day retention limit.
  static const Duration _retention = Duration(days: 28);

  // Endpoints whose traffic is audited; matched case-insensitively against
  // the URL path. Never add endpoints that carry secrets (MPIN, OTP, tokens).
  static const List<String> _auditedPathFragments = [
    'pay-quick-transaction',
    'calculate-amount',
  ];

  static const int _maxLoggedChars = 20000;

  final Random _random = Random.secure();

  // App version and device model, resolved once and reused for all entries.
  Future<(String, String)>? _buildInfo;

  @override
  bool isAudited(http.BaseRequest request) {
    final path = request.url.path.toLowerCase();
    return _auditedPathFragments.any(path.contains);
  }

  @override
  String newRequestId() {
    final ts = DateTime.now().toUtc().millisecondsSinceEpoch.toRadixString(16);
    final rand = List.generate(
      8,
      (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
    return '$ts-$rand';
  }

  @override
  void logRequest(http.BaseRequest request) {
    if (!isAudited(request)) return;

    String? body;
    String? bodySha256;
    int? bodyLengthBytes;
    if (request is http.Request && request.bodyBytes.isNotEmpty) {
      // bodyBytes is exactly what hits the wire — the hash is tamper-evident
      // proof of the payload the app transmitted.
      final bytes = request.bodyBytes;
      bodyLengthBytes = bytes.length;
      bodySha256 = sha256.convert(bytes).toString();
      body = utf8.decode(bytes, allowMalformed: true);
    }

    _submit(
      request: request,
      event: 'request',
      body: body,
      bodySha256: bodySha256,
      bodyLengthBytes: bodyLengthBytes,
    );
  }

  @override
  void logResponse({
    required http.BaseRequest request,
    required int statusCode,
    required String body,
    required int duration,
  }) {
    if (!isAudited(request)) return;

    _submit(
      request: request,
      event: 'response',
      body: _clip(body),
      statusCode: statusCode,
      durationMs: duration,
    );
  }

  @override
  void logException({
    required http.BaseRequest request,
    required Object exception,
  }) {
    if (!isAudited(request)) return;

    _submit(
      request: request,
      event: 'exception',
      exceptionType: exception.runtimeType.toString(),
      exception: _clip(exception.toString()),
    );
  }

  // Fire-and-forget: the write happens asynchronously and every failure is
  // swallowed — auditing must never take down the payment call it observes.
  void _submit({
    required http.BaseRequest request,
    required String event,
    String? body,
    String? bodySha256,
    int? bodyLengthBytes,
    int? statusCode,
    int? durationMs,
    String? exceptionType,
    String? exception,
  }) {
    _write(
      request: request,
      event: event,
      body: body,
      bodySha256: bodySha256,
      bodyLengthBytes: bodyLengthBytes,
      statusCode: statusCode,
      durationMs: durationMs,
      exceptionType: exceptionType,
      exception: exception,
    ).catchError((_) {});
  }

  Future<void> _write({
    required http.BaseRequest request,
    required String event,
    String? body,
    String? bodySha256,
    int? bodyLengthBytes,
    int? statusCode,
    int? durationMs,
    String? exceptionType,
    String? exception,
  }) async {
    // Until the client's own Firebase config is in place, initializeApp in
    // main.dart fails silently and auditing is a no-op.
    if (Firebase.apps.isEmpty) return;

    final (appVersion, device) = await (_buildInfo ??= _resolveBuildInfo());

    final entry = AuditLogEntryDto(
      event: event,
      memberCode: _sharedPrefs.getMemberCode(),
      mobileNumber: _sharedPrefs.getMobileNumber(),
      requestId: request.headers[IAuditLogFacade.requestIdHeader],
      attempt: int.tryParse(request.headers['x-retry-attempt'] ?? '0') ?? 0,
      method: request.method,
      url: request.url.toString(),
      tsClientUtc: DateTime.now().toUtc().toIso8601String(),
      appVersion: appVersion,
      device: device,
      headers: _sanitizeHeaders(request.headers),
      body: body,
      bodySha256: bodySha256,
      bodyLengthBytes: bodyLengthBytes,
      statusCode: statusCode,
      durationMs: durationMs,
      exceptionType: exceptionType,
      exception: exception,
    );

    // Offline writes are queued by the Firestore SDK and uploaded when
    // connectivity returns — exactly the situations disputes come from.
    await FirebaseFirestore.instance.collection(_collection).add({
      ...entry.toJson(),
      'ts_server': FieldValue.serverTimestamp(),
      'expire_at': Timestamp.fromDate(DateTime.now().toUtc().add(_retention)),
    });
  }

  Map<String, String> _sanitizeHeaders(Map<String, String> headers) {
    final copy = Map<String, String>.from(headers)..remove('x-retry-attempt');
    if (copy.containsKey('Authorization')) {
      copy['Authorization'] = 'Bearer [REDACTED]';
    }
    return copy;
  }

  String _clip(String s) {
    if (s.length <= _maxLoggedChars) return s;
    return '${s.substring(0, _maxLoggedChars)}'
        '... [+${s.length - _maxLoggedChars} chars truncated]';
  }

  Future<(String, String)> _resolveBuildInfo() async {
    var appVersion = 'unknown';
    var device = '${Platform.operatingSystem} '
        '${Platform.operatingSystemVersion}';
    try {
      final info = await PackageInfo.fromPlatform();
      appVersion = '${info.version}+${info.buildNumber}';
    } catch (_) {}
    try {
      final plugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final android = await plugin.androidInfo;
        device =
            '${android.manufacturer} ${android.model} '
            '(Android ${android.version.release}, SDK ${android.version.sdkInt})';
      } else if (Platform.isIOS) {
        final ios = await plugin.iosInfo;
        device = '${ios.utsname.machine} (iOS ${ios.systemVersion})';
      }
    } catch (_) {}
    return (appVersion, device);
  }
}
