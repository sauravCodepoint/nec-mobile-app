import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'home_mandatory_field_check_dto.freezed.dart';
part 'home_mandatory_field_check_dto.g.dart';

HomeMandatoryFieldCheckDto homeMandatoryFieldCheckDtoFromJson(String str) => HomeMandatoryFieldCheckDto.fromJson(json.decode(str));

String homeMandatoryFieldCheckDtoToJson(HomeMandatoryFieldCheckDto data) => json.encode(data.toJson());

@freezed
sealed class HomeMandatoryFieldCheckDto with _$HomeMandatoryFieldCheckDto {
  const factory HomeMandatoryFieldCheckDto({
    @JsonKey(name: "success")
    String? success,
    @JsonKey(name: "status_code")
    int? statusCode,
    @JsonKey(name: "message")
    String? message,
    @JsonKey(name: "data")
    HomeMandatoryFieldCheckData? data,
    @JsonKey(name: "time_stamp")
    DateTime? timeStamp,
    @JsonKey(name: "version")
    String? version,
  }) = _HomeMandatoryFieldCheckDto;

  factory HomeMandatoryFieldCheckDto.fromJson(Map<String, dynamic> json) => _$HomeMandatoryFieldCheckDtoFromJson(json);
}

@freezed
sealed class HomeMandatoryFieldCheckData with _$HomeMandatoryFieldCheckData {
  const factory HomeMandatoryFieldCheckData({
    @JsonKey(name: "product")
    HomeMandatoryFieldProduct? product,
  }) = _HomeMandatoryFieldCheckData;

  factory HomeMandatoryFieldCheckData.fromJson(Map<String, dynamic> json) => _$HomeMandatoryFieldCheckDataFromJson(json);
}

@freezed
sealed class HomeMandatoryFieldProduct with _$HomeMandatoryFieldProduct {
  const factory HomeMandatoryFieldProduct({
    @JsonKey(name: "code")
    int? code,
    @JsonKey(name: "name")
    String? name,
  }) = _HomeMandatoryFieldProduct;

  factory HomeMandatoryFieldProduct.fromJson(Map<String, dynamic> json) => _$HomeMandatoryFieldProductFromJson(json);
}
