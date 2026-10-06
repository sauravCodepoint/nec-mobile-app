import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_calculator_calculate_amount_dto.freezed.dart';
part 'rate_calculator_calculate_amount_dto.g.dart';

RateCalculatorCalculateAmountDto rateCalculatorCalculateAmountDtoFromJson(
  String str,
) => RateCalculatorCalculateAmountDto.fromJson(json.decode(str));

String rateCalculatorCalculateAmountDtoToJson(
  RateCalculatorCalculateAmountDto data,
) => json.encode(data.toJson());

@freezed
sealed class RateCalculatorCalculateAmountDto
    with _$RateCalculatorCalculateAmountDto {
  const factory RateCalculatorCalculateAmountDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "status_code") int? statusCode,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "data") RateCalcData? data,
    @JsonKey(name: "time_stamp") DateTime? timeStamp,
    @JsonKey(name: "version") String? version,
  }) = _RateCalculatorCalculateAmountDto;

  factory RateCalculatorCalculateAmountDto.fromJson(
    Map<String, dynamic> json,
  ) => _$RateCalculatorCalculateAmountDtoFromJson(json);
}

@freezed
sealed class RateCalcData with _$RateCalcData {
  const factory RateCalcData({
    @JsonKey(name: "amount") RateCalcAmount? amount,
  }) = _RateCalcData;

  factory RateCalcData.fromJson(Map<String, dynamic> json) =>
      _$RateCalcDataFromJson(json);
}

@freezed
sealed class RateCalcAmount with _$RateCalcAmount {
  const factory RateCalcAmount({
    // Principal that converts (pay_amount × rate ≈ net_receive_amount).
    @JsonKey(name: "pay_amount") double? payAmount,
    @JsonKey(name: "rate") double? rate,
    // Customer-facing rate the app should render; falls back to `rate`.
    @JsonKey(name: "display_rate") double? displayRate,
    @JsonKey(name: "net_receive_amount") double? netReceiveAmount,
    @JsonKey(name: "rate_operator") String? rateOperator,
    @JsonKey(name: "mobile_rate_operator") String? mobileRateOperator,
    // Backend-authored note rendered under the rate card in place of a
    // hard-coded disclaimer, so the wording stays server-controlled.
    @JsonKey(name: "remarks") String? remarks,
  }) = _RateCalcAmount;

  factory RateCalcAmount.fromJson(Map<String, dynamic> json) =>
      _$RateCalcAmountFromJson(json);
}