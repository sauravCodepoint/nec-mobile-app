import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'complete_profile_city_dto.freezed.dart';
part 'complete_profile_city_dto.g.dart';

CompleteProfileCityDto completeProfileCityDtoFromJson(String str) =>
    CompleteProfileCityDto.fromJson(json.decode(str));

String completeProfileCityDtoToJson(CompleteProfileCityDto data) =>
    json.encode(data.toJson());

@freezed
sealed class CompleteProfileCityDto with _$CompleteProfileCityDto {
  const factory CompleteProfileCityDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "data") Data? data,
  }) = _CompleteProfileCityDto;

  factory CompleteProfileCityDto.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileCityDtoFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
    @JsonKey(name: "city_list") List<CityList>? cityList,
    @JsonKey(name: "app_member_code") int? appMemberCode,
    @JsonKey(name: "economic_activity_id") int? economicActivityId,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
sealed class CityList with _$CityList {
  const factory CityList({
    @JsonKey(name: "code") String? code,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "is_default") bool? isDefault,
    @JsonKey(name: "product_code") int? productCode,
  }) = _CityList;

  factory CityList.fromJson(Map<String, dynamic> json) =>
      _$CityListFromJson(json);
}