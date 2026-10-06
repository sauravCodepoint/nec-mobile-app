import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_send_money_dto.freezed.dart';
part 'common_send_money_dto.g.dart';

CommonSendMoneyDto commonSendMoneyDtoFromJson(String str) =>
    CommonSendMoneyDto.fromJson(json.decode(str));

String commonSendMoneyDtoToJson(CommonSendMoneyDto data) =>
    json.encode(data.toJson());

@freezed
sealed class CommonSendMoneyDto with _$CommonSendMoneyDto {
  const factory CommonSendMoneyDto({
    double? sourceAmount,
    double? destinationAmount,
    double? displayRate,
    double? rate,
    String? rateOperator,
    double? benePay,
    double? fCCommission,
    double? netLcAmount,
    double? commission,
    double? fee,
    double? tax,
    double? taxPercentage,
    double? payAmount,
    double? totalPayableAmount,
    String? branchName,
    String? branchCode,
    double? hoRate,
    bool? isBankOrAgentRequired,
    // Backend-supplied note flagging any variation between the amounts the
    // user calculated and the source/destination amounts the backend returns.
    String? amountVariation,
    // Backend base-currency reference echoed back into the create-transaction
    // payload (audit/reconciliation on the server side).
    double? apiBaseCurrencyRate,
    double? apiBaseCurrencyValue,
  }) = _CommonSendMoneyDto;

  factory CommonSendMoneyDto.empty() =>
      const CommonSendMoneyDto(sourceAmount: 0.0, destinationAmount: 0.0);

  factory CommonSendMoneyDto.fromJson(Map<String, dynamic> json) =>
      _$CommonSendMoneyDtoFromJson(json);
}
