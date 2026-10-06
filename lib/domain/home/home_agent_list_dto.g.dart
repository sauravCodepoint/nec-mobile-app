// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_agent_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeAgentListDto _$HomeAgentListDtoFromJson(Map<String, dynamic> json) =>
    _HomeAgentListDto(
      success: json['success'] as String?,
      data: json['data'] == null
          ? null
          : HomeAgentData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeAgentListDtoToJson(_HomeAgentListDto instance) =>
    <String, dynamic>{'success': instance.success, 'data': instance.data};

_HomeAgentData _$HomeAgentDataFromJson(Map<String, dynamic> json) =>
    _HomeAgentData(
      agentList: (json['beneficiary_agent_list'] as List<dynamic>?)
          ?.map((e) => HomeAgentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeAgentDataToJson(_HomeAgentData instance) =>
    <String, dynamic>{'beneficiary_agent_list': instance.agentList};

_HomeAgentItem _$HomeAgentItemFromJson(Map<String, dynamic> json) =>
    _HomeAgentItem(
      code: json['code'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$HomeAgentItemToJson(_HomeAgentItem instance) =>
    <String, dynamic>{'code': instance.code, 'name': instance.name};
