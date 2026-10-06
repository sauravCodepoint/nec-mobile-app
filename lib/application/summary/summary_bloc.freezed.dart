// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SummaryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent()';
}


}

/// @nodoc
class $SummaryEventCopyWith<$Res>  {
$SummaryEventCopyWith(SummaryEvent _, $Res Function(SummaryEvent) __);
}


/// Adds pattern-matching-related methods to [SummaryEvent].
extension SummaryEventPatterns on SummaryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _PrepareSummary value)?  prepareSummary,TResult Function( _RetryBeneficiary value)?  retryBeneficiary,TResult Function( _RetryPaymentMethod value)?  retryPaymentMethod,TResult Function( _BeneficiaryUpdatedChanged value)?  beneficiaryUpdatedChanged,TResult Function( _SourceAmountChanged value)?  sourceAmountChanged,TResult Function( _DestinationAmountChanged value)?  destinationAmountChanged,TResult Function( _PaymentMethodChanged value)?  paymentMethodChanged,TResult Function( _GetBranches value)?  getBranches,TResult Function( _BranchChanged value)?  branchChanged,TResult Function( _CreatePayAtBranchTransaction value)?  createPayAtBranchTransaction,TResult Function( _RoundOffDecision value)?  roundOffDecision,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrepareSummary() when prepareSummary != null:
return prepareSummary(_that);case _RetryBeneficiary() when retryBeneficiary != null:
return retryBeneficiary(_that);case _RetryPaymentMethod() when retryPaymentMethod != null:
return retryPaymentMethod(_that);case _BeneficiaryUpdatedChanged() when beneficiaryUpdatedChanged != null:
return beneficiaryUpdatedChanged(_that);case _SourceAmountChanged() when sourceAmountChanged != null:
return sourceAmountChanged(_that);case _DestinationAmountChanged() when destinationAmountChanged != null:
return destinationAmountChanged(_that);case _PaymentMethodChanged() when paymentMethodChanged != null:
return paymentMethodChanged(_that);case _GetBranches() when getBranches != null:
return getBranches(_that);case _BranchChanged() when branchChanged != null:
return branchChanged(_that);case _CreatePayAtBranchTransaction() when createPayAtBranchTransaction != null:
return createPayAtBranchTransaction(_that);case _RoundOffDecision() when roundOffDecision != null:
return roundOffDecision(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _PrepareSummary value)  prepareSummary,required TResult Function( _RetryBeneficiary value)  retryBeneficiary,required TResult Function( _RetryPaymentMethod value)  retryPaymentMethod,required TResult Function( _BeneficiaryUpdatedChanged value)  beneficiaryUpdatedChanged,required TResult Function( _SourceAmountChanged value)  sourceAmountChanged,required TResult Function( _DestinationAmountChanged value)  destinationAmountChanged,required TResult Function( _PaymentMethodChanged value)  paymentMethodChanged,required TResult Function( _GetBranches value)  getBranches,required TResult Function( _BranchChanged value)  branchChanged,required TResult Function( _CreatePayAtBranchTransaction value)  createPayAtBranchTransaction,required TResult Function( _RoundOffDecision value)  roundOffDecision,}){
final _that = this;
switch (_that) {
case _PrepareSummary():
return prepareSummary(_that);case _RetryBeneficiary():
return retryBeneficiary(_that);case _RetryPaymentMethod():
return retryPaymentMethod(_that);case _BeneficiaryUpdatedChanged():
return beneficiaryUpdatedChanged(_that);case _SourceAmountChanged():
return sourceAmountChanged(_that);case _DestinationAmountChanged():
return destinationAmountChanged(_that);case _PaymentMethodChanged():
return paymentMethodChanged(_that);case _GetBranches():
return getBranches(_that);case _BranchChanged():
return branchChanged(_that);case _CreatePayAtBranchTransaction():
return createPayAtBranchTransaction(_that);case _RoundOffDecision():
return roundOffDecision(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _PrepareSummary value)?  prepareSummary,TResult? Function( _RetryBeneficiary value)?  retryBeneficiary,TResult? Function( _RetryPaymentMethod value)?  retryPaymentMethod,TResult? Function( _BeneficiaryUpdatedChanged value)?  beneficiaryUpdatedChanged,TResult? Function( _SourceAmountChanged value)?  sourceAmountChanged,TResult? Function( _DestinationAmountChanged value)?  destinationAmountChanged,TResult? Function( _PaymentMethodChanged value)?  paymentMethodChanged,TResult? Function( _GetBranches value)?  getBranches,TResult? Function( _BranchChanged value)?  branchChanged,TResult? Function( _CreatePayAtBranchTransaction value)?  createPayAtBranchTransaction,TResult? Function( _RoundOffDecision value)?  roundOffDecision,}){
final _that = this;
switch (_that) {
case _PrepareSummary() when prepareSummary != null:
return prepareSummary(_that);case _RetryBeneficiary() when retryBeneficiary != null:
return retryBeneficiary(_that);case _RetryPaymentMethod() when retryPaymentMethod != null:
return retryPaymentMethod(_that);case _BeneficiaryUpdatedChanged() when beneficiaryUpdatedChanged != null:
return beneficiaryUpdatedChanged(_that);case _SourceAmountChanged() when sourceAmountChanged != null:
return sourceAmountChanged(_that);case _DestinationAmountChanged() when destinationAmountChanged != null:
return destinationAmountChanged(_that);case _PaymentMethodChanged() when paymentMethodChanged != null:
return paymentMethodChanged(_that);case _GetBranches() when getBranches != null:
return getBranches(_that);case _BranchChanged() when branchChanged != null:
return branchChanged(_that);case _CreatePayAtBranchTransaction() when createPayAtBranchTransaction != null:
return createPayAtBranchTransaction(_that);case _RoundOffDecision() when roundOffDecision != null:
return roundOffDecision(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String beneficiaryId,  bool isTranslistRequired,  String agentCode,  String agentName)?  prepareSummary,TResult Function()?  retryBeneficiary,TResult Function()?  retryPaymentMethod,TResult Function( String? eId)?  beneficiaryUpdatedChanged,TResult Function( String sourceAmount)?  sourceAmountChanged,TResult Function( String destinationAmount)?  destinationAmountChanged,TResult Function( CommonSelectableItem selectedPaymentMethodItem)?  paymentMethodChanged,TResult Function()?  getBranches,TResult Function( CommonSelectableItem selectedBranchItem)?  branchChanged,TResult Function()?  createPayAtBranchTransaction,TResult Function( bool isReadyToProceed)?  roundOffDecision,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrepareSummary() when prepareSummary != null:
return prepareSummary(_that.beneficiaryId,_that.isTranslistRequired,_that.agentCode,_that.agentName);case _RetryBeneficiary() when retryBeneficiary != null:
return retryBeneficiary();case _RetryPaymentMethod() when retryPaymentMethod != null:
return retryPaymentMethod();case _BeneficiaryUpdatedChanged() when beneficiaryUpdatedChanged != null:
return beneficiaryUpdatedChanged(_that.eId);case _SourceAmountChanged() when sourceAmountChanged != null:
return sourceAmountChanged(_that.sourceAmount);case _DestinationAmountChanged() when destinationAmountChanged != null:
return destinationAmountChanged(_that.destinationAmount);case _PaymentMethodChanged() when paymentMethodChanged != null:
return paymentMethodChanged(_that.selectedPaymentMethodItem);case _GetBranches() when getBranches != null:
return getBranches();case _BranchChanged() when branchChanged != null:
return branchChanged(_that.selectedBranchItem);case _CreatePayAtBranchTransaction() when createPayAtBranchTransaction != null:
return createPayAtBranchTransaction();case _RoundOffDecision() when roundOffDecision != null:
return roundOffDecision(_that.isReadyToProceed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String beneficiaryId,  bool isTranslistRequired,  String agentCode,  String agentName)  prepareSummary,required TResult Function()  retryBeneficiary,required TResult Function()  retryPaymentMethod,required TResult Function( String? eId)  beneficiaryUpdatedChanged,required TResult Function( String sourceAmount)  sourceAmountChanged,required TResult Function( String destinationAmount)  destinationAmountChanged,required TResult Function( CommonSelectableItem selectedPaymentMethodItem)  paymentMethodChanged,required TResult Function()  getBranches,required TResult Function( CommonSelectableItem selectedBranchItem)  branchChanged,required TResult Function()  createPayAtBranchTransaction,required TResult Function( bool isReadyToProceed)  roundOffDecision,}) {final _that = this;
switch (_that) {
case _PrepareSummary():
return prepareSummary(_that.beneficiaryId,_that.isTranslistRequired,_that.agentCode,_that.agentName);case _RetryBeneficiary():
return retryBeneficiary();case _RetryPaymentMethod():
return retryPaymentMethod();case _BeneficiaryUpdatedChanged():
return beneficiaryUpdatedChanged(_that.eId);case _SourceAmountChanged():
return sourceAmountChanged(_that.sourceAmount);case _DestinationAmountChanged():
return destinationAmountChanged(_that.destinationAmount);case _PaymentMethodChanged():
return paymentMethodChanged(_that.selectedPaymentMethodItem);case _GetBranches():
return getBranches();case _BranchChanged():
return branchChanged(_that.selectedBranchItem);case _CreatePayAtBranchTransaction():
return createPayAtBranchTransaction();case _RoundOffDecision():
return roundOffDecision(_that.isReadyToProceed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String beneficiaryId,  bool isTranslistRequired,  String agentCode,  String agentName)?  prepareSummary,TResult? Function()?  retryBeneficiary,TResult? Function()?  retryPaymentMethod,TResult? Function( String? eId)?  beneficiaryUpdatedChanged,TResult? Function( String sourceAmount)?  sourceAmountChanged,TResult? Function( String destinationAmount)?  destinationAmountChanged,TResult? Function( CommonSelectableItem selectedPaymentMethodItem)?  paymentMethodChanged,TResult? Function()?  getBranches,TResult? Function( CommonSelectableItem selectedBranchItem)?  branchChanged,TResult? Function()?  createPayAtBranchTransaction,TResult? Function( bool isReadyToProceed)?  roundOffDecision,}) {final _that = this;
switch (_that) {
case _PrepareSummary() when prepareSummary != null:
return prepareSummary(_that.beneficiaryId,_that.isTranslistRequired,_that.agentCode,_that.agentName);case _RetryBeneficiary() when retryBeneficiary != null:
return retryBeneficiary();case _RetryPaymentMethod() when retryPaymentMethod != null:
return retryPaymentMethod();case _BeneficiaryUpdatedChanged() when beneficiaryUpdatedChanged != null:
return beneficiaryUpdatedChanged(_that.eId);case _SourceAmountChanged() when sourceAmountChanged != null:
return sourceAmountChanged(_that.sourceAmount);case _DestinationAmountChanged() when destinationAmountChanged != null:
return destinationAmountChanged(_that.destinationAmount);case _PaymentMethodChanged() when paymentMethodChanged != null:
return paymentMethodChanged(_that.selectedPaymentMethodItem);case _GetBranches() when getBranches != null:
return getBranches();case _BranchChanged() when branchChanged != null:
return branchChanged(_that.selectedBranchItem);case _CreatePayAtBranchTransaction() when createPayAtBranchTransaction != null:
return createPayAtBranchTransaction();case _RoundOffDecision() when roundOffDecision != null:
return roundOffDecision(_that.isReadyToProceed);case _:
  return null;

}
}

}

/// @nodoc


class _PrepareSummary implements SummaryEvent {
  const _PrepareSummary({required this.beneficiaryId, this.isTranslistRequired = false, this.agentCode = '', this.agentName = ''});
  

 final  String beneficiaryId;
@JsonKey() final  bool isTranslistRequired;
@JsonKey() final  String agentCode;
@JsonKey() final  String agentName;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrepareSummaryCopyWith<_PrepareSummary> get copyWith => __$PrepareSummaryCopyWithImpl<_PrepareSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrepareSummary&&(identical(other.beneficiaryId, beneficiaryId) || other.beneficiaryId == beneficiaryId)&&(identical(other.isTranslistRequired, isTranslistRequired) || other.isTranslistRequired == isTranslistRequired)&&(identical(other.agentCode, agentCode) || other.agentCode == agentCode)&&(identical(other.agentName, agentName) || other.agentName == agentName));
}


@override
int get hashCode => Object.hash(runtimeType,beneficiaryId,isTranslistRequired,agentCode,agentName);

@override
String toString() {
  return 'SummaryEvent.prepareSummary(beneficiaryId: $beneficiaryId, isTranslistRequired: $isTranslistRequired, agentCode: $agentCode, agentName: $agentName)';
}


}

/// @nodoc
abstract mixin class _$PrepareSummaryCopyWith<$Res> implements $SummaryEventCopyWith<$Res> {
  factory _$PrepareSummaryCopyWith(_PrepareSummary value, $Res Function(_PrepareSummary) _then) = __$PrepareSummaryCopyWithImpl;
@useResult
$Res call({
 String beneficiaryId, bool isTranslistRequired, String agentCode, String agentName
});




}
/// @nodoc
class __$PrepareSummaryCopyWithImpl<$Res>
    implements _$PrepareSummaryCopyWith<$Res> {
  __$PrepareSummaryCopyWithImpl(this._self, this._then);

  final _PrepareSummary _self;
  final $Res Function(_PrepareSummary) _then;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? beneficiaryId = null,Object? isTranslistRequired = null,Object? agentCode = null,Object? agentName = null,}) {
  return _then(_PrepareSummary(
beneficiaryId: null == beneficiaryId ? _self.beneficiaryId : beneficiaryId // ignore: cast_nullable_to_non_nullable
as String,isTranslistRequired: null == isTranslistRequired ? _self.isTranslistRequired : isTranslistRequired // ignore: cast_nullable_to_non_nullable
as bool,agentCode: null == agentCode ? _self.agentCode : agentCode // ignore: cast_nullable_to_non_nullable
as String,agentName: null == agentName ? _self.agentName : agentName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RetryBeneficiary implements SummaryEvent {
  const _RetryBeneficiary();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryBeneficiary);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent.retryBeneficiary()';
}


}




/// @nodoc


class _RetryPaymentMethod implements SummaryEvent {
  const _RetryPaymentMethod();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryPaymentMethod);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent.retryPaymentMethod()';
}


}




/// @nodoc


class _BeneficiaryUpdatedChanged implements SummaryEvent {
  const _BeneficiaryUpdatedChanged({this.eId});
  

 final  String? eId;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BeneficiaryUpdatedChangedCopyWith<_BeneficiaryUpdatedChanged> get copyWith => __$BeneficiaryUpdatedChangedCopyWithImpl<_BeneficiaryUpdatedChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BeneficiaryUpdatedChanged&&(identical(other.eId, eId) || other.eId == eId));
}


@override
int get hashCode => Object.hash(runtimeType,eId);

@override
String toString() {
  return 'SummaryEvent.beneficiaryUpdatedChanged(eId: $eId)';
}


}

/// @nodoc
abstract mixin class _$BeneficiaryUpdatedChangedCopyWith<$Res> implements $SummaryEventCopyWith<$Res> {
  factory _$BeneficiaryUpdatedChangedCopyWith(_BeneficiaryUpdatedChanged value, $Res Function(_BeneficiaryUpdatedChanged) _then) = __$BeneficiaryUpdatedChangedCopyWithImpl;
@useResult
$Res call({
 String? eId
});




}
/// @nodoc
class __$BeneficiaryUpdatedChangedCopyWithImpl<$Res>
    implements _$BeneficiaryUpdatedChangedCopyWith<$Res> {
  __$BeneficiaryUpdatedChangedCopyWithImpl(this._self, this._then);

  final _BeneficiaryUpdatedChanged _self;
  final $Res Function(_BeneficiaryUpdatedChanged) _then;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eId = freezed,}) {
  return _then(_BeneficiaryUpdatedChanged(
eId: freezed == eId ? _self.eId : eId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SourceAmountChanged implements SummaryEvent {
  const _SourceAmountChanged({required this.sourceAmount});
  

 final  String sourceAmount;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceAmountChangedCopyWith<_SourceAmountChanged> get copyWith => __$SourceAmountChangedCopyWithImpl<_SourceAmountChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceAmountChanged&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount));
}


@override
int get hashCode => Object.hash(runtimeType,sourceAmount);

@override
String toString() {
  return 'SummaryEvent.sourceAmountChanged(sourceAmount: $sourceAmount)';
}


}

/// @nodoc
abstract mixin class _$SourceAmountChangedCopyWith<$Res> implements $SummaryEventCopyWith<$Res> {
  factory _$SourceAmountChangedCopyWith(_SourceAmountChanged value, $Res Function(_SourceAmountChanged) _then) = __$SourceAmountChangedCopyWithImpl;
@useResult
$Res call({
 String sourceAmount
});




}
/// @nodoc
class __$SourceAmountChangedCopyWithImpl<$Res>
    implements _$SourceAmountChangedCopyWith<$Res> {
  __$SourceAmountChangedCopyWithImpl(this._self, this._then);

  final _SourceAmountChanged _self;
  final $Res Function(_SourceAmountChanged) _then;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sourceAmount = null,}) {
  return _then(_SourceAmountChanged(
sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DestinationAmountChanged implements SummaryEvent {
  const _DestinationAmountChanged({required this.destinationAmount});
  

 final  String destinationAmount;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DestinationAmountChangedCopyWith<_DestinationAmountChanged> get copyWith => __$DestinationAmountChangedCopyWithImpl<_DestinationAmountChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DestinationAmountChanged&&(identical(other.destinationAmount, destinationAmount) || other.destinationAmount == destinationAmount));
}


@override
int get hashCode => Object.hash(runtimeType,destinationAmount);

@override
String toString() {
  return 'SummaryEvent.destinationAmountChanged(destinationAmount: $destinationAmount)';
}


}

/// @nodoc
abstract mixin class _$DestinationAmountChangedCopyWith<$Res> implements $SummaryEventCopyWith<$Res> {
  factory _$DestinationAmountChangedCopyWith(_DestinationAmountChanged value, $Res Function(_DestinationAmountChanged) _then) = __$DestinationAmountChangedCopyWithImpl;
@useResult
$Res call({
 String destinationAmount
});




}
/// @nodoc
class __$DestinationAmountChangedCopyWithImpl<$Res>
    implements _$DestinationAmountChangedCopyWith<$Res> {
  __$DestinationAmountChangedCopyWithImpl(this._self, this._then);

  final _DestinationAmountChanged _self;
  final $Res Function(_DestinationAmountChanged) _then;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? destinationAmount = null,}) {
  return _then(_DestinationAmountChanged(
destinationAmount: null == destinationAmount ? _self.destinationAmount : destinationAmount // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PaymentMethodChanged implements SummaryEvent {
  const _PaymentMethodChanged(this.selectedPaymentMethodItem);
  

 final  CommonSelectableItem selectedPaymentMethodItem;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodChangedCopyWith<_PaymentMethodChanged> get copyWith => __$PaymentMethodChangedCopyWithImpl<_PaymentMethodChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethodChanged&&(identical(other.selectedPaymentMethodItem, selectedPaymentMethodItem) || other.selectedPaymentMethodItem == selectedPaymentMethodItem));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPaymentMethodItem);

@override
String toString() {
  return 'SummaryEvent.paymentMethodChanged(selectedPaymentMethodItem: $selectedPaymentMethodItem)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodChangedCopyWith<$Res> implements $SummaryEventCopyWith<$Res> {
  factory _$PaymentMethodChangedCopyWith(_PaymentMethodChanged value, $Res Function(_PaymentMethodChanged) _then) = __$PaymentMethodChangedCopyWithImpl;
@useResult
$Res call({
 CommonSelectableItem selectedPaymentMethodItem
});


$CommonSelectableItemCopyWith<$Res> get selectedPaymentMethodItem;

}
/// @nodoc
class __$PaymentMethodChangedCopyWithImpl<$Res>
    implements _$PaymentMethodChangedCopyWith<$Res> {
  __$PaymentMethodChangedCopyWithImpl(this._self, this._then);

  final _PaymentMethodChanged _self;
  final $Res Function(_PaymentMethodChanged) _then;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedPaymentMethodItem = null,}) {
  return _then(_PaymentMethodChanged(
null == selectedPaymentMethodItem ? _self.selectedPaymentMethodItem : selectedPaymentMethodItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem,
  ));
}

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res> get selectedPaymentMethodItem {
  
  return $CommonSelectableItemCopyWith<$Res>(_self.selectedPaymentMethodItem, (value) {
    return _then(_self.copyWith(selectedPaymentMethodItem: value));
  });
}
}

/// @nodoc


class _GetBranches implements SummaryEvent {
  const _GetBranches();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetBranches);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent.getBranches()';
}


}




/// @nodoc


class _BranchChanged implements SummaryEvent {
  const _BranchChanged(this.selectedBranchItem);
  

 final  CommonSelectableItem selectedBranchItem;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BranchChangedCopyWith<_BranchChanged> get copyWith => __$BranchChangedCopyWithImpl<_BranchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BranchChanged&&(identical(other.selectedBranchItem, selectedBranchItem) || other.selectedBranchItem == selectedBranchItem));
}


@override
int get hashCode => Object.hash(runtimeType,selectedBranchItem);

@override
String toString() {
  return 'SummaryEvent.branchChanged(selectedBranchItem: $selectedBranchItem)';
}


}

/// @nodoc
abstract mixin class _$BranchChangedCopyWith<$Res> implements $SummaryEventCopyWith<$Res> {
  factory _$BranchChangedCopyWith(_BranchChanged value, $Res Function(_BranchChanged) _then) = __$BranchChangedCopyWithImpl;
@useResult
$Res call({
 CommonSelectableItem selectedBranchItem
});


$CommonSelectableItemCopyWith<$Res> get selectedBranchItem;

}
/// @nodoc
class __$BranchChangedCopyWithImpl<$Res>
    implements _$BranchChangedCopyWith<$Res> {
  __$BranchChangedCopyWithImpl(this._self, this._then);

  final _BranchChanged _self;
  final $Res Function(_BranchChanged) _then;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedBranchItem = null,}) {
  return _then(_BranchChanged(
null == selectedBranchItem ? _self.selectedBranchItem : selectedBranchItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem,
  ));
}

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res> get selectedBranchItem {
  
  return $CommonSelectableItemCopyWith<$Res>(_self.selectedBranchItem, (value) {
    return _then(_self.copyWith(selectedBranchItem: value));
  });
}
}

/// @nodoc


class _CreatePayAtBranchTransaction implements SummaryEvent {
  const _CreatePayAtBranchTransaction();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePayAtBranchTransaction);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SummaryEvent.createPayAtBranchTransaction()';
}


}




/// @nodoc


class _RoundOffDecision implements SummaryEvent {
  const _RoundOffDecision({required this.isReadyToProceed});
  

 final  bool isReadyToProceed;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoundOffDecisionCopyWith<_RoundOffDecision> get copyWith => __$RoundOffDecisionCopyWithImpl<_RoundOffDecision>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoundOffDecision&&(identical(other.isReadyToProceed, isReadyToProceed) || other.isReadyToProceed == isReadyToProceed));
}


@override
int get hashCode => Object.hash(runtimeType,isReadyToProceed);

@override
String toString() {
  return 'SummaryEvent.roundOffDecision(isReadyToProceed: $isReadyToProceed)';
}


}

/// @nodoc
abstract mixin class _$RoundOffDecisionCopyWith<$Res> implements $SummaryEventCopyWith<$Res> {
  factory _$RoundOffDecisionCopyWith(_RoundOffDecision value, $Res Function(_RoundOffDecision) _then) = __$RoundOffDecisionCopyWithImpl;
@useResult
$Res call({
 bool isReadyToProceed
});




}
/// @nodoc
class __$RoundOffDecisionCopyWithImpl<$Res>
    implements _$RoundOffDecisionCopyWith<$Res> {
  __$RoundOffDecisionCopyWithImpl(this._self, this._then);

  final _RoundOffDecision _self;
  final $Res Function(_RoundOffDecision) _then;

/// Create a copy of SummaryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isReadyToProceed = null,}) {
  return _then(_RoundOffDecision(
isReadyToProceed: null == isReadyToProceed ? _self.isReadyToProceed : isReadyToProceed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SummaryState {

 bool get isInitialLoading; bool get isBeneficiaryLoading; bool get isPaymentMethodLoading; bool get isSubmitting; bool get isRateLoading; bool get isSourceAmountCalculating; bool get isDestinationAmountCalculating; bool get isBranchesLoading; String get lastRawSourceAmount; String get lastRawDestinationAmount; bool get isLastInputSource; String? get beneficiaryId; bool get isTranslistRequired; String get homeAgentCode; String get homeAgentName; SummaryFailure? get beneficiaryFailure; SummaryFailure? get paymentMethodFailure; SummaryBeneficiaryByIdDto? get summaryBeneficiaryByIdDto; CommonSendMoneyDto get commonSendMoneyDto; CommonSelectableDto? get commonSourceSelectableDto; CommonSelectableItem? get selectedCommonSourceItem; CommonSelectableDto? get commonDestinationSelectableDto; CommonSelectableItem? get selectedCommonDestinationItem; CommonSelectableDto? get commonPaymentMethodSelectableDto; CommonSelectableItem? get selectedPaymentMethodItem; SummaryPaymentMethodDto? get summaryPaymentMethodDto; CommonPaymentResultDto? get commonPaymentResultDto; CommonBranchesDto? get summaryBranchesDto; CommonSelectableItem? get selectedBranchItem; SummaryPaymentResultDto? get roundOffResult; Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>> get summaryBeneficiaryByIdFailureOrSuccessOption; Option<Either<SummaryFailure, SummaryCurrencyListDto>> get summarySourceCurrencyListFailureOrSuccessOption; Option<Either<SummaryFailure, SummaryCurrencyListDto>> get summaryDestinationCurrencyListFailureOrSuccessOption; Option<Either<SummaryFailure, SummaryCalculateAmountDto>> get summaryCalculatedSourceAmountFailureOrSuccessOption; Option<Either<SummaryFailure, SummaryCalculateAmountDto>> get summaryCalculatedDestinationAmountFailureOrSuccessOption; Option<Either<SummaryFailure, SummaryPaymentMethodDto>> get summaryPaymentMethodFailureOrSuccessOption; Option<Either<SummaryFailure, SummaryBranchesDto>> get summaryBranchesFailureOrSuccessOption; Option<Either<SummaryFailure, SummaryPaymentResultDto>> get summaryPayAtBranchFailureOrSuccessOption; Option<Either<SummaryFailure, SummaryPaymentResultDto>> get summaryRoundOffFailureOrSuccessOption;
/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryStateCopyWith<SummaryState> get copyWith => _$SummaryStateCopyWithImpl<SummaryState>(this as SummaryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryState&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isBeneficiaryLoading, isBeneficiaryLoading) || other.isBeneficiaryLoading == isBeneficiaryLoading)&&(identical(other.isPaymentMethodLoading, isPaymentMethodLoading) || other.isPaymentMethodLoading == isPaymentMethodLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isRateLoading, isRateLoading) || other.isRateLoading == isRateLoading)&&(identical(other.isSourceAmountCalculating, isSourceAmountCalculating) || other.isSourceAmountCalculating == isSourceAmountCalculating)&&(identical(other.isDestinationAmountCalculating, isDestinationAmountCalculating) || other.isDestinationAmountCalculating == isDestinationAmountCalculating)&&(identical(other.isBranchesLoading, isBranchesLoading) || other.isBranchesLoading == isBranchesLoading)&&(identical(other.lastRawSourceAmount, lastRawSourceAmount) || other.lastRawSourceAmount == lastRawSourceAmount)&&(identical(other.lastRawDestinationAmount, lastRawDestinationAmount) || other.lastRawDestinationAmount == lastRawDestinationAmount)&&(identical(other.isLastInputSource, isLastInputSource) || other.isLastInputSource == isLastInputSource)&&(identical(other.beneficiaryId, beneficiaryId) || other.beneficiaryId == beneficiaryId)&&(identical(other.isTranslistRequired, isTranslistRequired) || other.isTranslistRequired == isTranslistRequired)&&(identical(other.homeAgentCode, homeAgentCode) || other.homeAgentCode == homeAgentCode)&&(identical(other.homeAgentName, homeAgentName) || other.homeAgentName == homeAgentName)&&(identical(other.beneficiaryFailure, beneficiaryFailure) || other.beneficiaryFailure == beneficiaryFailure)&&(identical(other.paymentMethodFailure, paymentMethodFailure) || other.paymentMethodFailure == paymentMethodFailure)&&(identical(other.summaryBeneficiaryByIdDto, summaryBeneficiaryByIdDto) || other.summaryBeneficiaryByIdDto == summaryBeneficiaryByIdDto)&&(identical(other.commonSendMoneyDto, commonSendMoneyDto) || other.commonSendMoneyDto == commonSendMoneyDto)&&(identical(other.commonSourceSelectableDto, commonSourceSelectableDto) || other.commonSourceSelectableDto == commonSourceSelectableDto)&&(identical(other.selectedCommonSourceItem, selectedCommonSourceItem) || other.selectedCommonSourceItem == selectedCommonSourceItem)&&(identical(other.commonDestinationSelectableDto, commonDestinationSelectableDto) || other.commonDestinationSelectableDto == commonDestinationSelectableDto)&&(identical(other.selectedCommonDestinationItem, selectedCommonDestinationItem) || other.selectedCommonDestinationItem == selectedCommonDestinationItem)&&(identical(other.commonPaymentMethodSelectableDto, commonPaymentMethodSelectableDto) || other.commonPaymentMethodSelectableDto == commonPaymentMethodSelectableDto)&&(identical(other.selectedPaymentMethodItem, selectedPaymentMethodItem) || other.selectedPaymentMethodItem == selectedPaymentMethodItem)&&(identical(other.summaryPaymentMethodDto, summaryPaymentMethodDto) || other.summaryPaymentMethodDto == summaryPaymentMethodDto)&&(identical(other.commonPaymentResultDto, commonPaymentResultDto) || other.commonPaymentResultDto == commonPaymentResultDto)&&(identical(other.summaryBranchesDto, summaryBranchesDto) || other.summaryBranchesDto == summaryBranchesDto)&&(identical(other.selectedBranchItem, selectedBranchItem) || other.selectedBranchItem == selectedBranchItem)&&(identical(other.roundOffResult, roundOffResult) || other.roundOffResult == roundOffResult)&&(identical(other.summaryBeneficiaryByIdFailureOrSuccessOption, summaryBeneficiaryByIdFailureOrSuccessOption) || other.summaryBeneficiaryByIdFailureOrSuccessOption == summaryBeneficiaryByIdFailureOrSuccessOption)&&(identical(other.summarySourceCurrencyListFailureOrSuccessOption, summarySourceCurrencyListFailureOrSuccessOption) || other.summarySourceCurrencyListFailureOrSuccessOption == summarySourceCurrencyListFailureOrSuccessOption)&&(identical(other.summaryDestinationCurrencyListFailureOrSuccessOption, summaryDestinationCurrencyListFailureOrSuccessOption) || other.summaryDestinationCurrencyListFailureOrSuccessOption == summaryDestinationCurrencyListFailureOrSuccessOption)&&(identical(other.summaryCalculatedSourceAmountFailureOrSuccessOption, summaryCalculatedSourceAmountFailureOrSuccessOption) || other.summaryCalculatedSourceAmountFailureOrSuccessOption == summaryCalculatedSourceAmountFailureOrSuccessOption)&&(identical(other.summaryCalculatedDestinationAmountFailureOrSuccessOption, summaryCalculatedDestinationAmountFailureOrSuccessOption) || other.summaryCalculatedDestinationAmountFailureOrSuccessOption == summaryCalculatedDestinationAmountFailureOrSuccessOption)&&(identical(other.summaryPaymentMethodFailureOrSuccessOption, summaryPaymentMethodFailureOrSuccessOption) || other.summaryPaymentMethodFailureOrSuccessOption == summaryPaymentMethodFailureOrSuccessOption)&&(identical(other.summaryBranchesFailureOrSuccessOption, summaryBranchesFailureOrSuccessOption) || other.summaryBranchesFailureOrSuccessOption == summaryBranchesFailureOrSuccessOption)&&(identical(other.summaryPayAtBranchFailureOrSuccessOption, summaryPayAtBranchFailureOrSuccessOption) || other.summaryPayAtBranchFailureOrSuccessOption == summaryPayAtBranchFailureOrSuccessOption)&&(identical(other.summaryRoundOffFailureOrSuccessOption, summaryRoundOffFailureOrSuccessOption) || other.summaryRoundOffFailureOrSuccessOption == summaryRoundOffFailureOrSuccessOption));
}


@override
int get hashCode => Object.hashAll([runtimeType,isInitialLoading,isBeneficiaryLoading,isPaymentMethodLoading,isSubmitting,isRateLoading,isSourceAmountCalculating,isDestinationAmountCalculating,isBranchesLoading,lastRawSourceAmount,lastRawDestinationAmount,isLastInputSource,beneficiaryId,isTranslistRequired,homeAgentCode,homeAgentName,beneficiaryFailure,paymentMethodFailure,summaryBeneficiaryByIdDto,commonSendMoneyDto,commonSourceSelectableDto,selectedCommonSourceItem,commonDestinationSelectableDto,selectedCommonDestinationItem,commonPaymentMethodSelectableDto,selectedPaymentMethodItem,summaryPaymentMethodDto,commonPaymentResultDto,summaryBranchesDto,selectedBranchItem,roundOffResult,summaryBeneficiaryByIdFailureOrSuccessOption,summarySourceCurrencyListFailureOrSuccessOption,summaryDestinationCurrencyListFailureOrSuccessOption,summaryCalculatedSourceAmountFailureOrSuccessOption,summaryCalculatedDestinationAmountFailureOrSuccessOption,summaryPaymentMethodFailureOrSuccessOption,summaryBranchesFailureOrSuccessOption,summaryPayAtBranchFailureOrSuccessOption,summaryRoundOffFailureOrSuccessOption]);

@override
String toString() {
  return 'SummaryState(isInitialLoading: $isInitialLoading, isBeneficiaryLoading: $isBeneficiaryLoading, isPaymentMethodLoading: $isPaymentMethodLoading, isSubmitting: $isSubmitting, isRateLoading: $isRateLoading, isSourceAmountCalculating: $isSourceAmountCalculating, isDestinationAmountCalculating: $isDestinationAmountCalculating, isBranchesLoading: $isBranchesLoading, lastRawSourceAmount: $lastRawSourceAmount, lastRawDestinationAmount: $lastRawDestinationAmount, isLastInputSource: $isLastInputSource, beneficiaryId: $beneficiaryId, isTranslistRequired: $isTranslistRequired, homeAgentCode: $homeAgentCode, homeAgentName: $homeAgentName, beneficiaryFailure: $beneficiaryFailure, paymentMethodFailure: $paymentMethodFailure, summaryBeneficiaryByIdDto: $summaryBeneficiaryByIdDto, commonSendMoneyDto: $commonSendMoneyDto, commonSourceSelectableDto: $commonSourceSelectableDto, selectedCommonSourceItem: $selectedCommonSourceItem, commonDestinationSelectableDto: $commonDestinationSelectableDto, selectedCommonDestinationItem: $selectedCommonDestinationItem, commonPaymentMethodSelectableDto: $commonPaymentMethodSelectableDto, selectedPaymentMethodItem: $selectedPaymentMethodItem, summaryPaymentMethodDto: $summaryPaymentMethodDto, commonPaymentResultDto: $commonPaymentResultDto, summaryBranchesDto: $summaryBranchesDto, selectedBranchItem: $selectedBranchItem, roundOffResult: $roundOffResult, summaryBeneficiaryByIdFailureOrSuccessOption: $summaryBeneficiaryByIdFailureOrSuccessOption, summarySourceCurrencyListFailureOrSuccessOption: $summarySourceCurrencyListFailureOrSuccessOption, summaryDestinationCurrencyListFailureOrSuccessOption: $summaryDestinationCurrencyListFailureOrSuccessOption, summaryCalculatedSourceAmountFailureOrSuccessOption: $summaryCalculatedSourceAmountFailureOrSuccessOption, summaryCalculatedDestinationAmountFailureOrSuccessOption: $summaryCalculatedDestinationAmountFailureOrSuccessOption, summaryPaymentMethodFailureOrSuccessOption: $summaryPaymentMethodFailureOrSuccessOption, summaryBranchesFailureOrSuccessOption: $summaryBranchesFailureOrSuccessOption, summaryPayAtBranchFailureOrSuccessOption: $summaryPayAtBranchFailureOrSuccessOption, summaryRoundOffFailureOrSuccessOption: $summaryRoundOffFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class $SummaryStateCopyWith<$Res>  {
  factory $SummaryStateCopyWith(SummaryState value, $Res Function(SummaryState) _then) = _$SummaryStateCopyWithImpl;
@useResult
$Res call({
 bool isInitialLoading, bool isBeneficiaryLoading, bool isPaymentMethodLoading, bool isSubmitting, bool isRateLoading, bool isSourceAmountCalculating, bool isDestinationAmountCalculating, bool isBranchesLoading, String lastRawSourceAmount, String lastRawDestinationAmount, bool isLastInputSource, String? beneficiaryId, bool isTranslistRequired, String homeAgentCode, String homeAgentName, SummaryFailure? beneficiaryFailure, SummaryFailure? paymentMethodFailure, SummaryBeneficiaryByIdDto? summaryBeneficiaryByIdDto, CommonSendMoneyDto commonSendMoneyDto, CommonSelectableDto? commonSourceSelectableDto, CommonSelectableItem? selectedCommonSourceItem, CommonSelectableDto? commonDestinationSelectableDto, CommonSelectableItem? selectedCommonDestinationItem, CommonSelectableDto? commonPaymentMethodSelectableDto, CommonSelectableItem? selectedPaymentMethodItem, SummaryPaymentMethodDto? summaryPaymentMethodDto, CommonPaymentResultDto? commonPaymentResultDto, CommonBranchesDto? summaryBranchesDto, CommonSelectableItem? selectedBranchItem, SummaryPaymentResultDto? roundOffResult, Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>> summaryBeneficiaryByIdFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryCurrencyListDto>> summarySourceCurrencyListFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryCurrencyListDto>> summaryDestinationCurrencyListFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedSourceAmountFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedDestinationAmountFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryPaymentMethodDto>> summaryPaymentMethodFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryBranchesDto>> summaryBranchesFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryPayAtBranchFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryRoundOffFailureOrSuccessOption
});


$SummaryFailureCopyWith<$Res>? get beneficiaryFailure;$SummaryFailureCopyWith<$Res>? get paymentMethodFailure;$SummaryBeneficiaryByIdDtoCopyWith<$Res>? get summaryBeneficiaryByIdDto;$CommonSendMoneyDtoCopyWith<$Res> get commonSendMoneyDto;$CommonSelectableDtoCopyWith<$Res>? get commonSourceSelectableDto;$CommonSelectableItemCopyWith<$Res>? get selectedCommonSourceItem;$CommonSelectableDtoCopyWith<$Res>? get commonDestinationSelectableDto;$CommonSelectableItemCopyWith<$Res>? get selectedCommonDestinationItem;$CommonSelectableDtoCopyWith<$Res>? get commonPaymentMethodSelectableDto;$CommonSelectableItemCopyWith<$Res>? get selectedPaymentMethodItem;$SummaryPaymentMethodDtoCopyWith<$Res>? get summaryPaymentMethodDto;$CommonPaymentResultDtoCopyWith<$Res>? get commonPaymentResultDto;$CommonBranchesDtoCopyWith<$Res>? get summaryBranchesDto;$CommonSelectableItemCopyWith<$Res>? get selectedBranchItem;$SummaryPaymentResultDtoCopyWith<$Res>? get roundOffResult;

}
/// @nodoc
class _$SummaryStateCopyWithImpl<$Res>
    implements $SummaryStateCopyWith<$Res> {
  _$SummaryStateCopyWithImpl(this._self, this._then);

  final SummaryState _self;
  final $Res Function(SummaryState) _then;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isInitialLoading = null,Object? isBeneficiaryLoading = null,Object? isPaymentMethodLoading = null,Object? isSubmitting = null,Object? isRateLoading = null,Object? isSourceAmountCalculating = null,Object? isDestinationAmountCalculating = null,Object? isBranchesLoading = null,Object? lastRawSourceAmount = null,Object? lastRawDestinationAmount = null,Object? isLastInputSource = null,Object? beneficiaryId = freezed,Object? isTranslistRequired = null,Object? homeAgentCode = null,Object? homeAgentName = null,Object? beneficiaryFailure = freezed,Object? paymentMethodFailure = freezed,Object? summaryBeneficiaryByIdDto = freezed,Object? commonSendMoneyDto = null,Object? commonSourceSelectableDto = freezed,Object? selectedCommonSourceItem = freezed,Object? commonDestinationSelectableDto = freezed,Object? selectedCommonDestinationItem = freezed,Object? commonPaymentMethodSelectableDto = freezed,Object? selectedPaymentMethodItem = freezed,Object? summaryPaymentMethodDto = freezed,Object? commonPaymentResultDto = freezed,Object? summaryBranchesDto = freezed,Object? selectedBranchItem = freezed,Object? roundOffResult = freezed,Object? summaryBeneficiaryByIdFailureOrSuccessOption = null,Object? summarySourceCurrencyListFailureOrSuccessOption = null,Object? summaryDestinationCurrencyListFailureOrSuccessOption = null,Object? summaryCalculatedSourceAmountFailureOrSuccessOption = null,Object? summaryCalculatedDestinationAmountFailureOrSuccessOption = null,Object? summaryPaymentMethodFailureOrSuccessOption = null,Object? summaryBranchesFailureOrSuccessOption = null,Object? summaryPayAtBranchFailureOrSuccessOption = null,Object? summaryRoundOffFailureOrSuccessOption = null,}) {
  return _then(_self.copyWith(
isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isBeneficiaryLoading: null == isBeneficiaryLoading ? _self.isBeneficiaryLoading : isBeneficiaryLoading // ignore: cast_nullable_to_non_nullable
as bool,isPaymentMethodLoading: null == isPaymentMethodLoading ? _self.isPaymentMethodLoading : isPaymentMethodLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isRateLoading: null == isRateLoading ? _self.isRateLoading : isRateLoading // ignore: cast_nullable_to_non_nullable
as bool,isSourceAmountCalculating: null == isSourceAmountCalculating ? _self.isSourceAmountCalculating : isSourceAmountCalculating // ignore: cast_nullable_to_non_nullable
as bool,isDestinationAmountCalculating: null == isDestinationAmountCalculating ? _self.isDestinationAmountCalculating : isDestinationAmountCalculating // ignore: cast_nullable_to_non_nullable
as bool,isBranchesLoading: null == isBranchesLoading ? _self.isBranchesLoading : isBranchesLoading // ignore: cast_nullable_to_non_nullable
as bool,lastRawSourceAmount: null == lastRawSourceAmount ? _self.lastRawSourceAmount : lastRawSourceAmount // ignore: cast_nullable_to_non_nullable
as String,lastRawDestinationAmount: null == lastRawDestinationAmount ? _self.lastRawDestinationAmount : lastRawDestinationAmount // ignore: cast_nullable_to_non_nullable
as String,isLastInputSource: null == isLastInputSource ? _self.isLastInputSource : isLastInputSource // ignore: cast_nullable_to_non_nullable
as bool,beneficiaryId: freezed == beneficiaryId ? _self.beneficiaryId : beneficiaryId // ignore: cast_nullable_to_non_nullable
as String?,isTranslistRequired: null == isTranslistRequired ? _self.isTranslistRequired : isTranslistRequired // ignore: cast_nullable_to_non_nullable
as bool,homeAgentCode: null == homeAgentCode ? _self.homeAgentCode : homeAgentCode // ignore: cast_nullable_to_non_nullable
as String,homeAgentName: null == homeAgentName ? _self.homeAgentName : homeAgentName // ignore: cast_nullable_to_non_nullable
as String,beneficiaryFailure: freezed == beneficiaryFailure ? _self.beneficiaryFailure : beneficiaryFailure // ignore: cast_nullable_to_non_nullable
as SummaryFailure?,paymentMethodFailure: freezed == paymentMethodFailure ? _self.paymentMethodFailure : paymentMethodFailure // ignore: cast_nullable_to_non_nullable
as SummaryFailure?,summaryBeneficiaryByIdDto: freezed == summaryBeneficiaryByIdDto ? _self.summaryBeneficiaryByIdDto : summaryBeneficiaryByIdDto // ignore: cast_nullable_to_non_nullable
as SummaryBeneficiaryByIdDto?,commonSendMoneyDto: null == commonSendMoneyDto ? _self.commonSendMoneyDto : commonSendMoneyDto // ignore: cast_nullable_to_non_nullable
as CommonSendMoneyDto,commonSourceSelectableDto: freezed == commonSourceSelectableDto ? _self.commonSourceSelectableDto : commonSourceSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedCommonSourceItem: freezed == selectedCommonSourceItem ? _self.selectedCommonSourceItem : selectedCommonSourceItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,commonDestinationSelectableDto: freezed == commonDestinationSelectableDto ? _self.commonDestinationSelectableDto : commonDestinationSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedCommonDestinationItem: freezed == selectedCommonDestinationItem ? _self.selectedCommonDestinationItem : selectedCommonDestinationItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,commonPaymentMethodSelectableDto: freezed == commonPaymentMethodSelectableDto ? _self.commonPaymentMethodSelectableDto : commonPaymentMethodSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedPaymentMethodItem: freezed == selectedPaymentMethodItem ? _self.selectedPaymentMethodItem : selectedPaymentMethodItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,summaryPaymentMethodDto: freezed == summaryPaymentMethodDto ? _self.summaryPaymentMethodDto : summaryPaymentMethodDto // ignore: cast_nullable_to_non_nullable
as SummaryPaymentMethodDto?,commonPaymentResultDto: freezed == commonPaymentResultDto ? _self.commonPaymentResultDto : commonPaymentResultDto // ignore: cast_nullable_to_non_nullable
as CommonPaymentResultDto?,summaryBranchesDto: freezed == summaryBranchesDto ? _self.summaryBranchesDto : summaryBranchesDto // ignore: cast_nullable_to_non_nullable
as CommonBranchesDto?,selectedBranchItem: freezed == selectedBranchItem ? _self.selectedBranchItem : selectedBranchItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,roundOffResult: freezed == roundOffResult ? _self.roundOffResult : roundOffResult // ignore: cast_nullable_to_non_nullable
as SummaryPaymentResultDto?,summaryBeneficiaryByIdFailureOrSuccessOption: null == summaryBeneficiaryByIdFailureOrSuccessOption ? _self.summaryBeneficiaryByIdFailureOrSuccessOption : summaryBeneficiaryByIdFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>>,summarySourceCurrencyListFailureOrSuccessOption: null == summarySourceCurrencyListFailureOrSuccessOption ? _self.summarySourceCurrencyListFailureOrSuccessOption : summarySourceCurrencyListFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryCurrencyListDto>>,summaryDestinationCurrencyListFailureOrSuccessOption: null == summaryDestinationCurrencyListFailureOrSuccessOption ? _self.summaryDestinationCurrencyListFailureOrSuccessOption : summaryDestinationCurrencyListFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryCurrencyListDto>>,summaryCalculatedSourceAmountFailureOrSuccessOption: null == summaryCalculatedSourceAmountFailureOrSuccessOption ? _self.summaryCalculatedSourceAmountFailureOrSuccessOption : summaryCalculatedSourceAmountFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryCalculateAmountDto>>,summaryCalculatedDestinationAmountFailureOrSuccessOption: null == summaryCalculatedDestinationAmountFailureOrSuccessOption ? _self.summaryCalculatedDestinationAmountFailureOrSuccessOption : summaryCalculatedDestinationAmountFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryCalculateAmountDto>>,summaryPaymentMethodFailureOrSuccessOption: null == summaryPaymentMethodFailureOrSuccessOption ? _self.summaryPaymentMethodFailureOrSuccessOption : summaryPaymentMethodFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryPaymentMethodDto>>,summaryBranchesFailureOrSuccessOption: null == summaryBranchesFailureOrSuccessOption ? _self.summaryBranchesFailureOrSuccessOption : summaryBranchesFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryBranchesDto>>,summaryPayAtBranchFailureOrSuccessOption: null == summaryPayAtBranchFailureOrSuccessOption ? _self.summaryPayAtBranchFailureOrSuccessOption : summaryPayAtBranchFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryPaymentResultDto>>,summaryRoundOffFailureOrSuccessOption: null == summaryRoundOffFailureOrSuccessOption ? _self.summaryRoundOffFailureOrSuccessOption : summaryRoundOffFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryPaymentResultDto>>,
  ));
}
/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryFailureCopyWith<$Res>? get beneficiaryFailure {
    if (_self.beneficiaryFailure == null) {
    return null;
  }

  return $SummaryFailureCopyWith<$Res>(_self.beneficiaryFailure!, (value) {
    return _then(_self.copyWith(beneficiaryFailure: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryFailureCopyWith<$Res>? get paymentMethodFailure {
    if (_self.paymentMethodFailure == null) {
    return null;
  }

  return $SummaryFailureCopyWith<$Res>(_self.paymentMethodFailure!, (value) {
    return _then(_self.copyWith(paymentMethodFailure: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryBeneficiaryByIdDtoCopyWith<$Res>? get summaryBeneficiaryByIdDto {
    if (_self.summaryBeneficiaryByIdDto == null) {
    return null;
  }

  return $SummaryBeneficiaryByIdDtoCopyWith<$Res>(_self.summaryBeneficiaryByIdDto!, (value) {
    return _then(_self.copyWith(summaryBeneficiaryByIdDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSendMoneyDtoCopyWith<$Res> get commonSendMoneyDto {
  
  return $CommonSendMoneyDtoCopyWith<$Res>(_self.commonSendMoneyDto, (value) {
    return _then(_self.copyWith(commonSendMoneyDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonSourceSelectableDto {
    if (_self.commonSourceSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonSourceSelectableDto!, (value) {
    return _then(_self.copyWith(commonSourceSelectableDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedCommonSourceItem {
    if (_self.selectedCommonSourceItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedCommonSourceItem!, (value) {
    return _then(_self.copyWith(selectedCommonSourceItem: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonDestinationSelectableDto {
    if (_self.commonDestinationSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonDestinationSelectableDto!, (value) {
    return _then(_self.copyWith(commonDestinationSelectableDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedCommonDestinationItem {
    if (_self.selectedCommonDestinationItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedCommonDestinationItem!, (value) {
    return _then(_self.copyWith(selectedCommonDestinationItem: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonPaymentMethodSelectableDto {
    if (_self.commonPaymentMethodSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonPaymentMethodSelectableDto!, (value) {
    return _then(_self.copyWith(commonPaymentMethodSelectableDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedPaymentMethodItem {
    if (_self.selectedPaymentMethodItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedPaymentMethodItem!, (value) {
    return _then(_self.copyWith(selectedPaymentMethodItem: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryPaymentMethodDtoCopyWith<$Res>? get summaryPaymentMethodDto {
    if (_self.summaryPaymentMethodDto == null) {
    return null;
  }

  return $SummaryPaymentMethodDtoCopyWith<$Res>(_self.summaryPaymentMethodDto!, (value) {
    return _then(_self.copyWith(summaryPaymentMethodDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonPaymentResultDtoCopyWith<$Res>? get commonPaymentResultDto {
    if (_self.commonPaymentResultDto == null) {
    return null;
  }

  return $CommonPaymentResultDtoCopyWith<$Res>(_self.commonPaymentResultDto!, (value) {
    return _then(_self.copyWith(commonPaymentResultDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonBranchesDtoCopyWith<$Res>? get summaryBranchesDto {
    if (_self.summaryBranchesDto == null) {
    return null;
  }

  return $CommonBranchesDtoCopyWith<$Res>(_self.summaryBranchesDto!, (value) {
    return _then(_self.copyWith(summaryBranchesDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedBranchItem {
    if (_self.selectedBranchItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedBranchItem!, (value) {
    return _then(_self.copyWith(selectedBranchItem: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryPaymentResultDtoCopyWith<$Res>? get roundOffResult {
    if (_self.roundOffResult == null) {
    return null;
  }

  return $SummaryPaymentResultDtoCopyWith<$Res>(_self.roundOffResult!, (value) {
    return _then(_self.copyWith(roundOffResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [SummaryState].
extension SummaryStatePatterns on SummaryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryState value)  $default,){
final _that = this;
switch (_that) {
case _SummaryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryState value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isInitialLoading,  bool isBeneficiaryLoading,  bool isPaymentMethodLoading,  bool isSubmitting,  bool isRateLoading,  bool isSourceAmountCalculating,  bool isDestinationAmountCalculating,  bool isBranchesLoading,  String lastRawSourceAmount,  String lastRawDestinationAmount,  bool isLastInputSource,  String? beneficiaryId,  bool isTranslistRequired,  String homeAgentCode,  String homeAgentName,  SummaryFailure? beneficiaryFailure,  SummaryFailure? paymentMethodFailure,  SummaryBeneficiaryByIdDto? summaryBeneficiaryByIdDto,  CommonSendMoneyDto commonSendMoneyDto,  CommonSelectableDto? commonSourceSelectableDto,  CommonSelectableItem? selectedCommonSourceItem,  CommonSelectableDto? commonDestinationSelectableDto,  CommonSelectableItem? selectedCommonDestinationItem,  CommonSelectableDto? commonPaymentMethodSelectableDto,  CommonSelectableItem? selectedPaymentMethodItem,  SummaryPaymentMethodDto? summaryPaymentMethodDto,  CommonPaymentResultDto? commonPaymentResultDto,  CommonBranchesDto? summaryBranchesDto,  CommonSelectableItem? selectedBranchItem,  SummaryPaymentResultDto? roundOffResult,  Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>> summaryBeneficiaryByIdFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCurrencyListDto>> summarySourceCurrencyListFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCurrencyListDto>> summaryDestinationCurrencyListFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedSourceAmountFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedDestinationAmountFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryPaymentMethodDto>> summaryPaymentMethodFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryBranchesDto>> summaryBranchesFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryPayAtBranchFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryRoundOffFailureOrSuccessOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryState() when $default != null:
return $default(_that.isInitialLoading,_that.isBeneficiaryLoading,_that.isPaymentMethodLoading,_that.isSubmitting,_that.isRateLoading,_that.isSourceAmountCalculating,_that.isDestinationAmountCalculating,_that.isBranchesLoading,_that.lastRawSourceAmount,_that.lastRawDestinationAmount,_that.isLastInputSource,_that.beneficiaryId,_that.isTranslistRequired,_that.homeAgentCode,_that.homeAgentName,_that.beneficiaryFailure,_that.paymentMethodFailure,_that.summaryBeneficiaryByIdDto,_that.commonSendMoneyDto,_that.commonSourceSelectableDto,_that.selectedCommonSourceItem,_that.commonDestinationSelectableDto,_that.selectedCommonDestinationItem,_that.commonPaymentMethodSelectableDto,_that.selectedPaymentMethodItem,_that.summaryPaymentMethodDto,_that.commonPaymentResultDto,_that.summaryBranchesDto,_that.selectedBranchItem,_that.roundOffResult,_that.summaryBeneficiaryByIdFailureOrSuccessOption,_that.summarySourceCurrencyListFailureOrSuccessOption,_that.summaryDestinationCurrencyListFailureOrSuccessOption,_that.summaryCalculatedSourceAmountFailureOrSuccessOption,_that.summaryCalculatedDestinationAmountFailureOrSuccessOption,_that.summaryPaymentMethodFailureOrSuccessOption,_that.summaryBranchesFailureOrSuccessOption,_that.summaryPayAtBranchFailureOrSuccessOption,_that.summaryRoundOffFailureOrSuccessOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isInitialLoading,  bool isBeneficiaryLoading,  bool isPaymentMethodLoading,  bool isSubmitting,  bool isRateLoading,  bool isSourceAmountCalculating,  bool isDestinationAmountCalculating,  bool isBranchesLoading,  String lastRawSourceAmount,  String lastRawDestinationAmount,  bool isLastInputSource,  String? beneficiaryId,  bool isTranslistRequired,  String homeAgentCode,  String homeAgentName,  SummaryFailure? beneficiaryFailure,  SummaryFailure? paymentMethodFailure,  SummaryBeneficiaryByIdDto? summaryBeneficiaryByIdDto,  CommonSendMoneyDto commonSendMoneyDto,  CommonSelectableDto? commonSourceSelectableDto,  CommonSelectableItem? selectedCommonSourceItem,  CommonSelectableDto? commonDestinationSelectableDto,  CommonSelectableItem? selectedCommonDestinationItem,  CommonSelectableDto? commonPaymentMethodSelectableDto,  CommonSelectableItem? selectedPaymentMethodItem,  SummaryPaymentMethodDto? summaryPaymentMethodDto,  CommonPaymentResultDto? commonPaymentResultDto,  CommonBranchesDto? summaryBranchesDto,  CommonSelectableItem? selectedBranchItem,  SummaryPaymentResultDto? roundOffResult,  Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>> summaryBeneficiaryByIdFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCurrencyListDto>> summarySourceCurrencyListFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCurrencyListDto>> summaryDestinationCurrencyListFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedSourceAmountFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedDestinationAmountFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryPaymentMethodDto>> summaryPaymentMethodFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryBranchesDto>> summaryBranchesFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryPayAtBranchFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryRoundOffFailureOrSuccessOption)  $default,) {final _that = this;
switch (_that) {
case _SummaryState():
return $default(_that.isInitialLoading,_that.isBeneficiaryLoading,_that.isPaymentMethodLoading,_that.isSubmitting,_that.isRateLoading,_that.isSourceAmountCalculating,_that.isDestinationAmountCalculating,_that.isBranchesLoading,_that.lastRawSourceAmount,_that.lastRawDestinationAmount,_that.isLastInputSource,_that.beneficiaryId,_that.isTranslistRequired,_that.homeAgentCode,_that.homeAgentName,_that.beneficiaryFailure,_that.paymentMethodFailure,_that.summaryBeneficiaryByIdDto,_that.commonSendMoneyDto,_that.commonSourceSelectableDto,_that.selectedCommonSourceItem,_that.commonDestinationSelectableDto,_that.selectedCommonDestinationItem,_that.commonPaymentMethodSelectableDto,_that.selectedPaymentMethodItem,_that.summaryPaymentMethodDto,_that.commonPaymentResultDto,_that.summaryBranchesDto,_that.selectedBranchItem,_that.roundOffResult,_that.summaryBeneficiaryByIdFailureOrSuccessOption,_that.summarySourceCurrencyListFailureOrSuccessOption,_that.summaryDestinationCurrencyListFailureOrSuccessOption,_that.summaryCalculatedSourceAmountFailureOrSuccessOption,_that.summaryCalculatedDestinationAmountFailureOrSuccessOption,_that.summaryPaymentMethodFailureOrSuccessOption,_that.summaryBranchesFailureOrSuccessOption,_that.summaryPayAtBranchFailureOrSuccessOption,_that.summaryRoundOffFailureOrSuccessOption);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isInitialLoading,  bool isBeneficiaryLoading,  bool isPaymentMethodLoading,  bool isSubmitting,  bool isRateLoading,  bool isSourceAmountCalculating,  bool isDestinationAmountCalculating,  bool isBranchesLoading,  String lastRawSourceAmount,  String lastRawDestinationAmount,  bool isLastInputSource,  String? beneficiaryId,  bool isTranslistRequired,  String homeAgentCode,  String homeAgentName,  SummaryFailure? beneficiaryFailure,  SummaryFailure? paymentMethodFailure,  SummaryBeneficiaryByIdDto? summaryBeneficiaryByIdDto,  CommonSendMoneyDto commonSendMoneyDto,  CommonSelectableDto? commonSourceSelectableDto,  CommonSelectableItem? selectedCommonSourceItem,  CommonSelectableDto? commonDestinationSelectableDto,  CommonSelectableItem? selectedCommonDestinationItem,  CommonSelectableDto? commonPaymentMethodSelectableDto,  CommonSelectableItem? selectedPaymentMethodItem,  SummaryPaymentMethodDto? summaryPaymentMethodDto,  CommonPaymentResultDto? commonPaymentResultDto,  CommonBranchesDto? summaryBranchesDto,  CommonSelectableItem? selectedBranchItem,  SummaryPaymentResultDto? roundOffResult,  Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>> summaryBeneficiaryByIdFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCurrencyListDto>> summarySourceCurrencyListFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCurrencyListDto>> summaryDestinationCurrencyListFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedSourceAmountFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedDestinationAmountFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryPaymentMethodDto>> summaryPaymentMethodFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryBranchesDto>> summaryBranchesFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryPayAtBranchFailureOrSuccessOption,  Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryRoundOffFailureOrSuccessOption)?  $default,) {final _that = this;
switch (_that) {
case _SummaryState() when $default != null:
return $default(_that.isInitialLoading,_that.isBeneficiaryLoading,_that.isPaymentMethodLoading,_that.isSubmitting,_that.isRateLoading,_that.isSourceAmountCalculating,_that.isDestinationAmountCalculating,_that.isBranchesLoading,_that.lastRawSourceAmount,_that.lastRawDestinationAmount,_that.isLastInputSource,_that.beneficiaryId,_that.isTranslistRequired,_that.homeAgentCode,_that.homeAgentName,_that.beneficiaryFailure,_that.paymentMethodFailure,_that.summaryBeneficiaryByIdDto,_that.commonSendMoneyDto,_that.commonSourceSelectableDto,_that.selectedCommonSourceItem,_that.commonDestinationSelectableDto,_that.selectedCommonDestinationItem,_that.commonPaymentMethodSelectableDto,_that.selectedPaymentMethodItem,_that.summaryPaymentMethodDto,_that.commonPaymentResultDto,_that.summaryBranchesDto,_that.selectedBranchItem,_that.roundOffResult,_that.summaryBeneficiaryByIdFailureOrSuccessOption,_that.summarySourceCurrencyListFailureOrSuccessOption,_that.summaryDestinationCurrencyListFailureOrSuccessOption,_that.summaryCalculatedSourceAmountFailureOrSuccessOption,_that.summaryCalculatedDestinationAmountFailureOrSuccessOption,_that.summaryPaymentMethodFailureOrSuccessOption,_that.summaryBranchesFailureOrSuccessOption,_that.summaryPayAtBranchFailureOrSuccessOption,_that.summaryRoundOffFailureOrSuccessOption);case _:
  return null;

}
}

}

/// @nodoc


class _SummaryState implements SummaryState {
  const _SummaryState({this.isInitialLoading = true, this.isBeneficiaryLoading = false, this.isPaymentMethodLoading = false, this.isSubmitting = false, this.isRateLoading = false, this.isSourceAmountCalculating = false, this.isDestinationAmountCalculating = false, this.isBranchesLoading = false, this.lastRawSourceAmount = '', this.lastRawDestinationAmount = '', this.isLastInputSource = true, this.beneficiaryId, this.isTranslistRequired = false, this.homeAgentCode = '', this.homeAgentName = '', this.beneficiaryFailure, this.paymentMethodFailure, this.summaryBeneficiaryByIdDto, required this.commonSendMoneyDto, this.commonSourceSelectableDto, this.selectedCommonSourceItem, this.commonDestinationSelectableDto, this.selectedCommonDestinationItem, this.commonPaymentMethodSelectableDto, this.selectedPaymentMethodItem, this.summaryPaymentMethodDto, this.commonPaymentResultDto, this.summaryBranchesDto, this.selectedBranchItem, this.roundOffResult, required this.summaryBeneficiaryByIdFailureOrSuccessOption, required this.summarySourceCurrencyListFailureOrSuccessOption, required this.summaryDestinationCurrencyListFailureOrSuccessOption, required this.summaryCalculatedSourceAmountFailureOrSuccessOption, required this.summaryCalculatedDestinationAmountFailureOrSuccessOption, required this.summaryPaymentMethodFailureOrSuccessOption, required this.summaryBranchesFailureOrSuccessOption, required this.summaryPayAtBranchFailureOrSuccessOption, required this.summaryRoundOffFailureOrSuccessOption});
  

@override@JsonKey() final  bool isInitialLoading;
@override@JsonKey() final  bool isBeneficiaryLoading;
@override@JsonKey() final  bool isPaymentMethodLoading;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isRateLoading;
@override@JsonKey() final  bool isSourceAmountCalculating;
@override@JsonKey() final  bool isDestinationAmountCalculating;
@override@JsonKey() final  bool isBranchesLoading;
@override@JsonKey() final  String lastRawSourceAmount;
@override@JsonKey() final  String lastRawDestinationAmount;
@override@JsonKey() final  bool isLastInputSource;
@override final  String? beneficiaryId;
@override@JsonKey() final  bool isTranslistRequired;
@override@JsonKey() final  String homeAgentCode;
@override@JsonKey() final  String homeAgentName;
@override final  SummaryFailure? beneficiaryFailure;
@override final  SummaryFailure? paymentMethodFailure;
@override final  SummaryBeneficiaryByIdDto? summaryBeneficiaryByIdDto;
@override final  CommonSendMoneyDto commonSendMoneyDto;
@override final  CommonSelectableDto? commonSourceSelectableDto;
@override final  CommonSelectableItem? selectedCommonSourceItem;
@override final  CommonSelectableDto? commonDestinationSelectableDto;
@override final  CommonSelectableItem? selectedCommonDestinationItem;
@override final  CommonSelectableDto? commonPaymentMethodSelectableDto;
@override final  CommonSelectableItem? selectedPaymentMethodItem;
@override final  SummaryPaymentMethodDto? summaryPaymentMethodDto;
@override final  CommonPaymentResultDto? commonPaymentResultDto;
@override final  CommonBranchesDto? summaryBranchesDto;
@override final  CommonSelectableItem? selectedBranchItem;
@override final  SummaryPaymentResultDto? roundOffResult;
@override final  Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>> summaryBeneficiaryByIdFailureOrSuccessOption;
@override final  Option<Either<SummaryFailure, SummaryCurrencyListDto>> summarySourceCurrencyListFailureOrSuccessOption;
@override final  Option<Either<SummaryFailure, SummaryCurrencyListDto>> summaryDestinationCurrencyListFailureOrSuccessOption;
@override final  Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedSourceAmountFailureOrSuccessOption;
@override final  Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedDestinationAmountFailureOrSuccessOption;
@override final  Option<Either<SummaryFailure, SummaryPaymentMethodDto>> summaryPaymentMethodFailureOrSuccessOption;
@override final  Option<Either<SummaryFailure, SummaryBranchesDto>> summaryBranchesFailureOrSuccessOption;
@override final  Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryPayAtBranchFailureOrSuccessOption;
@override final  Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryRoundOffFailureOrSuccessOption;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryStateCopyWith<_SummaryState> get copyWith => __$SummaryStateCopyWithImpl<_SummaryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryState&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isBeneficiaryLoading, isBeneficiaryLoading) || other.isBeneficiaryLoading == isBeneficiaryLoading)&&(identical(other.isPaymentMethodLoading, isPaymentMethodLoading) || other.isPaymentMethodLoading == isPaymentMethodLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isRateLoading, isRateLoading) || other.isRateLoading == isRateLoading)&&(identical(other.isSourceAmountCalculating, isSourceAmountCalculating) || other.isSourceAmountCalculating == isSourceAmountCalculating)&&(identical(other.isDestinationAmountCalculating, isDestinationAmountCalculating) || other.isDestinationAmountCalculating == isDestinationAmountCalculating)&&(identical(other.isBranchesLoading, isBranchesLoading) || other.isBranchesLoading == isBranchesLoading)&&(identical(other.lastRawSourceAmount, lastRawSourceAmount) || other.lastRawSourceAmount == lastRawSourceAmount)&&(identical(other.lastRawDestinationAmount, lastRawDestinationAmount) || other.lastRawDestinationAmount == lastRawDestinationAmount)&&(identical(other.isLastInputSource, isLastInputSource) || other.isLastInputSource == isLastInputSource)&&(identical(other.beneficiaryId, beneficiaryId) || other.beneficiaryId == beneficiaryId)&&(identical(other.isTranslistRequired, isTranslistRequired) || other.isTranslistRequired == isTranslistRequired)&&(identical(other.homeAgentCode, homeAgentCode) || other.homeAgentCode == homeAgentCode)&&(identical(other.homeAgentName, homeAgentName) || other.homeAgentName == homeAgentName)&&(identical(other.beneficiaryFailure, beneficiaryFailure) || other.beneficiaryFailure == beneficiaryFailure)&&(identical(other.paymentMethodFailure, paymentMethodFailure) || other.paymentMethodFailure == paymentMethodFailure)&&(identical(other.summaryBeneficiaryByIdDto, summaryBeneficiaryByIdDto) || other.summaryBeneficiaryByIdDto == summaryBeneficiaryByIdDto)&&(identical(other.commonSendMoneyDto, commonSendMoneyDto) || other.commonSendMoneyDto == commonSendMoneyDto)&&(identical(other.commonSourceSelectableDto, commonSourceSelectableDto) || other.commonSourceSelectableDto == commonSourceSelectableDto)&&(identical(other.selectedCommonSourceItem, selectedCommonSourceItem) || other.selectedCommonSourceItem == selectedCommonSourceItem)&&(identical(other.commonDestinationSelectableDto, commonDestinationSelectableDto) || other.commonDestinationSelectableDto == commonDestinationSelectableDto)&&(identical(other.selectedCommonDestinationItem, selectedCommonDestinationItem) || other.selectedCommonDestinationItem == selectedCommonDestinationItem)&&(identical(other.commonPaymentMethodSelectableDto, commonPaymentMethodSelectableDto) || other.commonPaymentMethodSelectableDto == commonPaymentMethodSelectableDto)&&(identical(other.selectedPaymentMethodItem, selectedPaymentMethodItem) || other.selectedPaymentMethodItem == selectedPaymentMethodItem)&&(identical(other.summaryPaymentMethodDto, summaryPaymentMethodDto) || other.summaryPaymentMethodDto == summaryPaymentMethodDto)&&(identical(other.commonPaymentResultDto, commonPaymentResultDto) || other.commonPaymentResultDto == commonPaymentResultDto)&&(identical(other.summaryBranchesDto, summaryBranchesDto) || other.summaryBranchesDto == summaryBranchesDto)&&(identical(other.selectedBranchItem, selectedBranchItem) || other.selectedBranchItem == selectedBranchItem)&&(identical(other.roundOffResult, roundOffResult) || other.roundOffResult == roundOffResult)&&(identical(other.summaryBeneficiaryByIdFailureOrSuccessOption, summaryBeneficiaryByIdFailureOrSuccessOption) || other.summaryBeneficiaryByIdFailureOrSuccessOption == summaryBeneficiaryByIdFailureOrSuccessOption)&&(identical(other.summarySourceCurrencyListFailureOrSuccessOption, summarySourceCurrencyListFailureOrSuccessOption) || other.summarySourceCurrencyListFailureOrSuccessOption == summarySourceCurrencyListFailureOrSuccessOption)&&(identical(other.summaryDestinationCurrencyListFailureOrSuccessOption, summaryDestinationCurrencyListFailureOrSuccessOption) || other.summaryDestinationCurrencyListFailureOrSuccessOption == summaryDestinationCurrencyListFailureOrSuccessOption)&&(identical(other.summaryCalculatedSourceAmountFailureOrSuccessOption, summaryCalculatedSourceAmountFailureOrSuccessOption) || other.summaryCalculatedSourceAmountFailureOrSuccessOption == summaryCalculatedSourceAmountFailureOrSuccessOption)&&(identical(other.summaryCalculatedDestinationAmountFailureOrSuccessOption, summaryCalculatedDestinationAmountFailureOrSuccessOption) || other.summaryCalculatedDestinationAmountFailureOrSuccessOption == summaryCalculatedDestinationAmountFailureOrSuccessOption)&&(identical(other.summaryPaymentMethodFailureOrSuccessOption, summaryPaymentMethodFailureOrSuccessOption) || other.summaryPaymentMethodFailureOrSuccessOption == summaryPaymentMethodFailureOrSuccessOption)&&(identical(other.summaryBranchesFailureOrSuccessOption, summaryBranchesFailureOrSuccessOption) || other.summaryBranchesFailureOrSuccessOption == summaryBranchesFailureOrSuccessOption)&&(identical(other.summaryPayAtBranchFailureOrSuccessOption, summaryPayAtBranchFailureOrSuccessOption) || other.summaryPayAtBranchFailureOrSuccessOption == summaryPayAtBranchFailureOrSuccessOption)&&(identical(other.summaryRoundOffFailureOrSuccessOption, summaryRoundOffFailureOrSuccessOption) || other.summaryRoundOffFailureOrSuccessOption == summaryRoundOffFailureOrSuccessOption));
}


@override
int get hashCode => Object.hashAll([runtimeType,isInitialLoading,isBeneficiaryLoading,isPaymentMethodLoading,isSubmitting,isRateLoading,isSourceAmountCalculating,isDestinationAmountCalculating,isBranchesLoading,lastRawSourceAmount,lastRawDestinationAmount,isLastInputSource,beneficiaryId,isTranslistRequired,homeAgentCode,homeAgentName,beneficiaryFailure,paymentMethodFailure,summaryBeneficiaryByIdDto,commonSendMoneyDto,commonSourceSelectableDto,selectedCommonSourceItem,commonDestinationSelectableDto,selectedCommonDestinationItem,commonPaymentMethodSelectableDto,selectedPaymentMethodItem,summaryPaymentMethodDto,commonPaymentResultDto,summaryBranchesDto,selectedBranchItem,roundOffResult,summaryBeneficiaryByIdFailureOrSuccessOption,summarySourceCurrencyListFailureOrSuccessOption,summaryDestinationCurrencyListFailureOrSuccessOption,summaryCalculatedSourceAmountFailureOrSuccessOption,summaryCalculatedDestinationAmountFailureOrSuccessOption,summaryPaymentMethodFailureOrSuccessOption,summaryBranchesFailureOrSuccessOption,summaryPayAtBranchFailureOrSuccessOption,summaryRoundOffFailureOrSuccessOption]);

@override
String toString() {
  return 'SummaryState(isInitialLoading: $isInitialLoading, isBeneficiaryLoading: $isBeneficiaryLoading, isPaymentMethodLoading: $isPaymentMethodLoading, isSubmitting: $isSubmitting, isRateLoading: $isRateLoading, isSourceAmountCalculating: $isSourceAmountCalculating, isDestinationAmountCalculating: $isDestinationAmountCalculating, isBranchesLoading: $isBranchesLoading, lastRawSourceAmount: $lastRawSourceAmount, lastRawDestinationAmount: $lastRawDestinationAmount, isLastInputSource: $isLastInputSource, beneficiaryId: $beneficiaryId, isTranslistRequired: $isTranslistRequired, homeAgentCode: $homeAgentCode, homeAgentName: $homeAgentName, beneficiaryFailure: $beneficiaryFailure, paymentMethodFailure: $paymentMethodFailure, summaryBeneficiaryByIdDto: $summaryBeneficiaryByIdDto, commonSendMoneyDto: $commonSendMoneyDto, commonSourceSelectableDto: $commonSourceSelectableDto, selectedCommonSourceItem: $selectedCommonSourceItem, commonDestinationSelectableDto: $commonDestinationSelectableDto, selectedCommonDestinationItem: $selectedCommonDestinationItem, commonPaymentMethodSelectableDto: $commonPaymentMethodSelectableDto, selectedPaymentMethodItem: $selectedPaymentMethodItem, summaryPaymentMethodDto: $summaryPaymentMethodDto, commonPaymentResultDto: $commonPaymentResultDto, summaryBranchesDto: $summaryBranchesDto, selectedBranchItem: $selectedBranchItem, roundOffResult: $roundOffResult, summaryBeneficiaryByIdFailureOrSuccessOption: $summaryBeneficiaryByIdFailureOrSuccessOption, summarySourceCurrencyListFailureOrSuccessOption: $summarySourceCurrencyListFailureOrSuccessOption, summaryDestinationCurrencyListFailureOrSuccessOption: $summaryDestinationCurrencyListFailureOrSuccessOption, summaryCalculatedSourceAmountFailureOrSuccessOption: $summaryCalculatedSourceAmountFailureOrSuccessOption, summaryCalculatedDestinationAmountFailureOrSuccessOption: $summaryCalculatedDestinationAmountFailureOrSuccessOption, summaryPaymentMethodFailureOrSuccessOption: $summaryPaymentMethodFailureOrSuccessOption, summaryBranchesFailureOrSuccessOption: $summaryBranchesFailureOrSuccessOption, summaryPayAtBranchFailureOrSuccessOption: $summaryPayAtBranchFailureOrSuccessOption, summaryRoundOffFailureOrSuccessOption: $summaryRoundOffFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class _$SummaryStateCopyWith<$Res> implements $SummaryStateCopyWith<$Res> {
  factory _$SummaryStateCopyWith(_SummaryState value, $Res Function(_SummaryState) _then) = __$SummaryStateCopyWithImpl;
@override @useResult
$Res call({
 bool isInitialLoading, bool isBeneficiaryLoading, bool isPaymentMethodLoading, bool isSubmitting, bool isRateLoading, bool isSourceAmountCalculating, bool isDestinationAmountCalculating, bool isBranchesLoading, String lastRawSourceAmount, String lastRawDestinationAmount, bool isLastInputSource, String? beneficiaryId, bool isTranslistRequired, String homeAgentCode, String homeAgentName, SummaryFailure? beneficiaryFailure, SummaryFailure? paymentMethodFailure, SummaryBeneficiaryByIdDto? summaryBeneficiaryByIdDto, CommonSendMoneyDto commonSendMoneyDto, CommonSelectableDto? commonSourceSelectableDto, CommonSelectableItem? selectedCommonSourceItem, CommonSelectableDto? commonDestinationSelectableDto, CommonSelectableItem? selectedCommonDestinationItem, CommonSelectableDto? commonPaymentMethodSelectableDto, CommonSelectableItem? selectedPaymentMethodItem, SummaryPaymentMethodDto? summaryPaymentMethodDto, CommonPaymentResultDto? commonPaymentResultDto, CommonBranchesDto? summaryBranchesDto, CommonSelectableItem? selectedBranchItem, SummaryPaymentResultDto? roundOffResult, Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>> summaryBeneficiaryByIdFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryCurrencyListDto>> summarySourceCurrencyListFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryCurrencyListDto>> summaryDestinationCurrencyListFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedSourceAmountFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryCalculateAmountDto>> summaryCalculatedDestinationAmountFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryPaymentMethodDto>> summaryPaymentMethodFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryBranchesDto>> summaryBranchesFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryPayAtBranchFailureOrSuccessOption, Option<Either<SummaryFailure, SummaryPaymentResultDto>> summaryRoundOffFailureOrSuccessOption
});


@override $SummaryFailureCopyWith<$Res>? get beneficiaryFailure;@override $SummaryFailureCopyWith<$Res>? get paymentMethodFailure;@override $SummaryBeneficiaryByIdDtoCopyWith<$Res>? get summaryBeneficiaryByIdDto;@override $CommonSendMoneyDtoCopyWith<$Res> get commonSendMoneyDto;@override $CommonSelectableDtoCopyWith<$Res>? get commonSourceSelectableDto;@override $CommonSelectableItemCopyWith<$Res>? get selectedCommonSourceItem;@override $CommonSelectableDtoCopyWith<$Res>? get commonDestinationSelectableDto;@override $CommonSelectableItemCopyWith<$Res>? get selectedCommonDestinationItem;@override $CommonSelectableDtoCopyWith<$Res>? get commonPaymentMethodSelectableDto;@override $CommonSelectableItemCopyWith<$Res>? get selectedPaymentMethodItem;@override $SummaryPaymentMethodDtoCopyWith<$Res>? get summaryPaymentMethodDto;@override $CommonPaymentResultDtoCopyWith<$Res>? get commonPaymentResultDto;@override $CommonBranchesDtoCopyWith<$Res>? get summaryBranchesDto;@override $CommonSelectableItemCopyWith<$Res>? get selectedBranchItem;@override $SummaryPaymentResultDtoCopyWith<$Res>? get roundOffResult;

}
/// @nodoc
class __$SummaryStateCopyWithImpl<$Res>
    implements _$SummaryStateCopyWith<$Res> {
  __$SummaryStateCopyWithImpl(this._self, this._then);

  final _SummaryState _self;
  final $Res Function(_SummaryState) _then;

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isInitialLoading = null,Object? isBeneficiaryLoading = null,Object? isPaymentMethodLoading = null,Object? isSubmitting = null,Object? isRateLoading = null,Object? isSourceAmountCalculating = null,Object? isDestinationAmountCalculating = null,Object? isBranchesLoading = null,Object? lastRawSourceAmount = null,Object? lastRawDestinationAmount = null,Object? isLastInputSource = null,Object? beneficiaryId = freezed,Object? isTranslistRequired = null,Object? homeAgentCode = null,Object? homeAgentName = null,Object? beneficiaryFailure = freezed,Object? paymentMethodFailure = freezed,Object? summaryBeneficiaryByIdDto = freezed,Object? commonSendMoneyDto = null,Object? commonSourceSelectableDto = freezed,Object? selectedCommonSourceItem = freezed,Object? commonDestinationSelectableDto = freezed,Object? selectedCommonDestinationItem = freezed,Object? commonPaymentMethodSelectableDto = freezed,Object? selectedPaymentMethodItem = freezed,Object? summaryPaymentMethodDto = freezed,Object? commonPaymentResultDto = freezed,Object? summaryBranchesDto = freezed,Object? selectedBranchItem = freezed,Object? roundOffResult = freezed,Object? summaryBeneficiaryByIdFailureOrSuccessOption = null,Object? summarySourceCurrencyListFailureOrSuccessOption = null,Object? summaryDestinationCurrencyListFailureOrSuccessOption = null,Object? summaryCalculatedSourceAmountFailureOrSuccessOption = null,Object? summaryCalculatedDestinationAmountFailureOrSuccessOption = null,Object? summaryPaymentMethodFailureOrSuccessOption = null,Object? summaryBranchesFailureOrSuccessOption = null,Object? summaryPayAtBranchFailureOrSuccessOption = null,Object? summaryRoundOffFailureOrSuccessOption = null,}) {
  return _then(_SummaryState(
isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isBeneficiaryLoading: null == isBeneficiaryLoading ? _self.isBeneficiaryLoading : isBeneficiaryLoading // ignore: cast_nullable_to_non_nullable
as bool,isPaymentMethodLoading: null == isPaymentMethodLoading ? _self.isPaymentMethodLoading : isPaymentMethodLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isRateLoading: null == isRateLoading ? _self.isRateLoading : isRateLoading // ignore: cast_nullable_to_non_nullable
as bool,isSourceAmountCalculating: null == isSourceAmountCalculating ? _self.isSourceAmountCalculating : isSourceAmountCalculating // ignore: cast_nullable_to_non_nullable
as bool,isDestinationAmountCalculating: null == isDestinationAmountCalculating ? _self.isDestinationAmountCalculating : isDestinationAmountCalculating // ignore: cast_nullable_to_non_nullable
as bool,isBranchesLoading: null == isBranchesLoading ? _self.isBranchesLoading : isBranchesLoading // ignore: cast_nullable_to_non_nullable
as bool,lastRawSourceAmount: null == lastRawSourceAmount ? _self.lastRawSourceAmount : lastRawSourceAmount // ignore: cast_nullable_to_non_nullable
as String,lastRawDestinationAmount: null == lastRawDestinationAmount ? _self.lastRawDestinationAmount : lastRawDestinationAmount // ignore: cast_nullable_to_non_nullable
as String,isLastInputSource: null == isLastInputSource ? _self.isLastInputSource : isLastInputSource // ignore: cast_nullable_to_non_nullable
as bool,beneficiaryId: freezed == beneficiaryId ? _self.beneficiaryId : beneficiaryId // ignore: cast_nullable_to_non_nullable
as String?,isTranslistRequired: null == isTranslistRequired ? _self.isTranslistRequired : isTranslistRequired // ignore: cast_nullable_to_non_nullable
as bool,homeAgentCode: null == homeAgentCode ? _self.homeAgentCode : homeAgentCode // ignore: cast_nullable_to_non_nullable
as String,homeAgentName: null == homeAgentName ? _self.homeAgentName : homeAgentName // ignore: cast_nullable_to_non_nullable
as String,beneficiaryFailure: freezed == beneficiaryFailure ? _self.beneficiaryFailure : beneficiaryFailure // ignore: cast_nullable_to_non_nullable
as SummaryFailure?,paymentMethodFailure: freezed == paymentMethodFailure ? _self.paymentMethodFailure : paymentMethodFailure // ignore: cast_nullable_to_non_nullable
as SummaryFailure?,summaryBeneficiaryByIdDto: freezed == summaryBeneficiaryByIdDto ? _self.summaryBeneficiaryByIdDto : summaryBeneficiaryByIdDto // ignore: cast_nullable_to_non_nullable
as SummaryBeneficiaryByIdDto?,commonSendMoneyDto: null == commonSendMoneyDto ? _self.commonSendMoneyDto : commonSendMoneyDto // ignore: cast_nullable_to_non_nullable
as CommonSendMoneyDto,commonSourceSelectableDto: freezed == commonSourceSelectableDto ? _self.commonSourceSelectableDto : commonSourceSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedCommonSourceItem: freezed == selectedCommonSourceItem ? _self.selectedCommonSourceItem : selectedCommonSourceItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,commonDestinationSelectableDto: freezed == commonDestinationSelectableDto ? _self.commonDestinationSelectableDto : commonDestinationSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedCommonDestinationItem: freezed == selectedCommonDestinationItem ? _self.selectedCommonDestinationItem : selectedCommonDestinationItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,commonPaymentMethodSelectableDto: freezed == commonPaymentMethodSelectableDto ? _self.commonPaymentMethodSelectableDto : commonPaymentMethodSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedPaymentMethodItem: freezed == selectedPaymentMethodItem ? _self.selectedPaymentMethodItem : selectedPaymentMethodItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,summaryPaymentMethodDto: freezed == summaryPaymentMethodDto ? _self.summaryPaymentMethodDto : summaryPaymentMethodDto // ignore: cast_nullable_to_non_nullable
as SummaryPaymentMethodDto?,commonPaymentResultDto: freezed == commonPaymentResultDto ? _self.commonPaymentResultDto : commonPaymentResultDto // ignore: cast_nullable_to_non_nullable
as CommonPaymentResultDto?,summaryBranchesDto: freezed == summaryBranchesDto ? _self.summaryBranchesDto : summaryBranchesDto // ignore: cast_nullable_to_non_nullable
as CommonBranchesDto?,selectedBranchItem: freezed == selectedBranchItem ? _self.selectedBranchItem : selectedBranchItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,roundOffResult: freezed == roundOffResult ? _self.roundOffResult : roundOffResult // ignore: cast_nullable_to_non_nullable
as SummaryPaymentResultDto?,summaryBeneficiaryByIdFailureOrSuccessOption: null == summaryBeneficiaryByIdFailureOrSuccessOption ? _self.summaryBeneficiaryByIdFailureOrSuccessOption : summaryBeneficiaryByIdFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryBeneficiaryByIdDto>>,summarySourceCurrencyListFailureOrSuccessOption: null == summarySourceCurrencyListFailureOrSuccessOption ? _self.summarySourceCurrencyListFailureOrSuccessOption : summarySourceCurrencyListFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryCurrencyListDto>>,summaryDestinationCurrencyListFailureOrSuccessOption: null == summaryDestinationCurrencyListFailureOrSuccessOption ? _self.summaryDestinationCurrencyListFailureOrSuccessOption : summaryDestinationCurrencyListFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryCurrencyListDto>>,summaryCalculatedSourceAmountFailureOrSuccessOption: null == summaryCalculatedSourceAmountFailureOrSuccessOption ? _self.summaryCalculatedSourceAmountFailureOrSuccessOption : summaryCalculatedSourceAmountFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryCalculateAmountDto>>,summaryCalculatedDestinationAmountFailureOrSuccessOption: null == summaryCalculatedDestinationAmountFailureOrSuccessOption ? _self.summaryCalculatedDestinationAmountFailureOrSuccessOption : summaryCalculatedDestinationAmountFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryCalculateAmountDto>>,summaryPaymentMethodFailureOrSuccessOption: null == summaryPaymentMethodFailureOrSuccessOption ? _self.summaryPaymentMethodFailureOrSuccessOption : summaryPaymentMethodFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryPaymentMethodDto>>,summaryBranchesFailureOrSuccessOption: null == summaryBranchesFailureOrSuccessOption ? _self.summaryBranchesFailureOrSuccessOption : summaryBranchesFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryBranchesDto>>,summaryPayAtBranchFailureOrSuccessOption: null == summaryPayAtBranchFailureOrSuccessOption ? _self.summaryPayAtBranchFailureOrSuccessOption : summaryPayAtBranchFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryPaymentResultDto>>,summaryRoundOffFailureOrSuccessOption: null == summaryRoundOffFailureOrSuccessOption ? _self.summaryRoundOffFailureOrSuccessOption : summaryRoundOffFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<SummaryFailure, SummaryPaymentResultDto>>,
  ));
}

/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryFailureCopyWith<$Res>? get beneficiaryFailure {
    if (_self.beneficiaryFailure == null) {
    return null;
  }

  return $SummaryFailureCopyWith<$Res>(_self.beneficiaryFailure!, (value) {
    return _then(_self.copyWith(beneficiaryFailure: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryFailureCopyWith<$Res>? get paymentMethodFailure {
    if (_self.paymentMethodFailure == null) {
    return null;
  }

  return $SummaryFailureCopyWith<$Res>(_self.paymentMethodFailure!, (value) {
    return _then(_self.copyWith(paymentMethodFailure: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryBeneficiaryByIdDtoCopyWith<$Res>? get summaryBeneficiaryByIdDto {
    if (_self.summaryBeneficiaryByIdDto == null) {
    return null;
  }

  return $SummaryBeneficiaryByIdDtoCopyWith<$Res>(_self.summaryBeneficiaryByIdDto!, (value) {
    return _then(_self.copyWith(summaryBeneficiaryByIdDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSendMoneyDtoCopyWith<$Res> get commonSendMoneyDto {
  
  return $CommonSendMoneyDtoCopyWith<$Res>(_self.commonSendMoneyDto, (value) {
    return _then(_self.copyWith(commonSendMoneyDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonSourceSelectableDto {
    if (_self.commonSourceSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonSourceSelectableDto!, (value) {
    return _then(_self.copyWith(commonSourceSelectableDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedCommonSourceItem {
    if (_self.selectedCommonSourceItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedCommonSourceItem!, (value) {
    return _then(_self.copyWith(selectedCommonSourceItem: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonDestinationSelectableDto {
    if (_self.commonDestinationSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonDestinationSelectableDto!, (value) {
    return _then(_self.copyWith(commonDestinationSelectableDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedCommonDestinationItem {
    if (_self.selectedCommonDestinationItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedCommonDestinationItem!, (value) {
    return _then(_self.copyWith(selectedCommonDestinationItem: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonPaymentMethodSelectableDto {
    if (_self.commonPaymentMethodSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonPaymentMethodSelectableDto!, (value) {
    return _then(_self.copyWith(commonPaymentMethodSelectableDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedPaymentMethodItem {
    if (_self.selectedPaymentMethodItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedPaymentMethodItem!, (value) {
    return _then(_self.copyWith(selectedPaymentMethodItem: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryPaymentMethodDtoCopyWith<$Res>? get summaryPaymentMethodDto {
    if (_self.summaryPaymentMethodDto == null) {
    return null;
  }

  return $SummaryPaymentMethodDtoCopyWith<$Res>(_self.summaryPaymentMethodDto!, (value) {
    return _then(_self.copyWith(summaryPaymentMethodDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonPaymentResultDtoCopyWith<$Res>? get commonPaymentResultDto {
    if (_self.commonPaymentResultDto == null) {
    return null;
  }

  return $CommonPaymentResultDtoCopyWith<$Res>(_self.commonPaymentResultDto!, (value) {
    return _then(_self.copyWith(commonPaymentResultDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonBranchesDtoCopyWith<$Res>? get summaryBranchesDto {
    if (_self.summaryBranchesDto == null) {
    return null;
  }

  return $CommonBranchesDtoCopyWith<$Res>(_self.summaryBranchesDto!, (value) {
    return _then(_self.copyWith(summaryBranchesDto: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedBranchItem {
    if (_self.selectedBranchItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedBranchItem!, (value) {
    return _then(_self.copyWith(selectedBranchItem: value));
  });
}/// Create a copy of SummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryPaymentResultDtoCopyWith<$Res>? get roundOffResult {
    if (_self.roundOffResult == null) {
    return null;
  }

  return $SummaryPaymentResultDtoCopyWith<$Res>(_self.roundOffResult!, (value) {
    return _then(_self.copyWith(roundOffResult: value));
  });
}
}

// dart format on
