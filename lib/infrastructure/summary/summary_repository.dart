import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/summary/i_summary_facade.dart';
import '../../domain/summary/summary_beneficiary_by_id_dto.dart';
import '../../domain/summary/summary_branches_dto.dart';
import '../../domain/summary/summary_calculate_amount_dto.dart';
import '../../domain/summary/summary_currency_list_dto.dart';
import '../../domain/summary/summary_failure.dart';
import '../../domain/summary/summary_payment_method_dto.dart';
import '../../domain/summary/summary_payment_result_dto.dart';

@LazySingleton(as: ISummaryFacade)
class SummaryRepository implements ISummaryFacade {
  final ApiServices _apiServices;
  final SharedPrefs _sharedPrefs;

  SummaryRepository(this._apiServices, this._sharedPrefs);

  @override
  Future<Either<SummaryFailure, SummaryBeneficiaryByIdDto>> getBeneficiaryById(
    String beneficiaryId, {
    bool isTranslistRequired = false,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final response = await _apiServices.getBeneficiaryById(
        token: token,
        beneficiaryId: beneficiaryId,
        isTranslistRequired: isTranslistRequired,
      );
      if (response.isSuccessful) {
        return right(SummaryBeneficiaryByIdDto.fromJson(response.body));
      }
      return left(const SummaryFailure.unableToGetBeneficiary());
    } catch (e) {
      return left(const SummaryFailure.serverError());
    }
  }

  @override
  Future<Either<SummaryFailure, SummaryCurrencyListDto>>
  getHomeSourceCurrencyList() async {
    try {
      final queryParams = {'is_base': true};
      final response = await _apiServices.getCurrencies(
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        return right(SummaryCurrencyListDto.fromJson(response.body));
      }
      return left(const SummaryFailure.unableToGetSourceCurrency());
    } catch (e) {
      return left(const SummaryFailure.serverError());
    }
  }

  @override
  Future<Either<SummaryFailure, SummaryCurrencyListDto>>
  getHomeDestinationCurrencyList() async {
    try {
      final queryParams = {'is_base': false};
      final response = await _apiServices.getCurrencies(
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        return right(SummaryCurrencyListDto.fromJson(response.body));
      }
      return left(const SummaryFailure.unableToGetDestinationCurrency());
    } catch (e) {
      return left(const SummaryFailure.serverError());
    }
  }

  @override
  Future<Either<SummaryFailure, SummaryPaymentMethodDto>>
  getSummaryPaymentMethod() async {
    try {
      final response = await _apiServices.getPaymentModes();
      if (response.isSuccessful) {
        return right(SummaryPaymentMethodDto.fromJson(response.body));
      }
      return left(const SummaryFailure.unableToGetPaymentMethod());
    } catch (e) {
      return left(const SummaryFailure.serverError());
    }
  }

  @override
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
  }) async {
    try {
      final response = await _apiServices.getCalculatedAmount({
        'DestinationCountryCode': destinationCountryCode,
        'DestinationCurrencyCode': destinationCurrencyCode,
        'SourceCountryCode': sourceCountryCode,
        'SourceCurrencyCode': sourceCurrencyCode,
        'SourceAmount': sourceAmount,
        'ProductCode': productCode,
        'TransferModeCode': transferTypeCode,
        'PaymentMode': paymentMethodCode,
        'BankId': bankOrAgentCode,
        'agent_code': agentCode,
      });
      if (response.isSuccessful) {
        return right(SummaryCalculateAmountDto.fromJson(response.body));
      }
      return left(const SummaryFailure.unableToCalculateSourceAmount());
    } catch (e) {
      return left(const SummaryFailure.serverError());
    }
  }

  @override
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
  }) async {
    try {
      final response = await _apiServices.getCalculatedAmount({
        'DestinationCountryCode': destinationCountryCode,
        'DestinationCurrencyCode': destinationCurrencyCode,
        'SourceCountryCode': sourceCountryCode,
        'SourceCurrencyCode': sourceCurrencyCode,
        'DestinationAmount': destinationAmount,
        'ProductCode': productCode,
        'TransferModeCode': transferTypeCode,
        'PaymentMode': paymentMethodCode,
        'BankId': bankOrAgentCode,
        'agent_code': agentCode,
      });
      if (response.isSuccessful) {
        return right(SummaryCalculateAmountDto.fromJson(response.body));
      }
      return left(const SummaryFailure.unableToCalculateDestinationAmount());
    } catch (e) {
      return left(const SummaryFailure.serverError());
    }
  }

  @override
  Future<Either<SummaryFailure, SummaryBranchesDto>> getBranches() async {
    try {
      final response = await _apiServices.getBranches();
      if (response.isSuccessful) {
        return right(SummaryBranchesDto.fromJson(response.body));
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(SummaryFailure.unableToGetBranches(message));
      }
    } catch (e) {
      return left(const SummaryFailure.serverError());
    }
  }

  @override
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
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final body = {
        'pay_location': payLocation,

        'source_amount': sourceAmount,
        'source_currency_code': sourceCurrencyCode,
        'source_country_code': sourceCountryCode,

        'destination_amount': destinationAmount,
        'destination_currency_code': destinationCurrencyCode,
        'destination_country_code': destinationCountryCode,

        'rate': displayRate,
        'rate_operator': rateOperator,
        'h_o_rate': hoRate,

        'transfer_mode_code': transferTypeCode,
        'product_code': productCode,
        'service_code': serviceCode,

        'agent_name': agentName,
        'agent_code': agentCode,

        'purpose_code': purposeOfTransactionCode,
        'purpose': purposeOfTransactionName,

        'income_source_code': sourceOfFundsCode,
        'income_source': sourceOfFundsName,

        'beneficiary_code': beneficiaryCode,
        'beneficiary_eid': beneficiaryId,

        'commission': commission,
        'payment_commission': paymentCommission,
        'f_c_commission': fcCommission,

        'tax_percentage': taxPercentage,
        'tax_collected': taxCollected,

        'net_amount': netAmount,

        'remarks': null,

        'payment': {'payment_mode': paymentMethodCode},

        'api_base_currency_rate': apiBaseCurrencyRate,
        'api_base_currency_value': apiBaseCurrencyValue,
      };
      final response = await _apiServices.postTransaction(
        token: token,
        body: body,
      );
      if (response.isSuccessful) {
        final dto = SummaryPaymentResultDto.fromJson(response.body);
        return right(dto);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        // 409 = backend rounded the amount and asks for confirmation. Its body
        // mirrors the success payload, so parse it into the same DTO.
        if (response.statusCode == 409 && errorMap != null) {
          return left(
            SummaryFailure.roundOffRequired(
              SummaryPaymentResultDto.fromJson(errorMap),
            ),
          );
        }
        final message = errorMap?['message']?.toString() ?? '';
        return left(
          SummaryFailure.unableToCreatePayAtBranchTransaction(message),
        );
      }
    } catch (e) {
      return left(SummaryFailure.serverError());
    }
  }

  @override
  Future<Either<SummaryFailure, SummaryPaymentResultDto>> confirmRoundOff({
    required String eId,
    required int transactionReference,
    required int appTransactionReference,
    required bool isReadyToProceed,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final response = await _apiServices.updateRoundOff(
        token: token,
        body: {
          'e_id': eId,
          'transaction_reference': transactionReference,
          'app_transaction_reference': appTransactionReference,
          'is_ready_to_proceed': isReadyToProceed,
        },
      );
      if (response.isSuccessful) {
        return right(SummaryPaymentResultDto.fromJson(response.body));
      }
      final errorMap = response.error as Map<String, dynamic>?;
      final message = errorMap?['message']?.toString() ?? '';
      return left(SummaryFailure.unableToConfirmRoundOff(message));
    } catch (e) {
      return left(const SummaryFailure.serverError());
    }
  }
}
