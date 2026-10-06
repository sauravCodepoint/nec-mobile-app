import 'package:dartz/dartz.dart';
import 'summary_beneficiary_by_id_dto.dart';
import 'summary_branches_dto.dart';
import 'summary_calculate_amount_dto.dart';
import 'summary_currency_list_dto.dart';
import 'summary_failure.dart';
import 'summary_payment_method_dto.dart';
import 'summary_payment_result_dto.dart';

abstract class ISummaryFacade {
  Future<Either<SummaryFailure, SummaryBeneficiaryByIdDto>> getBeneficiaryById(
    String beneficiaryId, {
    bool isTranslistRequired = false,
  });
  Future<Either<SummaryFailure, SummaryCurrencyListDto>>
  getHomeSourceCurrencyList();
  Future<Either<SummaryFailure, SummaryCurrencyListDto>>
  getHomeDestinationCurrencyList();
  Future<Either<SummaryFailure, SummaryCalculateAmountDto>>
  getCalculatedSourceAmount({
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String sourceCountryCode,
    required String sourceCurrencyCode,
    required String sourceAmount,
    required String productCode,
    required String transferTypeCode,
    required String paymentMethodCode,
    required String bankOrAgentCode,
    required String agentCode,
  });
  Future<Either<SummaryFailure, SummaryCalculateAmountDto>>
  getCalculatedDestinationAmount({
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String sourceCountryCode,
    required String sourceCurrencyCode,
    required String destinationAmount,
    required String productCode,
    required String transferTypeCode,
    required String paymentMethodCode,
    required String bankOrAgentCode,
    required String agentCode,
  });
  Future<Either<SummaryFailure, SummaryPaymentMethodDto>>
  getSummaryPaymentMethod();
  Future<Either<SummaryFailure, SummaryBranchesDto>> getBranches();

  Future<Either<SummaryFailure, SummaryPaymentResultDto>>
  createPayAtBranchTransaction({
    required int payLocation,
    required double sourceAmount,
    required String sourceCurrencyCode,
    required String sourceCountryCode,
    required double destinationAmount,
    required String destinationCurrencyCode,
    required String destinationCountryCode,
    required double displayRate,
    required String rateOperator,
    required String transferTypeCode,
    required int productCode,
    required String serviceCode,
    required String purposeOfTransactionCode,
    required String purposeOfTransactionName,
    required String sourceOfFundsCode,
    required String sourceOfFundsName,
    required int beneficiaryCode,
    required String beneficiaryId,
    required double commission,
    required double paymentCommission,
    required double fcCommission,
    required double taxPercentage,
    required double taxCollected,
    required double netAmount,
    required String paymentMethodCode,
    String? agentName,
    String? agentCode,
    double? hoRate,
    double? apiBaseCurrencyRate,
    double? apiBaseCurrencyValue,
  });

  Future<Either<SummaryFailure, SummaryPaymentResultDto>> confirmRoundOff({
    required String eId,
    required int transactionReference,
    required int appTransactionReference,
    required bool isReadyToProceed,
  });
}
