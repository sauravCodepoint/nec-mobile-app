// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_payment_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommonPaymentResultDto _$CommonPaymentResultDtoFromJson(
  Map<String, dynamic> json,
) => _CommonPaymentResultDto(
  success: json['success'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : PaymentResultData.fromJson(json['data'] as Map<String, dynamic>),
  timeStamp: json['timeStamp'] == null
      ? null
      : DateTime.parse(json['timeStamp'] as String),
);

Map<String, dynamic> _$CommonPaymentResultDtoToJson(
  _CommonPaymentResultDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'timeStamp': instance.timeStamp?.toIso8601String(),
};

_PaymentResultData _$PaymentResultDataFromJson(Map<String, dynamic> json) =>
    _PaymentResultData(
      paymentTransaction: json['paymentTransaction'] == null
          ? null
          : PaymentTransaction.fromJson(
              json['paymentTransaction'] as Map<String, dynamic>,
            ),
      eId: json['eId'] as String?,
    );

Map<String, dynamic> _$PaymentResultDataToJson(_PaymentResultData instance) =>
    <String, dynamic>{
      'paymentTransaction': instance.paymentTransaction,
      'eId': instance.eId,
    };

_PaymentTransaction _$PaymentTransactionFromJson(Map<String, dynamic> json) =>
    _PaymentTransaction(
      transactionReference: (json['transactionReference'] as num?)?.toInt(),
      netAmount: (json['netAmount'] as num?)?.toDouble(),
      transactions: json['transactions'] == null
          ? null
          : TransactionDetails.fromJson(
              json['transactions'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PaymentTransactionToJson(_PaymentTransaction instance) =>
    <String, dynamic>{
      'transactionReference': instance.transactionReference,
      'netAmount': instance.netAmount,
      'transactions': instance.transactions,
    };

_TransactionDetails _$TransactionDetailsFromJson(Map<String, dynamic> json) =>
    _TransactionDetails(
      isSuccessful: json['isSuccessful'] as bool?,
      transactionReference: (json['transactionReference'] as num?)?.toInt(),
      netAmount: (json['netAmount'] as num?)?.toDouble(),
      status: json['status'] as String?,
      beneficiaryName: json['beneficiaryName'] as String?,
      paymentMode: json['paymentMode'] as String?,
      appStatus: json['appStatus'] as String?,
    );

Map<String, dynamic> _$TransactionDetailsToJson(_TransactionDetails instance) =>
    <String, dynamic>{
      'isSuccessful': instance.isSuccessful,
      'transactionReference': instance.transactionReference,
      'netAmount': instance.netAmount,
      'status': instance.status,
      'beneficiaryName': instance.beneficiaryName,
      'paymentMode': instance.paymentMode,
      'appStatus': instance.appStatus,
    };
