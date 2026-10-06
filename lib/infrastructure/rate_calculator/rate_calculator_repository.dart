import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/services/api_services.dart';
import '../../domain/rate_calculator/i_rate_calculator_facade.dart';
import '../../domain/rate_calculator/rate_calculator_calculate_amount_dto.dart';
import '../../domain/rate_calculator/rate_calculator_currency_list_dto.dart';
import '../../domain/rate_calculator/rate_calculator_failure.dart';

@LazySingleton(as: IRateCalculatorFacade)
class RateCalculatorRepository implements IRateCalculatorFacade {
  final ApiServices _apiServices;
  RateCalculatorRepository(this._apiServices);

  @override
  Future<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>
  getSourceCurrencyList() async {
    try {
      final response = await _apiServices.getCurrencies(
        queryParams: {'is_base': true},
      );
      if (response.isSuccessful) {
        return right(RateCalculatorCurrencyListDto.fromJson(response.body));
      }
      return left(const RateCalculatorFailure.unableToFetchSourceCurrencyList());
    } catch (e) {
      return left(const RateCalculatorFailure.serverError());
    }
  }

  @override
  Future<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>
  getDestinationCurrencyList() async {
    try {
      final response = await _apiServices.getCurrencies(
        queryParams: {'is_base': false},
      );
      if (response.isSuccessful) {
        return right(RateCalculatorCurrencyListDto.fromJson(response.body));
      }
      return left(
        const RateCalculatorFailure.unableToFetchDestinationCurrencyList(),
      );
    } catch (e) {
      return left(const RateCalculatorFailure.serverError());
    }
  }

  @override
  Future<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>>
  getConvertedSourceAmount({
    required String sourceCountryCode,
    required String sourceCurrencyCode,
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String sourceAmount,
  }) async {
    try {
      // Pure indicative conversion: the calculator carries no corridor context
      // (transfer type / bank / payment mode), so only the currencies, the
      // amount, and a placeholder ProductCode (0) are sent. The backend returns
      // the rate and the converted amount for the currency pair.
      final response = await _apiServices.getCalculatedAmount({
        'DestinationCountryCode': destinationCountryCode,
        'DestinationCurrencyCode': destinationCurrencyCode,
        'SourceCountryCode': sourceCountryCode,
        'SourceCurrencyCode': sourceCurrencyCode,
        'SourceAmount': sourceAmount,
        'ProductCode': '0',
      });
      if (response.isSuccessful) {
        return right(RateCalculatorCalculateAmountDto.fromJson(response.body));
      }
      return left(const RateCalculatorFailure.unableToConvert());
    } catch (e) {
      return left(const RateCalculatorFailure.serverError());
    }
  }

  @override
  Future<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>>
  getConvertedDestinationAmount({
    required String sourceCountryCode,
    required String sourceCurrencyCode,
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String destinationAmount,
  }) async {
    try {
      final response = await _apiServices.getCalculatedAmount({
        'DestinationCountryCode': destinationCountryCode,
        'DestinationCurrencyCode': destinationCurrencyCode,
        'SourceCountryCode': sourceCountryCode,
        'SourceCurrencyCode': sourceCurrencyCode,
        'DestinationAmount': destinationAmount,
        'ProductCode': '0',
      });
      if (response.isSuccessful) {
        return right(RateCalculatorCalculateAmountDto.fromJson(response.body));
      }
      return left(const RateCalculatorFailure.unableToConvert());
    } catch (e) {
      return left(const RateCalculatorFailure.serverError());
    }
  }
}