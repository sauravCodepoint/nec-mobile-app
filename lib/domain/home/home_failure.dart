import 'package:freezed_annotation/freezed_annotation.dart';

import 'home_mandatory_field_check_dto.dart';

part 'home_failure.freezed.dart';

@freezed
sealed class HomeFailure with _$HomeFailure {
  const factory HomeFailure.unableToFetchAdvertisement() =
  _UnableToFetchAdvertisement;
  const factory HomeFailure.unableToFetchUserData() = _UnableToFetchUserData;
  const factory HomeFailure.unableToFetchBeneficiaries() =
  _UnableToFetchBeneficiaries;
  const factory HomeFailure.unableToFetchRecentTransactions() =
  _UnableToFetchRecentTransactions;
  const factory HomeFailure.unableToFetchDestinationCurrencyList() =
  _UnableToFetchDestinationCurrencyList;
  const factory HomeFailure.unableToFetchTransferTypes() =
  _UnableToFetchTransferTypes;
  const factory HomeFailure.unableToFetchBankOrAgentList() =
  _UnableToFetchBankOrAgentList;
  const factory HomeFailure.unableToFetchAgentList() = _UnableToFetchAgentList;
  /// The agent fetch *succeeded* but the corridor offers no agent, and the
  /// backend did not answer 406 ("agent not required"). Distinct from
  /// [HomeFailure.unableToFetchAgentList] because retrying returns the same
  /// empty answer, so the UI must not offer a retry.
  const factory HomeFailure.agentUnavailable() = _AgentUnavailable;
  const factory HomeFailure.unableToFetchBeneficiaryList() =
  _UnableToFetchBeneficiaryList;
  const factory HomeFailure.unableToDeleteBeneficiary(String message) =
  _UnableToDeleteBeneficiary;
  const factory HomeFailure.missingMandatoryFields(
      String message, {
        HomeMandatoryFieldProduct? product,
      }) = _MissingMandatoryFields;
  const factory HomeFailure.unableToCheckMandatoryFields() =
  _UnableToCheckMandatoryFields;
  const factory HomeFailure.emailNotChanged() = _EmailNotChanged;
  const factory HomeFailure.unableToUpdateEmailAddress(String message) =
  _UnableToUpdateEmailAddress;
  const factory HomeFailure.unableToVerifyEmailOtp(String message) = _UnableToVerifyEmailOtp;
  const factory HomeFailure.serverError() = _ServerError;
}
