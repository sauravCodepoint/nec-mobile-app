import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'summary_branches_dto.freezed.dart';
part 'summary_branches_dto.g.dart';

SummaryBranchesDto summaryBranchesDtoFromJson(String str) =>
    SummaryBranchesDto.fromJson(json.decode(str));

String summaryBranchesDtoToJson(SummaryBranchesDto data) =>
    json.encode(data.toJson());

@freezed
sealed class SummaryBranchesDto with _$SummaryBranchesDto {
  const factory SummaryBranchesDto({
    @JsonKey(name: "success") String? success,
    int? statusCode,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "data") Data? data,
  }) = _SummaryBranchesDto;

  factory SummaryBranchesDto.fromJson(Map<String, dynamic> json) =>
      _$SummaryBranchesDtoFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
    @JsonKey(name: "branch_list") List<BranchList>? branchList,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
sealed class BranchList with _$BranchList {
  const factory BranchList({
    @JsonKey(name: "branch_code") String? branchCode,
    @JsonKey(name: "branch_name") String? branchName,
    @JsonKey(name: "address1") String? address1,
    @JsonKey(name: "address2") String? address2,
    @JsonKey(name: "address3") String? address3,
    @JsonKey(name: "phone") String? phone,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "latitude") String? latitude,
    @JsonKey(name: "longitude") String? longitude,
    @JsonKey(name: "working_hours") String? workingHours,
    @JsonKey(name: "app_message1") String? appMessage1,
    @JsonKey(name: "app_message2") String? appMessage2,
    @JsonKey(name: "valid_time_limit") String? validTimeLimit,
  }) = _BranchList;

  factory BranchList.fromJson(Map<String, dynamic> json) =>
      _$BranchListFromJson(json);
}
