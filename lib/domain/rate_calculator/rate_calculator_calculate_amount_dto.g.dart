// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_calculator_calculate_amount_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RateCalculatorCalculateAmountDto _$RateCalculatorCalculateAmountDtoFromJson(
  Map<String, dynamic> json,
) => _RateCalculatorCalculateAmountDto(
  success: json['success'] as String?,
  statusCode: (json['status_code'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : RateCalcData.fromJson(json['data'] as Map<String, dynamic>),
  timeStamp: json['time_stamp'] == null
      ? null
      : DateTime.parse(json['time_stamp'] as String),
  version: json['version'] as String?,
);

Map<String, dynamic> _$RateCalculatorCalculateAmountDtoToJson(
  _RateCalculatorCalculateAmountDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
  'time_stamp': instance.timeStamp?.toIso8601String(),
  'version': instance.version,
};

_RateCalcData _$RateCalcDataFromJson(Map<String, dynamic> json) =>
    _RateCalcData(
      amount: json['amount'] == null
          ? null
          : RateCalcAmount.fromJson(json['amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RateCalcDataToJson(_RateCalcData instance) =>
    <String, dynamic>{'amount': instance.amount};

_RateCalcAmount _$RateCalcAmountFromJson(Map<String, dynamic> json) =>
    _RateCalcAmount(
      payAmount: (json['pay_amount'] as num?)?.toDouble(),
      rate: (json['rate'] as num?)?.toDouble(),
      displayRate: (json['display_rate'] as num?)?.toDouble(),
      netReceiveAmount: (json['net_receive_amount'] as num?)?.toDouble(),
      rateOperator: json['rate_operator'] as String?,
      mobileRateOperator: json['mobile_rate_operator'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$RateCalcAmountToJson(_RateCalcAmount instance) =>
    <String, dynamic>{
      'pay_amount': instance.payAmount,
      'rate': instance.rate,
      'display_rate': instance.displayRate,
      'net_receive_amount': instance.netReceiveAmount,
      'rate_operator': instance.rateOperator,
      'mobile_rate_operator': instance.mobileRateOperator,
      'remarks': instance.remarks,
    };
