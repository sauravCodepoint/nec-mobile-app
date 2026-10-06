import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'home_bank_or_agent_list_dto.freezed.dart';
part 'home_bank_or_agent_list_dto.g.dart';

HomeBankOrAgentListDto homeBankOrAgentListDtoFromJson(String str) => HomeBankOrAgentListDto.fromJson(json.decode(str));

String homeBankOrAgentListDtoToJson(HomeBankOrAgentListDto data) => json.encode(data.toJson());

@freezed
sealed class HomeBankOrAgentListDto with _$HomeBankOrAgentListDto {
  const factory HomeBankOrAgentListDto({
    @JsonKey(name: "success")
    String? success,
    @JsonKey(name: "data")
    Data? data,
  }) = _HomeBankOrAgentListDto;

  factory HomeBankOrAgentListDto.fromJson(Map<String, dynamic> json) => _$HomeBankOrAgentListDtoFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
    @JsonKey(name: "product_list")
    List<BeneficiaryBankList>? beneficiaryBankList,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
sealed class BeneficiaryBankList with _$BeneficiaryBankList {
  const factory BeneficiaryBankList({
    @JsonKey(name: "code")
    int? code,
    @JsonKey(name: "name")
    String? name,
  }) = _BeneficiaryBankList;

  factory BeneficiaryBankList.fromJson(Map<String, dynamic> json) => _$BeneficiaryBankListFromJson(json);
}
