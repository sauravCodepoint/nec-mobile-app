import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'beneficiary_country_list_dto.freezed.dart';
part 'beneficiary_country_list_dto.g.dart';

BeneficiaryCountryListDto beneficiaryCountryListDtoFromJson(String str) =>
    BeneficiaryCountryListDto.fromJson(json.decode(str));

String beneficiaryCountryListDtoToJson(BeneficiaryCountryListDto data) =>
    json.encode(data.toJson());

@freezed
sealed class BeneficiaryCountryListDto with _$BeneficiaryCountryListDto {
  const factory BeneficiaryCountryListDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "status_code") int? statusCode,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "data") BeneficiaryCountryListData? data,
    @JsonKey(name: "time_stamp") DateTime? timeStamp,
    @JsonKey(name: "version") String? version,
  }) = _BeneficiaryCountryListDto;

  factory BeneficiaryCountryListDto.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryCountryListDtoFromJson(json);
}

@freezed
sealed class BeneficiaryCountryListData with _$BeneficiaryCountryListData {
  const factory BeneficiaryCountryListData({
    @JsonKey(name: "app_member_code") int? appMemberCode,
    @JsonKey(name: "economic_activity_id") int? economicActivityId,
    @JsonKey(name: "country_list") List<BeneficiaryCountryItem>? countryList,
  }) = _BeneficiaryCountryListData;

  factory BeneficiaryCountryListData.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryCountryListDataFromJson(json);
}

@freezed
sealed class BeneficiaryCountryItem with _$BeneficiaryCountryItem {
  const factory BeneficiaryCountryItem({
    @JsonKey(name: "code") String? code,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "decimal_place") int? decimalPlace,
    @JsonKey(name: "combo_name") String? comboName,
  }) = _BeneficiaryCountryItem;

  factory BeneficiaryCountryItem.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryCountryItemFromJson(json);
}