// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bank_or_agent_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeBankOrAgentListDto _$HomeBankOrAgentListDtoFromJson(
  Map<String, dynamic> json,
) => _HomeBankOrAgentListDto(
  success: json['success'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeBankOrAgentListDtoToJson(
  _HomeBankOrAgentListDto instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

_Data _$DataFromJson(Map<String, dynamic> json) => _Data(
  beneficiaryBankList: (json['product_list'] as List<dynamic>?)
      ?.map((e) => BeneficiaryBankList.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
  'product_list': instance.beneficiaryBankList,
};

_BeneficiaryBankList _$BeneficiaryBankListFromJson(Map<String, dynamic> json) =>
    _BeneficiaryBankList(
      code: (json['code'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BeneficiaryBankListToJson(
  _BeneficiaryBankList instance,
) => <String, dynamic>{'code': instance.code, 'name': instance.name};
