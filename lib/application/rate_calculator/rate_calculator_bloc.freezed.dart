// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate_calculator_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RateCalculatorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateCalculatorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RateCalculatorEvent()';
}


}

/// @nodoc
class $RateCalculatorEventCopyWith<$Res>  {
$RateCalculatorEventCopyWith(RateCalculatorEvent _, $Res Function(RateCalculatorEvent) __);
}


/// Adds pattern-matching-related methods to [RateCalculatorEvent].
extension RateCalculatorEventPatterns on RateCalculatorEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InitializeEvent value)?  initialize,TResult Function( _SourceCurrencySelectedEvent value)?  sourceCurrencySelected,TResult Function( _DestinationCurrencySelectedEvent value)?  destinationCurrencySelected,TResult Function( _SourceAmountChangedEvent value)?  sourceAmountChanged,TResult Function( _DestinationAmountChangedEvent value)?  destinationAmountChanged,TResult Function( _RefreshRateEvent value)?  refreshRate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitializeEvent() when initialize != null:
return initialize(_that);case _SourceCurrencySelectedEvent() when sourceCurrencySelected != null:
return sourceCurrencySelected(_that);case _DestinationCurrencySelectedEvent() when destinationCurrencySelected != null:
return destinationCurrencySelected(_that);case _SourceAmountChangedEvent() when sourceAmountChanged != null:
return sourceAmountChanged(_that);case _DestinationAmountChangedEvent() when destinationAmountChanged != null:
return destinationAmountChanged(_that);case _RefreshRateEvent() when refreshRate != null:
return refreshRate(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InitializeEvent value)  initialize,required TResult Function( _SourceCurrencySelectedEvent value)  sourceCurrencySelected,required TResult Function( _DestinationCurrencySelectedEvent value)  destinationCurrencySelected,required TResult Function( _SourceAmountChangedEvent value)  sourceAmountChanged,required TResult Function( _DestinationAmountChangedEvent value)  destinationAmountChanged,required TResult Function( _RefreshRateEvent value)  refreshRate,}){
final _that = this;
switch (_that) {
case _InitializeEvent():
return initialize(_that);case _SourceCurrencySelectedEvent():
return sourceCurrencySelected(_that);case _DestinationCurrencySelectedEvent():
return destinationCurrencySelected(_that);case _SourceAmountChangedEvent():
return sourceAmountChanged(_that);case _DestinationAmountChangedEvent():
return destinationAmountChanged(_that);case _RefreshRateEvent():
return refreshRate(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InitializeEvent value)?  initialize,TResult? Function( _SourceCurrencySelectedEvent value)?  sourceCurrencySelected,TResult? Function( _DestinationCurrencySelectedEvent value)?  destinationCurrencySelected,TResult? Function( _SourceAmountChangedEvent value)?  sourceAmountChanged,TResult? Function( _DestinationAmountChangedEvent value)?  destinationAmountChanged,TResult? Function( _RefreshRateEvent value)?  refreshRate,}){
final _that = this;
switch (_that) {
case _InitializeEvent() when initialize != null:
return initialize(_that);case _SourceCurrencySelectedEvent() when sourceCurrencySelected != null:
return sourceCurrencySelected(_that);case _DestinationCurrencySelectedEvent() when destinationCurrencySelected != null:
return destinationCurrencySelected(_that);case _SourceAmountChangedEvent() when sourceAmountChanged != null:
return sourceAmountChanged(_that);case _DestinationAmountChangedEvent() when destinationAmountChanged != null:
return destinationAmountChanged(_that);case _RefreshRateEvent() when refreshRate != null:
return refreshRate(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialize,TResult Function( CommonSelectableItem item)?  sourceCurrencySelected,TResult Function( CommonSelectableItem item)?  destinationCurrencySelected,TResult Function( String amount)?  sourceAmountChanged,TResult Function( String amount)?  destinationAmountChanged,TResult Function()?  refreshRate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitializeEvent() when initialize != null:
return initialize();case _SourceCurrencySelectedEvent() when sourceCurrencySelected != null:
return sourceCurrencySelected(_that.item);case _DestinationCurrencySelectedEvent() when destinationCurrencySelected != null:
return destinationCurrencySelected(_that.item);case _SourceAmountChangedEvent() when sourceAmountChanged != null:
return sourceAmountChanged(_that.amount);case _DestinationAmountChangedEvent() when destinationAmountChanged != null:
return destinationAmountChanged(_that.amount);case _RefreshRateEvent() when refreshRate != null:
return refreshRate();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialize,required TResult Function( CommonSelectableItem item)  sourceCurrencySelected,required TResult Function( CommonSelectableItem item)  destinationCurrencySelected,required TResult Function( String amount)  sourceAmountChanged,required TResult Function( String amount)  destinationAmountChanged,required TResult Function()  refreshRate,}) {final _that = this;
switch (_that) {
case _InitializeEvent():
return initialize();case _SourceCurrencySelectedEvent():
return sourceCurrencySelected(_that.item);case _DestinationCurrencySelectedEvent():
return destinationCurrencySelected(_that.item);case _SourceAmountChangedEvent():
return sourceAmountChanged(_that.amount);case _DestinationAmountChangedEvent():
return destinationAmountChanged(_that.amount);case _RefreshRateEvent():
return refreshRate();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialize,TResult? Function( CommonSelectableItem item)?  sourceCurrencySelected,TResult? Function( CommonSelectableItem item)?  destinationCurrencySelected,TResult? Function( String amount)?  sourceAmountChanged,TResult? Function( String amount)?  destinationAmountChanged,TResult? Function()?  refreshRate,}) {final _that = this;
switch (_that) {
case _InitializeEvent() when initialize != null:
return initialize();case _SourceCurrencySelectedEvent() when sourceCurrencySelected != null:
return sourceCurrencySelected(_that.item);case _DestinationCurrencySelectedEvent() when destinationCurrencySelected != null:
return destinationCurrencySelected(_that.item);case _SourceAmountChangedEvent() when sourceAmountChanged != null:
return sourceAmountChanged(_that.amount);case _DestinationAmountChangedEvent() when destinationAmountChanged != null:
return destinationAmountChanged(_that.amount);case _RefreshRateEvent() when refreshRate != null:
return refreshRate();case _:
  return null;

}
}

}

/// @nodoc


class _InitializeEvent implements RateCalculatorEvent {
  const _InitializeEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitializeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RateCalculatorEvent.initialize()';
}


}




/// @nodoc


class _SourceCurrencySelectedEvent implements RateCalculatorEvent {
  const _SourceCurrencySelectedEvent({required this.item});
  

 final  CommonSelectableItem item;

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceCurrencySelectedEventCopyWith<_SourceCurrencySelectedEvent> get copyWith => __$SourceCurrencySelectedEventCopyWithImpl<_SourceCurrencySelectedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceCurrencySelectedEvent&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'RateCalculatorEvent.sourceCurrencySelected(item: $item)';
}


}

/// @nodoc
abstract mixin class _$SourceCurrencySelectedEventCopyWith<$Res> implements $RateCalculatorEventCopyWith<$Res> {
  factory _$SourceCurrencySelectedEventCopyWith(_SourceCurrencySelectedEvent value, $Res Function(_SourceCurrencySelectedEvent) _then) = __$SourceCurrencySelectedEventCopyWithImpl;
@useResult
$Res call({
 CommonSelectableItem item
});


$CommonSelectableItemCopyWith<$Res> get item;

}
/// @nodoc
class __$SourceCurrencySelectedEventCopyWithImpl<$Res>
    implements _$SourceCurrencySelectedEventCopyWith<$Res> {
  __$SourceCurrencySelectedEventCopyWithImpl(this._self, this._then);

  final _SourceCurrencySelectedEvent _self;
  final $Res Function(_SourceCurrencySelectedEvent) _then;

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_SourceCurrencySelectedEvent(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem,
  ));
}

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res> get item {
  
  return $CommonSelectableItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

/// @nodoc


class _DestinationCurrencySelectedEvent implements RateCalculatorEvent {
  const _DestinationCurrencySelectedEvent({required this.item});
  

 final  CommonSelectableItem item;

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DestinationCurrencySelectedEventCopyWith<_DestinationCurrencySelectedEvent> get copyWith => __$DestinationCurrencySelectedEventCopyWithImpl<_DestinationCurrencySelectedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DestinationCurrencySelectedEvent&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'RateCalculatorEvent.destinationCurrencySelected(item: $item)';
}


}

/// @nodoc
abstract mixin class _$DestinationCurrencySelectedEventCopyWith<$Res> implements $RateCalculatorEventCopyWith<$Res> {
  factory _$DestinationCurrencySelectedEventCopyWith(_DestinationCurrencySelectedEvent value, $Res Function(_DestinationCurrencySelectedEvent) _then) = __$DestinationCurrencySelectedEventCopyWithImpl;
@useResult
$Res call({
 CommonSelectableItem item
});


$CommonSelectableItemCopyWith<$Res> get item;

}
/// @nodoc
class __$DestinationCurrencySelectedEventCopyWithImpl<$Res>
    implements _$DestinationCurrencySelectedEventCopyWith<$Res> {
  __$DestinationCurrencySelectedEventCopyWithImpl(this._self, this._then);

  final _DestinationCurrencySelectedEvent _self;
  final $Res Function(_DestinationCurrencySelectedEvent) _then;

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_DestinationCurrencySelectedEvent(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem,
  ));
}

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res> get item {
  
  return $CommonSelectableItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

/// @nodoc


class _SourceAmountChangedEvent implements RateCalculatorEvent {
  const _SourceAmountChangedEvent({required this.amount});
  

 final  String amount;

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceAmountChangedEventCopyWith<_SourceAmountChangedEvent> get copyWith => __$SourceAmountChangedEventCopyWithImpl<_SourceAmountChangedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceAmountChangedEvent&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'RateCalculatorEvent.sourceAmountChanged(amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$SourceAmountChangedEventCopyWith<$Res> implements $RateCalculatorEventCopyWith<$Res> {
  factory _$SourceAmountChangedEventCopyWith(_SourceAmountChangedEvent value, $Res Function(_SourceAmountChangedEvent) _then) = __$SourceAmountChangedEventCopyWithImpl;
@useResult
$Res call({
 String amount
});




}
/// @nodoc
class __$SourceAmountChangedEventCopyWithImpl<$Res>
    implements _$SourceAmountChangedEventCopyWith<$Res> {
  __$SourceAmountChangedEventCopyWithImpl(this._self, this._then);

  final _SourceAmountChangedEvent _self;
  final $Res Function(_SourceAmountChangedEvent) _then;

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(_SourceAmountChangedEvent(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DestinationAmountChangedEvent implements RateCalculatorEvent {
  const _DestinationAmountChangedEvent({required this.amount});
  

 final  String amount;

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DestinationAmountChangedEventCopyWith<_DestinationAmountChangedEvent> get copyWith => __$DestinationAmountChangedEventCopyWithImpl<_DestinationAmountChangedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DestinationAmountChangedEvent&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'RateCalculatorEvent.destinationAmountChanged(amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$DestinationAmountChangedEventCopyWith<$Res> implements $RateCalculatorEventCopyWith<$Res> {
  factory _$DestinationAmountChangedEventCopyWith(_DestinationAmountChangedEvent value, $Res Function(_DestinationAmountChangedEvent) _then) = __$DestinationAmountChangedEventCopyWithImpl;
@useResult
$Res call({
 String amount
});




}
/// @nodoc
class __$DestinationAmountChangedEventCopyWithImpl<$Res>
    implements _$DestinationAmountChangedEventCopyWith<$Res> {
  __$DestinationAmountChangedEventCopyWithImpl(this._self, this._then);

  final _DestinationAmountChangedEvent _self;
  final $Res Function(_DestinationAmountChangedEvent) _then;

/// Create a copy of RateCalculatorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(_DestinationAmountChangedEvent(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RefreshRateEvent implements RateCalculatorEvent {
  const _RefreshRateEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshRateEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RateCalculatorEvent.refreshRate()';
}


}




/// @nodoc
mixin _$RateCalculatorState {

 bool get isInitialLoading; bool get criticalLoadFailed; CommonSelectableDto? get sourceSelectableDto; CommonSelectableDto? get destinationSelectableDto; CommonSelectableItem? get selectedSourceItem; CommonSelectableItem? get selectedDestinationItem; String get lastRawSourceAmount; String get lastRawDestinationAmount; bool get isLastInputSource; CommonSendMoneyDto get commonSendMoneyDto; String get remarks; bool get isRateLoading; bool get isSourceAmountCalculating; bool get isDestinationAmountCalculating; Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> get sourceCurrencyOption; Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> get destinationCurrencyOption; Option<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>> get calculateOption;
/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateCalculatorStateCopyWith<RateCalculatorState> get copyWith => _$RateCalculatorStateCopyWithImpl<RateCalculatorState>(this as RateCalculatorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateCalculatorState&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.criticalLoadFailed, criticalLoadFailed) || other.criticalLoadFailed == criticalLoadFailed)&&(identical(other.sourceSelectableDto, sourceSelectableDto) || other.sourceSelectableDto == sourceSelectableDto)&&(identical(other.destinationSelectableDto, destinationSelectableDto) || other.destinationSelectableDto == destinationSelectableDto)&&(identical(other.selectedSourceItem, selectedSourceItem) || other.selectedSourceItem == selectedSourceItem)&&(identical(other.selectedDestinationItem, selectedDestinationItem) || other.selectedDestinationItem == selectedDestinationItem)&&(identical(other.lastRawSourceAmount, lastRawSourceAmount) || other.lastRawSourceAmount == lastRawSourceAmount)&&(identical(other.lastRawDestinationAmount, lastRawDestinationAmount) || other.lastRawDestinationAmount == lastRawDestinationAmount)&&(identical(other.isLastInputSource, isLastInputSource) || other.isLastInputSource == isLastInputSource)&&(identical(other.commonSendMoneyDto, commonSendMoneyDto) || other.commonSendMoneyDto == commonSendMoneyDto)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.isRateLoading, isRateLoading) || other.isRateLoading == isRateLoading)&&(identical(other.isSourceAmountCalculating, isSourceAmountCalculating) || other.isSourceAmountCalculating == isSourceAmountCalculating)&&(identical(other.isDestinationAmountCalculating, isDestinationAmountCalculating) || other.isDestinationAmountCalculating == isDestinationAmountCalculating)&&(identical(other.sourceCurrencyOption, sourceCurrencyOption) || other.sourceCurrencyOption == sourceCurrencyOption)&&(identical(other.destinationCurrencyOption, destinationCurrencyOption) || other.destinationCurrencyOption == destinationCurrencyOption)&&(identical(other.calculateOption, calculateOption) || other.calculateOption == calculateOption));
}


@override
int get hashCode => Object.hash(runtimeType,isInitialLoading,criticalLoadFailed,sourceSelectableDto,destinationSelectableDto,selectedSourceItem,selectedDestinationItem,lastRawSourceAmount,lastRawDestinationAmount,isLastInputSource,commonSendMoneyDto,remarks,isRateLoading,isSourceAmountCalculating,isDestinationAmountCalculating,sourceCurrencyOption,destinationCurrencyOption,calculateOption);

@override
String toString() {
  return 'RateCalculatorState(isInitialLoading: $isInitialLoading, criticalLoadFailed: $criticalLoadFailed, sourceSelectableDto: $sourceSelectableDto, destinationSelectableDto: $destinationSelectableDto, selectedSourceItem: $selectedSourceItem, selectedDestinationItem: $selectedDestinationItem, lastRawSourceAmount: $lastRawSourceAmount, lastRawDestinationAmount: $lastRawDestinationAmount, isLastInputSource: $isLastInputSource, commonSendMoneyDto: $commonSendMoneyDto, remarks: $remarks, isRateLoading: $isRateLoading, isSourceAmountCalculating: $isSourceAmountCalculating, isDestinationAmountCalculating: $isDestinationAmountCalculating, sourceCurrencyOption: $sourceCurrencyOption, destinationCurrencyOption: $destinationCurrencyOption, calculateOption: $calculateOption)';
}


}

/// @nodoc
abstract mixin class $RateCalculatorStateCopyWith<$Res>  {
  factory $RateCalculatorStateCopyWith(RateCalculatorState value, $Res Function(RateCalculatorState) _then) = _$RateCalculatorStateCopyWithImpl;
@useResult
$Res call({
 bool isInitialLoading, bool criticalLoadFailed, CommonSelectableDto? sourceSelectableDto, CommonSelectableDto? destinationSelectableDto, CommonSelectableItem? selectedSourceItem, CommonSelectableItem? selectedDestinationItem, String lastRawSourceAmount, String lastRawDestinationAmount, bool isLastInputSource, CommonSendMoneyDto commonSendMoneyDto, String remarks, bool isRateLoading, bool isSourceAmountCalculating, bool isDestinationAmountCalculating, Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> sourceCurrencyOption, Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> destinationCurrencyOption, Option<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>> calculateOption
});


$CommonSelectableDtoCopyWith<$Res>? get sourceSelectableDto;$CommonSelectableDtoCopyWith<$Res>? get destinationSelectableDto;$CommonSelectableItemCopyWith<$Res>? get selectedSourceItem;$CommonSelectableItemCopyWith<$Res>? get selectedDestinationItem;$CommonSendMoneyDtoCopyWith<$Res> get commonSendMoneyDto;

}
/// @nodoc
class _$RateCalculatorStateCopyWithImpl<$Res>
    implements $RateCalculatorStateCopyWith<$Res> {
  _$RateCalculatorStateCopyWithImpl(this._self, this._then);

  final RateCalculatorState _self;
  final $Res Function(RateCalculatorState) _then;

/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isInitialLoading = null,Object? criticalLoadFailed = null,Object? sourceSelectableDto = freezed,Object? destinationSelectableDto = freezed,Object? selectedSourceItem = freezed,Object? selectedDestinationItem = freezed,Object? lastRawSourceAmount = null,Object? lastRawDestinationAmount = null,Object? isLastInputSource = null,Object? commonSendMoneyDto = null,Object? remarks = null,Object? isRateLoading = null,Object? isSourceAmountCalculating = null,Object? isDestinationAmountCalculating = null,Object? sourceCurrencyOption = null,Object? destinationCurrencyOption = null,Object? calculateOption = null,}) {
  return _then(_self.copyWith(
isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,criticalLoadFailed: null == criticalLoadFailed ? _self.criticalLoadFailed : criticalLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,sourceSelectableDto: freezed == sourceSelectableDto ? _self.sourceSelectableDto : sourceSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,destinationSelectableDto: freezed == destinationSelectableDto ? _self.destinationSelectableDto : destinationSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedSourceItem: freezed == selectedSourceItem ? _self.selectedSourceItem : selectedSourceItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,selectedDestinationItem: freezed == selectedDestinationItem ? _self.selectedDestinationItem : selectedDestinationItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,lastRawSourceAmount: null == lastRawSourceAmount ? _self.lastRawSourceAmount : lastRawSourceAmount // ignore: cast_nullable_to_non_nullable
as String,lastRawDestinationAmount: null == lastRawDestinationAmount ? _self.lastRawDestinationAmount : lastRawDestinationAmount // ignore: cast_nullable_to_non_nullable
as String,isLastInputSource: null == isLastInputSource ? _self.isLastInputSource : isLastInputSource // ignore: cast_nullable_to_non_nullable
as bool,commonSendMoneyDto: null == commonSendMoneyDto ? _self.commonSendMoneyDto : commonSendMoneyDto // ignore: cast_nullable_to_non_nullable
as CommonSendMoneyDto,remarks: null == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String,isRateLoading: null == isRateLoading ? _self.isRateLoading : isRateLoading // ignore: cast_nullable_to_non_nullable
as bool,isSourceAmountCalculating: null == isSourceAmountCalculating ? _self.isSourceAmountCalculating : isSourceAmountCalculating // ignore: cast_nullable_to_non_nullable
as bool,isDestinationAmountCalculating: null == isDestinationAmountCalculating ? _self.isDestinationAmountCalculating : isDestinationAmountCalculating // ignore: cast_nullable_to_non_nullable
as bool,sourceCurrencyOption: null == sourceCurrencyOption ? _self.sourceCurrencyOption : sourceCurrencyOption // ignore: cast_nullable_to_non_nullable
as Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>,destinationCurrencyOption: null == destinationCurrencyOption ? _self.destinationCurrencyOption : destinationCurrencyOption // ignore: cast_nullable_to_non_nullable
as Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>,calculateOption: null == calculateOption ? _self.calculateOption : calculateOption // ignore: cast_nullable_to_non_nullable
as Option<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>>,
  ));
}
/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get sourceSelectableDto {
    if (_self.sourceSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.sourceSelectableDto!, (value) {
    return _then(_self.copyWith(sourceSelectableDto: value));
  });
}/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get destinationSelectableDto {
    if (_self.destinationSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.destinationSelectableDto!, (value) {
    return _then(_self.copyWith(destinationSelectableDto: value));
  });
}/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedSourceItem {
    if (_self.selectedSourceItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedSourceItem!, (value) {
    return _then(_self.copyWith(selectedSourceItem: value));
  });
}/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedDestinationItem {
    if (_self.selectedDestinationItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedDestinationItem!, (value) {
    return _then(_self.copyWith(selectedDestinationItem: value));
  });
}/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSendMoneyDtoCopyWith<$Res> get commonSendMoneyDto {
  
  return $CommonSendMoneyDtoCopyWith<$Res>(_self.commonSendMoneyDto, (value) {
    return _then(_self.copyWith(commonSendMoneyDto: value));
  });
}
}


/// Adds pattern-matching-related methods to [RateCalculatorState].
extension RateCalculatorStatePatterns on RateCalculatorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateCalculatorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateCalculatorState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateCalculatorState value)  $default,){
final _that = this;
switch (_that) {
case _RateCalculatorState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateCalculatorState value)?  $default,){
final _that = this;
switch (_that) {
case _RateCalculatorState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isInitialLoading,  bool criticalLoadFailed,  CommonSelectableDto? sourceSelectableDto,  CommonSelectableDto? destinationSelectableDto,  CommonSelectableItem? selectedSourceItem,  CommonSelectableItem? selectedDestinationItem,  String lastRawSourceAmount,  String lastRawDestinationAmount,  bool isLastInputSource,  CommonSendMoneyDto commonSendMoneyDto,  String remarks,  bool isRateLoading,  bool isSourceAmountCalculating,  bool isDestinationAmountCalculating,  Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> sourceCurrencyOption,  Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> destinationCurrencyOption,  Option<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>> calculateOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateCalculatorState() when $default != null:
return $default(_that.isInitialLoading,_that.criticalLoadFailed,_that.sourceSelectableDto,_that.destinationSelectableDto,_that.selectedSourceItem,_that.selectedDestinationItem,_that.lastRawSourceAmount,_that.lastRawDestinationAmount,_that.isLastInputSource,_that.commonSendMoneyDto,_that.remarks,_that.isRateLoading,_that.isSourceAmountCalculating,_that.isDestinationAmountCalculating,_that.sourceCurrencyOption,_that.destinationCurrencyOption,_that.calculateOption);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isInitialLoading,  bool criticalLoadFailed,  CommonSelectableDto? sourceSelectableDto,  CommonSelectableDto? destinationSelectableDto,  CommonSelectableItem? selectedSourceItem,  CommonSelectableItem? selectedDestinationItem,  String lastRawSourceAmount,  String lastRawDestinationAmount,  bool isLastInputSource,  CommonSendMoneyDto commonSendMoneyDto,  String remarks,  bool isRateLoading,  bool isSourceAmountCalculating,  bool isDestinationAmountCalculating,  Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> sourceCurrencyOption,  Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> destinationCurrencyOption,  Option<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>> calculateOption)  $default,) {final _that = this;
switch (_that) {
case _RateCalculatorState():
return $default(_that.isInitialLoading,_that.criticalLoadFailed,_that.sourceSelectableDto,_that.destinationSelectableDto,_that.selectedSourceItem,_that.selectedDestinationItem,_that.lastRawSourceAmount,_that.lastRawDestinationAmount,_that.isLastInputSource,_that.commonSendMoneyDto,_that.remarks,_that.isRateLoading,_that.isSourceAmountCalculating,_that.isDestinationAmountCalculating,_that.sourceCurrencyOption,_that.destinationCurrencyOption,_that.calculateOption);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isInitialLoading,  bool criticalLoadFailed,  CommonSelectableDto? sourceSelectableDto,  CommonSelectableDto? destinationSelectableDto,  CommonSelectableItem? selectedSourceItem,  CommonSelectableItem? selectedDestinationItem,  String lastRawSourceAmount,  String lastRawDestinationAmount,  bool isLastInputSource,  CommonSendMoneyDto commonSendMoneyDto,  String remarks,  bool isRateLoading,  bool isSourceAmountCalculating,  bool isDestinationAmountCalculating,  Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> sourceCurrencyOption,  Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> destinationCurrencyOption,  Option<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>> calculateOption)?  $default,) {final _that = this;
switch (_that) {
case _RateCalculatorState() when $default != null:
return $default(_that.isInitialLoading,_that.criticalLoadFailed,_that.sourceSelectableDto,_that.destinationSelectableDto,_that.selectedSourceItem,_that.selectedDestinationItem,_that.lastRawSourceAmount,_that.lastRawDestinationAmount,_that.isLastInputSource,_that.commonSendMoneyDto,_that.remarks,_that.isRateLoading,_that.isSourceAmountCalculating,_that.isDestinationAmountCalculating,_that.sourceCurrencyOption,_that.destinationCurrencyOption,_that.calculateOption);case _:
  return null;

}
}

}

/// @nodoc


class _RateCalculatorState implements RateCalculatorState {
  const _RateCalculatorState({this.isInitialLoading = true, this.criticalLoadFailed = false, this.sourceSelectableDto, this.destinationSelectableDto, this.selectedSourceItem, this.selectedDestinationItem, this.lastRawSourceAmount = '', this.lastRawDestinationAmount = '', this.isLastInputSource = true, required this.commonSendMoneyDto, this.remarks = '', this.isRateLoading = false, this.isSourceAmountCalculating = false, this.isDestinationAmountCalculating = false, required this.sourceCurrencyOption, required this.destinationCurrencyOption, required this.calculateOption});
  

@override@JsonKey() final  bool isInitialLoading;
@override@JsonKey() final  bool criticalLoadFailed;
@override final  CommonSelectableDto? sourceSelectableDto;
@override final  CommonSelectableDto? destinationSelectableDto;
@override final  CommonSelectableItem? selectedSourceItem;
@override final  CommonSelectableItem? selectedDestinationItem;
@override@JsonKey() final  String lastRawSourceAmount;
@override@JsonKey() final  String lastRawDestinationAmount;
@override@JsonKey() final  bool isLastInputSource;
@override final  CommonSendMoneyDto commonSendMoneyDto;
@override@JsonKey() final  String remarks;
@override@JsonKey() final  bool isRateLoading;
@override@JsonKey() final  bool isSourceAmountCalculating;
@override@JsonKey() final  bool isDestinationAmountCalculating;
@override final  Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> sourceCurrencyOption;
@override final  Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> destinationCurrencyOption;
@override final  Option<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>> calculateOption;

/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateCalculatorStateCopyWith<_RateCalculatorState> get copyWith => __$RateCalculatorStateCopyWithImpl<_RateCalculatorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateCalculatorState&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.criticalLoadFailed, criticalLoadFailed) || other.criticalLoadFailed == criticalLoadFailed)&&(identical(other.sourceSelectableDto, sourceSelectableDto) || other.sourceSelectableDto == sourceSelectableDto)&&(identical(other.destinationSelectableDto, destinationSelectableDto) || other.destinationSelectableDto == destinationSelectableDto)&&(identical(other.selectedSourceItem, selectedSourceItem) || other.selectedSourceItem == selectedSourceItem)&&(identical(other.selectedDestinationItem, selectedDestinationItem) || other.selectedDestinationItem == selectedDestinationItem)&&(identical(other.lastRawSourceAmount, lastRawSourceAmount) || other.lastRawSourceAmount == lastRawSourceAmount)&&(identical(other.lastRawDestinationAmount, lastRawDestinationAmount) || other.lastRawDestinationAmount == lastRawDestinationAmount)&&(identical(other.isLastInputSource, isLastInputSource) || other.isLastInputSource == isLastInputSource)&&(identical(other.commonSendMoneyDto, commonSendMoneyDto) || other.commonSendMoneyDto == commonSendMoneyDto)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.isRateLoading, isRateLoading) || other.isRateLoading == isRateLoading)&&(identical(other.isSourceAmountCalculating, isSourceAmountCalculating) || other.isSourceAmountCalculating == isSourceAmountCalculating)&&(identical(other.isDestinationAmountCalculating, isDestinationAmountCalculating) || other.isDestinationAmountCalculating == isDestinationAmountCalculating)&&(identical(other.sourceCurrencyOption, sourceCurrencyOption) || other.sourceCurrencyOption == sourceCurrencyOption)&&(identical(other.destinationCurrencyOption, destinationCurrencyOption) || other.destinationCurrencyOption == destinationCurrencyOption)&&(identical(other.calculateOption, calculateOption) || other.calculateOption == calculateOption));
}


@override
int get hashCode => Object.hash(runtimeType,isInitialLoading,criticalLoadFailed,sourceSelectableDto,destinationSelectableDto,selectedSourceItem,selectedDestinationItem,lastRawSourceAmount,lastRawDestinationAmount,isLastInputSource,commonSendMoneyDto,remarks,isRateLoading,isSourceAmountCalculating,isDestinationAmountCalculating,sourceCurrencyOption,destinationCurrencyOption,calculateOption);

@override
String toString() {
  return 'RateCalculatorState(isInitialLoading: $isInitialLoading, criticalLoadFailed: $criticalLoadFailed, sourceSelectableDto: $sourceSelectableDto, destinationSelectableDto: $destinationSelectableDto, selectedSourceItem: $selectedSourceItem, selectedDestinationItem: $selectedDestinationItem, lastRawSourceAmount: $lastRawSourceAmount, lastRawDestinationAmount: $lastRawDestinationAmount, isLastInputSource: $isLastInputSource, commonSendMoneyDto: $commonSendMoneyDto, remarks: $remarks, isRateLoading: $isRateLoading, isSourceAmountCalculating: $isSourceAmountCalculating, isDestinationAmountCalculating: $isDestinationAmountCalculating, sourceCurrencyOption: $sourceCurrencyOption, destinationCurrencyOption: $destinationCurrencyOption, calculateOption: $calculateOption)';
}


}

/// @nodoc
abstract mixin class _$RateCalculatorStateCopyWith<$Res> implements $RateCalculatorStateCopyWith<$Res> {
  factory _$RateCalculatorStateCopyWith(_RateCalculatorState value, $Res Function(_RateCalculatorState) _then) = __$RateCalculatorStateCopyWithImpl;
@override @useResult
$Res call({
 bool isInitialLoading, bool criticalLoadFailed, CommonSelectableDto? sourceSelectableDto, CommonSelectableDto? destinationSelectableDto, CommonSelectableItem? selectedSourceItem, CommonSelectableItem? selectedDestinationItem, String lastRawSourceAmount, String lastRawDestinationAmount, bool isLastInputSource, CommonSendMoneyDto commonSendMoneyDto, String remarks, bool isRateLoading, bool isSourceAmountCalculating, bool isDestinationAmountCalculating, Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> sourceCurrencyOption, Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>> destinationCurrencyOption, Option<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>> calculateOption
});


@override $CommonSelectableDtoCopyWith<$Res>? get sourceSelectableDto;@override $CommonSelectableDtoCopyWith<$Res>? get destinationSelectableDto;@override $CommonSelectableItemCopyWith<$Res>? get selectedSourceItem;@override $CommonSelectableItemCopyWith<$Res>? get selectedDestinationItem;@override $CommonSendMoneyDtoCopyWith<$Res> get commonSendMoneyDto;

}
/// @nodoc
class __$RateCalculatorStateCopyWithImpl<$Res>
    implements _$RateCalculatorStateCopyWith<$Res> {
  __$RateCalculatorStateCopyWithImpl(this._self, this._then);

  final _RateCalculatorState _self;
  final $Res Function(_RateCalculatorState) _then;

/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isInitialLoading = null,Object? criticalLoadFailed = null,Object? sourceSelectableDto = freezed,Object? destinationSelectableDto = freezed,Object? selectedSourceItem = freezed,Object? selectedDestinationItem = freezed,Object? lastRawSourceAmount = null,Object? lastRawDestinationAmount = null,Object? isLastInputSource = null,Object? commonSendMoneyDto = null,Object? remarks = null,Object? isRateLoading = null,Object? isSourceAmountCalculating = null,Object? isDestinationAmountCalculating = null,Object? sourceCurrencyOption = null,Object? destinationCurrencyOption = null,Object? calculateOption = null,}) {
  return _then(_RateCalculatorState(
isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,criticalLoadFailed: null == criticalLoadFailed ? _self.criticalLoadFailed : criticalLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,sourceSelectableDto: freezed == sourceSelectableDto ? _self.sourceSelectableDto : sourceSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,destinationSelectableDto: freezed == destinationSelectableDto ? _self.destinationSelectableDto : destinationSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedSourceItem: freezed == selectedSourceItem ? _self.selectedSourceItem : selectedSourceItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,selectedDestinationItem: freezed == selectedDestinationItem ? _self.selectedDestinationItem : selectedDestinationItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,lastRawSourceAmount: null == lastRawSourceAmount ? _self.lastRawSourceAmount : lastRawSourceAmount // ignore: cast_nullable_to_non_nullable
as String,lastRawDestinationAmount: null == lastRawDestinationAmount ? _self.lastRawDestinationAmount : lastRawDestinationAmount // ignore: cast_nullable_to_non_nullable
as String,isLastInputSource: null == isLastInputSource ? _self.isLastInputSource : isLastInputSource // ignore: cast_nullable_to_non_nullable
as bool,commonSendMoneyDto: null == commonSendMoneyDto ? _self.commonSendMoneyDto : commonSendMoneyDto // ignore: cast_nullable_to_non_nullable
as CommonSendMoneyDto,remarks: null == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String,isRateLoading: null == isRateLoading ? _self.isRateLoading : isRateLoading // ignore: cast_nullable_to_non_nullable
as bool,isSourceAmountCalculating: null == isSourceAmountCalculating ? _self.isSourceAmountCalculating : isSourceAmountCalculating // ignore: cast_nullable_to_non_nullable
as bool,isDestinationAmountCalculating: null == isDestinationAmountCalculating ? _self.isDestinationAmountCalculating : isDestinationAmountCalculating // ignore: cast_nullable_to_non_nullable
as bool,sourceCurrencyOption: null == sourceCurrencyOption ? _self.sourceCurrencyOption : sourceCurrencyOption // ignore: cast_nullable_to_non_nullable
as Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>,destinationCurrencyOption: null == destinationCurrencyOption ? _self.destinationCurrencyOption : destinationCurrencyOption // ignore: cast_nullable_to_non_nullable
as Option<Either<RateCalculatorFailure, RateCalculatorCurrencyListDto>>,calculateOption: null == calculateOption ? _self.calculateOption : calculateOption // ignore: cast_nullable_to_non_nullable
as Option<Either<RateCalculatorFailure, RateCalculatorCalculateAmountDto>>,
  ));
}

/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get sourceSelectableDto {
    if (_self.sourceSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.sourceSelectableDto!, (value) {
    return _then(_self.copyWith(sourceSelectableDto: value));
  });
}/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get destinationSelectableDto {
    if (_self.destinationSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.destinationSelectableDto!, (value) {
    return _then(_self.copyWith(destinationSelectableDto: value));
  });
}/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedSourceItem {
    if (_self.selectedSourceItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedSourceItem!, (value) {
    return _then(_self.copyWith(selectedSourceItem: value));
  });
}/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedDestinationItem {
    if (_self.selectedDestinationItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedDestinationItem!, (value) {
    return _then(_self.copyWith(selectedDestinationItem: value));
  });
}/// Create a copy of RateCalculatorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSendMoneyDtoCopyWith<$Res> get commonSendMoneyDto {
  
  return $CommonSendMoneyDtoCopyWith<$Res>(_self.commonSendMoneyDto, (value) {
    return _then(_self.copyWith(commonSendMoneyDto: value));
  });
}
}

// dart format on
