// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_country_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BeneficiaryCountryListDto _$BeneficiaryCountryListDtoFromJson(
  Map<String, dynamic> json,
) => _BeneficiaryCountryListDto(
  success: json['success'] as String?,
  statusCode: (json['status_code'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : BeneficiaryCountryListData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  timeStamp: json['time_stamp'] == null
      ? null
      : DateTime.parse(json['time_stamp'] as String),
  version: json['version'] as String?,
);

Map<String, dynamic> _$BeneficiaryCountryListDtoToJson(
  _BeneficiaryCountryListDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
  'time_stamp': instance.timeStamp?.toIso8601String(),
  'version': instance.version,
};

_BeneficiaryCountryListData _$BeneficiaryCountryListDataFromJson(
  Map<String, dynamic> json,
) => _BeneficiaryCountryListData(
  appMemberCode: (json['app_member_code'] as num?)?.toInt(),
  economicActivityId: (json['economic_activity_id'] as num?)?.toInt(),
  countryList: (json['country_list'] as List<dynamic>?)
      ?.map((e) => BeneficiaryCountryItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BeneficiaryCountryListDataToJson(
  _BeneficiaryCountryListData instance,
) => <String, dynamic>{
  'app_member_code': instance.appMemberCode,
  'economic_activity_id': instance.economicActivityId,
  'country_list': instance.countryList,
};

_BeneficiaryCountryItem _$BeneficiaryCountryItemFromJson(
  Map<String, dynamic> json,
) => _BeneficiaryCountryItem(
  code: json['code'] as String?,
  name: json['name'] as String?,
  decimalPlace: (json['decimal_place'] as num?)?.toInt(),
  comboName: json['combo_name'] as String?,
);

Map<String, dynamic> _$BeneficiaryCountryItemToJson(
  _BeneficiaryCountryItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'decimal_place': instance.decimalPlace,
  'combo_name': instance.comboName,
};
