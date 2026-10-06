import 'package:dartz/dartz.dart';

import 'rate_calculator_calculate_amount_dto.dart';
import 'rate_calculator_currency_list_dto.dart';
import 'rate_calculator_failure.dart';

abstract class IRateCalculatorFacade {
  /// Base currencies (`is_base=true`) — the "from" side of the calculator.
  Future<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>
  getSourceCurrencyList();

  /// Foreign currencies (`is_base=false`) — the "to" side of the calculator.
  Future<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>
  getDestinationCurrencyList();

  /// Convert a known source amount into the destination currency.
  Future<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>>
  getConvertedSourceAmount({
    required String sourceCountryCode,
    required String sourceCurrencyCode,
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String sourceAmount,
  });

  /// Convert a known destination amount back into the source currency.
  Future<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>>
  getConvertedDestinationAmount({
    required String sourceCountryCode,
    required String sourceCurrencyCode,
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String destinationAmount,
  });
}