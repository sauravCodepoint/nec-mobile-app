// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuditLogEntryDto _$AuditLogEntryDtoFromJson(Map<String, dynamic> json) =>
    _AuditLogEntryDto(
      event: json['event'] as String,
      memberCode: (json['member_code'] as num).toInt(),
      mobileNumber: json['mobile_number'] as String?,
      requestId: json['request_id'] as String?,
      attempt: (json['attempt'] as num).toInt(),
      method: json['method'] as String,
      url: json['url'] as String,
      tsClientUtc: json['ts_client_utc'] as String,
      appVersion: json['app_version'] as String,
      device: json['device'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      body: json['body'] as String?,
      bodySha256: json['body_sha256'] as String?,
      bodyLengthBytes: (json['body_length_bytes'] as num?)?.toInt(),
      statusCode: (json['status_code'] as num?)?.toInt(),
      durationMs: (json['duration_ms'] as num?)?.toInt(),
      exceptionType: json['exception_type'] as String?,
      exception: json['exception'] as String?,
    );

Map<String, dynamic> _$AuditLogEntryDtoToJson(_AuditLogEntryDto instance) =>
    <String, dynamic>{
      'event': instance.event,
      'member_code': instance.memberCode,
      'mobile_number': instance.mobileNumber,
      'request_id': instance.requestId,
      'attempt': instance.attempt,
      'method': instance.method,
      'url': instance.url,
      'ts_client_utc': instance.tsClientUtc,
      'app_version': instance.appVersion,
      'device': instance.device,
      'headers': instance.headers,
      'body': instance.body,
      'body_sha256': instance.bodySha256,
      'body_length_bytes': instance.bodyLengthBytes,
      'status_code': instance.statusCode,
      'duration_ms': instance.durationMs,
      'exception_type': instance.exceptionType,
      'exception': instance.exception,
    };
