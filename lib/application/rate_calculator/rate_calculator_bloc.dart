import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/common/common_selectable_dto.dart';
import '../../domain/common/common_send_money_dto.dart';
import '../../domain/rate_calculator/i_rate_calculator_facade.dart';
import '../../domain/rate_calculator/rate_calculator_calculate_amount_dto.dart';
import '../../domain/rate_calculator/rate_calculator_currency_list_dto.dart';
import '../../domain/rate_calculator/rate_calculator_failure.dart';

part 'rate_calculator_event.dart';
part 'rate_calculator_state.dart';
part 'rate_calculator_bloc.freezed.dart';

@injectable
class RateCalculatorBloc extends Bloc<RateCalculatorEvent, RateCalculatorState> {
  final IRateCalculatorFacade _facade;

  RateCalculatorBloc(this._facade) : super(RateCalculatorState.initial()) {
    on<_InitializeEvent>(_initialize);
    on<_SourceCurrencySelectedEvent>(_sourceCurrencySelected);
    on<_DestinationCurrencySelectedEvent>(_destinationCurrencySelected);
    on<_SourceAmountChangedEvent>(_sourceAmountChanged);
    on<_DestinationAmountChangedEvent>(_destinationAmountChanged);
    on<_RefreshRateEvent>(
      _onRefreshRate,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );
  }

  EventTransformer<T> _debounce<T>(Duration duration) =>
          (events, mapper) => events.debounceTime(duration).switchMap(mapper);

  CommonSelectableItem _toItem(RateCurrencyItem e) => CommonSelectableItem(
    leading: e.flagUrl,
    titleName: e.countryName ?? '',
    titleCode: e.countryCode ?? '',
    trailingName: e.currencyName ?? '',
    trailingCode: e.currencyCode ?? '',
    decimalPlaces: e.decimalPlaces,
  );

  FutureOr<void> _initialize(
      _InitializeEvent event,
      Emitter<RateCalculatorState> emit,
      ) async {
    emit(
      state.copyWith(
        isInitialLoading: true,
        criticalLoadFailed: false,
        sourceCurrencyOption: none(),
        destinationCurrencyOption: none(),
        // Reset any carried-over conversion so re-entering the screen starts
        // clean: the bloc is a top-level singleton, so without this the stale
        // typed amounts would be recomputed by the opening refreshRate and
        // repopulate the (freshly-empty) amount fields.
        lastRawSourceAmount: '',
        lastRawDestinationAmount: '',
        isLastInputSource: true,
        commonSendMoneyDto: CommonSendMoneyDto.empty(),
        calculateOption: none(),
      ),
    );

    final (sourceResult, destResult) = await (
    _facade.getSourceCurrencyList(),
    _facade.getDestinationCurrencyList(),
    ).wait;

    CommonSelectableDto? sourceDto;
    CommonSelectableItem? selectedSource;
    sourceResult.fold((_) {}, (dto) {
      final list = dto.data?.currencyList ?? [];
      if (list.isEmpty) return;
      sourceDto = CommonSelectableDto(
        data: CommonSelectableData(list: list.map(_toItem).toList()),
      );
      // Restore the previous selection on refresh, else default to the first.
      final prev = state.selectedSourceItem;
      final match = prev == null
          ? null
          : list.firstWhereOrNull(
            (e) =>
        e.countryCode == prev.titleCode &&
            e.currencyCode == prev.trailingCode,
      );
      selectedSource = _toItem(match ?? list.first);
    });

    CommonSelectableDto? destDto;
    CommonSelectableItem? selectedDest;
    destResult.fold((_) {}, (dto) {
      final list = dto.data?.currencyList ?? [];
      if (list.isEmpty) return;
      destDto = CommonSelectableDto(
        data: CommonSelectableData(list: list.map(_toItem).toList()),
      );
      final prev = state.selectedDestinationItem;
      final match = prev == null
          ? null
          : list.firstWhereOrNull(
            (e) =>
        e.countryCode == prev.titleCode &&
            e.currencyCode == prev.trailingCode,
      );
      selectedDest = _toItem(match ?? list.first);
    });

    final criticalLoadFailed = sourceResult.isLeft() || destResult.isLeft();

    emit(
      state.copyWith(
        isInitialLoading: false,
        criticalLoadFailed: criticalLoadFailed,
        sourceSelectableDto: sourceDto ?? state.sourceSelectableDto,
        destinationSelectableDto: destDto ?? state.destinationSelectableDto,
        selectedSourceItem: selectedSource ?? state.selectedSourceItem,
        selectedDestinationItem: selectedDest ?? state.selectedDestinationItem,
        sourceCurrencyOption: some(sourceResult),
        destinationCurrencyOption: some(destResult),
      ),
    );
    // Drop the one-shot options so a later unrelated emit can't replay the
    // load-failure toast.
    emit(
      state.copyWith(
        sourceCurrencyOption: none(),
        destinationCurrencyOption: none(),
      ),
    );

    // Pull an initial rate for the default pair so the screen shows a live
    // rate before the user types anything.
    if (!criticalLoadFailed) {
      emit(state.copyWith(isRateLoading: true));
      add(const RateCalculatorEvent.refreshRate());
    }
  }

  FutureOr<void> _sourceCurrencySelected(
      _SourceCurrencySelectedEvent event,
      Emitter<RateCalculatorState> emit,
      ) async {
    if (state.selectedSourceItem?.titleCode == event.item.titleCode &&
        state.selectedSourceItem?.trailingCode == event.item.trailingCode) {
      return;
    }
    emit(state.copyWith(selectedSourceItem: event.item));
    add(const RateCalculatorEvent.refreshRate());
  }

  FutureOr<void> _destinationCurrencySelected(
      _DestinationCurrencySelectedEvent event,
      Emitter<RateCalculatorState> emit,
      ) async {
    if (state.selectedDestinationItem?.titleCode == event.item.titleCode &&
        state.selectedDestinationItem?.trailingCode == event.item.trailingCode) {
      return;
    }
    emit(state.copyWith(selectedDestinationItem: event.item));
    add(const RateCalculatorEvent.refreshRate());
  }

  FutureOr<void> _sourceAmountChanged(
      _SourceAmountChangedEvent event,
      Emitter<RateCalculatorState> emit,
      ) async {
    emit(
      state.copyWith(
        lastRawSourceAmount: event.amount,
        isLastInputSource: true,
        isSourceAmountCalculating: false,
        isDestinationAmountCalculating: true,
        calculateOption: none(),
      ),
    );
    add(const RateCalculatorEvent.refreshRate());
  }

  FutureOr<void> _destinationAmountChanged(
      _DestinationAmountChangedEvent event,
      Emitter<RateCalculatorState> emit,
      ) async {
    emit(
      state.copyWith(
        lastRawDestinationAmount: event.amount,
        isLastInputSource: false,
        isSourceAmountCalculating: true,
        isDestinationAmountCalculating: false,
        calculateOption: none(),
      ),
    );
    add(const RateCalculatorEvent.refreshRate());
  }

  FutureOr<void> _onRefreshRate(
      _RefreshRateEvent event,
      Emitter<RateCalculatorState> emit,
      ) async {
    final source = state.selectedSourceItem;
    final dest = state.selectedDestinationItem;
    final sourceCountry = source?.titleCode ?? '';
    final sourceCurrency = source?.trailingCode ?? '';
    final destCountry = dest?.titleCode ?? '';
    final destCurrency = dest?.trailingCode ?? '';

    if (sourceCountry.isEmpty ||
        sourceCurrency.isEmpty ||
        destCountry.isEmpty ||
        destCurrency.isEmpty) {
      emit(
        state.copyWith(
          isRateLoading: false,
          isSourceAmountCalculating: false,
          isDestinationAmountCalculating: false,
        ),
      );
      return;
    }

    // When the user last typed in the destination field we solve back for the
    // source amount; otherwise we convert the source amount forward.
    final useDestination =
        !state.isLastInputSource && state.lastRawDestinationAmount.isNotEmpty;
    final rawAmount = useDestination
        ? state.lastRawDestinationAmount
        : state.lastRawSourceAmount;
    final safeAmount = rawAmount.trim().isEmpty ? '0' : rawAmount;

    emit(
      state.copyWith(
        isSourceAmountCalculating: useDestination,
        isDestinationAmountCalculating: !useDestination,
        calculateOption: none(),
      ),
    );

    final result = useDestination
        ? await _facade.getConvertedDestinationAmount(
      sourceCountryCode: sourceCountry,
      sourceCurrencyCode: sourceCurrency,
      destinationCountryCode: destCountry,
      destinationCurrencyCode: destCurrency,
      destinationAmount: safeAmount,
    )
        : await _facade.getConvertedSourceAmount(
      sourceCountryCode: sourceCountry,
      sourceCurrencyCode: sourceCurrency,
      destinationCountryCode: destCountry,
      destinationCurrencyCode: destCurrency,
      sourceAmount: safeAmount,
    );

    emit(
      result.fold(
        (f) => state.copyWith(
          isRateLoading: false,
          isSourceAmountCalculating: false,
          isDestinationAmountCalculating: false,
          // Drop the stale computed result so the failed side clears.
          commonSendMoneyDto: CommonSendMoneyDto.empty(),
          remarks: '',
          calculateOption: some(left(f)),
        ),
        (dto) {
          final amount = dto.data?.amount;
          return state.copyWith(
            isRateLoading: false,
            isSourceAmountCalculating: false,
            isDestinationAmountCalculating: false,
            commonSendMoneyDto: CommonSendMoneyDto(
              // pay_amount is the principal that converts; net_receive_amount is
              // its value in the destination currency.
              sourceAmount: amount?.payAmount ?? 0.0,
              destinationAmount: amount?.netReceiveAmount ?? 0.0,
              displayRate: amount?.displayRate ?? amount?.rate ?? 0.0,
              rate: amount?.rate ?? 0.0,
              rateOperator: amount?.mobileRateOperator ?? amount?.rateOperator,
            ),
            remarks: amount?.remarks?.trim() ?? '',
            calculateOption: some(right(dto)),
          );
        },
      ),
    );
  }
}