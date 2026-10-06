import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'common_payment_result_dto.freezed.dart';
part 'common_payment_result_dto.g.dart';

CommonPaymentResultDto commonPaymentResultDtoFromJson(String str) =>
    CommonPaymentResultDto.fromJson(json.decode(str));

String commonPaymentResultDtoToJson(CommonPaymentResultDto data) =>
    json.encode(data.toJson());

@freezed
sealed class CommonPaymentResultDto with _$CommonPaymentResultDto {
  const factory CommonPaymentResultDto({
    String? success,
    String? message,
    PaymentResultData? data,
    DateTime? timeStamp,
  }) = _CommonPaymentResultDto;

  factory CommonPaymentResultDto.fromJson(Map<String, dynamic> json) =>
      _$CommonPaymentResultDtoFromJson(json);
}

@freezed
sealed class PaymentResultData with _$PaymentResultData {
  const factory PaymentResultData({
    PaymentTransaction? paymentTransaction,
    String? eId,
  }) = _PaymentResultData;

  factory PaymentResultData.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultDataFromJson(json);
}

@freezed
sealed class PaymentTransaction with _$PaymentTransaction {
  const factory PaymentTransaction({
    int? transactionReference,
    double? netAmount,
    TransactionDetails? transactions,
  }) = _PaymentTransaction;

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionFromJson(json);
}

@freezed
sealed class TransactionDetails with _$TransactionDetails {
  const factory TransactionDetails({
    bool? isSuccessful,
    int? transactionReference,
    double? netAmount,
    String? status,
    String? beneficiaryName,
    String? paymentMode,
    String? appStatus,
  }) = _TransactionDetails;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson(json);
}