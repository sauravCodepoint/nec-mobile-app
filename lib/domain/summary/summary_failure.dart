import 'package:freezed_annotation/freezed_annotation.dart';
import 'summary_payment_result_dto.dart';
part 'summary_failure.freezed.dart';

@freezed
abstract class SummaryFailure with _$SummaryFailure {
  const factory SummaryFailure.unableToGetBeneficiary() =
      _UnableToGetBeneficiary;
  const factory SummaryFailure.unableToGetSourceCurrency() =
      _UnableToGetSourceCurrency;
  const factory SummaryFailure.unableToGetDestinationCurrency() =
      _UnableToGetDestinationCurrency;
  const factory SummaryFailure.unableToCalculateSourceAmount() =
      _UnableToCalculateSourceAmount;
  const factory SummaryFailure.unableToCalculateDestinationAmount() =
      _UnableToCalculateDestinationAmount;
  const factory SummaryFailure.unableToGetPaymentMethod() =
      _UnableToGetPaymentMethod;
  const factory SummaryFailure.unableToGetBranches(String? message) =
      _UnableToGetBranches;
  const factory SummaryFailure.unableToCreatePayAtBranchTransaction(
    String? message,
  ) = _UnableToCreatePayAtBranchTransaction;
  const factory SummaryFailure.roundOffRequired(
    SummaryPaymentResultDto result,
  ) = _RoundOffRequired;
  const factory SummaryFailure.unableToConfirmRoundOff(String? message) =
      _UnableToConfirmRoundOff;
  const factory SummaryFailure.serverError() = _ServerError;
}
