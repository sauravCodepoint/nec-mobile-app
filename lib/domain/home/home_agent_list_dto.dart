import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'home_agent_list_dto.freezed.dart';
part 'home_agent_list_dto.g.dart';

HomeAgentListDto homeAgentListDtoFromJson(String str) =>
    HomeAgentListDto.fromJson(json.decode(str));

String homeAgentListDtoToJson(HomeAgentListDto data) =>
    json.encode(data.toJson());

@freezed
sealed class HomeAgentListDto with _$HomeAgentListDto {
  const factory HomeAgentListDto({
    @JsonKey(name: "success")
    String? success,
    @JsonKey(name: "data")
    HomeAgentData? data,
    // Not part of the wire payload — synthesised by HomeRepository when the
    // backend answers 406 to get-beneficiary-agent-Product-combo-list, which
    // means "this corridor needs no agent". That is the ONE case where an
    // empty agent list must not block the send-money flow; a 200 carrying an
    // empty list is a corridor that offers no agent at all, and the two used
    // to be indistinguishable here, so the second silently waved the user
    // through onto an unusable corridor.
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool agentNotRequired,
  }) = _HomeAgentListDto;

  factory HomeAgentListDto.fromJson(Map<String, dynamic> json) =>
      _$HomeAgentListDtoFromJson(json);
}

@freezed
sealed class HomeAgentData with _$HomeAgentData {
  const factory HomeAgentData({
    @JsonKey(name: "beneficiary_agent_list")
    List<HomeAgentItem>? agentList,
  }) = _HomeAgentData;

  factory HomeAgentData.fromJson(Map<String, dynamic> json) =>
      _$HomeAgentDataFromJson(json);
}

@freezed
sealed class HomeAgentItem with _$HomeAgentItem {
  const factory HomeAgentItem({
    // Agent code is an alphanumeric string (e.g. "AE0000"), not a number.
    @JsonKey(name: "code")
    String? code,
    @JsonKey(name: "name")
    String? name,
  }) = _HomeAgentItem;

  factory HomeAgentItem.fromJson(Map<String, dynamic> json) =>
      _$HomeAgentItemFromJson(json);
}