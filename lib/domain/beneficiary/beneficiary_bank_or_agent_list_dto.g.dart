// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_bank_or_agent_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BeneficiaryBankOrAgentListDto _$BeneficiaryBankOrAgentListDtoFromJson(
  Map<String, dynamic> json,
) => _BeneficiaryBankOrAgentListDto(
  success: json['success'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BeneficiaryBankOrAgentListDtoToJson(
  _BeneficiaryBankOrAgentListDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

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
