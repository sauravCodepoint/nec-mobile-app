import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'complete_profile_state_dto.freezed.dart';
part 'complete_profile_state_dto.g.dart';

CompleteProfileStateDto completeProfileStateDtoFromJson(String str) =>
    CompleteProfileStateDto.fromJson(json.decode(str));

String completeProfileStateDtoToJson(CompleteProfileStateDto data) =>
    json.encode(data.toJson());

@freezed
sealed class CompleteProfileStateDto with _$CompleteProfileStateDto {
  const factory CompleteProfileStateDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "data") Data? data,
  }) = _CompleteProfileStateDto;

  factory CompleteProfileStateDto.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileStateDtoFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
    @JsonKey(name: "state_list") List<StateList>? stateList,
    @JsonKey(name: "app_member_code") int? appMemberCode,
    @JsonKey(name: "economic_activity_id") int? economicActivityId,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
sealed class StateList with _$StateList {
  const factory StateList({
    @JsonKey(name: "code") String? code,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "is_default") bool? isDefault,
    @JsonKey(name: "product_code") int? productCode,
  }) = _StateList;

  factory StateList.fromJson(Map<String, dynamic> json) =>
      _$StateListFromJson(json);
}