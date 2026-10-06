import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:easy_localization/easy_localization.dart';
import '../../../presentation/core/notify/app_notify.dart';
import '../../../presentation/routes/app_routes.dart';
import '../../../presentation/routes/app_routes.gr.dart';
import '../audit/i_audit_log_facade.dart';
import '../config/app_config.dart';
import '../di/injection.dart';
import '../prefs/app_prefs.dart';
import '../session/force_logout_handler.dart';

part 'api_services.chopper.dart';

// Sentinel header that marks requests which should bypass automatic token
// injection and the 401 → refresh/logout flow. Chopper sets it via
// @Headers; AuthHttpClient strips it before the request hits the wire.
const String _kSkipAuth = 'x-skip-auth';

// Sentinel header for fire-and-forget background calls (e.g. the app-version
// check): infrastructure failures are rethrown to the caller instead of
// surfacing the shared retry dialog. Stripped before the request hits the wire.
const String _kSilent = 'x-silent';

@ChopperApi(baseUrl: '/api')
abstract class ApiServices extends ChopperService {
  @GET(path: '/auth/get-kyc-combo-list', headers: {'x-skip-auth': 'true'})
  Future<Response> getKycComboList();

  @GET(path: '/auth/get-contact-us-details', headers: {'x-skip-auth': 'true'})
  Future<Response> getContactUs({
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @POST(path: '/auth/request-otp', headers: {'x-skip-auth': 'true'})
  Future<Response> postRequestOtp(@Body() Map<String, dynamic> body);

  @POST(path: '/auth/verify-login-otp', headers: {'x-skip-auth': 'true'})
  Future<Response> postVerifyOtp(@Body() Map<String, dynamic> body);

  @POST(path: '/auth/kyc-renewal', headers: {'x-skip-auth': 'true'})
  Future<Response> postUpdateKyc({@Body() required Map<String, dynamic> body});

  @GET(
    path: '/Customer/get-all-member-field-settings-with-combo',
    headers: {'x-skip-auth': 'true'},
  )
  Future<Response> getMemberFieldSettings({
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/Customer/get-all-member-field-settings-with-userdetail')
  Future<Response> getMemberFieldSettingsWithData({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/Customer/get-state-combo-list', headers: {'x-skip-auth': 'true'})
  Future<Response> getStateCombo({
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/Customer/get-city-combo-list', headers: {'x-skip-auth': 'true'})
  Future<Response> getCityCombo({
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @POST(path: '/auth/core-register-user', headers: {'x-skip-auth': 'true'})
  Future<Response> postCompleteProfile(@Body() Map<String, dynamic> body);

  @POST(path: '/auth/verify-mpin', headers: {'x-skip-auth': 'true'})
  Future<Response> postVerifyMpin(@Body() Map<String, dynamic> body);

  @POST(path: '/auth/update-mpin')
  Future<Response> postSetMpin({
    @Header('Authorization') required String? token,
    @Body() required Map<String, dynamic> body,
  });

  @POST(path: '/auth/Verify_Biometric', headers: {'x-skip-auth': 'true'})
  Future<Response> postVerifyBiometric(@Body() Map<String, dynamic> body);

  @POST(
    path: '/auth/app-version-check',
    headers: {'x-skip-auth': 'true', 'x-silent': 'true'},
  )
  Future<Response> postAppVersionCheck(@Body() Map<String, dynamic> body);

  @POST(
    path: '/auth/registration-status',
    headers: {'x-skip-auth': 'true', 'x-silent': 'true'},
  )
  Future<Response> postMemberApprovalStatus(@Body() Map<String, dynamic> body);

  @POST(path: '/auth/request-email-otp')
  Future<Response> postRequestEmailOtp({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @POST(path: '/auth/email-updation')
  Future<Response> postVerifyEmailOtp({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/auth/GetBanners', headers: {'x-skip-auth': 'true'})
  Future<Response> getAdvertisement();

  @GET(path: '/customer/get-user')
  Future<Response> getUserInfo({
    @Header('Authorization') required String? token,
  });

  @GET(path: '/beneficiary/get-recent-beneficiary-list')
  Future<Response> getRecentBeneficiaries({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(
    path: '/customer/get-country-combo-list',
    headers: {'x-skip-auth': 'true'},
  )
  Future<Response> getCountries();

  @GET(path: '/customer/get-currency-list', headers: {'x-skip-auth': 'true'})
  Future<Response> getCurrencies({
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @POST(path: '/transaction/pay-quick-transaction')
  Future<Response> postTransaction({
    @Header('Authorization') required String? token,
    @Body() required Map<String, dynamic> body,
  });

  @PUT(path: '/transaction/confirm-transaction-changes')
  Future<Response> updateRoundOff({
    @Header('Authorization') required String? token,
    @Body() required Map<String, dynamic> body,
  });

  @GET(
    path: '/customer/get-transfer-mode-list',
    headers: {'x-skip-auth': 'true'},
  )
  Future<Response> getTransferTypes({
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/customer/get-product-list')
  Future<Response> getBankOrAgents({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/beneficiary/get-beneficiary-agent-Product-combo-list')
  Future<Response> getAgents({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(
    path: '/transaction/get-payment-mode-list',
    headers: {'x-skip-auth': 'true'},
  )
  Future<Response> getPaymentModes();

  @GET(path: '/transaction/calculate-amount', headers: {'x-skip-auth': 'true'})
  Future<Response> getCalculatedAmount(
    @QueryMap() Map<String, dynamic> queryParams,
  );

  @GET(path: '/beneficiary/get-beneficiary-list')
  Future<Response> getBeneficiaries({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(
    path: '/beneficiary/get-all-product-field-settings-with-beneficiarydetail',
  )
  Future<Response> getProductFieldSettings({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/transaction/get-income-source-combo-list')
  Future<Response> getSourceOfFund({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/transaction/get-purpose-combo-list')
  Future<Response> getPurposeOfTransfer({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/notification/get-notification-list')
  Future<Response> getNotifications({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @POST(
    path: '/notification/update-device-token',
    headers: {'x-silent': 'true'},
  )
  Future<Response> postUpdateDeviceToken({
    @Header('Authorization') required String? token,
    @Body() required Map<String, dynamic> body,
  });

  @GET(path: '/beneficiary/get-beneficiary-bank-combo-list')
  Future<Response> getBankCombo({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/beneficiary/get-beneficiary-branch-combo-list')
  Future<Response> getBankBranchCombo({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/beneficiary/get-beneficiary-route-code-combo-list')
  Future<Response> getRouteCode({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @POST(path: '/auth/request-Beneficiary-otp')
  Future<Response> postRequestBeneficiaryOtp({
    @Header('Authorization') required String? token,
    @Body() required Map<String, dynamic> body,
  });

  @POST(path: '/auth/verify-Benficiary-login-otp')
  Future<Response> postVerifyBeneficiaryOtp({
    @Header('Authorization') required String? token,
    @Body() required Map<String, dynamic> body,
  });

  @DELETE(path: '/beneficiary/delete-beneficiary')
  Future<Response> deleteBeneficiary({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/beneficiary/get-beneficiary-bank-details')
  Future<Response> getBankBranchFromRoute({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/Beneficiary/get-beneficiary-by-id')
  Future<Response> getBeneficiaryById({
    @Header('Authorization') required String? token,
    @Query('eId') required String? beneficiaryId,
    @Query('IsTranslistRequired') bool isTranslistRequired = false,
  });

  @GET(path: '/Beneficiary/verify-beneficiary-product-field-settings')
  Future<Response> checkBeneficiaryMandatoryFields({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/auth/get-profile')
  Future<Response> getProfile({
    @Header('Authorization') required String? token,
  });

  @GET(path: '/transaction/get-transaction-list')
  Future<Response> getTransactionHistories({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/customer/get-branch-list', headers: {'x-skip-auth': 'true'})
  Future<Response> getBranches();

  @GET(
    path: '/Customer/get-country-combo-list',
    headers: {'x-skip-auth': 'true'},
  )
  Future<Response> getCountryCombo();

  @GET(path: '/Transaction/get-transaction')
  Future<Response> getTransactionDetails({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @GET(path: '/Transaction/print-receipt')
  @FactoryConverter(response: _binaryConverter)
  Future<Response<List<int>>> downloadOrShareReceipt({
    @Header('Authorization') required String? token,
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  @POST(path: '/docManagement/upload-doc', headers: {'x-skip-auth': 'true'})
  @multipart
  Future<Response> uploadDocs({
    @Part('Module') required String module,
    @Part('ModuleCode') required int moduleCode,
    @Part('DocName') required String docName,
    @PartFile('file') required MultipartFile file,
  });

  @POST(path: '/DocManagement/delete-doc', headers: {'x-skip-auth': 'true'})
  Future<Response> deleteDocs({@Body() required Map<String, dynamic> body});

  @GET(path: '/Auth/print-policy', headers: {'x-skip-auth': 'true'})
  Future<Response> getCompanyInfo({
    @QueryMap() required Map<String, dynamic> queryParams,
  });

  static ApiServices create() {
    final client = AuthHttpClient(http.Client());

    return _$ApiServices(
      ChopperClient(
        baseUrl: Uri.tryParse(AppConfig.appBaseUrl),
        services: [_$ApiServices()],
        client: client,
        converter: const JsonConverter(),
        errorConverter: const JsonConverter(),
        interceptors: [HttpLoggingInterceptor()],
      ),
    );
  }
}

enum _ErrorKind {
  network,
  timeout,
  server;

  String get titleKey => switch (this) {
    _ErrorKind.network => 'network.error.connectionError.title',
    _ErrorKind.timeout => 'network.error.requestTimeout.title',
    _ErrorKind.server => 'network.error.serverError.title',
  };

  String get messageKey => switch (this) {
    _ErrorKind.network => 'network.error.connectionError.message',
    _ErrorKind.timeout => 'network.error.requestTimeout.message',
    _ErrorKind.server => 'network.error.serverError.message',
  };
}

class AuthHttpClient extends http.BaseClient {
  final http.Client _inner;
  final SharedPrefs _prefs = getIt<SharedPrefs>();
  final AppRouter _router = getIt<AppRouter>();

  static const _requestTimeout = Duration(seconds: 60);
  static const _refreshTimeout = Duration(seconds: 15);

  // Only one token refresh runs at a time; concurrent 401s share its result.
  Future<bool>? _ongoingRefresh;

  // Queues completers for all concurrent requests awaiting a user retry decision.
  final List<Completer<bool>> _pendingRetryCompleters = [];
  bool _isRetryDialogVisible = false;

  AuthHttpClient(this._inner);

  bool _isBinaryResponse(http.StreamedResponse response) {
    final contentType = response.headers['content-type'] ?? '';
    return contentType.contains('application/pdf') ||
        contentType.contains('application/octet-stream') ||
        contentType.contains('application/vnd');
  }

  int _retryCount(http.BaseRequest request) =>
      int.tryParse(request.headers['x-retry-attempt'] ?? '0') ?? 0;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Reject non-HTTPS to prevent accidental plaintext banking data transmission.
    // if (!request.url.scheme.startsWith('https')) {
    //   throw Exception(
    //     'Insecure connections are not permitted in this application.',
    //   );
    // }

    // Read and strip the skip-auth sentinel before the request hits the wire.
    // Chopper sets it via headers: {'x-skip-auth': 'true'} on the method annotation.
    final skipAuth = request.headers.remove(_kSkipAuth) != null;

    // Silent requests never surface the shared retry dialog — infrastructure
    // failures are rethrown and mapped to a domain failure by the repository.
    final silent = request.headers.remove(_kSilent) != null;

    if (!skipAuth) {
      final token = _prefs.getToken();
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Audited (business-critical) endpoints get a correlation id the backend
    // can log too. Clones inherit headers, so every retry of one logical call
    // shares the same id and is distinguished by x-retry-attempt.
    final audit = getIt<IAuditLogFacade>();
    if (audit.isAudited(request) &&
        !request.headers.containsKey(IAuditLogFacade.requestIdHeader)) {
      request.headers[IAuditLogFacade.requestIdHeader] = audit.newRequestId();
    }

    HttpLogger.logRequest(request);

    final startTime = DateTime.now();

    // --- Initial send ---
    final http.StreamedResponse response;
    try {
      response = await _inner.send(request).timeout(_requestTimeout);
    } on SocketException catch (e) {
      HttpLogger.logException(request: request, exception: e);
      if (silent) rethrow;
      final shouldRetry = await _awaitRetryDecision(_ErrorKind.network);
      if (shouldRetry) {
        final clone = _cloneForRetry(request, skipAuth: skipAuth);
        if (clone != null) return send(clone);
      }
      rethrow;
    } on TimeoutException catch (e) {
      HttpLogger.logException(request: request, exception: e);
      if (silent) rethrow;
      final shouldRetry = await _awaitRetryDecision(_ErrorKind.timeout);
      if (shouldRetry) {
        final clone = _cloneForRetry(request, skipAuth: skipAuth);
        if (clone != null) return send(clone);
      }
      rethrow;
    } on HandshakeException catch (e) {
      HttpLogger.logException(request: request, exception: e);
      if (silent) rethrow;
      await _awaitRetryDecision(_ErrorKind.server, retryable: false);
      rethrow;
    } on TlsException catch (e) {
      HttpLogger.logException(request: request, exception: e);
      if (silent) rethrow;
      await _awaitRetryDecision(_ErrorKind.server, retryable: false);
      rethrow;
    } catch (e) {
      HttpLogger.logException(request: request, exception: e);
      if (silent) rethrow;
      await _awaitRetryDecision(_ErrorKind.server, retryable: false);
      rethrow;
    }

    final duration = DateTime.now().difference(startTime).inMilliseconds;
    final (buffered, body) = await _bufferAndLog(response, request, duration);

    // --- 428 — the backend has revoked this session; wipe and go to login ---
    if (buffered.statusCode == ForceLogoutHandler.statusCode) {
      await _handleForceLogout(body);
      return buffered;
    }

    // Only surface the retry dialog for genuine infrastructure failures.
    // A valid JSON object body means the backend authored this error response
    // intentionally (business-logic error); the repository layer will decode
    // and map it to the correct domain failure.
    if (buffered.statusCode >= 500 && !_isBackendJson(body)) {
      if (silent) return buffered;
      final safeMethod = _isSafeMethod(request.method);
      final shouldRetry = await _awaitRetryDecision(
        _ErrorKind.server,
        retryable: safeMethod,
      );
      if (shouldRetry && safeMethod) {
        final clone = _cloneForRetry(request, skipAuth: skipAuth);
        if (clone != null) return send(clone);
      }
      return buffered;
    }

    if (skipAuth || buffered.statusCode != 401) {
      return buffered;
    }

    // --- 401 — attempt token refresh exactly once per request chain ---
    if (_retryCount(request) >= 1) {
      // Already retried once; session is genuinely expired.
      _scheduleLogout();
      return buffered;
    }

    final refreshed = await _serializedRefresh();
    if (!refreshed) {
      _scheduleLogout();
      return buffered;
    }

    final newToken = _prefs.getToken();
    final retryReq = _cloneWithAuth(request, newToken, retryCount: 1);
    if (retryReq == null) {
      // Request type cannot be cloned (e.g., streamed file upload after send).
      _scheduleLogout();
      return buffered;
    }

    HttpLogger.logRequest(retryReq);

    // --- Retry send ---
    final retryStart = DateTime.now();
    final http.StreamedResponse retryResponse;
    try {
      retryResponse = await _inner.send(retryReq).timeout(_requestTimeout);
    } on SocketException catch (e) {
      HttpLogger.logException(request: retryReq, exception: e);
      final shouldRetry = await _awaitRetryDecision(_ErrorKind.network);
      if (shouldRetry) {
        final clone = _cloneForRetry(retryReq);
        if (clone != null) return send(clone);
      }
      rethrow;
    } on TimeoutException catch (e) {
      HttpLogger.logException(request: retryReq, exception: e);
      final shouldRetry = await _awaitRetryDecision(_ErrorKind.timeout);
      if (shouldRetry) {
        final clone = _cloneForRetry(retryReq);
        if (clone != null) return send(clone);
      }
      rethrow;
    } catch (e) {
      HttpLogger.logException(request: retryReq, exception: e);
      await _awaitRetryDecision(_ErrorKind.server, retryable: false);
      rethrow;
    }

    final retryDuration = DateTime.now().difference(retryStart).inMilliseconds;
    final (bufferedRetry, retryBody) = await _bufferAndLog(
      retryResponse,
      retryReq,
      retryDuration,
    );

    if (bufferedRetry.statusCode == ForceLogoutHandler.statusCode) {
      await _handleForceLogout(retryBody);
      return bufferedRetry;
    }

    if (bufferedRetry.statusCode >= 500 && !_isBackendJson(retryBody)) {
      final safeMethod = _isSafeMethod(retryReq.method);
      final shouldRetry = await _awaitRetryDecision(
        _ErrorKind.server,
        retryable: safeMethod,
      );
      if (shouldRetry && safeMethod) {
        final clone = _cloneForRetry(retryReq);
        if (clone != null) return send(clone);
      }
    } else if (bufferedRetry.statusCode == 401) {
      // Refresh succeeded but server still rejects — force logout.
      _scheduleLogout();
    }

    return bufferedRetry;
  }

  // Reads the response stream into memory exactly once, forwards it to the
  // audit log, and returns both a new StreamedResponse backed by the buffered
  // bytes and the raw body
  // string (empty for binary responses). The body string is used by the caller
  // to distinguish backend business-logic errors (valid JSON) from true
  // infrastructure failures (HTML, empty, or unparseable bodies).
  Future<(http.StreamedResponse, String)> _bufferAndLog(
    http.StreamedResponse response,
    http.BaseRequest request,
    int duration,
  ) async {
    if (_isBinaryResponse(response)) {
      final bytes = await response.stream.toBytes();
      return (
        http.StreamedResponse(
          Stream.value(bytes),
          response.statusCode,
          contentLength: bytes.length,
          headers: response.headers,
          request: response.request,
          reasonPhrase: response.reasonPhrase,
        ),
        '',
      );
    }

    final body = await response.stream.bytesToString();
    HttpLogger.logResponse(
      request: request,
      statusCode: response.statusCode,
      body: body,
      duration: duration,
    );
    final encoded = utf8.encode(body);
    return (
      http.StreamedResponse(
        Stream.value(encoded),
        response.statusCode,
        contentLength: encoded.length,
        headers: response.headers,
        request: response.request,
        reasonPhrase: response.reasonPhrase,
      ),
      body,
    );
  }

  // Returns true when the body is a JSON object — i.e. the backend authored
  // the response intentionally (business-logic error). Non-JSON bodies
  // (HTML error pages, empty strings, plain text) indicate a true
  // infrastructure failure that should surface the retry dialog.
  bool _isBackendJson(String body) {
    if (body.isEmpty) return false;
    try {
      return jsonDecode(body) is Map<String, dynamic>;
    } catch (_) {
      return false;
    }
  }

  // Returns the ongoing refresh future if one is already in flight so that
  // concurrent 401 responses don't race to refresh the token multiple times.
  Future<bool> _serializedRefresh() {
    _ongoingRefresh ??= _doRefreshToken().whenComplete(() {
      _ongoingRefresh = null;
    });
    return _ongoingRefresh!;
  }

  Future<bool> _doRefreshToken() async {
    final refreshToken = _prefs.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      final url = Uri.parse('${AppConfig.appBaseUrl}/api/Auth/refresh-token');
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refresh_token': refreshToken}),
          )
          .timeout(_refreshTimeout);

      if (response.statusCode != 200) {
        return false;
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>?;
      final data = decoded?['data'] as Map<String, dynamic>?;
      final newToken = data?['jwt_token'] as String?;
      final newRefreshToken = data?['refresh_token'] as String?;

      if (newToken == null || newToken.isEmpty) {
        return false;
      }

      await _prefs.setToken(newToken);
      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await _prefs.setRefreshToken(newRefreshToken);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  http.BaseRequest? _cloneWithAuth(
    http.BaseRequest original,
    String? token, {
    required int retryCount,
  }) {
    final headers = {
      ...original.headers,
      'Authorization': 'Bearer $token',
      'x-retry-attempt': retryCount.toString(),
    };

    if (original is http.Request) {
      return http.Request(original.method, original.url)
        ..headers.addAll(headers)
        ..bodyBytes = original.bodyBytes;
    }

    // Multipart file streams may already be consumed after the first send.
    // We clone what we can; the caller handles null gracefully.
    if (original is http.MultipartRequest) {
      return http.MultipartRequest(original.method, original.url)
        ..headers.addAll(headers)
        ..fields.addAll(original.fields)
        ..files.addAll(original.files);
    }

    return null;
  }

  // Clones a request preserving all headers, used for network/timeout retries
  // where the auth state has not changed. skipAuth re-attaches the sentinel so
  // the recursive send() call honours the same bypass decision.
  http.BaseRequest? _cloneForRetry(
    http.BaseRequest original, {
    bool skipAuth = false,
  }) {
    final headers = Map<String, String>.from(original.headers);
    if (skipAuth) headers[_kSkipAuth] = 'true';
    if (original is http.Request) {
      return http.Request(original.method, original.url)
        ..headers.addAll(headers)
        ..bodyBytes = original.bodyBytes;
    }
    if (original is http.MultipartRequest) {
      return http.MultipartRequest(original.method, original.url)
        ..headers.addAll(headers)
        ..fields.addAll(original.fields)
        ..files.addAll(original.files);
    }
    return null;
  }

  // A 428 from any endpoint means the backend has repudiated the session.
  // Deliberately ignores both sentinels: x-skip-auth endpoints (verify-mpin,
  // verify-biometric) still run inside a live session, and x-silent only
  // suppresses the retry dialog — never a forced sign-out, so background
  // pollers (version check, approval status, device-token sync) trigger it too.
  // The response is still handed back to the repository so no caller hangs.
  Future<void> _handleForceLogout(String body) async {
    final handler = getIt<ForceLogoutHandler>();
    // Pre-auth 428 (login / OTP / registration): nothing to log out of, and
    // wiping prefs would destroy a legitimate registration-resume state.
    if (!handler.hasSession) return;
    await handler.trigger(serverMessage: handler.messageFromBody(body));
  }

  // Only GET/HEAD/OPTIONS are safe to retry on 5xx — POST/PUT/DELETE could
  // cause duplicate transactions if the server partially processed the request.
  bool _isSafeMethod(String method) =>
      const {'GET', 'HEAD', 'OPTIONS'}.contains(method.toUpperCase());

  // Suspends the calling HTTP request until the user taps Retry or Cancel.
  // All concurrent requests that fail while a dialog is visible share the
  // same dialog; they all retry (or give up) together when the user decides.
  Future<bool> _awaitRetryDecision(
    _ErrorKind kind, {
    bool retryable = true,
  }) async {
    final completer = Completer<bool>();
    _pendingRetryCompleters.add(completer);

    if (!_isRetryDialogVisible) {
      _isRetryDialogVisible = true;
      _showNetworkDialog(kind, retryable: retryable);
    }

    return completer.future.timeout(
      const Duration(minutes: 5),
      onTimeout: () {
        _isRetryDialogVisible = false;
        _resolveAll(false);
        return false;
      },
    );
  }

  void _showNetworkDialog(_ErrorKind kind, {required bool retryable}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _router.navigatorKey.currentContext;
      if (context == null || !context.mounted) {
        _isRetryDialogVisible = false;
        _resolveAll(false);
        return;
      }
      DialogHelper.show(
        context,
        type: AppDialogType.error,
        title: kind.titleKey.tr(),
        message: kind.messageKey.tr(),
        buttonText: retryable ? 'buttons.retry'.tr() : 'buttons.okay'.tr(),
        onPressed: () {
          _router.navigatorKey.currentState?.pop();
          _isRetryDialogVisible = false;
          _resolveAll(retryable);
        },
        showTwoButtons: retryable,
        secondButtonText: retryable ? 'buttons.cancel'.tr() : null,
        onSecondPressed: retryable
            ? () {
                _router.navigatorKey.currentState?.pop();
                _isRetryDialogVisible = false;
                _resolveAll(false);
              }
            : null,
      ).whenComplete(() {
        // Catches any dismissal not handled by a button (e.g. Android back key).
        _isRetryDialogVisible = false;
        _resolveAll(false);
      });
    });
  }

  void _resolveAll(bool shouldRetry) {
    final completers = List<Completer<bool>>.from(_pendingRetryCompleters);
    _pendingRetryCompleters.clear();
    for (final c in completers) {
      if (!c.isCompleted) c.complete(shouldRetry);
    }
  }

  void _scheduleLogout() {
    // A force logout (428) owns the navigation and must win: the soft MPIN
    // lock would offer an unlock for a session the server has already killed.
    if (getIt<ForceLogoutHandler>().isLoggingOut) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _router.navigatorKey.currentContext;
      if (context == null || !context.mounted) return;
      _router.replaceAll([MpinRoute()]);
    });
  }
}

// ---------------------------------------------------------------------------
// HttpLogger  —  audit forwarding only
// ---------------------------------------------------------------------------
//
// Console output was removed deliberately: no request, response, header, or
// body is ever written to the debug console, in any build mode. Each method
// forwards to IAuditLogFacade, which persists audited (business-critical)
// endpoint traffic to the cloud in ALL build modes. These call sites cover
// every attempt — initial send, 401 re-send, and network-retry clones — so the
// audit trail stays complete without touching the send() flow.
//
// Do not reintroduce console logging here: these payloads carry bearer tokens,
// KYC documents, and customer financial data.
// ---------------------------------------------------------------------------

class HttpLogger {
  static void logRequest(http.BaseRequest request) {
    getIt<IAuditLogFacade>().logRequest(request);
  }

  static void logResponse({
    required http.BaseRequest request,
    required int statusCode,
    required String body,
    required int duration,
  }) {
    getIt<IAuditLogFacade>().logResponse(
      request: request,
      statusCode: statusCode,
      body: body,
      duration: duration,
    );
  }

  static void logException({
    required http.BaseRequest request,
    required Object exception,
  }) {
    getIt<IAuditLogFacade>().logException(
      request: request,
      exception: exception,
    );
  }
}

// ---------------------------------------------------------------------------
// Binary response converter (used by @FactoryConverter on receipt endpoints)
// ---------------------------------------------------------------------------

Response<List<int>> _binaryConverter(Response response) {
  return response.copyWith<List<int>>(body: response.bodyBytes);
}
