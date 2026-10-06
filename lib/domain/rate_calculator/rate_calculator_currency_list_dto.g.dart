// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_calculator_currency_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RateCalculatorCurrencyListDto _$RateCalculatorCurrencyListDtoFromJson(
  Map<String, dynamic> json,
) => _RateCalculatorCurrencyListDto(
  success: json['success'] as String?,
  statusCode: (json['status_code'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : RateCurrencyData.fromJson(json['data'] as Map<String, dynamic>),
  timeStamp: json['time_stamp'] == null
      ? null
      : DateTime.parse(json['time_stamp'] as String),
  version: json['version'] as String?,
);

Map<String, dynamic> _$RateCalculatorCurrencyListDtoToJson(
  _RateCalculatorCurrencyListDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
  'time_stamp': instance.timeStamp?.toIso8601String(),
  'version': instance.version,
};

_RateCurrencyData _$RateCurrencyDataFromJson(Map<String, dynamic> json) =>
    _RateCurrencyData(
      currencyList: (json['currency_list'] as List<dynamic>?)
          ?.map((e) => RateCurrencyItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RateCurrencyDataToJson(_RateCurrencyData instance) =>
    <String, dynamic>{'currency_list': instance.currencyList};

_RateCurrencyItem _$RateCurrencyItemFromJson(Map<String, dynamic> json) =>
    _RateCurrencyItem(
      eId: json['e_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencyName: json['currency_name'] as String?,
      countryCode: json['country_code'] as String?,
      countryName: json['country_name'] as String?,
      flagUrl: json['flag_url'] as String?,
      decimalPlaces: (json['decimal_places'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RateCurrencyItemToJson(_RateCurrencyItem instance) =>
    <String, dynamic>{
      'e_id': instance.eId,
      'currency_code': instance.currencyCode,
      'currency_name': instance.currencyName,
      'country_code': instance.countryCode,
      'country_name': instance.countryName,
      'flag_url': instance.flagUrl,
      'decimal_places': instance.decimalPlaces,
    };
