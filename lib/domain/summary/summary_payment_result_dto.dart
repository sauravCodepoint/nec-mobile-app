import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'summary_payment_result_dto.freezed.dart';
part 'summary_payment_result_dto.g.dart';

SummaryPaymentResultDto summaryPaymentResultDtoFromJson(String str) =>
    SummaryPaymentResultDto.fromJson(json.decode(str));

String summaryPaymentResultDtoToJson(SummaryPaymentResultDto data) =>
    json.encode(data.toJson());

@freezed
sealed class SummaryPaymentResultDto with _$SummaryPaymentResultDto {
  const factory SummaryPaymentResultDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "status_code") int? statusCode,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "data") SummaryPaymentResultDtoData? data,
  }) = _SummaryPaymentResultDto;

  factory SummaryPaymentResultDto.fromJson(Map<String, dynamic> json) =>
      _$SummaryPaymentResultDtoFromJson(json);
}

@freezed
sealed class SummaryPaymentResultDtoData with _$SummaryPaymentResultDtoData {
  const factory SummaryPaymentResultDtoData({
    @JsonKey(name: "app_transaction") AppTransaction? appTransaction,
    @JsonKey(name: "e_id") String? eId,
  }) = _SummaryPaymentResultDtoData;

  factory SummaryPaymentResultDtoData.fromJson(Map<String, dynamic> json) =>
      _$SummaryPaymentResultDtoDataFromJson(json);
}

@freezed
sealed class AppTransaction with _$AppTransaction {
  const factory AppTransaction({
    @JsonKey(name: "transaction_reference") int? transactionReference,
    @JsonKey(name: "net_amount") double? netAmount,
    @JsonKey(name: "transactions") List<Transaction>? transactions,
    @JsonKey(name: "app_transaction_reference") int? appTransactionReference,
  }) = _AppTransaction;

  factory AppTransaction.fromJson(Map<String, dynamic> json) =>
      _$AppTransactionFromJson(json);
}

@freezed
sealed class Transaction with _$Transaction {
  const factory Transaction({
    @JsonKey(name: "transaction_reference") int? transactionReference,
    @JsonKey(name: "net_amount") double? netAmount,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "beneficiary_name") String? beneficiaryName,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
