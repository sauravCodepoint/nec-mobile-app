import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_log_entry_dto.freezed.dart';
part 'audit_log_entry_dto.g.dart';

/// One document in the `api_audit_logs` Firestore collection: a single
/// request, response, or exception event of an audited critical API call.
/// The repository appends the Firestore-typed `ts_server` and `expire_at`
/// fields at write time — they cannot be expressed via json_serializable.
@freezed
sealed class AuditLogEntryDto with _$AuditLogEntryDto {
  const factory AuditLogEntryDto({
    @JsonKey(name: "event")
    required String event,
    @JsonKey(name: "member_code")
    required int memberCode,
    @JsonKey(name: "mobile_number")
    String? mobileNumber,
    @JsonKey(name: "request_id")
    String? requestId,
    @JsonKey(name: "attempt")
    required int attempt,
    @JsonKey(name: "method")
    required String method,
    @JsonKey(name: "url")
    required String url,
    @JsonKey(name: "ts_client_utc")
    required String tsClientUtc,
    @JsonKey(name: "app_version")
    required String appVersion,
    @JsonKey(name: "device")
    required String device,
    @JsonKey(name: "headers")
    Map<String, String>? headers,
    @JsonKey(name: "body")
    String? body,
    @JsonKey(name: "body_sha256")
    String? bodySha256,
    @JsonKey(name: "body_length_bytes")
    int? bodyLengthBytes,
    @JsonKey(name: "status_code")
    int? statusCode,
    @JsonKey(name: "duration_ms")
    int? durationMs,
    @JsonKey(name: "exception_type")
    String? exceptionType,
    @JsonKey(name: "exception")
    String? exception,
  }) = _AuditLogEntryDto;

  factory AuditLogEntryDto.fromJson(Map<String, dynamic> json) => _$AuditLogEntryDtoFromJson(json);
}
