import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_calculator_currency_list_dto.freezed.dart';
part 'rate_calculator_currency_list_dto.g.dart';

RateCalculatorCurrencyListDto rateCalculatorCurrencyListDtoFromJson(String str) =>
    RateCalculatorCurrencyListDto.fromJson(json.decode(str));

String rateCalculatorCurrencyListDtoToJson(RateCalculatorCurrencyListDto data) =>
    json.encode(data.toJson());

@freezed
sealed class RateCalculatorCurrencyListDto with _$RateCalculatorCurrencyListDto {
  const factory RateCalculatorCurrencyListDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "status_code") int? statusCode,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "data") RateCurrencyData? data,
    @JsonKey(name: "time_stamp") DateTime? timeStamp,
    @JsonKey(name: "version") String? version,
  }) = _RateCalculatorCurrencyListDto;

  factory RateCalculatorCurrencyListDto.fromJson(Map<String, dynamic> json) =>
      _$RateCalculatorCurrencyListDtoFromJson(json);
}

@freezed
sealed class RateCurrencyData with _$RateCurrencyData {
  const factory RateCurrencyData({
    @JsonKey(name: "currency_list") List<RateCurrencyItem>? currencyList,
  }) = _RateCurrencyData;

  factory RateCurrencyData.fromJson(Map<String, dynamic> json) =>
      _$RateCurrencyDataFromJson(json);
}

@freezed
sealed class RateCurrencyItem with _$RateCurrencyItem {
  const factory RateCurrencyItem({
    @JsonKey(name: "e_id") String? eId,
    @JsonKey(name: "currency_code") String? currencyCode,
    @JsonKey(name: "currency_name") String? currencyName,
    @JsonKey(name: "country_code") String? countryCode,
    @JsonKey(name: "country_name") String? countryName,
    @JsonKey(name: "flag_url") String? flagUrl,
    @JsonKey(name: "decimal_places") int? decimalPlaces,
  }) = _RateCurrencyItem;

  factory RateCurrencyItem.fromJson(Map<String, dynamic> json) =>
      _$RateCurrencyItemFromJson(json);
}