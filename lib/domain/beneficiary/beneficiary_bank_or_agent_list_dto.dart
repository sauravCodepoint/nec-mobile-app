import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'beneficiary_bank_or_agent_list_dto.freezed.dart';
part 'beneficiary_bank_or_agent_list_dto.g.dart';

BeneficiaryBankOrAgentListDto beneficiaryBankOrAgentListDtoFromJson(String str) => BeneficiaryBankOrAgentListDto.fromJson(json.decode(str));

String beneficiaryBankOrAgentListDtoToJson(BeneficiaryBankOrAgentListDto data) => json.encode(data.toJson());

@freezed
sealed class BeneficiaryBankOrAgentListDto with _$BeneficiaryBankOrAgentListDto {
  const factory BeneficiaryBankOrAgentListDto({
    @JsonKey(name: "success")
    String? success,
    @JsonKey(name: "message")
    String? message,
    @JsonKey(name: "data")
    Data? data,
  }) = _BeneficiaryBankOrAgentListDto;

  factory BeneficiaryBankOrAgentListDto.fromJson(Map<String, dynamic> json) => _$BeneficiaryBankOrAgentListDtoFromJson(json);
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
