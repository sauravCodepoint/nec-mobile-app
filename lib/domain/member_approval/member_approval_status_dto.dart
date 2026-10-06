import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'member_approval_status_dto.freezed.dart';
part 'member_approval_status_dto.g.dart';

MemberApprovalStatusDto memberApprovalStatusDtoFromJson(String str) =>
    MemberApprovalStatusDto.fromJson(json.decode(str));

String memberApprovalStatusDtoToJson(MemberApprovalStatusDto data) =>
    json.encode(data.toJson());

@freezed
sealed class MemberApprovalStatusDto with _$MemberApprovalStatusDto {
  const factory MemberApprovalStatusDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "status_code") int? statusCode,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "data") MemberApprovalStatusDataDto? data,
    @JsonKey(name: "time_stamp") DateTime? timeStamp,
    @JsonKey(name: "version") String? version,
  }) = _MemberApprovalStatusDto;

  factory MemberApprovalStatusDto.fromJson(Map<String, dynamic> json) =>
      _$MemberApprovalStatusDtoFromJson(json);
}

@freezed
sealed class MemberApprovalStatusDataDto with _$MemberApprovalStatusDataDto {
  const factory MemberApprovalStatusDataDto({
    @JsonKey(name: "jwt_token") String? jwtToken,
    @JsonKey(name: "jwt_token_exp") DateTime? jwtTokenExp,
    @JsonKey(name: "refresh_token") String? refreshToken,
    @JsonKey(name: "app_member_code") int? appMemberCode,
    @JsonKey(name: "registration_status") String? registrationStatus,
    @JsonKey(name: "user") MemberApprovalUserDto? user,
  }) = _MemberApprovalStatusDataDto;

  factory MemberApprovalStatusDataDto.fromJson(Map<String, dynamic> json) =>
      _$MemberApprovalStatusDataDtoFromJson(json);
}

@freezed
sealed class MemberApprovalUserDto with _$MemberApprovalUserDto {
  const factory MemberApprovalUserDto({
    @JsonKey(name: "e_id") String? eId,
    @JsonKey(name: "mobile_code") int? mobileCode,
    @JsonKey(name: "mobile_number") String? mobileNumber,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "middle_name") String? middleName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "date_of_birth") DateTime? dateOfBirth,
    @JsonKey(name: "gender") String? gender,
    @JsonKey(name: "gender_code") String? genderCode,
    @JsonKey(name: "country_code") String? countryCode,
    @JsonKey(name: "id_number") String? idNumber,
    @JsonKey(name: "country") String? country,
    @JsonKey(name: "state_code") String? stateCode,
    @JsonKey(name: "state") String? state,
    @JsonKey(name: "city_id") String? cityId,
    @JsonKey(name: "city") String? city,
    @JsonKey(name: "address1") String? address1,
    @JsonKey(name: "address2") String? address2,
    @JsonKey(name: "nationality_code") String? nationalityCode,
    @JsonKey(name: "nationality") String? nationality,
    @JsonKey(name: "country_of_birth_code") String? countryOfBirthCode,
    @JsonKey(name: "country_of_birth") String? countryOfBirth,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "residency_type") String? residencyType,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "status_description") String? statusDescription,
    @JsonKey(name: "is_user_registered") bool? isUserRegistered,
    @JsonKey(name: "is_k_y_c_registered") bool? isKYCRegistered,
    @JsonKey(name: "is_approved") bool? isApproved,
    @JsonKey(name: "is_m_p_i_n_created") bool? isMPINCreated,
    @JsonKey(name: "app_member_code") int? appMemberCode,
    @JsonKey(name: "member_code") int? memberCode,
    @JsonKey(name: "is_bio_metric_login_enabled") bool? isBioMetricLoginEnabled,
    @JsonKey(name: "expected_turnover") int? expectedTurnover,
    @JsonKey(name: "expected_transaction_count") int? expectedTransactionCount,
    @JsonKey(name: "expected_transaction_count_range")
    String? expectedTransactionCountRange,
    @JsonKey(name: "mobile_number_with_out_code")
    String? mobileNumberWithOutCode,
    @JsonKey(name: "salutation") String? salutation,
    @JsonKey(name: "employer") String? employer,
    @JsonKey(name: "place_of_birth") String? placeOfBirth,
    @JsonKey(name: "economic_activity_code") String? economicActivityCode,
    @JsonKey(name: "member_group_id") int? memberGroupId,
    @JsonKey(name: "present_address2") String? presentAddress2,
    @JsonKey(name: "risk_type_code") String? riskTypeCode,
    @JsonKey(name: "member_group") String? memberGroup,
    @JsonKey(name: "account_number") String? accountNumber,
    @JsonKey(name: "bank") String? bank,
    @JsonKey(name: "bank_name") String? bankName,
    @JsonKey(name: "risk_type_name") String? riskTypeName,
    @JsonKey(name: "salutation_name") String? salutationName,
    @JsonKey(name: "land_mark") String? landMark,
  }) = _MemberApprovalUserDto;

  factory MemberApprovalUserDto.fromJson(Map<String, dynamic> json) =>
      _$MemberApprovalUserDtoFromJson(json);
}
