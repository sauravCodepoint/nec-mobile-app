import 'package:http/http.dart' as http;

/// Fire-and-forget cloud audit trail for business-critical API calls.
///
/// Persists the exact wire payload (plus its SHA-256 hash), the response,
/// and any exception of audited endpoints per user, so payload disputes with
/// the backend can be settled with evidence. Methods deliberately return
/// `void` instead of `Either<Failure, T>`: a logging failure must never
/// propagate into — let alone break — the payment call it observes.
abstract class IAuditLogFacade {
  /// Correlation header attached to every audited request. The backend team
  /// should log it too, so both sides can locate the same request
  /// unambiguously. Retries of one logical call share the same id and are
  /// distinguished by their attempt number.
  static const String requestIdHeader = 'X-Client-Request-Id';

  /// Whether [request] targets an audited endpoint.
  bool isAudited(http.BaseRequest request);

  /// Generates a new value for [requestIdHeader].
  String newRequestId();

  /// Records an outgoing request, including the exact bytes on the wire.
  void logRequest(http.BaseRequest request);

  /// Records the response to an audited request.
  void logResponse({
    required http.BaseRequest request,
    required int statusCode,
    required String body,
    required int duration,
  });

  /// Records a network/timeout/TLS failure of an audited request.
  void logException({
    required http.BaseRequest request,
    required Object exception,
  });
}
