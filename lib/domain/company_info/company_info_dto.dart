import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info_dto.freezed.dart';
part 'company_info_dto.g.dart';

@freezed
sealed class CompanyInfoDto with _$CompanyInfoDto {
  const factory CompanyInfoDto({
    @JsonKey(name: 'success') String? success,
    int? statusCode,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'data') String? data,
  }) = _CompanyInfoDto;

  factory CompanyInfoDto.fromJson(Map<String, dynamic> json) =>
      _$CompanyInfoDtoFromJson(json);
}