import 'package:freezed_annotation/freezed_annotation.dart';
part 'rate_calculator_failure.freezed.dart';

@freezed
sealed class RateCalculatorFailure with _$RateCalculatorFailure {
  const factory RateCalculatorFailure.unableToFetchSourceCurrencyList() =
      _UnableToFetchSourceCurrencyList;
  const factory RateCalculatorFailure.unableToFetchDestinationCurrencyList() =
      _UnableToFetchDestinationCurrencyList;
  const factory RateCalculatorFailure.unableToConvert() = _UnableToConvert;
  const factory RateCalculatorFailure.serverError() = _ServerError;
}