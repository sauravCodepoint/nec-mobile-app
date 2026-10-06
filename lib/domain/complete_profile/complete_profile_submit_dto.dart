import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../otp/otp_dto.dart' as session;

part 'complete_profile_submit_dto.freezed.dart';
part 'complete_profile_submit_dto.g.dart';

CompleteProfileSubmitDto completeProfileSubmitDtoFromJson(String str) =>
    CompleteProfileSubmitDto.fromJson(json.decode(str));

String completeProfileSubmitDtoToJson(CompleteProfileSubmitDto data) =>
    json.encode(data.toJson());

/// Response envelope for POST /auth/core-register-user. On success the
/// backend returns freshly-minted session credentials (tokens + user) so
/// the app can sign the user in immediately after registration instead of
/// bouncing them back to Login. Self-contained mirror of the verify-OTP
/// envelope — the complete_profile feature owns its own payload classes and
/// does not depend on the otp feature's DTOs.
@freezed
sealed class CompleteProfileSubmitDto with _$CompleteProfileSubmitDto {
  const factory CompleteProfileSubmitDto({
    @JsonKey(name: "success") String? success,
    @JsonKey(name: "status_code") int? statusCode,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "data") CompleteProfileSubmitData? data,
    @JsonKey(name: "time_stamp") DateTime? timeStamp,
    @JsonKey(name: "version") String? version,
  }) = _CompleteProfileSubmitDto;

  factory CompleteProfileSubmitDto.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileSubmitDtoFromJson(json);
}

@freezed
sealed class CompleteProfileSubmitData with _$CompleteProfileSubmitData {
  const factory CompleteProfileSubmitData({
    @JsonKey(name: "jwt_token") String? jwtToken,
    @JsonKey(name: "jwt_token_exp") DateTime? jwtTokenExp,
    @JsonKey(name: "refresh_token") String? refreshToken,
    @JsonKey(name: "user") CompleteProfileSubmitUser? user,
  }) = _CompleteProfileSubmitData;

  factory CompleteProfileSubmitData.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileSubmitDataFromJson(json);
}

@freezed
sealed class CompleteProfileSubmitUser with _$CompleteProfileSubmitUser {
  const factory CompleteProfileSubmitUser({
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
  }) = _CompleteProfileSubmitUser;

  factory CompleteProfileSubmitUser.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileSubmitUserFromJson(json);
}

extension CompleteProfileSubmitUserX on CompleteProfileSubmitUser {
  /// The session store ([SessionPayload] / SharedPrefs.setUser) persists the
  /// shared session [session.User] type. Both classes serialize with
  /// identical JSON keys, so a JSON round-trip is a lossless conversion and
  /// keeps this single otp-type dependency out of the repository.
  session.User toSessionUser() => session.User.fromJson(toJson());
}