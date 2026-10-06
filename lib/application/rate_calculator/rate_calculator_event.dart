part of 'rate_calculator_bloc.dart';

@freezed
sealed class RateCalculatorEvent with _$RateCalculatorEvent {
  /// Loads the source/destination currency lists and pulls the opening rate.
  /// Re-runnable for pull-to-retry; the current selection is restored if the
  /// same currency is still present in the reloaded list.
  const factory RateCalculatorEvent.initialize() = _InitializeEvent;
  const factory RateCalculatorEvent.sourceCurrencySelected({
    required CommonSelectableItem item,
  }) = _SourceCurrencySelectedEvent;
  const factory RateCalculatorEvent.destinationCurrencySelected({
    required CommonSelectableItem item,
  }) = _DestinationCurrencySelectedEvent;
  const factory RateCalculatorEvent.sourceAmountChanged({
    required String amount,
  }) = _SourceAmountChangedEvent;
  const factory RateCalculatorEvent.destinationAmountChanged({
    required String amount,
  }) = _DestinationAmountChangedEvent;
  const factory RateCalculatorEvent.refreshRate() = _RefreshRateEvent;
}