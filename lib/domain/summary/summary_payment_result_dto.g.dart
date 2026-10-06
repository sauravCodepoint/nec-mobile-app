// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_payment_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SummaryPaymentResultDto _$SummaryPaymentResultDtoFromJson(
  Map<String, dynamic> json,
) => _SummaryPaymentResultDto(
  success: json['success'] as String?,
  statusCode: (json['status_code'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : SummaryPaymentResultDtoData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SummaryPaymentResultDtoToJson(
  _SummaryPaymentResultDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

_SummaryPaymentResultDtoData _$SummaryPaymentResultDtoDataFromJson(
  Map<String, dynamic> json,
) => _SummaryPaymentResultDtoData(
  appTransaction: json['app_transaction'] == null
      ? null
      : AppTransaction.fromJson(
          json['app_transaction'] as Map<String, dynamic>,
        ),
  eId: json['e_id'] as String?,
);

Map<String, dynamic> _$SummaryPaymentResultDtoDataToJson(
  _SummaryPaymentResultDtoData instance,
) => <String, dynamic>{
  'app_transaction': instance.appTransaction,
  'e_id': instance.eId,
};

_AppTransaction _$AppTransactionFromJson(Map<String, dynamic> json) =>
    _AppTransaction(
      transactionReference: (json['transaction_reference'] as num?)?.toInt(),
      netAmount: (json['net_amount'] as num?)?.toDouble(),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      appTransactionReference: (json['app_transaction_reference'] as num?)
          ?.toInt(),
    );

Map<String, dynamic> _$AppTransactionToJson(_AppTransaction instance) =>
    <String, dynamic>{
      'transaction_reference': instance.transactionReference,
      'net_amount': instance.netAmount,
      'transactions': instance.transactions,
      'app_transaction_reference': instance.appTransactionReference,
    };

_Transaction _$TransactionFromJson(Map<String, dynamic> json) => _Transaction(
  transactionReference: (json['transaction_reference'] as num?)?.toInt(),
  netAmount: (json['net_amount'] as num?)?.toDouble(),
  status: json['status'] as String?,
  beneficiaryName: json['beneficiary_name'] as String?,
);

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
    <String, dynamic>{
      'transaction_reference': instance.transactionReference,
      'net_amount': instance.netAmount,
      'status': instance.status,
      'beneficiary_name': instance.beneficiaryName,
    };
