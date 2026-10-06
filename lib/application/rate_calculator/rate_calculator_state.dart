part of 'rate_calculator_bloc.dart';

@freezed
sealed class RateCalculatorState with _$RateCalculatorState {
  const factory RateCalculatorState({
    // True while the two currency lists load on first entry.
    @Default(true) bool isInitialLoading,
    // True when either currency list failed on load — drives the full-screen
    // retry state instead of a partial calculator.
    @Default(false) bool criticalLoadFailed,
    // Currency options + current selection for each side of the conversion.
    CommonSelectableDto? sourceSelectableDto,
    CommonSelectableDto? destinationSelectableDto,
    CommonSelectableItem? selectedSourceItem,
    CommonSelectableItem? selectedDestinationItem,
    // Raw user input; `isLastInputSource` records which field was edited last so
    // the calculator knows whether to convert forward or solve back.
    @Default('') String lastRawSourceAmount,
    @Default('') String lastRawDestinationAmount,
    @Default(true) bool isLastInputSource,
    // Latest converted amounts + rate. Reuses the shared send-money DTO so the
    // rate card and its formatting extensions render it unchanged.
    required CommonSendMoneyDto commonSendMoneyDto,
    // Backend-authored note for the latest calculation, rendered under the rate
    // card. Empty until a calculation lands, and cleared when one fails.
    @Default('') String remarks,
    // True for the opening rate pull (no field is being edited yet).
    @Default(false) bool isRateLoading,
    @Default(false) bool isSourceAmountCalculating,
    @Default(false) bool isDestinationAmountCalculating,
    // One-shot reactions for the UI listener.
    required Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>
    sourceCurrencyOption,
    required Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>
    destinationCurrencyOption,
    required Option<
      Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>
    >
    calculateOption,
  }) = _RateCalculatorState;

  factory RateCalculatorState.initial() => RateCalculatorState(
    commonSendMoneyDto: CommonSendMoneyDto.empty(),
    sourceCurrencyOption: none(),
    destinationCurrencyOption: none(),
    calculateOption: none(),
  );
}