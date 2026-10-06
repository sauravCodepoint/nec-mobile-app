// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InitializeEvent value)?  initialize,TResult Function( _GetHomeRecentBeneficiariesEvent value)?  getHomeRecentBeneficiaries,TResult Function( _GetHomeRecentTransactionsEvent value)?  getHomeRecentTransactions,TResult Function( _RecentBeneficiaryTappedEvent value)?  recentBeneficiaryTapped,TResult Function( _RecentBeneficiaryAgentSelectedEvent value)?  recentBeneficiaryAgentSelected,TResult Function( _DestinationCountrySelectedEvent value)?  destinationCountrySelected,TResult Function( _GetHomeTransferTypesEvent value)?  getHomeTransferTypes,TResult Function( _RetryCorridorEvent value)?  retryCorridor,TResult Function( _TransferTypeSelectedEvent value)?  transferTypeSelected,TResult Function( _GetHomeBankOrAgentListEvent value)?  getHomeBankOrAgentList,TResult Function( _BankOrAgentSelectedEvent value)?  bankOrAgentSelected,TResult Function( _GetHomeAgentListEvent value)?  getHomeAgentList,TResult Function( _AgentSelectedEvent value)?  agentSelected,TResult Function( _GetBeneficiaryListEvent value)?  getBeneficiaryList,TResult Function( _SelectedBeneficiaryIndexChangedEvent value)?  selectedBeneficiaryIndexChanged,TResult Function( _DeleteBeneficiaryEvent value)?  deleteBeneficiary,TResult Function( _SelectedBeneficiaryContinuePressedEvent value)?  selectedBeneficiaryContinuePressed,TResult Function( _CurrentEmailAddressChanged value)?  currentEmailAddressChanged,TResult Function( _UpdateEmailAddressChanged value)?  updateEmailAddressChanged,TResult Function( _RequestUpdateEmailAddressPressed value)?  requestUpdateEmailAddressPressed,TResult Function( _EmailOtpChanged value)?  emailOtpChanged,TResult Function( _ContinueOtpButtonPressed value)?  continueOtpButtonPressed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitializeEvent() when initialize != null:
return initialize(_that);case _GetHomeRecentBeneficiariesEvent() when getHomeRecentBeneficiaries != null:
return getHomeRecentBeneficiaries(_that);case _GetHomeRecentTransactionsEvent() when getHomeRecentTransactions != null:
return getHomeRecentTransactions(_that);case _RecentBeneficiaryTappedEvent() when recentBeneficiaryTapped != null:
return recentBeneficiaryTapped(_that);case _RecentBeneficiaryAgentSelectedEvent() when recentBeneficiaryAgentSelected != null:
return recentBeneficiaryAgentSelected(_that);case _DestinationCountrySelectedEvent() when destinationCountrySelected != null:
return destinationCountrySelected(_that);case _GetHomeTransferTypesEvent() when getHomeTransferTypes != null:
return getHomeTransferTypes(_that);case _RetryCorridorEvent() when retryCorridor != null:
return retryCorridor(_that);case _TransferTypeSelectedEvent() when transferTypeSelected != null:
return transferTypeSelected(_that);case _GetHomeBankOrAgentListEvent() when getHomeBankOrAgentList != null:
return getHomeBankOrAgentList(_that);case _BankOrAgentSelectedEvent() when bankOrAgentSelected != null:
return bankOrAgentSelected(_that);case _GetHomeAgentListEvent() when getHomeAgentList != null:
return getHomeAgentList(_that);case _AgentSelectedEvent() when agentSelected != null:
return agentSelected(_that);case _GetBeneficiaryListEvent() when getBeneficiaryList != null:
return getBeneficiaryList(_that);case _SelectedBeneficiaryIndexChangedEvent() when selectedBeneficiaryIndexChanged != null:
return selectedBeneficiaryIndexChanged(_that);case _DeleteBeneficiaryEvent() when deleteBeneficiary != null:
return deleteBeneficiary(_that);case _SelectedBeneficiaryContinuePressedEvent() when selectedBeneficiaryContinuePressed != null:
return selectedBeneficiaryContinuePressed(_that);case _CurrentEmailAddressChanged() when currentEmailAddressChanged != null:
return currentEmailAddressChanged(_that);case _UpdateEmailAddressChanged() when updateEmailAddressChanged != null:
return updateEmailAddressChanged(_that);case _RequestUpdateEmailAddressPressed() when requestUpdateEmailAddressPressed != null:
return requestUpdateEmailAddressPressed(_that);case _EmailOtpChanged() when emailOtpChanged != null:
return emailOtpChanged(_that);case _ContinueOtpButtonPressed() when continueOtpButtonPressed != null:
return continueOtpButtonPressed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InitializeEvent value)  initialize,required TResult Function( _GetHomeRecentBeneficiariesEvent value)  getHomeRecentBeneficiaries,required TResult Function( _GetHomeRecentTransactionsEvent value)  getHomeRecentTransactions,required TResult Function( _RecentBeneficiaryTappedEvent value)  recentBeneficiaryTapped,required TResult Function( _RecentBeneficiaryAgentSelectedEvent value)  recentBeneficiaryAgentSelected,required TResult Function( _DestinationCountrySelectedEvent value)  destinationCountrySelected,required TResult Function( _GetHomeTransferTypesEvent value)  getHomeTransferTypes,required TResult Function( _RetryCorridorEvent value)  retryCorridor,required TResult Function( _TransferTypeSelectedEvent value)  transferTypeSelected,required TResult Function( _GetHomeBankOrAgentListEvent value)  getHomeBankOrAgentList,required TResult Function( _BankOrAgentSelectedEvent value)  bankOrAgentSelected,required TResult Function( _GetHomeAgentListEvent value)  getHomeAgentList,required TResult Function( _AgentSelectedEvent value)  agentSelected,required TResult Function( _GetBeneficiaryListEvent value)  getBeneficiaryList,required TResult Function( _SelectedBeneficiaryIndexChangedEvent value)  selectedBeneficiaryIndexChanged,required TResult Function( _DeleteBeneficiaryEvent value)  deleteBeneficiary,required TResult Function( _SelectedBeneficiaryContinuePressedEvent value)  selectedBeneficiaryContinuePressed,required TResult Function( _CurrentEmailAddressChanged value)  currentEmailAddressChanged,required TResult Function( _UpdateEmailAddressChanged value)  updateEmailAddressChanged,required TResult Function( _RequestUpdateEmailAddressPressed value)  requestUpdateEmailAddressPressed,required TResult Function( _EmailOtpChanged value)  emailOtpChanged,required TResult Function( _ContinueOtpButtonPressed value)  continueOtpButtonPressed,}){
final _that = this;
switch (_that) {
case _InitializeEvent():
return initialize(_that);case _GetHomeRecentBeneficiariesEvent():
return getHomeRecentBeneficiaries(_that);case _GetHomeRecentTransactionsEvent():
return getHomeRecentTransactions(_that);case _RecentBeneficiaryTappedEvent():
return recentBeneficiaryTapped(_that);case _RecentBeneficiaryAgentSelectedEvent():
return recentBeneficiaryAgentSelected(_that);case _DestinationCountrySelectedEvent():
return destinationCountrySelected(_that);case _GetHomeTransferTypesEvent():
return getHomeTransferTypes(_that);case _RetryCorridorEvent():
return retryCorridor(_that);case _TransferTypeSelectedEvent():
return transferTypeSelected(_that);case _GetHomeBankOrAgentListEvent():
return getHomeBankOrAgentList(_that);case _BankOrAgentSelectedEvent():
return bankOrAgentSelected(_that);case _GetHomeAgentListEvent():
return getHomeAgentList(_that);case _AgentSelectedEvent():
return agentSelected(_that);case _GetBeneficiaryListEvent():
return getBeneficiaryList(_that);case _SelectedBeneficiaryIndexChangedEvent():
return selectedBeneficiaryIndexChanged(_that);case _DeleteBeneficiaryEvent():
return deleteBeneficiary(_that);case _SelectedBeneficiaryContinuePressedEvent():
return selectedBeneficiaryContinuePressed(_that);case _CurrentEmailAddressChanged():
return currentEmailAddressChanged(_that);case _UpdateEmailAddressChanged():
return updateEmailAddressChanged(_that);case _RequestUpdateEmailAddressPressed():
return requestUpdateEmailAddressPressed(_that);case _EmailOtpChanged():
return emailOtpChanged(_that);case _ContinueOtpButtonPressed():
return continueOtpButtonPressed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InitializeEvent value)?  initialize,TResult? Function( _GetHomeRecentBeneficiariesEvent value)?  getHomeRecentBeneficiaries,TResult? Function( _GetHomeRecentTransactionsEvent value)?  getHomeRecentTransactions,TResult? Function( _RecentBeneficiaryTappedEvent value)?  recentBeneficiaryTapped,TResult? Function( _RecentBeneficiaryAgentSelectedEvent value)?  recentBeneficiaryAgentSelected,TResult? Function( _DestinationCountrySelectedEvent value)?  destinationCountrySelected,TResult? Function( _GetHomeTransferTypesEvent value)?  getHomeTransferTypes,TResult? Function( _RetryCorridorEvent value)?  retryCorridor,TResult? Function( _TransferTypeSelectedEvent value)?  transferTypeSelected,TResult? Function( _GetHomeBankOrAgentListEvent value)?  getHomeBankOrAgentList,TResult? Function( _BankOrAgentSelectedEvent value)?  bankOrAgentSelected,TResult? Function( _GetHomeAgentListEvent value)?  getHomeAgentList,TResult? Function( _AgentSelectedEvent value)?  agentSelected,TResult? Function( _GetBeneficiaryListEvent value)?  getBeneficiaryList,TResult? Function( _SelectedBeneficiaryIndexChangedEvent value)?  selectedBeneficiaryIndexChanged,TResult? Function( _DeleteBeneficiaryEvent value)?  deleteBeneficiary,TResult? Function( _SelectedBeneficiaryContinuePressedEvent value)?  selectedBeneficiaryContinuePressed,TResult? Function( _CurrentEmailAddressChanged value)?  currentEmailAddressChanged,TResult? Function( _UpdateEmailAddressChanged value)?  updateEmailAddressChanged,TResult? Function( _RequestUpdateEmailAddressPressed value)?  requestUpdateEmailAddressPressed,TResult? Function( _EmailOtpChanged value)?  emailOtpChanged,TResult? Function( _ContinueOtpButtonPressed value)?  continueOtpButtonPressed,}){
final _that = this;
switch (_that) {
case _InitializeEvent() when initialize != null:
return initialize(_that);case _GetHomeRecentBeneficiariesEvent() when getHomeRecentBeneficiaries != null:
return getHomeRecentBeneficiaries(_that);case _GetHomeRecentTransactionsEvent() when getHomeRecentTransactions != null:
return getHomeRecentTransactions(_that);case _RecentBeneficiaryTappedEvent() when recentBeneficiaryTapped != null:
return recentBeneficiaryTapped(_that);case _RecentBeneficiaryAgentSelectedEvent() when recentBeneficiaryAgentSelected != null:
return recentBeneficiaryAgentSelected(_that);case _DestinationCountrySelectedEvent() when destinationCountrySelected != null:
return destinationCountrySelected(_that);case _GetHomeTransferTypesEvent() when getHomeTransferTypes != null:
return getHomeTransferTypes(_that);case _RetryCorridorEvent() when retryCorridor != null:
return retryCorridor(_that);case _TransferTypeSelectedEvent() when transferTypeSelected != null:
return transferTypeSelected(_that);case _GetHomeBankOrAgentListEvent() when getHomeBankOrAgentList != null:
return getHomeBankOrAgentList(_that);case _BankOrAgentSelectedEvent() when bankOrAgentSelected != null:
return bankOrAgentSelected(_that);case _GetHomeAgentListEvent() when getHomeAgentList != null:
return getHomeAgentList(_that);case _AgentSelectedEvent() when agentSelected != null:
return agentSelected(_that);case _GetBeneficiaryListEvent() when getBeneficiaryList != null:
return getBeneficiaryList(_that);case _SelectedBeneficiaryIndexChangedEvent() when selectedBeneficiaryIndexChanged != null:
return selectedBeneficiaryIndexChanged(_that);case _DeleteBeneficiaryEvent() when deleteBeneficiary != null:
return deleteBeneficiary(_that);case _SelectedBeneficiaryContinuePressedEvent() when selectedBeneficiaryContinuePressed != null:
return selectedBeneficiaryContinuePressed(_that);case _CurrentEmailAddressChanged() when currentEmailAddressChanged != null:
return currentEmailAddressChanged(_that);case _UpdateEmailAddressChanged() when updateEmailAddressChanged != null:
return updateEmailAddressChanged(_that);case _RequestUpdateEmailAddressPressed() when requestUpdateEmailAddressPressed != null:
return requestUpdateEmailAddressPressed(_that);case _EmailOtpChanged() when emailOtpChanged != null:
return emailOtpChanged(_that);case _ContinueOtpButtonPressed() when continueOtpButtonPressed != null:
return continueOtpButtonPressed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isRefresh,  bool resetSelections)?  initialize,TResult Function( bool isRefresh)?  getHomeRecentBeneficiaries,TResult Function()?  getHomeRecentTransactions,TResult Function( RecentBeneficiaryList beneficiary)?  recentBeneficiaryTapped,TResult Function( CommonSelectableItem agent)?  recentBeneficiaryAgentSelected,TResult Function( CommonSelectableItem selectedCommonDestinationItem)?  destinationCountrySelected,TResult Function()?  getHomeTransferTypes,TResult Function()?  retryCorridor,TResult Function( CommonSelectableItem selectedTransferTypeItem,  bool fromUser)?  transferTypeSelected,TResult Function( String destinationCountryCode,  String destinationCurrencyCode,  String transferTypeCode)?  getHomeBankOrAgentList,TResult Function( String selectedBankOrAgent,  String selectedBankOrAgentCode,  bool fromUser)?  bankOrAgentSelected,TResult Function( String destinationCountryCode,  String destinationCurrencyCode,  String transferTypeCode)?  getHomeAgentList,TResult Function( String selectedAgent,  String selectedAgentCode,  bool fromUser)?  agentSelected,TResult Function()?  getBeneficiaryList,TResult Function( int selectedBeneficiaryIndex)?  selectedBeneficiaryIndexChanged,TResult Function( String eId)?  deleteBeneficiary,TResult Function()?  selectedBeneficiaryContinuePressed,TResult Function( String emailAddress)?  currentEmailAddressChanged,TResult Function( String emailAddress)?  updateEmailAddressChanged,TResult Function()?  requestUpdateEmailAddressPressed,TResult Function( String emailOtp)?  emailOtpChanged,TResult Function()?  continueOtpButtonPressed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitializeEvent() when initialize != null:
return initialize(_that.isRefresh,_that.resetSelections);case _GetHomeRecentBeneficiariesEvent() when getHomeRecentBeneficiaries != null:
return getHomeRecentBeneficiaries(_that.isRefresh);case _GetHomeRecentTransactionsEvent() when getHomeRecentTransactions != null:
return getHomeRecentTransactions();case _RecentBeneficiaryTappedEvent() when recentBeneficiaryTapped != null:
return recentBeneficiaryTapped(_that.beneficiary);case _RecentBeneficiaryAgentSelectedEvent() when recentBeneficiaryAgentSelected != null:
return recentBeneficiaryAgentSelected(_that.agent);case _DestinationCountrySelectedEvent() when destinationCountrySelected != null:
return destinationCountrySelected(_that.selectedCommonDestinationItem);case _GetHomeTransferTypesEvent() when getHomeTransferTypes != null:
return getHomeTransferTypes();case _RetryCorridorEvent() when retryCorridor != null:
return retryCorridor();case _TransferTypeSelectedEvent() when transferTypeSelected != null:
return transferTypeSelected(_that.selectedTransferTypeItem,_that.fromUser);case _GetHomeBankOrAgentListEvent() when getHomeBankOrAgentList != null:
return getHomeBankOrAgentList(_that.destinationCountryCode,_that.destinationCurrencyCode,_that.transferTypeCode);case _BankOrAgentSelectedEvent() when bankOrAgentSelected != null:
return bankOrAgentSelected(_that.selectedBankOrAgent,_that.selectedBankOrAgentCode,_that.fromUser);case _GetHomeAgentListEvent() when getHomeAgentList != null:
return getHomeAgentList(_that.destinationCountryCode,_that.destinationCurrencyCode,_that.transferTypeCode);case _AgentSelectedEvent() when agentSelected != null:
return agentSelected(_that.selectedAgent,_that.selectedAgentCode,_that.fromUser);case _GetBeneficiaryListEvent() when getBeneficiaryList != null:
return getBeneficiaryList();case _SelectedBeneficiaryIndexChangedEvent() when selectedBeneficiaryIndexChanged != null:
return selectedBeneficiaryIndexChanged(_that.selectedBeneficiaryIndex);case _DeleteBeneficiaryEvent() when deleteBeneficiary != null:
return deleteBeneficiary(_that.eId);case _SelectedBeneficiaryContinuePressedEvent() when selectedBeneficiaryContinuePressed != null:
return selectedBeneficiaryContinuePressed();case _CurrentEmailAddressChanged() when currentEmailAddressChanged != null:
return currentEmailAddressChanged(_that.emailAddress);case _UpdateEmailAddressChanged() when updateEmailAddressChanged != null:
return updateEmailAddressChanged(_that.emailAddress);case _RequestUpdateEmailAddressPressed() when requestUpdateEmailAddressPressed != null:
return requestUpdateEmailAddressPressed();case _EmailOtpChanged() when emailOtpChanged != null:
return emailOtpChanged(_that.emailOtp);case _ContinueOtpButtonPressed() when continueOtpButtonPressed != null:
return continueOtpButtonPressed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isRefresh,  bool resetSelections)  initialize,required TResult Function( bool isRefresh)  getHomeRecentBeneficiaries,required TResult Function()  getHomeRecentTransactions,required TResult Function( RecentBeneficiaryList beneficiary)  recentBeneficiaryTapped,required TResult Function( CommonSelectableItem agent)  recentBeneficiaryAgentSelected,required TResult Function( CommonSelectableItem selectedCommonDestinationItem)  destinationCountrySelected,required TResult Function()  getHomeTransferTypes,required TResult Function()  retryCorridor,required TResult Function( CommonSelectableItem selectedTransferTypeItem,  bool fromUser)  transferTypeSelected,required TResult Function( String destinationCountryCode,  String destinationCurrencyCode,  String transferTypeCode)  getHomeBankOrAgentList,required TResult Function( String selectedBankOrAgent,  String selectedBankOrAgentCode,  bool fromUser)  bankOrAgentSelected,required TResult Function( String destinationCountryCode,  String destinationCurrencyCode,  String transferTypeCode)  getHomeAgentList,required TResult Function( String selectedAgent,  String selectedAgentCode,  bool fromUser)  agentSelected,required TResult Function()  getBeneficiaryList,required TResult Function( int selectedBeneficiaryIndex)  selectedBeneficiaryIndexChanged,required TResult Function( String eId)  deleteBeneficiary,required TResult Function()  selectedBeneficiaryContinuePressed,required TResult Function( String emailAddress)  currentEmailAddressChanged,required TResult Function( String emailAddress)  updateEmailAddressChanged,required TResult Function()  requestUpdateEmailAddressPressed,required TResult Function( String emailOtp)  emailOtpChanged,required TResult Function()  continueOtpButtonPressed,}) {final _that = this;
switch (_that) {
case _InitializeEvent():
return initialize(_that.isRefresh,_that.resetSelections);case _GetHomeRecentBeneficiariesEvent():
return getHomeRecentBeneficiaries(_that.isRefresh);case _GetHomeRecentTransactionsEvent():
return getHomeRecentTransactions();case _RecentBeneficiaryTappedEvent():
return recentBeneficiaryTapped(_that.beneficiary);case _RecentBeneficiaryAgentSelectedEvent():
return recentBeneficiaryAgentSelected(_that.agent);case _DestinationCountrySelectedEvent():
return destinationCountrySelected(_that.selectedCommonDestinationItem);case _GetHomeTransferTypesEvent():
return getHomeTransferTypes();case _RetryCorridorEvent():
return retryCorridor();case _TransferTypeSelectedEvent():
return transferTypeSelected(_that.selectedTransferTypeItem,_that.fromUser);case _GetHomeBankOrAgentListEvent():
return getHomeBankOrAgentList(_that.destinationCountryCode,_that.destinationCurrencyCode,_that.transferTypeCode);case _BankOrAgentSelectedEvent():
return bankOrAgentSelected(_that.selectedBankOrAgent,_that.selectedBankOrAgentCode,_that.fromUser);case _GetHomeAgentListEvent():
return getHomeAgentList(_that.destinationCountryCode,_that.destinationCurrencyCode,_that.transferTypeCode);case _AgentSelectedEvent():
return agentSelected(_that.selectedAgent,_that.selectedAgentCode,_that.fromUser);case _GetBeneficiaryListEvent():
return getBeneficiaryList();case _SelectedBeneficiaryIndexChangedEvent():
return selectedBeneficiaryIndexChanged(_that.selectedBeneficiaryIndex);case _DeleteBeneficiaryEvent():
return deleteBeneficiary(_that.eId);case _SelectedBeneficiaryContinuePressedEvent():
return selectedBeneficiaryContinuePressed();case _CurrentEmailAddressChanged():
return currentEmailAddressChanged(_that.emailAddress);case _UpdateEmailAddressChanged():
return updateEmailAddressChanged(_that.emailAddress);case _RequestUpdateEmailAddressPressed():
return requestUpdateEmailAddressPressed();case _EmailOtpChanged():
return emailOtpChanged(_that.emailOtp);case _ContinueOtpButtonPressed():
return continueOtpButtonPressed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isRefresh,  bool resetSelections)?  initialize,TResult? Function( bool isRefresh)?  getHomeRecentBeneficiaries,TResult? Function()?  getHomeRecentTransactions,TResult? Function( RecentBeneficiaryList beneficiary)?  recentBeneficiaryTapped,TResult? Function( CommonSelectableItem agent)?  recentBeneficiaryAgentSelected,TResult? Function( CommonSelectableItem selectedCommonDestinationItem)?  destinationCountrySelected,TResult? Function()?  getHomeTransferTypes,TResult? Function()?  retryCorridor,TResult? Function( CommonSelectableItem selectedTransferTypeItem,  bool fromUser)?  transferTypeSelected,TResult? Function( String destinationCountryCode,  String destinationCurrencyCode,  String transferTypeCode)?  getHomeBankOrAgentList,TResult? Function( String selectedBankOrAgent,  String selectedBankOrAgentCode,  bool fromUser)?  bankOrAgentSelected,TResult? Function( String destinationCountryCode,  String destinationCurrencyCode,  String transferTypeCode)?  getHomeAgentList,TResult? Function( String selectedAgent,  String selectedAgentCode,  bool fromUser)?  agentSelected,TResult? Function()?  getBeneficiaryList,TResult? Function( int selectedBeneficiaryIndex)?  selectedBeneficiaryIndexChanged,TResult? Function( String eId)?  deleteBeneficiary,TResult? Function()?  selectedBeneficiaryContinuePressed,TResult? Function( String emailAddress)?  currentEmailAddressChanged,TResult? Function( String emailAddress)?  updateEmailAddressChanged,TResult? Function()?  requestUpdateEmailAddressPressed,TResult? Function( String emailOtp)?  emailOtpChanged,TResult? Function()?  continueOtpButtonPressed,}) {final _that = this;
switch (_that) {
case _InitializeEvent() when initialize != null:
return initialize(_that.isRefresh,_that.resetSelections);case _GetHomeRecentBeneficiariesEvent() when getHomeRecentBeneficiaries != null:
return getHomeRecentBeneficiaries(_that.isRefresh);case _GetHomeRecentTransactionsEvent() when getHomeRecentTransactions != null:
return getHomeRecentTransactions();case _RecentBeneficiaryTappedEvent() when recentBeneficiaryTapped != null:
return recentBeneficiaryTapped(_that.beneficiary);case _RecentBeneficiaryAgentSelectedEvent() when recentBeneficiaryAgentSelected != null:
return recentBeneficiaryAgentSelected(_that.agent);case _DestinationCountrySelectedEvent() when destinationCountrySelected != null:
return destinationCountrySelected(_that.selectedCommonDestinationItem);case _GetHomeTransferTypesEvent() when getHomeTransferTypes != null:
return getHomeTransferTypes();case _RetryCorridorEvent() when retryCorridor != null:
return retryCorridor();case _TransferTypeSelectedEvent() when transferTypeSelected != null:
return transferTypeSelected(_that.selectedTransferTypeItem,_that.fromUser);case _GetHomeBankOrAgentListEvent() when getHomeBankOrAgentList != null:
return getHomeBankOrAgentList(_that.destinationCountryCode,_that.destinationCurrencyCode,_that.transferTypeCode);case _BankOrAgentSelectedEvent() when bankOrAgentSelected != null:
return bankOrAgentSelected(_that.selectedBankOrAgent,_that.selectedBankOrAgentCode,_that.fromUser);case _GetHomeAgentListEvent() when getHomeAgentList != null:
return getHomeAgentList(_that.destinationCountryCode,_that.destinationCurrencyCode,_that.transferTypeCode);case _AgentSelectedEvent() when agentSelected != null:
return agentSelected(_that.selectedAgent,_that.selectedAgentCode,_that.fromUser);case _GetBeneficiaryListEvent() when getBeneficiaryList != null:
return getBeneficiaryList();case _SelectedBeneficiaryIndexChangedEvent() when selectedBeneficiaryIndexChanged != null:
return selectedBeneficiaryIndexChanged(_that.selectedBeneficiaryIndex);case _DeleteBeneficiaryEvent() when deleteBeneficiary != null:
return deleteBeneficiary(_that.eId);case _SelectedBeneficiaryContinuePressedEvent() when selectedBeneficiaryContinuePressed != null:
return selectedBeneficiaryContinuePressed();case _CurrentEmailAddressChanged() when currentEmailAddressChanged != null:
return currentEmailAddressChanged(_that.emailAddress);case _UpdateEmailAddressChanged() when updateEmailAddressChanged != null:
return updateEmailAddressChanged(_that.emailAddress);case _RequestUpdateEmailAddressPressed() when requestUpdateEmailAddressPressed != null:
return requestUpdateEmailAddressPressed();case _EmailOtpChanged() when emailOtpChanged != null:
return emailOtpChanged(_that.emailOtp);case _ContinueOtpButtonPressed() when continueOtpButtonPressed != null:
return continueOtpButtonPressed();case _:
  return null;

}
}

}

/// @nodoc


class _InitializeEvent implements HomeEvent {
  const _InitializeEvent({this.isRefresh = false, this.resetSelections = false});
  

@JsonKey() final  bool isRefresh;
/// Drops every user selection on the send-money form (destination,
/// transfer type, bank/agent, payment method, tapped beneficiary) so the
/// refresh lands on first-load defaults instead of restoring them.
/// Used after a completed transaction.
@JsonKey() final  bool resetSelections;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitializeEventCopyWith<_InitializeEvent> get copyWith => __$InitializeEventCopyWithImpl<_InitializeEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitializeEvent&&(identical(other.isRefresh, isRefresh) || other.isRefresh == isRefresh)&&(identical(other.resetSelections, resetSelections) || other.resetSelections == resetSelections));
}


@override
int get hashCode => Object.hash(runtimeType,isRefresh,resetSelections);

@override
String toString() {
  return 'HomeEvent.initialize(isRefresh: $isRefresh, resetSelections: $resetSelections)';
}


}

/// @nodoc
abstract mixin class _$InitializeEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$InitializeEventCopyWith(_InitializeEvent value, $Res Function(_InitializeEvent) _then) = __$InitializeEventCopyWithImpl;
@useResult
$Res call({
 bool isRefresh, bool resetSelections
});




}
/// @nodoc
class __$InitializeEventCopyWithImpl<$Res>
    implements _$InitializeEventCopyWith<$Res> {
  __$InitializeEventCopyWithImpl(this._self, this._then);

  final _InitializeEvent _self;
  final $Res Function(_InitializeEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isRefresh = null,Object? resetSelections = null,}) {
  return _then(_InitializeEvent(
isRefresh: null == isRefresh ? _self.isRefresh : isRefresh // ignore: cast_nullable_to_non_nullable
as bool,resetSelections: null == resetSelections ? _self.resetSelections : resetSelections // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _GetHomeRecentBeneficiariesEvent implements HomeEvent {
  const _GetHomeRecentBeneficiariesEvent({this.isRefresh = false});
  

@JsonKey() final  bool isRefresh;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetHomeRecentBeneficiariesEventCopyWith<_GetHomeRecentBeneficiariesEvent> get copyWith => __$GetHomeRecentBeneficiariesEventCopyWithImpl<_GetHomeRecentBeneficiariesEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetHomeRecentBeneficiariesEvent&&(identical(other.isRefresh, isRefresh) || other.isRefresh == isRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,isRefresh);

@override
String toString() {
  return 'HomeEvent.getHomeRecentBeneficiaries(isRefresh: $isRefresh)';
}


}

/// @nodoc
abstract mixin class _$GetHomeRecentBeneficiariesEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$GetHomeRecentBeneficiariesEventCopyWith(_GetHomeRecentBeneficiariesEvent value, $Res Function(_GetHomeRecentBeneficiariesEvent) _then) = __$GetHomeRecentBeneficiariesEventCopyWithImpl;
@useResult
$Res call({
 bool isRefresh
});




}
/// @nodoc
class __$GetHomeRecentBeneficiariesEventCopyWithImpl<$Res>
    implements _$GetHomeRecentBeneficiariesEventCopyWith<$Res> {
  __$GetHomeRecentBeneficiariesEventCopyWithImpl(this._self, this._then);

  final _GetHomeRecentBeneficiariesEvent _self;
  final $Res Function(_GetHomeRecentBeneficiariesEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isRefresh = null,}) {
  return _then(_GetHomeRecentBeneficiariesEvent(
isRefresh: null == isRefresh ? _self.isRefresh : isRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _GetHomeRecentTransactionsEvent implements HomeEvent {
  const _GetHomeRecentTransactionsEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetHomeRecentTransactionsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.getHomeRecentTransactions()';
}


}




/// @nodoc


class _RecentBeneficiaryTappedEvent implements HomeEvent {
  const _RecentBeneficiaryTappedEvent({required this.beneficiary});
  

 final  RecentBeneficiaryList beneficiary;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentBeneficiaryTappedEventCopyWith<_RecentBeneficiaryTappedEvent> get copyWith => __$RecentBeneficiaryTappedEventCopyWithImpl<_RecentBeneficiaryTappedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentBeneficiaryTappedEvent&&(identical(other.beneficiary, beneficiary) || other.beneficiary == beneficiary));
}


@override
int get hashCode => Object.hash(runtimeType,beneficiary);

@override
String toString() {
  return 'HomeEvent.recentBeneficiaryTapped(beneficiary: $beneficiary)';
}


}

/// @nodoc
abstract mixin class _$RecentBeneficiaryTappedEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$RecentBeneficiaryTappedEventCopyWith(_RecentBeneficiaryTappedEvent value, $Res Function(_RecentBeneficiaryTappedEvent) _then) = __$RecentBeneficiaryTappedEventCopyWithImpl;
@useResult
$Res call({
 RecentBeneficiaryList beneficiary
});


$RecentBeneficiaryListCopyWith<$Res> get beneficiary;

}
/// @nodoc
class __$RecentBeneficiaryTappedEventCopyWithImpl<$Res>
    implements _$RecentBeneficiaryTappedEventCopyWith<$Res> {
  __$RecentBeneficiaryTappedEventCopyWithImpl(this._self, this._then);

  final _RecentBeneficiaryTappedEvent _self;
  final $Res Function(_RecentBeneficiaryTappedEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? beneficiary = null,}) {
  return _then(_RecentBeneficiaryTappedEvent(
beneficiary: null == beneficiary ? _self.beneficiary : beneficiary // ignore: cast_nullable_to_non_nullable
as RecentBeneficiaryList,
  ));
}

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecentBeneficiaryListCopyWith<$Res> get beneficiary {
  
  return $RecentBeneficiaryListCopyWith<$Res>(_self.beneficiary, (value) {
    return _then(_self.copyWith(beneficiary: value));
  });
}
}

/// @nodoc


class _RecentBeneficiaryAgentSelectedEvent implements HomeEvent {
  const _RecentBeneficiaryAgentSelectedEvent({required this.agent});
  

 final  CommonSelectableItem agent;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentBeneficiaryAgentSelectedEventCopyWith<_RecentBeneficiaryAgentSelectedEvent> get copyWith => __$RecentBeneficiaryAgentSelectedEventCopyWithImpl<_RecentBeneficiaryAgentSelectedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentBeneficiaryAgentSelectedEvent&&(identical(other.agent, agent) || other.agent == agent));
}


@override
int get hashCode => Object.hash(runtimeType,agent);

@override
String toString() {
  return 'HomeEvent.recentBeneficiaryAgentSelected(agent: $agent)';
}


}

/// @nodoc
abstract mixin class _$RecentBeneficiaryAgentSelectedEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$RecentBeneficiaryAgentSelectedEventCopyWith(_RecentBeneficiaryAgentSelectedEvent value, $Res Function(_RecentBeneficiaryAgentSelectedEvent) _then) = __$RecentBeneficiaryAgentSelectedEventCopyWithImpl;
@useResult
$Res call({
 CommonSelectableItem agent
});


$CommonSelectableItemCopyWith<$Res> get agent;

}
/// @nodoc
class __$RecentBeneficiaryAgentSelectedEventCopyWithImpl<$Res>
    implements _$RecentBeneficiaryAgentSelectedEventCopyWith<$Res> {
  __$RecentBeneficiaryAgentSelectedEventCopyWithImpl(this._self, this._then);

  final _RecentBeneficiaryAgentSelectedEvent _self;
  final $Res Function(_RecentBeneficiaryAgentSelectedEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? agent = null,}) {
  return _then(_RecentBeneficiaryAgentSelectedEvent(
agent: null == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem,
  ));
}

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res> get agent {
  
  return $CommonSelectableItemCopyWith<$Res>(_self.agent, (value) {
    return _then(_self.copyWith(agent: value));
  });
}
}

/// @nodoc


class _DestinationCountrySelectedEvent implements HomeEvent {
  const _DestinationCountrySelectedEvent({required this.selectedCommonDestinationItem});
  

 final  CommonSelectableItem selectedCommonDestinationItem;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DestinationCountrySelectedEventCopyWith<_DestinationCountrySelectedEvent> get copyWith => __$DestinationCountrySelectedEventCopyWithImpl<_DestinationCountrySelectedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DestinationCountrySelectedEvent&&(identical(other.selectedCommonDestinationItem, selectedCommonDestinationItem) || other.selectedCommonDestinationItem == selectedCommonDestinationItem));
}


@override
int get hashCode => Object.hash(runtimeType,selectedCommonDestinationItem);

@override
String toString() {
  return 'HomeEvent.destinationCountrySelected(selectedCommonDestinationItem: $selectedCommonDestinationItem)';
}


}

/// @nodoc
abstract mixin class _$DestinationCountrySelectedEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$DestinationCountrySelectedEventCopyWith(_DestinationCountrySelectedEvent value, $Res Function(_DestinationCountrySelectedEvent) _then) = __$DestinationCountrySelectedEventCopyWithImpl;
@useResult
$Res call({
 CommonSelectableItem selectedCommonDestinationItem
});


$CommonSelectableItemCopyWith<$Res> get selectedCommonDestinationItem;

}
/// @nodoc
class __$DestinationCountrySelectedEventCopyWithImpl<$Res>
    implements _$DestinationCountrySelectedEventCopyWith<$Res> {
  __$DestinationCountrySelectedEventCopyWithImpl(this._self, this._then);

  final _DestinationCountrySelectedEvent _self;
  final $Res Function(_DestinationCountrySelectedEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedCommonDestinationItem = null,}) {
  return _then(_DestinationCountrySelectedEvent(
selectedCommonDestinationItem: null == selectedCommonDestinationItem ? _self.selectedCommonDestinationItem : selectedCommonDestinationItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem,
  ));
}

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res> get selectedCommonDestinationItem {
  
  return $CommonSelectableItemCopyWith<$Res>(_self.selectedCommonDestinationItem, (value) {
    return _then(_self.copyWith(selectedCommonDestinationItem: value));
  });
}
}

/// @nodoc


class _GetHomeTransferTypesEvent implements HomeEvent {
  const _GetHomeTransferTypesEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetHomeTransferTypesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.getHomeTransferTypes()';
}


}




/// @nodoc


class _RetryCorridorEvent implements HomeEvent {
  const _RetryCorridorEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryCorridorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.retryCorridor()';
}


}




/// @nodoc


class _TransferTypeSelectedEvent implements HomeEvent {
  const _TransferTypeSelectedEvent({required this.selectedTransferTypeItem, this.fromUser = false});
  

 final  CommonSelectableItem selectedTransferTypeItem;
@JsonKey() final  bool fromUser;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferTypeSelectedEventCopyWith<_TransferTypeSelectedEvent> get copyWith => __$TransferTypeSelectedEventCopyWithImpl<_TransferTypeSelectedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferTypeSelectedEvent&&(identical(other.selectedTransferTypeItem, selectedTransferTypeItem) || other.selectedTransferTypeItem == selectedTransferTypeItem)&&(identical(other.fromUser, fromUser) || other.fromUser == fromUser));
}


@override
int get hashCode => Object.hash(runtimeType,selectedTransferTypeItem,fromUser);

@override
String toString() {
  return 'HomeEvent.transferTypeSelected(selectedTransferTypeItem: $selectedTransferTypeItem, fromUser: $fromUser)';
}


}

/// @nodoc
abstract mixin class _$TransferTypeSelectedEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$TransferTypeSelectedEventCopyWith(_TransferTypeSelectedEvent value, $Res Function(_TransferTypeSelectedEvent) _then) = __$TransferTypeSelectedEventCopyWithImpl;
@useResult
$Res call({
 CommonSelectableItem selectedTransferTypeItem, bool fromUser
});


$CommonSelectableItemCopyWith<$Res> get selectedTransferTypeItem;

}
/// @nodoc
class __$TransferTypeSelectedEventCopyWithImpl<$Res>
    implements _$TransferTypeSelectedEventCopyWith<$Res> {
  __$TransferTypeSelectedEventCopyWithImpl(this._self, this._then);

  final _TransferTypeSelectedEvent _self;
  final $Res Function(_TransferTypeSelectedEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedTransferTypeItem = null,Object? fromUser = null,}) {
  return _then(_TransferTypeSelectedEvent(
selectedTransferTypeItem: null == selectedTransferTypeItem ? _self.selectedTransferTypeItem : selectedTransferTypeItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem,fromUser: null == fromUser ? _self.fromUser : fromUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res> get selectedTransferTypeItem {
  
  return $CommonSelectableItemCopyWith<$Res>(_self.selectedTransferTypeItem, (value) {
    return _then(_self.copyWith(selectedTransferTypeItem: value));
  });
}
}

/// @nodoc


class _GetHomeBankOrAgentListEvent implements HomeEvent {
  const _GetHomeBankOrAgentListEvent({required this.destinationCountryCode, required this.destinationCurrencyCode, required this.transferTypeCode});
  

 final  String destinationCountryCode;
 final  String destinationCurrencyCode;
 final  String transferTypeCode;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetHomeBankOrAgentListEventCopyWith<_GetHomeBankOrAgentListEvent> get copyWith => __$GetHomeBankOrAgentListEventCopyWithImpl<_GetHomeBankOrAgentListEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetHomeBankOrAgentListEvent&&(identical(other.destinationCountryCode, destinationCountryCode) || other.destinationCountryCode == destinationCountryCode)&&(identical(other.destinationCurrencyCode, destinationCurrencyCode) || other.destinationCurrencyCode == destinationCurrencyCode)&&(identical(other.transferTypeCode, transferTypeCode) || other.transferTypeCode == transferTypeCode));
}


@override
int get hashCode => Object.hash(runtimeType,destinationCountryCode,destinationCurrencyCode,transferTypeCode);

@override
String toString() {
  return 'HomeEvent.getHomeBankOrAgentList(destinationCountryCode: $destinationCountryCode, destinationCurrencyCode: $destinationCurrencyCode, transferTypeCode: $transferTypeCode)';
}


}

/// @nodoc
abstract mixin class _$GetHomeBankOrAgentListEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$GetHomeBankOrAgentListEventCopyWith(_GetHomeBankOrAgentListEvent value, $Res Function(_GetHomeBankOrAgentListEvent) _then) = __$GetHomeBankOrAgentListEventCopyWithImpl;
@useResult
$Res call({
 String destinationCountryCode, String destinationCurrencyCode, String transferTypeCode
});




}
/// @nodoc
class __$GetHomeBankOrAgentListEventCopyWithImpl<$Res>
    implements _$GetHomeBankOrAgentListEventCopyWith<$Res> {
  __$GetHomeBankOrAgentListEventCopyWithImpl(this._self, this._then);

  final _GetHomeBankOrAgentListEvent _self;
  final $Res Function(_GetHomeBankOrAgentListEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? destinationCountryCode = null,Object? destinationCurrencyCode = null,Object? transferTypeCode = null,}) {
  return _then(_GetHomeBankOrAgentListEvent(
destinationCountryCode: null == destinationCountryCode ? _self.destinationCountryCode : destinationCountryCode // ignore: cast_nullable_to_non_nullable
as String,destinationCurrencyCode: null == destinationCurrencyCode ? _self.destinationCurrencyCode : destinationCurrencyCode // ignore: cast_nullable_to_non_nullable
as String,transferTypeCode: null == transferTypeCode ? _self.transferTypeCode : transferTypeCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BankOrAgentSelectedEvent implements HomeEvent {
  const _BankOrAgentSelectedEvent({required this.selectedBankOrAgent, required this.selectedBankOrAgentCode, this.fromUser = false});
  

 final  String selectedBankOrAgent;
 final  String selectedBankOrAgentCode;
@JsonKey() final  bool fromUser;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankOrAgentSelectedEventCopyWith<_BankOrAgentSelectedEvent> get copyWith => __$BankOrAgentSelectedEventCopyWithImpl<_BankOrAgentSelectedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BankOrAgentSelectedEvent&&(identical(other.selectedBankOrAgent, selectedBankOrAgent) || other.selectedBankOrAgent == selectedBankOrAgent)&&(identical(other.selectedBankOrAgentCode, selectedBankOrAgentCode) || other.selectedBankOrAgentCode == selectedBankOrAgentCode)&&(identical(other.fromUser, fromUser) || other.fromUser == fromUser));
}


@override
int get hashCode => Object.hash(runtimeType,selectedBankOrAgent,selectedBankOrAgentCode,fromUser);

@override
String toString() {
  return 'HomeEvent.bankOrAgentSelected(selectedBankOrAgent: $selectedBankOrAgent, selectedBankOrAgentCode: $selectedBankOrAgentCode, fromUser: $fromUser)';
}


}

/// @nodoc
abstract mixin class _$BankOrAgentSelectedEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$BankOrAgentSelectedEventCopyWith(_BankOrAgentSelectedEvent value, $Res Function(_BankOrAgentSelectedEvent) _then) = __$BankOrAgentSelectedEventCopyWithImpl;
@useResult
$Res call({
 String selectedBankOrAgent, String selectedBankOrAgentCode, bool fromUser
});




}
/// @nodoc
class __$BankOrAgentSelectedEventCopyWithImpl<$Res>
    implements _$BankOrAgentSelectedEventCopyWith<$Res> {
  __$BankOrAgentSelectedEventCopyWithImpl(this._self, this._then);

  final _BankOrAgentSelectedEvent _self;
  final $Res Function(_BankOrAgentSelectedEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedBankOrAgent = null,Object? selectedBankOrAgentCode = null,Object? fromUser = null,}) {
  return _then(_BankOrAgentSelectedEvent(
selectedBankOrAgent: null == selectedBankOrAgent ? _self.selectedBankOrAgent : selectedBankOrAgent // ignore: cast_nullable_to_non_nullable
as String,selectedBankOrAgentCode: null == selectedBankOrAgentCode ? _self.selectedBankOrAgentCode : selectedBankOrAgentCode // ignore: cast_nullable_to_non_nullable
as String,fromUser: null == fromUser ? _self.fromUser : fromUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _GetHomeAgentListEvent implements HomeEvent {
  const _GetHomeAgentListEvent({required this.destinationCountryCode, required this.destinationCurrencyCode, required this.transferTypeCode});
  

 final  String destinationCountryCode;
 final  String destinationCurrencyCode;
 final  String transferTypeCode;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetHomeAgentListEventCopyWith<_GetHomeAgentListEvent> get copyWith => __$GetHomeAgentListEventCopyWithImpl<_GetHomeAgentListEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetHomeAgentListEvent&&(identical(other.destinationCountryCode, destinationCountryCode) || other.destinationCountryCode == destinationCountryCode)&&(identical(other.destinationCurrencyCode, destinationCurrencyCode) || other.destinationCurrencyCode == destinationCurrencyCode)&&(identical(other.transferTypeCode, transferTypeCode) || other.transferTypeCode == transferTypeCode));
}


@override
int get hashCode => Object.hash(runtimeType,destinationCountryCode,destinationCurrencyCode,transferTypeCode);

@override
String toString() {
  return 'HomeEvent.getHomeAgentList(destinationCountryCode: $destinationCountryCode, destinationCurrencyCode: $destinationCurrencyCode, transferTypeCode: $transferTypeCode)';
}


}

/// @nodoc
abstract mixin class _$GetHomeAgentListEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$GetHomeAgentListEventCopyWith(_GetHomeAgentListEvent value, $Res Function(_GetHomeAgentListEvent) _then) = __$GetHomeAgentListEventCopyWithImpl;
@useResult
$Res call({
 String destinationCountryCode, String destinationCurrencyCode, String transferTypeCode
});




}
/// @nodoc
class __$GetHomeAgentListEventCopyWithImpl<$Res>
    implements _$GetHomeAgentListEventCopyWith<$Res> {
  __$GetHomeAgentListEventCopyWithImpl(this._self, this._then);

  final _GetHomeAgentListEvent _self;
  final $Res Function(_GetHomeAgentListEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? destinationCountryCode = null,Object? destinationCurrencyCode = null,Object? transferTypeCode = null,}) {
  return _then(_GetHomeAgentListEvent(
destinationCountryCode: null == destinationCountryCode ? _self.destinationCountryCode : destinationCountryCode // ignore: cast_nullable_to_non_nullable
as String,destinationCurrencyCode: null == destinationCurrencyCode ? _self.destinationCurrencyCode : destinationCurrencyCode // ignore: cast_nullable_to_non_nullable
as String,transferTypeCode: null == transferTypeCode ? _self.transferTypeCode : transferTypeCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AgentSelectedEvent implements HomeEvent {
  const _AgentSelectedEvent({required this.selectedAgent, required this.selectedAgentCode, this.fromUser = false});
  

 final  String selectedAgent;
 final  String selectedAgentCode;
@JsonKey() final  bool fromUser;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgentSelectedEventCopyWith<_AgentSelectedEvent> get copyWith => __$AgentSelectedEventCopyWithImpl<_AgentSelectedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgentSelectedEvent&&(identical(other.selectedAgent, selectedAgent) || other.selectedAgent == selectedAgent)&&(identical(other.selectedAgentCode, selectedAgentCode) || other.selectedAgentCode == selectedAgentCode)&&(identical(other.fromUser, fromUser) || other.fromUser == fromUser));
}


@override
int get hashCode => Object.hash(runtimeType,selectedAgent,selectedAgentCode,fromUser);

@override
String toString() {
  return 'HomeEvent.agentSelected(selectedAgent: $selectedAgent, selectedAgentCode: $selectedAgentCode, fromUser: $fromUser)';
}


}

/// @nodoc
abstract mixin class _$AgentSelectedEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$AgentSelectedEventCopyWith(_AgentSelectedEvent value, $Res Function(_AgentSelectedEvent) _then) = __$AgentSelectedEventCopyWithImpl;
@useResult
$Res call({
 String selectedAgent, String selectedAgentCode, bool fromUser
});




}
/// @nodoc
class __$AgentSelectedEventCopyWithImpl<$Res>
    implements _$AgentSelectedEventCopyWith<$Res> {
  __$AgentSelectedEventCopyWithImpl(this._self, this._then);

  final _AgentSelectedEvent _self;
  final $Res Function(_AgentSelectedEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedAgent = null,Object? selectedAgentCode = null,Object? fromUser = null,}) {
  return _then(_AgentSelectedEvent(
selectedAgent: null == selectedAgent ? _self.selectedAgent : selectedAgent // ignore: cast_nullable_to_non_nullable
as String,selectedAgentCode: null == selectedAgentCode ? _self.selectedAgentCode : selectedAgentCode // ignore: cast_nullable_to_non_nullable
as String,fromUser: null == fromUser ? _self.fromUser : fromUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _GetBeneficiaryListEvent implements HomeEvent {
  const _GetBeneficiaryListEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetBeneficiaryListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.getBeneficiaryList()';
}


}




/// @nodoc


class _SelectedBeneficiaryIndexChangedEvent implements HomeEvent {
  const _SelectedBeneficiaryIndexChangedEvent({required this.selectedBeneficiaryIndex});
  

 final  int selectedBeneficiaryIndex;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectedBeneficiaryIndexChangedEventCopyWith<_SelectedBeneficiaryIndexChangedEvent> get copyWith => __$SelectedBeneficiaryIndexChangedEventCopyWithImpl<_SelectedBeneficiaryIndexChangedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectedBeneficiaryIndexChangedEvent&&(identical(other.selectedBeneficiaryIndex, selectedBeneficiaryIndex) || other.selectedBeneficiaryIndex == selectedBeneficiaryIndex));
}


@override
int get hashCode => Object.hash(runtimeType,selectedBeneficiaryIndex);

@override
String toString() {
  return 'HomeEvent.selectedBeneficiaryIndexChanged(selectedBeneficiaryIndex: $selectedBeneficiaryIndex)';
}


}

/// @nodoc
abstract mixin class _$SelectedBeneficiaryIndexChangedEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$SelectedBeneficiaryIndexChangedEventCopyWith(_SelectedBeneficiaryIndexChangedEvent value, $Res Function(_SelectedBeneficiaryIndexChangedEvent) _then) = __$SelectedBeneficiaryIndexChangedEventCopyWithImpl;
@useResult
$Res call({
 int selectedBeneficiaryIndex
});




}
/// @nodoc
class __$SelectedBeneficiaryIndexChangedEventCopyWithImpl<$Res>
    implements _$SelectedBeneficiaryIndexChangedEventCopyWith<$Res> {
  __$SelectedBeneficiaryIndexChangedEventCopyWithImpl(this._self, this._then);

  final _SelectedBeneficiaryIndexChangedEvent _self;
  final $Res Function(_SelectedBeneficiaryIndexChangedEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedBeneficiaryIndex = null,}) {
  return _then(_SelectedBeneficiaryIndexChangedEvent(
selectedBeneficiaryIndex: null == selectedBeneficiaryIndex ? _self.selectedBeneficiaryIndex : selectedBeneficiaryIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _DeleteBeneficiaryEvent implements HomeEvent {
  const _DeleteBeneficiaryEvent(this.eId);
  

 final  String eId;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteBeneficiaryEventCopyWith<_DeleteBeneficiaryEvent> get copyWith => __$DeleteBeneficiaryEventCopyWithImpl<_DeleteBeneficiaryEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteBeneficiaryEvent&&(identical(other.eId, eId) || other.eId == eId));
}


@override
int get hashCode => Object.hash(runtimeType,eId);

@override
String toString() {
  return 'HomeEvent.deleteBeneficiary(eId: $eId)';
}


}

/// @nodoc
abstract mixin class _$DeleteBeneficiaryEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$DeleteBeneficiaryEventCopyWith(_DeleteBeneficiaryEvent value, $Res Function(_DeleteBeneficiaryEvent) _then) = __$DeleteBeneficiaryEventCopyWithImpl;
@useResult
$Res call({
 String eId
});




}
/// @nodoc
class __$DeleteBeneficiaryEventCopyWithImpl<$Res>
    implements _$DeleteBeneficiaryEventCopyWith<$Res> {
  __$DeleteBeneficiaryEventCopyWithImpl(this._self, this._then);

  final _DeleteBeneficiaryEvent _self;
  final $Res Function(_DeleteBeneficiaryEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eId = null,}) {
  return _then(_DeleteBeneficiaryEvent(
null == eId ? _self.eId : eId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SelectedBeneficiaryContinuePressedEvent implements HomeEvent {
  const _SelectedBeneficiaryContinuePressedEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectedBeneficiaryContinuePressedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.selectedBeneficiaryContinuePressed()';
}


}




/// @nodoc


class _CurrentEmailAddressChanged implements HomeEvent {
  const _CurrentEmailAddressChanged({required this.emailAddress});
  

 final  String emailAddress;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentEmailAddressChangedCopyWith<_CurrentEmailAddressChanged> get copyWith => __$CurrentEmailAddressChangedCopyWithImpl<_CurrentEmailAddressChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentEmailAddressChanged&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress));
}


@override
int get hashCode => Object.hash(runtimeType,emailAddress);

@override
String toString() {
  return 'HomeEvent.currentEmailAddressChanged(emailAddress: $emailAddress)';
}


}

/// @nodoc
abstract mixin class _$CurrentEmailAddressChangedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$CurrentEmailAddressChangedCopyWith(_CurrentEmailAddressChanged value, $Res Function(_CurrentEmailAddressChanged) _then) = __$CurrentEmailAddressChangedCopyWithImpl;
@useResult
$Res call({
 String emailAddress
});




}
/// @nodoc
class __$CurrentEmailAddressChangedCopyWithImpl<$Res>
    implements _$CurrentEmailAddressChangedCopyWith<$Res> {
  __$CurrentEmailAddressChangedCopyWithImpl(this._self, this._then);

  final _CurrentEmailAddressChanged _self;
  final $Res Function(_CurrentEmailAddressChanged) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? emailAddress = null,}) {
  return _then(_CurrentEmailAddressChanged(
emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateEmailAddressChanged implements HomeEvent {
  const _UpdateEmailAddressChanged({required this.emailAddress});
  

 final  String emailAddress;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateEmailAddressChangedCopyWith<_UpdateEmailAddressChanged> get copyWith => __$UpdateEmailAddressChangedCopyWithImpl<_UpdateEmailAddressChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateEmailAddressChanged&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress));
}


@override
int get hashCode => Object.hash(runtimeType,emailAddress);

@override
String toString() {
  return 'HomeEvent.updateEmailAddressChanged(emailAddress: $emailAddress)';
}


}

/// @nodoc
abstract mixin class _$UpdateEmailAddressChangedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$UpdateEmailAddressChangedCopyWith(_UpdateEmailAddressChanged value, $Res Function(_UpdateEmailAddressChanged) _then) = __$UpdateEmailAddressChangedCopyWithImpl;
@useResult
$Res call({
 String emailAddress
});




}
/// @nodoc
class __$UpdateEmailAddressChangedCopyWithImpl<$Res>
    implements _$UpdateEmailAddressChangedCopyWith<$Res> {
  __$UpdateEmailAddressChangedCopyWithImpl(this._self, this._then);

  final _UpdateEmailAddressChanged _self;
  final $Res Function(_UpdateEmailAddressChanged) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? emailAddress = null,}) {
  return _then(_UpdateEmailAddressChanged(
emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RequestUpdateEmailAddressPressed implements HomeEvent {
  const _RequestUpdateEmailAddressPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestUpdateEmailAddressPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.requestUpdateEmailAddressPressed()';
}


}




/// @nodoc


class _EmailOtpChanged implements HomeEvent {
  const _EmailOtpChanged({required this.emailOtp});
  

 final  String emailOtp;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailOtpChangedCopyWith<_EmailOtpChanged> get copyWith => __$EmailOtpChangedCopyWithImpl<_EmailOtpChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailOtpChanged&&(identical(other.emailOtp, emailOtp) || other.emailOtp == emailOtp));
}


@override
int get hashCode => Object.hash(runtimeType,emailOtp);

@override
String toString() {
  return 'HomeEvent.emailOtpChanged(emailOtp: $emailOtp)';
}


}

/// @nodoc
abstract mixin class _$EmailOtpChangedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$EmailOtpChangedCopyWith(_EmailOtpChanged value, $Res Function(_EmailOtpChanged) _then) = __$EmailOtpChangedCopyWithImpl;
@useResult
$Res call({
 String emailOtp
});




}
/// @nodoc
class __$EmailOtpChangedCopyWithImpl<$Res>
    implements _$EmailOtpChangedCopyWith<$Res> {
  __$EmailOtpChangedCopyWithImpl(this._self, this._then);

  final _EmailOtpChanged _self;
  final $Res Function(_EmailOtpChanged) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? emailOtp = null,}) {
  return _then(_EmailOtpChanged(
emailOtp: null == emailOtp ? _self.emailOtp : emailOtp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ContinueOtpButtonPressed implements HomeEvent {
  const _ContinueOtpButtonPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContinueOtpButtonPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.continueOtpButtonPressed()';
}


}




/// @nodoc
mixin _$HomeState {

 bool get isUserLoading; bool get isRecentBeneficiariesLoading; bool get isRecentTransactionsLoading; bool get isSendMoneyFormLoading; bool get isRefreshing; bool get criticalLoadFailed; bool get isRecentBeneficiariesLoadFailed; bool get isRecentTransactionsLoadFailed; bool get isSubmitting; bool get isOtpSubmitting; bool get showErrorMessages; bool get showOtpErrorMessages; bool get isCorridorLoading; HomeCorridorStage? get failedCorridorStage; bool get isTransferTypeUnavailable; bool get isBeneficiaryListLoading; bool get isBeneficiaryListLoadFailed; bool get isDeletingBeneficiary; bool get isMandatoryFieldCheckLoading; RecentBeneficiaryList? get tappedRecentBeneficiary; HomeAdvertisementDto? get homeAdvertisementDto; HomeUserDto? get homeUserDto; HomeRecentBeneficiariesDto? get homeRecentBeneficiariesDto; CommonTransactionDto? get homeRecentTransactionsDto; CommonSelectableDto? get commonDestinationSelectableDto; bool get isDestinationLoadFailed; bool get isDestinationUnavailable; CommonSelectableItem? get selectedCommonDestinationItem; bool get isTransferTypeLoading; HomeTransferTypeDto? get homeTransferTypeDto; CommonSelectableItem? get selectedTransferTypeItem; CommonSelectableDto? get commonBankOrAgentSelectableDto; CommonSelectableItem? get selectedBankOrAgentItem; CommonSelectableDto? get commonAgentSelectableDto; bool get isAgentNotRequired; CommonSelectableItem? get selectedAgentItem; CommonSelectableItem? get sendAgainAgentItem; HomeBeneficiaryListDto? get homeBeneficiaryListDto; int get selectedBeneficiaryIndex; String get currentEmailAddress; EmailAddress get emailAddress; Otp get emailOtp; Option<Either<HomeFailure, HomeAdvertisementDto>> get homeAdvertisementFailureOrSuccessOption; Option<Either<HomeFailure, HomeUserDto>> get homeUserFailureOrSuccessOption; Option<Either<HomeFailure, HomeBeneficiaryListDto>> get homeBeneficiaryListFailureOrSuccessOption; Option<Either<HomeFailure, String>> get homeDeleteBeneficiaryFailureOrSuccessOption; Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> get homeMandatoryFieldCheckFailureOrSuccessOption; Option<Either<HomeFailure, CommonSelectableDto>> get homeSendAgainAgentOption; Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> get homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption; Option<Either<HomeFailure, Unit>> get homeRequestEmailOtpFailureOrSuccessOption; Option<Either<HomeFailure, Unit>> get homeVerifyEmailOtpFailureOrSuccessOption;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.isUserLoading, isUserLoading) || other.isUserLoading == isUserLoading)&&(identical(other.isRecentBeneficiariesLoading, isRecentBeneficiariesLoading) || other.isRecentBeneficiariesLoading == isRecentBeneficiariesLoading)&&(identical(other.isRecentTransactionsLoading, isRecentTransactionsLoading) || other.isRecentTransactionsLoading == isRecentTransactionsLoading)&&(identical(other.isSendMoneyFormLoading, isSendMoneyFormLoading) || other.isSendMoneyFormLoading == isSendMoneyFormLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.criticalLoadFailed, criticalLoadFailed) || other.criticalLoadFailed == criticalLoadFailed)&&(identical(other.isRecentBeneficiariesLoadFailed, isRecentBeneficiariesLoadFailed) || other.isRecentBeneficiariesLoadFailed == isRecentBeneficiariesLoadFailed)&&(identical(other.isRecentTransactionsLoadFailed, isRecentTransactionsLoadFailed) || other.isRecentTransactionsLoadFailed == isRecentTransactionsLoadFailed)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isOtpSubmitting, isOtpSubmitting) || other.isOtpSubmitting == isOtpSubmitting)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&(identical(other.showOtpErrorMessages, showOtpErrorMessages) || other.showOtpErrorMessages == showOtpErrorMessages)&&(identical(other.isCorridorLoading, isCorridorLoading) || other.isCorridorLoading == isCorridorLoading)&&(identical(other.failedCorridorStage, failedCorridorStage) || other.failedCorridorStage == failedCorridorStage)&&(identical(other.isTransferTypeUnavailable, isTransferTypeUnavailable) || other.isTransferTypeUnavailable == isTransferTypeUnavailable)&&(identical(other.isBeneficiaryListLoading, isBeneficiaryListLoading) || other.isBeneficiaryListLoading == isBeneficiaryListLoading)&&(identical(other.isBeneficiaryListLoadFailed, isBeneficiaryListLoadFailed) || other.isBeneficiaryListLoadFailed == isBeneficiaryListLoadFailed)&&(identical(other.isDeletingBeneficiary, isDeletingBeneficiary) || other.isDeletingBeneficiary == isDeletingBeneficiary)&&(identical(other.isMandatoryFieldCheckLoading, isMandatoryFieldCheckLoading) || other.isMandatoryFieldCheckLoading == isMandatoryFieldCheckLoading)&&(identical(other.tappedRecentBeneficiary, tappedRecentBeneficiary) || other.tappedRecentBeneficiary == tappedRecentBeneficiary)&&(identical(other.homeAdvertisementDto, homeAdvertisementDto) || other.homeAdvertisementDto == homeAdvertisementDto)&&(identical(other.homeUserDto, homeUserDto) || other.homeUserDto == homeUserDto)&&(identical(other.homeRecentBeneficiariesDto, homeRecentBeneficiariesDto) || other.homeRecentBeneficiariesDto == homeRecentBeneficiariesDto)&&(identical(other.homeRecentTransactionsDto, homeRecentTransactionsDto) || other.homeRecentTransactionsDto == homeRecentTransactionsDto)&&(identical(other.commonDestinationSelectableDto, commonDestinationSelectableDto) || other.commonDestinationSelectableDto == commonDestinationSelectableDto)&&(identical(other.isDestinationLoadFailed, isDestinationLoadFailed) || other.isDestinationLoadFailed == isDestinationLoadFailed)&&(identical(other.isDestinationUnavailable, isDestinationUnavailable) || other.isDestinationUnavailable == isDestinationUnavailable)&&(identical(other.selectedCommonDestinationItem, selectedCommonDestinationItem) || other.selectedCommonDestinationItem == selectedCommonDestinationItem)&&(identical(other.isTransferTypeLoading, isTransferTypeLoading) || other.isTransferTypeLoading == isTransferTypeLoading)&&(identical(other.homeTransferTypeDto, homeTransferTypeDto) || other.homeTransferTypeDto == homeTransferTypeDto)&&(identical(other.selectedTransferTypeItem, selectedTransferTypeItem) || other.selectedTransferTypeItem == selectedTransferTypeItem)&&(identical(other.commonBankOrAgentSelectableDto, commonBankOrAgentSelectableDto) || other.commonBankOrAgentSelectableDto == commonBankOrAgentSelectableDto)&&(identical(other.selectedBankOrAgentItem, selectedBankOrAgentItem) || other.selectedBankOrAgentItem == selectedBankOrAgentItem)&&(identical(other.commonAgentSelectableDto, commonAgentSelectableDto) || other.commonAgentSelectableDto == commonAgentSelectableDto)&&(identical(other.isAgentNotRequired, isAgentNotRequired) || other.isAgentNotRequired == isAgentNotRequired)&&(identical(other.selectedAgentItem, selectedAgentItem) || other.selectedAgentItem == selectedAgentItem)&&(identical(other.sendAgainAgentItem, sendAgainAgentItem) || other.sendAgainAgentItem == sendAgainAgentItem)&&(identical(other.homeBeneficiaryListDto, homeBeneficiaryListDto) || other.homeBeneficiaryListDto == homeBeneficiaryListDto)&&(identical(other.selectedBeneficiaryIndex, selectedBeneficiaryIndex) || other.selectedBeneficiaryIndex == selectedBeneficiaryIndex)&&(identical(other.currentEmailAddress, currentEmailAddress) || other.currentEmailAddress == currentEmailAddress)&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress)&&(identical(other.emailOtp, emailOtp) || other.emailOtp == emailOtp)&&(identical(other.homeAdvertisementFailureOrSuccessOption, homeAdvertisementFailureOrSuccessOption) || other.homeAdvertisementFailureOrSuccessOption == homeAdvertisementFailureOrSuccessOption)&&(identical(other.homeUserFailureOrSuccessOption, homeUserFailureOrSuccessOption) || other.homeUserFailureOrSuccessOption == homeUserFailureOrSuccessOption)&&(identical(other.homeBeneficiaryListFailureOrSuccessOption, homeBeneficiaryListFailureOrSuccessOption) || other.homeBeneficiaryListFailureOrSuccessOption == homeBeneficiaryListFailureOrSuccessOption)&&(identical(other.homeDeleteBeneficiaryFailureOrSuccessOption, homeDeleteBeneficiaryFailureOrSuccessOption) || other.homeDeleteBeneficiaryFailureOrSuccessOption == homeDeleteBeneficiaryFailureOrSuccessOption)&&(identical(other.homeMandatoryFieldCheckFailureOrSuccessOption, homeMandatoryFieldCheckFailureOrSuccessOption) || other.homeMandatoryFieldCheckFailureOrSuccessOption == homeMandatoryFieldCheckFailureOrSuccessOption)&&(identical(other.homeSendAgainAgentOption, homeSendAgainAgentOption) || other.homeSendAgainAgentOption == homeSendAgainAgentOption)&&(identical(other.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption, homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption) || other.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption == homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption)&&(identical(other.homeRequestEmailOtpFailureOrSuccessOption, homeRequestEmailOtpFailureOrSuccessOption) || other.homeRequestEmailOtpFailureOrSuccessOption == homeRequestEmailOtpFailureOrSuccessOption)&&(identical(other.homeVerifyEmailOtpFailureOrSuccessOption, homeVerifyEmailOtpFailureOrSuccessOption) || other.homeVerifyEmailOtpFailureOrSuccessOption == homeVerifyEmailOtpFailureOrSuccessOption));
}


@override
int get hashCode => Object.hashAll([runtimeType,isUserLoading,isRecentBeneficiariesLoading,isRecentTransactionsLoading,isSendMoneyFormLoading,isRefreshing,criticalLoadFailed,isRecentBeneficiariesLoadFailed,isRecentTransactionsLoadFailed,isSubmitting,isOtpSubmitting,showErrorMessages,showOtpErrorMessages,isCorridorLoading,failedCorridorStage,isTransferTypeUnavailable,isBeneficiaryListLoading,isBeneficiaryListLoadFailed,isDeletingBeneficiary,isMandatoryFieldCheckLoading,tappedRecentBeneficiary,homeAdvertisementDto,homeUserDto,homeRecentBeneficiariesDto,homeRecentTransactionsDto,commonDestinationSelectableDto,isDestinationLoadFailed,isDestinationUnavailable,selectedCommonDestinationItem,isTransferTypeLoading,homeTransferTypeDto,selectedTransferTypeItem,commonBankOrAgentSelectableDto,selectedBankOrAgentItem,commonAgentSelectableDto,isAgentNotRequired,selectedAgentItem,sendAgainAgentItem,homeBeneficiaryListDto,selectedBeneficiaryIndex,currentEmailAddress,emailAddress,emailOtp,homeAdvertisementFailureOrSuccessOption,homeUserFailureOrSuccessOption,homeBeneficiaryListFailureOrSuccessOption,homeDeleteBeneficiaryFailureOrSuccessOption,homeMandatoryFieldCheckFailureOrSuccessOption,homeSendAgainAgentOption,homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,homeRequestEmailOtpFailureOrSuccessOption,homeVerifyEmailOtpFailureOrSuccessOption]);

@override
String toString() {
  return 'HomeState(isUserLoading: $isUserLoading, isRecentBeneficiariesLoading: $isRecentBeneficiariesLoading, isRecentTransactionsLoading: $isRecentTransactionsLoading, isSendMoneyFormLoading: $isSendMoneyFormLoading, isRefreshing: $isRefreshing, criticalLoadFailed: $criticalLoadFailed, isRecentBeneficiariesLoadFailed: $isRecentBeneficiariesLoadFailed, isRecentTransactionsLoadFailed: $isRecentTransactionsLoadFailed, isSubmitting: $isSubmitting, isOtpSubmitting: $isOtpSubmitting, showErrorMessages: $showErrorMessages, showOtpErrorMessages: $showOtpErrorMessages, isCorridorLoading: $isCorridorLoading, failedCorridorStage: $failedCorridorStage, isTransferTypeUnavailable: $isTransferTypeUnavailable, isBeneficiaryListLoading: $isBeneficiaryListLoading, isBeneficiaryListLoadFailed: $isBeneficiaryListLoadFailed, isDeletingBeneficiary: $isDeletingBeneficiary, isMandatoryFieldCheckLoading: $isMandatoryFieldCheckLoading, tappedRecentBeneficiary: $tappedRecentBeneficiary, homeAdvertisementDto: $homeAdvertisementDto, homeUserDto: $homeUserDto, homeRecentBeneficiariesDto: $homeRecentBeneficiariesDto, homeRecentTransactionsDto: $homeRecentTransactionsDto, commonDestinationSelectableDto: $commonDestinationSelectableDto, isDestinationLoadFailed: $isDestinationLoadFailed, isDestinationUnavailable: $isDestinationUnavailable, selectedCommonDestinationItem: $selectedCommonDestinationItem, isTransferTypeLoading: $isTransferTypeLoading, homeTransferTypeDto: $homeTransferTypeDto, selectedTransferTypeItem: $selectedTransferTypeItem, commonBankOrAgentSelectableDto: $commonBankOrAgentSelectableDto, selectedBankOrAgentItem: $selectedBankOrAgentItem, commonAgentSelectableDto: $commonAgentSelectableDto, isAgentNotRequired: $isAgentNotRequired, selectedAgentItem: $selectedAgentItem, sendAgainAgentItem: $sendAgainAgentItem, homeBeneficiaryListDto: $homeBeneficiaryListDto, selectedBeneficiaryIndex: $selectedBeneficiaryIndex, currentEmailAddress: $currentEmailAddress, emailAddress: $emailAddress, emailOtp: $emailOtp, homeAdvertisementFailureOrSuccessOption: $homeAdvertisementFailureOrSuccessOption, homeUserFailureOrSuccessOption: $homeUserFailureOrSuccessOption, homeBeneficiaryListFailureOrSuccessOption: $homeBeneficiaryListFailureOrSuccessOption, homeDeleteBeneficiaryFailureOrSuccessOption: $homeDeleteBeneficiaryFailureOrSuccessOption, homeMandatoryFieldCheckFailureOrSuccessOption: $homeMandatoryFieldCheckFailureOrSuccessOption, homeSendAgainAgentOption: $homeSendAgainAgentOption, homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption: $homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption, homeRequestEmailOtpFailureOrSuccessOption: $homeRequestEmailOtpFailureOrSuccessOption, homeVerifyEmailOtpFailureOrSuccessOption: $homeVerifyEmailOtpFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 bool isUserLoading, bool isRecentBeneficiariesLoading, bool isRecentTransactionsLoading, bool isSendMoneyFormLoading, bool isRefreshing, bool criticalLoadFailed, bool isRecentBeneficiariesLoadFailed, bool isRecentTransactionsLoadFailed, bool isSubmitting, bool isOtpSubmitting, bool showErrorMessages, bool showOtpErrorMessages, bool isCorridorLoading, HomeCorridorStage? failedCorridorStage, bool isTransferTypeUnavailable, bool isBeneficiaryListLoading, bool isBeneficiaryListLoadFailed, bool isDeletingBeneficiary, bool isMandatoryFieldCheckLoading, RecentBeneficiaryList? tappedRecentBeneficiary, HomeAdvertisementDto? homeAdvertisementDto, HomeUserDto? homeUserDto, HomeRecentBeneficiariesDto? homeRecentBeneficiariesDto, CommonTransactionDto? homeRecentTransactionsDto, CommonSelectableDto? commonDestinationSelectableDto, bool isDestinationLoadFailed, bool isDestinationUnavailable, CommonSelectableItem? selectedCommonDestinationItem, bool isTransferTypeLoading, HomeTransferTypeDto? homeTransferTypeDto, CommonSelectableItem? selectedTransferTypeItem, CommonSelectableDto? commonBankOrAgentSelectableDto, CommonSelectableItem? selectedBankOrAgentItem, CommonSelectableDto? commonAgentSelectableDto, bool isAgentNotRequired, CommonSelectableItem? selectedAgentItem, CommonSelectableItem? sendAgainAgentItem, HomeBeneficiaryListDto? homeBeneficiaryListDto, int selectedBeneficiaryIndex, String currentEmailAddress, EmailAddress emailAddress, Otp emailOtp, Option<Either<HomeFailure, HomeAdvertisementDto>> homeAdvertisementFailureOrSuccessOption, Option<Either<HomeFailure, HomeUserDto>> homeUserFailureOrSuccessOption, Option<Either<HomeFailure, HomeBeneficiaryListDto>> homeBeneficiaryListFailureOrSuccessOption, Option<Either<HomeFailure, String>> homeDeleteBeneficiaryFailureOrSuccessOption, Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeMandatoryFieldCheckFailureOrSuccessOption, Option<Either<HomeFailure, CommonSelectableDto>> homeSendAgainAgentOption, Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption, Option<Either<HomeFailure, Unit>> homeRequestEmailOtpFailureOrSuccessOption, Option<Either<HomeFailure, Unit>> homeVerifyEmailOtpFailureOrSuccessOption
});


$RecentBeneficiaryListCopyWith<$Res>? get tappedRecentBeneficiary;$HomeAdvertisementDtoCopyWith<$Res>? get homeAdvertisementDto;$HomeUserDtoCopyWith<$Res>? get homeUserDto;$HomeRecentBeneficiariesDtoCopyWith<$Res>? get homeRecentBeneficiariesDto;$CommonTransactionDtoCopyWith<$Res>? get homeRecentTransactionsDto;$CommonSelectableDtoCopyWith<$Res>? get commonDestinationSelectableDto;$CommonSelectableItemCopyWith<$Res>? get selectedCommonDestinationItem;$HomeTransferTypeDtoCopyWith<$Res>? get homeTransferTypeDto;$CommonSelectableItemCopyWith<$Res>? get selectedTransferTypeItem;$CommonSelectableDtoCopyWith<$Res>? get commonBankOrAgentSelectableDto;$CommonSelectableItemCopyWith<$Res>? get selectedBankOrAgentItem;$CommonSelectableDtoCopyWith<$Res>? get commonAgentSelectableDto;$CommonSelectableItemCopyWith<$Res>? get selectedAgentItem;$CommonSelectableItemCopyWith<$Res>? get sendAgainAgentItem;$HomeBeneficiaryListDtoCopyWith<$Res>? get homeBeneficiaryListDto;

}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isUserLoading = null,Object? isRecentBeneficiariesLoading = null,Object? isRecentTransactionsLoading = null,Object? isSendMoneyFormLoading = null,Object? isRefreshing = null,Object? criticalLoadFailed = null,Object? isRecentBeneficiariesLoadFailed = null,Object? isRecentTransactionsLoadFailed = null,Object? isSubmitting = null,Object? isOtpSubmitting = null,Object? showErrorMessages = null,Object? showOtpErrorMessages = null,Object? isCorridorLoading = null,Object? failedCorridorStage = freezed,Object? isTransferTypeUnavailable = null,Object? isBeneficiaryListLoading = null,Object? isBeneficiaryListLoadFailed = null,Object? isDeletingBeneficiary = null,Object? isMandatoryFieldCheckLoading = null,Object? tappedRecentBeneficiary = freezed,Object? homeAdvertisementDto = freezed,Object? homeUserDto = freezed,Object? homeRecentBeneficiariesDto = freezed,Object? homeRecentTransactionsDto = freezed,Object? commonDestinationSelectableDto = freezed,Object? isDestinationLoadFailed = null,Object? isDestinationUnavailable = null,Object? selectedCommonDestinationItem = freezed,Object? isTransferTypeLoading = null,Object? homeTransferTypeDto = freezed,Object? selectedTransferTypeItem = freezed,Object? commonBankOrAgentSelectableDto = freezed,Object? selectedBankOrAgentItem = freezed,Object? commonAgentSelectableDto = freezed,Object? isAgentNotRequired = null,Object? selectedAgentItem = freezed,Object? sendAgainAgentItem = freezed,Object? homeBeneficiaryListDto = freezed,Object? selectedBeneficiaryIndex = null,Object? currentEmailAddress = null,Object? emailAddress = null,Object? emailOtp = null,Object? homeAdvertisementFailureOrSuccessOption = null,Object? homeUserFailureOrSuccessOption = null,Object? homeBeneficiaryListFailureOrSuccessOption = null,Object? homeDeleteBeneficiaryFailureOrSuccessOption = null,Object? homeMandatoryFieldCheckFailureOrSuccessOption = null,Object? homeSendAgainAgentOption = null,Object? homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption = null,Object? homeRequestEmailOtpFailureOrSuccessOption = null,Object? homeVerifyEmailOtpFailureOrSuccessOption = null,}) {
  return _then(_self.copyWith(
isUserLoading: null == isUserLoading ? _self.isUserLoading : isUserLoading // ignore: cast_nullable_to_non_nullable
as bool,isRecentBeneficiariesLoading: null == isRecentBeneficiariesLoading ? _self.isRecentBeneficiariesLoading : isRecentBeneficiariesLoading // ignore: cast_nullable_to_non_nullable
as bool,isRecentTransactionsLoading: null == isRecentTransactionsLoading ? _self.isRecentTransactionsLoading : isRecentTransactionsLoading // ignore: cast_nullable_to_non_nullable
as bool,isSendMoneyFormLoading: null == isSendMoneyFormLoading ? _self.isSendMoneyFormLoading : isSendMoneyFormLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,criticalLoadFailed: null == criticalLoadFailed ? _self.criticalLoadFailed : criticalLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isRecentBeneficiariesLoadFailed: null == isRecentBeneficiariesLoadFailed ? _self.isRecentBeneficiariesLoadFailed : isRecentBeneficiariesLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isRecentTransactionsLoadFailed: null == isRecentTransactionsLoadFailed ? _self.isRecentTransactionsLoadFailed : isRecentTransactionsLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isOtpSubmitting: null == isOtpSubmitting ? _self.isOtpSubmitting : isOtpSubmitting // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,showOtpErrorMessages: null == showOtpErrorMessages ? _self.showOtpErrorMessages : showOtpErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,isCorridorLoading: null == isCorridorLoading ? _self.isCorridorLoading : isCorridorLoading // ignore: cast_nullable_to_non_nullable
as bool,failedCorridorStage: freezed == failedCorridorStage ? _self.failedCorridorStage : failedCorridorStage // ignore: cast_nullable_to_non_nullable
as HomeCorridorStage?,isTransferTypeUnavailable: null == isTransferTypeUnavailable ? _self.isTransferTypeUnavailable : isTransferTypeUnavailable // ignore: cast_nullable_to_non_nullable
as bool,isBeneficiaryListLoading: null == isBeneficiaryListLoading ? _self.isBeneficiaryListLoading : isBeneficiaryListLoading // ignore: cast_nullable_to_non_nullable
as bool,isBeneficiaryListLoadFailed: null == isBeneficiaryListLoadFailed ? _self.isBeneficiaryListLoadFailed : isBeneficiaryListLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isDeletingBeneficiary: null == isDeletingBeneficiary ? _self.isDeletingBeneficiary : isDeletingBeneficiary // ignore: cast_nullable_to_non_nullable
as bool,isMandatoryFieldCheckLoading: null == isMandatoryFieldCheckLoading ? _self.isMandatoryFieldCheckLoading : isMandatoryFieldCheckLoading // ignore: cast_nullable_to_non_nullable
as bool,tappedRecentBeneficiary: freezed == tappedRecentBeneficiary ? _self.tappedRecentBeneficiary : tappedRecentBeneficiary // ignore: cast_nullable_to_non_nullable
as RecentBeneficiaryList?,homeAdvertisementDto: freezed == homeAdvertisementDto ? _self.homeAdvertisementDto : homeAdvertisementDto // ignore: cast_nullable_to_non_nullable
as HomeAdvertisementDto?,homeUserDto: freezed == homeUserDto ? _self.homeUserDto : homeUserDto // ignore: cast_nullable_to_non_nullable
as HomeUserDto?,homeRecentBeneficiariesDto: freezed == homeRecentBeneficiariesDto ? _self.homeRecentBeneficiariesDto : homeRecentBeneficiariesDto // ignore: cast_nullable_to_non_nullable
as HomeRecentBeneficiariesDto?,homeRecentTransactionsDto: freezed == homeRecentTransactionsDto ? _self.homeRecentTransactionsDto : homeRecentTransactionsDto // ignore: cast_nullable_to_non_nullable
as CommonTransactionDto?,commonDestinationSelectableDto: freezed == commonDestinationSelectableDto ? _self.commonDestinationSelectableDto : commonDestinationSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,isDestinationLoadFailed: null == isDestinationLoadFailed ? _self.isDestinationLoadFailed : isDestinationLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isDestinationUnavailable: null == isDestinationUnavailable ? _self.isDestinationUnavailable : isDestinationUnavailable // ignore: cast_nullable_to_non_nullable
as bool,selectedCommonDestinationItem: freezed == selectedCommonDestinationItem ? _self.selectedCommonDestinationItem : selectedCommonDestinationItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,isTransferTypeLoading: null == isTransferTypeLoading ? _self.isTransferTypeLoading : isTransferTypeLoading // ignore: cast_nullable_to_non_nullable
as bool,homeTransferTypeDto: freezed == homeTransferTypeDto ? _self.homeTransferTypeDto : homeTransferTypeDto // ignore: cast_nullable_to_non_nullable
as HomeTransferTypeDto?,selectedTransferTypeItem: freezed == selectedTransferTypeItem ? _self.selectedTransferTypeItem : selectedTransferTypeItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,commonBankOrAgentSelectableDto: freezed == commonBankOrAgentSelectableDto ? _self.commonBankOrAgentSelectableDto : commonBankOrAgentSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedBankOrAgentItem: freezed == selectedBankOrAgentItem ? _self.selectedBankOrAgentItem : selectedBankOrAgentItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,commonAgentSelectableDto: freezed == commonAgentSelectableDto ? _self.commonAgentSelectableDto : commonAgentSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,isAgentNotRequired: null == isAgentNotRequired ? _self.isAgentNotRequired : isAgentNotRequired // ignore: cast_nullable_to_non_nullable
as bool,selectedAgentItem: freezed == selectedAgentItem ? _self.selectedAgentItem : selectedAgentItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,sendAgainAgentItem: freezed == sendAgainAgentItem ? _self.sendAgainAgentItem : sendAgainAgentItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,homeBeneficiaryListDto: freezed == homeBeneficiaryListDto ? _self.homeBeneficiaryListDto : homeBeneficiaryListDto // ignore: cast_nullable_to_non_nullable
as HomeBeneficiaryListDto?,selectedBeneficiaryIndex: null == selectedBeneficiaryIndex ? _self.selectedBeneficiaryIndex : selectedBeneficiaryIndex // ignore: cast_nullable_to_non_nullable
as int,currentEmailAddress: null == currentEmailAddress ? _self.currentEmailAddress : currentEmailAddress // ignore: cast_nullable_to_non_nullable
as String,emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as EmailAddress,emailOtp: null == emailOtp ? _self.emailOtp : emailOtp // ignore: cast_nullable_to_non_nullable
as Otp,homeAdvertisementFailureOrSuccessOption: null == homeAdvertisementFailureOrSuccessOption ? _self.homeAdvertisementFailureOrSuccessOption : homeAdvertisementFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeAdvertisementDto>>,homeUserFailureOrSuccessOption: null == homeUserFailureOrSuccessOption ? _self.homeUserFailureOrSuccessOption : homeUserFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeUserDto>>,homeBeneficiaryListFailureOrSuccessOption: null == homeBeneficiaryListFailureOrSuccessOption ? _self.homeBeneficiaryListFailureOrSuccessOption : homeBeneficiaryListFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeBeneficiaryListDto>>,homeDeleteBeneficiaryFailureOrSuccessOption: null == homeDeleteBeneficiaryFailureOrSuccessOption ? _self.homeDeleteBeneficiaryFailureOrSuccessOption : homeDeleteBeneficiaryFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, String>>,homeMandatoryFieldCheckFailureOrSuccessOption: null == homeMandatoryFieldCheckFailureOrSuccessOption ? _self.homeMandatoryFieldCheckFailureOrSuccessOption : homeMandatoryFieldCheckFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>>,homeSendAgainAgentOption: null == homeSendAgainAgentOption ? _self.homeSendAgainAgentOption : homeSendAgainAgentOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, CommonSelectableDto>>,homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption: null == homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption ? _self.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption : homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>>,homeRequestEmailOtpFailureOrSuccessOption: null == homeRequestEmailOtpFailureOrSuccessOption ? _self.homeRequestEmailOtpFailureOrSuccessOption : homeRequestEmailOtpFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, Unit>>,homeVerifyEmailOtpFailureOrSuccessOption: null == homeVerifyEmailOtpFailureOrSuccessOption ? _self.homeVerifyEmailOtpFailureOrSuccessOption : homeVerifyEmailOtpFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, Unit>>,
  ));
}
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecentBeneficiaryListCopyWith<$Res>? get tappedRecentBeneficiary {
    if (_self.tappedRecentBeneficiary == null) {
    return null;
  }

  return $RecentBeneficiaryListCopyWith<$Res>(_self.tappedRecentBeneficiary!, (value) {
    return _then(_self.copyWith(tappedRecentBeneficiary: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeAdvertisementDtoCopyWith<$Res>? get homeAdvertisementDto {
    if (_self.homeAdvertisementDto == null) {
    return null;
  }

  return $HomeAdvertisementDtoCopyWith<$Res>(_self.homeAdvertisementDto!, (value) {
    return _then(_self.copyWith(homeAdvertisementDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeUserDtoCopyWith<$Res>? get homeUserDto {
    if (_self.homeUserDto == null) {
    return null;
  }

  return $HomeUserDtoCopyWith<$Res>(_self.homeUserDto!, (value) {
    return _then(_self.copyWith(homeUserDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeRecentBeneficiariesDtoCopyWith<$Res>? get homeRecentBeneficiariesDto {
    if (_self.homeRecentBeneficiariesDto == null) {
    return null;
  }

  return $HomeRecentBeneficiariesDtoCopyWith<$Res>(_self.homeRecentBeneficiariesDto!, (value) {
    return _then(_self.copyWith(homeRecentBeneficiariesDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonTransactionDtoCopyWith<$Res>? get homeRecentTransactionsDto {
    if (_self.homeRecentTransactionsDto == null) {
    return null;
  }

  return $CommonTransactionDtoCopyWith<$Res>(_self.homeRecentTransactionsDto!, (value) {
    return _then(_self.copyWith(homeRecentTransactionsDto: value));
  });
}/// Create a copy of HomeState
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
}/// Create a copy of HomeState
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
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeTransferTypeDtoCopyWith<$Res>? get homeTransferTypeDto {
    if (_self.homeTransferTypeDto == null) {
    return null;
  }

  return $HomeTransferTypeDtoCopyWith<$Res>(_self.homeTransferTypeDto!, (value) {
    return _then(_self.copyWith(homeTransferTypeDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedTransferTypeItem {
    if (_self.selectedTransferTypeItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedTransferTypeItem!, (value) {
    return _then(_self.copyWith(selectedTransferTypeItem: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonBankOrAgentSelectableDto {
    if (_self.commonBankOrAgentSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonBankOrAgentSelectableDto!, (value) {
    return _then(_self.copyWith(commonBankOrAgentSelectableDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedBankOrAgentItem {
    if (_self.selectedBankOrAgentItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedBankOrAgentItem!, (value) {
    return _then(_self.copyWith(selectedBankOrAgentItem: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonAgentSelectableDto {
    if (_self.commonAgentSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonAgentSelectableDto!, (value) {
    return _then(_self.copyWith(commonAgentSelectableDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedAgentItem {
    if (_self.selectedAgentItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedAgentItem!, (value) {
    return _then(_self.copyWith(selectedAgentItem: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get sendAgainAgentItem {
    if (_self.sendAgainAgentItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.sendAgainAgentItem!, (value) {
    return _then(_self.copyWith(sendAgainAgentItem: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeBeneficiaryListDtoCopyWith<$Res>? get homeBeneficiaryListDto {
    if (_self.homeBeneficiaryListDto == null) {
    return null;
  }

  return $HomeBeneficiaryListDtoCopyWith<$Res>(_self.homeBeneficiaryListDto!, (value) {
    return _then(_self.copyWith(homeBeneficiaryListDto: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isUserLoading,  bool isRecentBeneficiariesLoading,  bool isRecentTransactionsLoading,  bool isSendMoneyFormLoading,  bool isRefreshing,  bool criticalLoadFailed,  bool isRecentBeneficiariesLoadFailed,  bool isRecentTransactionsLoadFailed,  bool isSubmitting,  bool isOtpSubmitting,  bool showErrorMessages,  bool showOtpErrorMessages,  bool isCorridorLoading,  HomeCorridorStage? failedCorridorStage,  bool isTransferTypeUnavailable,  bool isBeneficiaryListLoading,  bool isBeneficiaryListLoadFailed,  bool isDeletingBeneficiary,  bool isMandatoryFieldCheckLoading,  RecentBeneficiaryList? tappedRecentBeneficiary,  HomeAdvertisementDto? homeAdvertisementDto,  HomeUserDto? homeUserDto,  HomeRecentBeneficiariesDto? homeRecentBeneficiariesDto,  CommonTransactionDto? homeRecentTransactionsDto,  CommonSelectableDto? commonDestinationSelectableDto,  bool isDestinationLoadFailed,  bool isDestinationUnavailable,  CommonSelectableItem? selectedCommonDestinationItem,  bool isTransferTypeLoading,  HomeTransferTypeDto? homeTransferTypeDto,  CommonSelectableItem? selectedTransferTypeItem,  CommonSelectableDto? commonBankOrAgentSelectableDto,  CommonSelectableItem? selectedBankOrAgentItem,  CommonSelectableDto? commonAgentSelectableDto,  bool isAgentNotRequired,  CommonSelectableItem? selectedAgentItem,  CommonSelectableItem? sendAgainAgentItem,  HomeBeneficiaryListDto? homeBeneficiaryListDto,  int selectedBeneficiaryIndex,  String currentEmailAddress,  EmailAddress emailAddress,  Otp emailOtp,  Option<Either<HomeFailure, HomeAdvertisementDto>> homeAdvertisementFailureOrSuccessOption,  Option<Either<HomeFailure, HomeUserDto>> homeUserFailureOrSuccessOption,  Option<Either<HomeFailure, HomeBeneficiaryListDto>> homeBeneficiaryListFailureOrSuccessOption,  Option<Either<HomeFailure, String>> homeDeleteBeneficiaryFailureOrSuccessOption,  Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeMandatoryFieldCheckFailureOrSuccessOption,  Option<Either<HomeFailure, CommonSelectableDto>> homeSendAgainAgentOption,  Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,  Option<Either<HomeFailure, Unit>> homeRequestEmailOtpFailureOrSuccessOption,  Option<Either<HomeFailure, Unit>> homeVerifyEmailOtpFailureOrSuccessOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.isUserLoading,_that.isRecentBeneficiariesLoading,_that.isRecentTransactionsLoading,_that.isSendMoneyFormLoading,_that.isRefreshing,_that.criticalLoadFailed,_that.isRecentBeneficiariesLoadFailed,_that.isRecentTransactionsLoadFailed,_that.isSubmitting,_that.isOtpSubmitting,_that.showErrorMessages,_that.showOtpErrorMessages,_that.isCorridorLoading,_that.failedCorridorStage,_that.isTransferTypeUnavailable,_that.isBeneficiaryListLoading,_that.isBeneficiaryListLoadFailed,_that.isDeletingBeneficiary,_that.isMandatoryFieldCheckLoading,_that.tappedRecentBeneficiary,_that.homeAdvertisementDto,_that.homeUserDto,_that.homeRecentBeneficiariesDto,_that.homeRecentTransactionsDto,_that.commonDestinationSelectableDto,_that.isDestinationLoadFailed,_that.isDestinationUnavailable,_that.selectedCommonDestinationItem,_that.isTransferTypeLoading,_that.homeTransferTypeDto,_that.selectedTransferTypeItem,_that.commonBankOrAgentSelectableDto,_that.selectedBankOrAgentItem,_that.commonAgentSelectableDto,_that.isAgentNotRequired,_that.selectedAgentItem,_that.sendAgainAgentItem,_that.homeBeneficiaryListDto,_that.selectedBeneficiaryIndex,_that.currentEmailAddress,_that.emailAddress,_that.emailOtp,_that.homeAdvertisementFailureOrSuccessOption,_that.homeUserFailureOrSuccessOption,_that.homeBeneficiaryListFailureOrSuccessOption,_that.homeDeleteBeneficiaryFailureOrSuccessOption,_that.homeMandatoryFieldCheckFailureOrSuccessOption,_that.homeSendAgainAgentOption,_that.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,_that.homeRequestEmailOtpFailureOrSuccessOption,_that.homeVerifyEmailOtpFailureOrSuccessOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isUserLoading,  bool isRecentBeneficiariesLoading,  bool isRecentTransactionsLoading,  bool isSendMoneyFormLoading,  bool isRefreshing,  bool criticalLoadFailed,  bool isRecentBeneficiariesLoadFailed,  bool isRecentTransactionsLoadFailed,  bool isSubmitting,  bool isOtpSubmitting,  bool showErrorMessages,  bool showOtpErrorMessages,  bool isCorridorLoading,  HomeCorridorStage? failedCorridorStage,  bool isTransferTypeUnavailable,  bool isBeneficiaryListLoading,  bool isBeneficiaryListLoadFailed,  bool isDeletingBeneficiary,  bool isMandatoryFieldCheckLoading,  RecentBeneficiaryList? tappedRecentBeneficiary,  HomeAdvertisementDto? homeAdvertisementDto,  HomeUserDto? homeUserDto,  HomeRecentBeneficiariesDto? homeRecentBeneficiariesDto,  CommonTransactionDto? homeRecentTransactionsDto,  CommonSelectableDto? commonDestinationSelectableDto,  bool isDestinationLoadFailed,  bool isDestinationUnavailable,  CommonSelectableItem? selectedCommonDestinationItem,  bool isTransferTypeLoading,  HomeTransferTypeDto? homeTransferTypeDto,  CommonSelectableItem? selectedTransferTypeItem,  CommonSelectableDto? commonBankOrAgentSelectableDto,  CommonSelectableItem? selectedBankOrAgentItem,  CommonSelectableDto? commonAgentSelectableDto,  bool isAgentNotRequired,  CommonSelectableItem? selectedAgentItem,  CommonSelectableItem? sendAgainAgentItem,  HomeBeneficiaryListDto? homeBeneficiaryListDto,  int selectedBeneficiaryIndex,  String currentEmailAddress,  EmailAddress emailAddress,  Otp emailOtp,  Option<Either<HomeFailure, HomeAdvertisementDto>> homeAdvertisementFailureOrSuccessOption,  Option<Either<HomeFailure, HomeUserDto>> homeUserFailureOrSuccessOption,  Option<Either<HomeFailure, HomeBeneficiaryListDto>> homeBeneficiaryListFailureOrSuccessOption,  Option<Either<HomeFailure, String>> homeDeleteBeneficiaryFailureOrSuccessOption,  Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeMandatoryFieldCheckFailureOrSuccessOption,  Option<Either<HomeFailure, CommonSelectableDto>> homeSendAgainAgentOption,  Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,  Option<Either<HomeFailure, Unit>> homeRequestEmailOtpFailureOrSuccessOption,  Option<Either<HomeFailure, Unit>> homeVerifyEmailOtpFailureOrSuccessOption)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.isUserLoading,_that.isRecentBeneficiariesLoading,_that.isRecentTransactionsLoading,_that.isSendMoneyFormLoading,_that.isRefreshing,_that.criticalLoadFailed,_that.isRecentBeneficiariesLoadFailed,_that.isRecentTransactionsLoadFailed,_that.isSubmitting,_that.isOtpSubmitting,_that.showErrorMessages,_that.showOtpErrorMessages,_that.isCorridorLoading,_that.failedCorridorStage,_that.isTransferTypeUnavailable,_that.isBeneficiaryListLoading,_that.isBeneficiaryListLoadFailed,_that.isDeletingBeneficiary,_that.isMandatoryFieldCheckLoading,_that.tappedRecentBeneficiary,_that.homeAdvertisementDto,_that.homeUserDto,_that.homeRecentBeneficiariesDto,_that.homeRecentTransactionsDto,_that.commonDestinationSelectableDto,_that.isDestinationLoadFailed,_that.isDestinationUnavailable,_that.selectedCommonDestinationItem,_that.isTransferTypeLoading,_that.homeTransferTypeDto,_that.selectedTransferTypeItem,_that.commonBankOrAgentSelectableDto,_that.selectedBankOrAgentItem,_that.commonAgentSelectableDto,_that.isAgentNotRequired,_that.selectedAgentItem,_that.sendAgainAgentItem,_that.homeBeneficiaryListDto,_that.selectedBeneficiaryIndex,_that.currentEmailAddress,_that.emailAddress,_that.emailOtp,_that.homeAdvertisementFailureOrSuccessOption,_that.homeUserFailureOrSuccessOption,_that.homeBeneficiaryListFailureOrSuccessOption,_that.homeDeleteBeneficiaryFailureOrSuccessOption,_that.homeMandatoryFieldCheckFailureOrSuccessOption,_that.homeSendAgainAgentOption,_that.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,_that.homeRequestEmailOtpFailureOrSuccessOption,_that.homeVerifyEmailOtpFailureOrSuccessOption);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isUserLoading,  bool isRecentBeneficiariesLoading,  bool isRecentTransactionsLoading,  bool isSendMoneyFormLoading,  bool isRefreshing,  bool criticalLoadFailed,  bool isRecentBeneficiariesLoadFailed,  bool isRecentTransactionsLoadFailed,  bool isSubmitting,  bool isOtpSubmitting,  bool showErrorMessages,  bool showOtpErrorMessages,  bool isCorridorLoading,  HomeCorridorStage? failedCorridorStage,  bool isTransferTypeUnavailable,  bool isBeneficiaryListLoading,  bool isBeneficiaryListLoadFailed,  bool isDeletingBeneficiary,  bool isMandatoryFieldCheckLoading,  RecentBeneficiaryList? tappedRecentBeneficiary,  HomeAdvertisementDto? homeAdvertisementDto,  HomeUserDto? homeUserDto,  HomeRecentBeneficiariesDto? homeRecentBeneficiariesDto,  CommonTransactionDto? homeRecentTransactionsDto,  CommonSelectableDto? commonDestinationSelectableDto,  bool isDestinationLoadFailed,  bool isDestinationUnavailable,  CommonSelectableItem? selectedCommonDestinationItem,  bool isTransferTypeLoading,  HomeTransferTypeDto? homeTransferTypeDto,  CommonSelectableItem? selectedTransferTypeItem,  CommonSelectableDto? commonBankOrAgentSelectableDto,  CommonSelectableItem? selectedBankOrAgentItem,  CommonSelectableDto? commonAgentSelectableDto,  bool isAgentNotRequired,  CommonSelectableItem? selectedAgentItem,  CommonSelectableItem? sendAgainAgentItem,  HomeBeneficiaryListDto? homeBeneficiaryListDto,  int selectedBeneficiaryIndex,  String currentEmailAddress,  EmailAddress emailAddress,  Otp emailOtp,  Option<Either<HomeFailure, HomeAdvertisementDto>> homeAdvertisementFailureOrSuccessOption,  Option<Either<HomeFailure, HomeUserDto>> homeUserFailureOrSuccessOption,  Option<Either<HomeFailure, HomeBeneficiaryListDto>> homeBeneficiaryListFailureOrSuccessOption,  Option<Either<HomeFailure, String>> homeDeleteBeneficiaryFailureOrSuccessOption,  Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeMandatoryFieldCheckFailureOrSuccessOption,  Option<Either<HomeFailure, CommonSelectableDto>> homeSendAgainAgentOption,  Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,  Option<Either<HomeFailure, Unit>> homeRequestEmailOtpFailureOrSuccessOption,  Option<Either<HomeFailure, Unit>> homeVerifyEmailOtpFailureOrSuccessOption)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.isUserLoading,_that.isRecentBeneficiariesLoading,_that.isRecentTransactionsLoading,_that.isSendMoneyFormLoading,_that.isRefreshing,_that.criticalLoadFailed,_that.isRecentBeneficiariesLoadFailed,_that.isRecentTransactionsLoadFailed,_that.isSubmitting,_that.isOtpSubmitting,_that.showErrorMessages,_that.showOtpErrorMessages,_that.isCorridorLoading,_that.failedCorridorStage,_that.isTransferTypeUnavailable,_that.isBeneficiaryListLoading,_that.isBeneficiaryListLoadFailed,_that.isDeletingBeneficiary,_that.isMandatoryFieldCheckLoading,_that.tappedRecentBeneficiary,_that.homeAdvertisementDto,_that.homeUserDto,_that.homeRecentBeneficiariesDto,_that.homeRecentTransactionsDto,_that.commonDestinationSelectableDto,_that.isDestinationLoadFailed,_that.isDestinationUnavailable,_that.selectedCommonDestinationItem,_that.isTransferTypeLoading,_that.homeTransferTypeDto,_that.selectedTransferTypeItem,_that.commonBankOrAgentSelectableDto,_that.selectedBankOrAgentItem,_that.commonAgentSelectableDto,_that.isAgentNotRequired,_that.selectedAgentItem,_that.sendAgainAgentItem,_that.homeBeneficiaryListDto,_that.selectedBeneficiaryIndex,_that.currentEmailAddress,_that.emailAddress,_that.emailOtp,_that.homeAdvertisementFailureOrSuccessOption,_that.homeUserFailureOrSuccessOption,_that.homeBeneficiaryListFailureOrSuccessOption,_that.homeDeleteBeneficiaryFailureOrSuccessOption,_that.homeMandatoryFieldCheckFailureOrSuccessOption,_that.homeSendAgainAgentOption,_that.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,_that.homeRequestEmailOtpFailureOrSuccessOption,_that.homeVerifyEmailOtpFailureOrSuccessOption);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({this.isUserLoading = true, this.isRecentBeneficiariesLoading = true, this.isRecentTransactionsLoading = true, this.isSendMoneyFormLoading = true, this.isRefreshing = false, this.criticalLoadFailed = false, this.isRecentBeneficiariesLoadFailed = false, this.isRecentTransactionsLoadFailed = false, required this.isSubmitting, required this.isOtpSubmitting, required this.showErrorMessages, required this.showOtpErrorMessages, this.isCorridorLoading = false, this.failedCorridorStage, this.isTransferTypeUnavailable = false, required this.isBeneficiaryListLoading, this.isBeneficiaryListLoadFailed = false, required this.isDeletingBeneficiary, this.isMandatoryFieldCheckLoading = false, this.tappedRecentBeneficiary, this.homeAdvertisementDto, this.homeUserDto, this.homeRecentBeneficiariesDto, this.homeRecentTransactionsDto, this.commonDestinationSelectableDto, this.isDestinationLoadFailed = false, this.isDestinationUnavailable = false, this.selectedCommonDestinationItem, this.isTransferTypeLoading = false, this.homeTransferTypeDto, this.selectedTransferTypeItem, this.commonBankOrAgentSelectableDto, this.selectedBankOrAgentItem, this.commonAgentSelectableDto, this.isAgentNotRequired = false, this.selectedAgentItem, this.sendAgainAgentItem, this.homeBeneficiaryListDto, required this.selectedBeneficiaryIndex, required this.currentEmailAddress, required this.emailAddress, required this.emailOtp, required this.homeAdvertisementFailureOrSuccessOption, required this.homeUserFailureOrSuccessOption, required this.homeBeneficiaryListFailureOrSuccessOption, required this.homeDeleteBeneficiaryFailureOrSuccessOption, required this.homeMandatoryFieldCheckFailureOrSuccessOption, required this.homeSendAgainAgentOption, required this.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption, required this.homeRequestEmailOtpFailureOrSuccessOption, required this.homeVerifyEmailOtpFailureOrSuccessOption});
  

@override@JsonKey() final  bool isUserLoading;
@override@JsonKey() final  bool isRecentBeneficiariesLoading;
@override@JsonKey() final  bool isRecentTransactionsLoading;
@override@JsonKey() final  bool isSendMoneyFormLoading;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool criticalLoadFailed;
@override@JsonKey() final  bool isRecentBeneficiariesLoadFailed;
@override@JsonKey() final  bool isRecentTransactionsLoadFailed;
@override final  bool isSubmitting;
@override final  bool isOtpSubmitting;
@override final  bool showErrorMessages;
@override final  bool showOtpErrorMessages;
@override@JsonKey() final  bool isCorridorLoading;
@override final  HomeCorridorStage? failedCorridorStage;
@override@JsonKey() final  bool isTransferTypeUnavailable;
@override final  bool isBeneficiaryListLoading;
@override@JsonKey() final  bool isBeneficiaryListLoadFailed;
@override final  bool isDeletingBeneficiary;
@override@JsonKey() final  bool isMandatoryFieldCheckLoading;
@override final  RecentBeneficiaryList? tappedRecentBeneficiary;
@override final  HomeAdvertisementDto? homeAdvertisementDto;
@override final  HomeUserDto? homeUserDto;
@override final  HomeRecentBeneficiariesDto? homeRecentBeneficiariesDto;
@override final  CommonTransactionDto? homeRecentTransactionsDto;
@override final  CommonSelectableDto? commonDestinationSelectableDto;
@override@JsonKey() final  bool isDestinationLoadFailed;
@override@JsonKey() final  bool isDestinationUnavailable;
@override final  CommonSelectableItem? selectedCommonDestinationItem;
@override@JsonKey() final  bool isTransferTypeLoading;
@override final  HomeTransferTypeDto? homeTransferTypeDto;
@override final  CommonSelectableItem? selectedTransferTypeItem;
@override final  CommonSelectableDto? commonBankOrAgentSelectableDto;
@override final  CommonSelectableItem? selectedBankOrAgentItem;
@override final  CommonSelectableDto? commonAgentSelectableDto;
@override@JsonKey() final  bool isAgentNotRequired;
@override final  CommonSelectableItem? selectedAgentItem;
@override final  CommonSelectableItem? sendAgainAgentItem;
@override final  HomeBeneficiaryListDto? homeBeneficiaryListDto;
@override final  int selectedBeneficiaryIndex;
@override final  String currentEmailAddress;
@override final  EmailAddress emailAddress;
@override final  Otp emailOtp;
@override final  Option<Either<HomeFailure, HomeAdvertisementDto>> homeAdvertisementFailureOrSuccessOption;
@override final  Option<Either<HomeFailure, HomeUserDto>> homeUserFailureOrSuccessOption;
@override final  Option<Either<HomeFailure, HomeBeneficiaryListDto>> homeBeneficiaryListFailureOrSuccessOption;
@override final  Option<Either<HomeFailure, String>> homeDeleteBeneficiaryFailureOrSuccessOption;
@override final  Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeMandatoryFieldCheckFailureOrSuccessOption;
@override final  Option<Either<HomeFailure, CommonSelectableDto>> homeSendAgainAgentOption;
@override final  Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption;
@override final  Option<Either<HomeFailure, Unit>> homeRequestEmailOtpFailureOrSuccessOption;
@override final  Option<Either<HomeFailure, Unit>> homeVerifyEmailOtpFailureOrSuccessOption;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.isUserLoading, isUserLoading) || other.isUserLoading == isUserLoading)&&(identical(other.isRecentBeneficiariesLoading, isRecentBeneficiariesLoading) || other.isRecentBeneficiariesLoading == isRecentBeneficiariesLoading)&&(identical(other.isRecentTransactionsLoading, isRecentTransactionsLoading) || other.isRecentTransactionsLoading == isRecentTransactionsLoading)&&(identical(other.isSendMoneyFormLoading, isSendMoneyFormLoading) || other.isSendMoneyFormLoading == isSendMoneyFormLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.criticalLoadFailed, criticalLoadFailed) || other.criticalLoadFailed == criticalLoadFailed)&&(identical(other.isRecentBeneficiariesLoadFailed, isRecentBeneficiariesLoadFailed) || other.isRecentBeneficiariesLoadFailed == isRecentBeneficiariesLoadFailed)&&(identical(other.isRecentTransactionsLoadFailed, isRecentTransactionsLoadFailed) || other.isRecentTransactionsLoadFailed == isRecentTransactionsLoadFailed)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isOtpSubmitting, isOtpSubmitting) || other.isOtpSubmitting == isOtpSubmitting)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&(identical(other.showOtpErrorMessages, showOtpErrorMessages) || other.showOtpErrorMessages == showOtpErrorMessages)&&(identical(other.isCorridorLoading, isCorridorLoading) || other.isCorridorLoading == isCorridorLoading)&&(identical(other.failedCorridorStage, failedCorridorStage) || other.failedCorridorStage == failedCorridorStage)&&(identical(other.isTransferTypeUnavailable, isTransferTypeUnavailable) || other.isTransferTypeUnavailable == isTransferTypeUnavailable)&&(identical(other.isBeneficiaryListLoading, isBeneficiaryListLoading) || other.isBeneficiaryListLoading == isBeneficiaryListLoading)&&(identical(other.isBeneficiaryListLoadFailed, isBeneficiaryListLoadFailed) || other.isBeneficiaryListLoadFailed == isBeneficiaryListLoadFailed)&&(identical(other.isDeletingBeneficiary, isDeletingBeneficiary) || other.isDeletingBeneficiary == isDeletingBeneficiary)&&(identical(other.isMandatoryFieldCheckLoading, isMandatoryFieldCheckLoading) || other.isMandatoryFieldCheckLoading == isMandatoryFieldCheckLoading)&&(identical(other.tappedRecentBeneficiary, tappedRecentBeneficiary) || other.tappedRecentBeneficiary == tappedRecentBeneficiary)&&(identical(other.homeAdvertisementDto, homeAdvertisementDto) || other.homeAdvertisementDto == homeAdvertisementDto)&&(identical(other.homeUserDto, homeUserDto) || other.homeUserDto == homeUserDto)&&(identical(other.homeRecentBeneficiariesDto, homeRecentBeneficiariesDto) || other.homeRecentBeneficiariesDto == homeRecentBeneficiariesDto)&&(identical(other.homeRecentTransactionsDto, homeRecentTransactionsDto) || other.homeRecentTransactionsDto == homeRecentTransactionsDto)&&(identical(other.commonDestinationSelectableDto, commonDestinationSelectableDto) || other.commonDestinationSelectableDto == commonDestinationSelectableDto)&&(identical(other.isDestinationLoadFailed, isDestinationLoadFailed) || other.isDestinationLoadFailed == isDestinationLoadFailed)&&(identical(other.isDestinationUnavailable, isDestinationUnavailable) || other.isDestinationUnavailable == isDestinationUnavailable)&&(identical(other.selectedCommonDestinationItem, selectedCommonDestinationItem) || other.selectedCommonDestinationItem == selectedCommonDestinationItem)&&(identical(other.isTransferTypeLoading, isTransferTypeLoading) || other.isTransferTypeLoading == isTransferTypeLoading)&&(identical(other.homeTransferTypeDto, homeTransferTypeDto) || other.homeTransferTypeDto == homeTransferTypeDto)&&(identical(other.selectedTransferTypeItem, selectedTransferTypeItem) || other.selectedTransferTypeItem == selectedTransferTypeItem)&&(identical(other.commonBankOrAgentSelectableDto, commonBankOrAgentSelectableDto) || other.commonBankOrAgentSelectableDto == commonBankOrAgentSelectableDto)&&(identical(other.selectedBankOrAgentItem, selectedBankOrAgentItem) || other.selectedBankOrAgentItem == selectedBankOrAgentItem)&&(identical(other.commonAgentSelectableDto, commonAgentSelectableDto) || other.commonAgentSelectableDto == commonAgentSelectableDto)&&(identical(other.isAgentNotRequired, isAgentNotRequired) || other.isAgentNotRequired == isAgentNotRequired)&&(identical(other.selectedAgentItem, selectedAgentItem) || other.selectedAgentItem == selectedAgentItem)&&(identical(other.sendAgainAgentItem, sendAgainAgentItem) || other.sendAgainAgentItem == sendAgainAgentItem)&&(identical(other.homeBeneficiaryListDto, homeBeneficiaryListDto) || other.homeBeneficiaryListDto == homeBeneficiaryListDto)&&(identical(other.selectedBeneficiaryIndex, selectedBeneficiaryIndex) || other.selectedBeneficiaryIndex == selectedBeneficiaryIndex)&&(identical(other.currentEmailAddress, currentEmailAddress) || other.currentEmailAddress == currentEmailAddress)&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress)&&(identical(other.emailOtp, emailOtp) || other.emailOtp == emailOtp)&&(identical(other.homeAdvertisementFailureOrSuccessOption, homeAdvertisementFailureOrSuccessOption) || other.homeAdvertisementFailureOrSuccessOption == homeAdvertisementFailureOrSuccessOption)&&(identical(other.homeUserFailureOrSuccessOption, homeUserFailureOrSuccessOption) || other.homeUserFailureOrSuccessOption == homeUserFailureOrSuccessOption)&&(identical(other.homeBeneficiaryListFailureOrSuccessOption, homeBeneficiaryListFailureOrSuccessOption) || other.homeBeneficiaryListFailureOrSuccessOption == homeBeneficiaryListFailureOrSuccessOption)&&(identical(other.homeDeleteBeneficiaryFailureOrSuccessOption, homeDeleteBeneficiaryFailureOrSuccessOption) || other.homeDeleteBeneficiaryFailureOrSuccessOption == homeDeleteBeneficiaryFailureOrSuccessOption)&&(identical(other.homeMandatoryFieldCheckFailureOrSuccessOption, homeMandatoryFieldCheckFailureOrSuccessOption) || other.homeMandatoryFieldCheckFailureOrSuccessOption == homeMandatoryFieldCheckFailureOrSuccessOption)&&(identical(other.homeSendAgainAgentOption, homeSendAgainAgentOption) || other.homeSendAgainAgentOption == homeSendAgainAgentOption)&&(identical(other.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption, homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption) || other.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption == homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption)&&(identical(other.homeRequestEmailOtpFailureOrSuccessOption, homeRequestEmailOtpFailureOrSuccessOption) || other.homeRequestEmailOtpFailureOrSuccessOption == homeRequestEmailOtpFailureOrSuccessOption)&&(identical(other.homeVerifyEmailOtpFailureOrSuccessOption, homeVerifyEmailOtpFailureOrSuccessOption) || other.homeVerifyEmailOtpFailureOrSuccessOption == homeVerifyEmailOtpFailureOrSuccessOption));
}


@override
int get hashCode => Object.hashAll([runtimeType,isUserLoading,isRecentBeneficiariesLoading,isRecentTransactionsLoading,isSendMoneyFormLoading,isRefreshing,criticalLoadFailed,isRecentBeneficiariesLoadFailed,isRecentTransactionsLoadFailed,isSubmitting,isOtpSubmitting,showErrorMessages,showOtpErrorMessages,isCorridorLoading,failedCorridorStage,isTransferTypeUnavailable,isBeneficiaryListLoading,isBeneficiaryListLoadFailed,isDeletingBeneficiary,isMandatoryFieldCheckLoading,tappedRecentBeneficiary,homeAdvertisementDto,homeUserDto,homeRecentBeneficiariesDto,homeRecentTransactionsDto,commonDestinationSelectableDto,isDestinationLoadFailed,isDestinationUnavailable,selectedCommonDestinationItem,isTransferTypeLoading,homeTransferTypeDto,selectedTransferTypeItem,commonBankOrAgentSelectableDto,selectedBankOrAgentItem,commonAgentSelectableDto,isAgentNotRequired,selectedAgentItem,sendAgainAgentItem,homeBeneficiaryListDto,selectedBeneficiaryIndex,currentEmailAddress,emailAddress,emailOtp,homeAdvertisementFailureOrSuccessOption,homeUserFailureOrSuccessOption,homeBeneficiaryListFailureOrSuccessOption,homeDeleteBeneficiaryFailureOrSuccessOption,homeMandatoryFieldCheckFailureOrSuccessOption,homeSendAgainAgentOption,homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,homeRequestEmailOtpFailureOrSuccessOption,homeVerifyEmailOtpFailureOrSuccessOption]);

@override
String toString() {
  return 'HomeState(isUserLoading: $isUserLoading, isRecentBeneficiariesLoading: $isRecentBeneficiariesLoading, isRecentTransactionsLoading: $isRecentTransactionsLoading, isSendMoneyFormLoading: $isSendMoneyFormLoading, isRefreshing: $isRefreshing, criticalLoadFailed: $criticalLoadFailed, isRecentBeneficiariesLoadFailed: $isRecentBeneficiariesLoadFailed, isRecentTransactionsLoadFailed: $isRecentTransactionsLoadFailed, isSubmitting: $isSubmitting, isOtpSubmitting: $isOtpSubmitting, showErrorMessages: $showErrorMessages, showOtpErrorMessages: $showOtpErrorMessages, isCorridorLoading: $isCorridorLoading, failedCorridorStage: $failedCorridorStage, isTransferTypeUnavailable: $isTransferTypeUnavailable, isBeneficiaryListLoading: $isBeneficiaryListLoading, isBeneficiaryListLoadFailed: $isBeneficiaryListLoadFailed, isDeletingBeneficiary: $isDeletingBeneficiary, isMandatoryFieldCheckLoading: $isMandatoryFieldCheckLoading, tappedRecentBeneficiary: $tappedRecentBeneficiary, homeAdvertisementDto: $homeAdvertisementDto, homeUserDto: $homeUserDto, homeRecentBeneficiariesDto: $homeRecentBeneficiariesDto, homeRecentTransactionsDto: $homeRecentTransactionsDto, commonDestinationSelectableDto: $commonDestinationSelectableDto, isDestinationLoadFailed: $isDestinationLoadFailed, isDestinationUnavailable: $isDestinationUnavailable, selectedCommonDestinationItem: $selectedCommonDestinationItem, isTransferTypeLoading: $isTransferTypeLoading, homeTransferTypeDto: $homeTransferTypeDto, selectedTransferTypeItem: $selectedTransferTypeItem, commonBankOrAgentSelectableDto: $commonBankOrAgentSelectableDto, selectedBankOrAgentItem: $selectedBankOrAgentItem, commonAgentSelectableDto: $commonAgentSelectableDto, isAgentNotRequired: $isAgentNotRequired, selectedAgentItem: $selectedAgentItem, sendAgainAgentItem: $sendAgainAgentItem, homeBeneficiaryListDto: $homeBeneficiaryListDto, selectedBeneficiaryIndex: $selectedBeneficiaryIndex, currentEmailAddress: $currentEmailAddress, emailAddress: $emailAddress, emailOtp: $emailOtp, homeAdvertisementFailureOrSuccessOption: $homeAdvertisementFailureOrSuccessOption, homeUserFailureOrSuccessOption: $homeUserFailureOrSuccessOption, homeBeneficiaryListFailureOrSuccessOption: $homeBeneficiaryListFailureOrSuccessOption, homeDeleteBeneficiaryFailureOrSuccessOption: $homeDeleteBeneficiaryFailureOrSuccessOption, homeMandatoryFieldCheckFailureOrSuccessOption: $homeMandatoryFieldCheckFailureOrSuccessOption, homeSendAgainAgentOption: $homeSendAgainAgentOption, homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption: $homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption, homeRequestEmailOtpFailureOrSuccessOption: $homeRequestEmailOtpFailureOrSuccessOption, homeVerifyEmailOtpFailureOrSuccessOption: $homeVerifyEmailOtpFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 bool isUserLoading, bool isRecentBeneficiariesLoading, bool isRecentTransactionsLoading, bool isSendMoneyFormLoading, bool isRefreshing, bool criticalLoadFailed, bool isRecentBeneficiariesLoadFailed, bool isRecentTransactionsLoadFailed, bool isSubmitting, bool isOtpSubmitting, bool showErrorMessages, bool showOtpErrorMessages, bool isCorridorLoading, HomeCorridorStage? failedCorridorStage, bool isTransferTypeUnavailable, bool isBeneficiaryListLoading, bool isBeneficiaryListLoadFailed, bool isDeletingBeneficiary, bool isMandatoryFieldCheckLoading, RecentBeneficiaryList? tappedRecentBeneficiary, HomeAdvertisementDto? homeAdvertisementDto, HomeUserDto? homeUserDto, HomeRecentBeneficiariesDto? homeRecentBeneficiariesDto, CommonTransactionDto? homeRecentTransactionsDto, CommonSelectableDto? commonDestinationSelectableDto, bool isDestinationLoadFailed, bool isDestinationUnavailable, CommonSelectableItem? selectedCommonDestinationItem, bool isTransferTypeLoading, HomeTransferTypeDto? homeTransferTypeDto, CommonSelectableItem? selectedTransferTypeItem, CommonSelectableDto? commonBankOrAgentSelectableDto, CommonSelectableItem? selectedBankOrAgentItem, CommonSelectableDto? commonAgentSelectableDto, bool isAgentNotRequired, CommonSelectableItem? selectedAgentItem, CommonSelectableItem? sendAgainAgentItem, HomeBeneficiaryListDto? homeBeneficiaryListDto, int selectedBeneficiaryIndex, String currentEmailAddress, EmailAddress emailAddress, Otp emailOtp, Option<Either<HomeFailure, HomeAdvertisementDto>> homeAdvertisementFailureOrSuccessOption, Option<Either<HomeFailure, HomeUserDto>> homeUserFailureOrSuccessOption, Option<Either<HomeFailure, HomeBeneficiaryListDto>> homeBeneficiaryListFailureOrSuccessOption, Option<Either<HomeFailure, String>> homeDeleteBeneficiaryFailureOrSuccessOption, Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeMandatoryFieldCheckFailureOrSuccessOption, Option<Either<HomeFailure, CommonSelectableDto>> homeSendAgainAgentOption, Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>> homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption, Option<Either<HomeFailure, Unit>> homeRequestEmailOtpFailureOrSuccessOption, Option<Either<HomeFailure, Unit>> homeVerifyEmailOtpFailureOrSuccessOption
});


@override $RecentBeneficiaryListCopyWith<$Res>? get tappedRecentBeneficiary;@override $HomeAdvertisementDtoCopyWith<$Res>? get homeAdvertisementDto;@override $HomeUserDtoCopyWith<$Res>? get homeUserDto;@override $HomeRecentBeneficiariesDtoCopyWith<$Res>? get homeRecentBeneficiariesDto;@override $CommonTransactionDtoCopyWith<$Res>? get homeRecentTransactionsDto;@override $CommonSelectableDtoCopyWith<$Res>? get commonDestinationSelectableDto;@override $CommonSelectableItemCopyWith<$Res>? get selectedCommonDestinationItem;@override $HomeTransferTypeDtoCopyWith<$Res>? get homeTransferTypeDto;@override $CommonSelectableItemCopyWith<$Res>? get selectedTransferTypeItem;@override $CommonSelectableDtoCopyWith<$Res>? get commonBankOrAgentSelectableDto;@override $CommonSelectableItemCopyWith<$Res>? get selectedBankOrAgentItem;@override $CommonSelectableDtoCopyWith<$Res>? get commonAgentSelectableDto;@override $CommonSelectableItemCopyWith<$Res>? get selectedAgentItem;@override $CommonSelectableItemCopyWith<$Res>? get sendAgainAgentItem;@override $HomeBeneficiaryListDtoCopyWith<$Res>? get homeBeneficiaryListDto;

}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isUserLoading = null,Object? isRecentBeneficiariesLoading = null,Object? isRecentTransactionsLoading = null,Object? isSendMoneyFormLoading = null,Object? isRefreshing = null,Object? criticalLoadFailed = null,Object? isRecentBeneficiariesLoadFailed = null,Object? isRecentTransactionsLoadFailed = null,Object? isSubmitting = null,Object? isOtpSubmitting = null,Object? showErrorMessages = null,Object? showOtpErrorMessages = null,Object? isCorridorLoading = null,Object? failedCorridorStage = freezed,Object? isTransferTypeUnavailable = null,Object? isBeneficiaryListLoading = null,Object? isBeneficiaryListLoadFailed = null,Object? isDeletingBeneficiary = null,Object? isMandatoryFieldCheckLoading = null,Object? tappedRecentBeneficiary = freezed,Object? homeAdvertisementDto = freezed,Object? homeUserDto = freezed,Object? homeRecentBeneficiariesDto = freezed,Object? homeRecentTransactionsDto = freezed,Object? commonDestinationSelectableDto = freezed,Object? isDestinationLoadFailed = null,Object? isDestinationUnavailable = null,Object? selectedCommonDestinationItem = freezed,Object? isTransferTypeLoading = null,Object? homeTransferTypeDto = freezed,Object? selectedTransferTypeItem = freezed,Object? commonBankOrAgentSelectableDto = freezed,Object? selectedBankOrAgentItem = freezed,Object? commonAgentSelectableDto = freezed,Object? isAgentNotRequired = null,Object? selectedAgentItem = freezed,Object? sendAgainAgentItem = freezed,Object? homeBeneficiaryListDto = freezed,Object? selectedBeneficiaryIndex = null,Object? currentEmailAddress = null,Object? emailAddress = null,Object? emailOtp = null,Object? homeAdvertisementFailureOrSuccessOption = null,Object? homeUserFailureOrSuccessOption = null,Object? homeBeneficiaryListFailureOrSuccessOption = null,Object? homeDeleteBeneficiaryFailureOrSuccessOption = null,Object? homeMandatoryFieldCheckFailureOrSuccessOption = null,Object? homeSendAgainAgentOption = null,Object? homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption = null,Object? homeRequestEmailOtpFailureOrSuccessOption = null,Object? homeVerifyEmailOtpFailureOrSuccessOption = null,}) {
  return _then(_HomeState(
isUserLoading: null == isUserLoading ? _self.isUserLoading : isUserLoading // ignore: cast_nullable_to_non_nullable
as bool,isRecentBeneficiariesLoading: null == isRecentBeneficiariesLoading ? _self.isRecentBeneficiariesLoading : isRecentBeneficiariesLoading // ignore: cast_nullable_to_non_nullable
as bool,isRecentTransactionsLoading: null == isRecentTransactionsLoading ? _self.isRecentTransactionsLoading : isRecentTransactionsLoading // ignore: cast_nullable_to_non_nullable
as bool,isSendMoneyFormLoading: null == isSendMoneyFormLoading ? _self.isSendMoneyFormLoading : isSendMoneyFormLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,criticalLoadFailed: null == criticalLoadFailed ? _self.criticalLoadFailed : criticalLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isRecentBeneficiariesLoadFailed: null == isRecentBeneficiariesLoadFailed ? _self.isRecentBeneficiariesLoadFailed : isRecentBeneficiariesLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isRecentTransactionsLoadFailed: null == isRecentTransactionsLoadFailed ? _self.isRecentTransactionsLoadFailed : isRecentTransactionsLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isOtpSubmitting: null == isOtpSubmitting ? _self.isOtpSubmitting : isOtpSubmitting // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,showOtpErrorMessages: null == showOtpErrorMessages ? _self.showOtpErrorMessages : showOtpErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,isCorridorLoading: null == isCorridorLoading ? _self.isCorridorLoading : isCorridorLoading // ignore: cast_nullable_to_non_nullable
as bool,failedCorridorStage: freezed == failedCorridorStage ? _self.failedCorridorStage : failedCorridorStage // ignore: cast_nullable_to_non_nullable
as HomeCorridorStage?,isTransferTypeUnavailable: null == isTransferTypeUnavailable ? _self.isTransferTypeUnavailable : isTransferTypeUnavailable // ignore: cast_nullable_to_non_nullable
as bool,isBeneficiaryListLoading: null == isBeneficiaryListLoading ? _self.isBeneficiaryListLoading : isBeneficiaryListLoading // ignore: cast_nullable_to_non_nullable
as bool,isBeneficiaryListLoadFailed: null == isBeneficiaryListLoadFailed ? _self.isBeneficiaryListLoadFailed : isBeneficiaryListLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isDeletingBeneficiary: null == isDeletingBeneficiary ? _self.isDeletingBeneficiary : isDeletingBeneficiary // ignore: cast_nullable_to_non_nullable
as bool,isMandatoryFieldCheckLoading: null == isMandatoryFieldCheckLoading ? _self.isMandatoryFieldCheckLoading : isMandatoryFieldCheckLoading // ignore: cast_nullable_to_non_nullable
as bool,tappedRecentBeneficiary: freezed == tappedRecentBeneficiary ? _self.tappedRecentBeneficiary : tappedRecentBeneficiary // ignore: cast_nullable_to_non_nullable
as RecentBeneficiaryList?,homeAdvertisementDto: freezed == homeAdvertisementDto ? _self.homeAdvertisementDto : homeAdvertisementDto // ignore: cast_nullable_to_non_nullable
as HomeAdvertisementDto?,homeUserDto: freezed == homeUserDto ? _self.homeUserDto : homeUserDto // ignore: cast_nullable_to_non_nullable
as HomeUserDto?,homeRecentBeneficiariesDto: freezed == homeRecentBeneficiariesDto ? _self.homeRecentBeneficiariesDto : homeRecentBeneficiariesDto // ignore: cast_nullable_to_non_nullable
as HomeRecentBeneficiariesDto?,homeRecentTransactionsDto: freezed == homeRecentTransactionsDto ? _self.homeRecentTransactionsDto : homeRecentTransactionsDto // ignore: cast_nullable_to_non_nullable
as CommonTransactionDto?,commonDestinationSelectableDto: freezed == commonDestinationSelectableDto ? _self.commonDestinationSelectableDto : commonDestinationSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,isDestinationLoadFailed: null == isDestinationLoadFailed ? _self.isDestinationLoadFailed : isDestinationLoadFailed // ignore: cast_nullable_to_non_nullable
as bool,isDestinationUnavailable: null == isDestinationUnavailable ? _self.isDestinationUnavailable : isDestinationUnavailable // ignore: cast_nullable_to_non_nullable
as bool,selectedCommonDestinationItem: freezed == selectedCommonDestinationItem ? _self.selectedCommonDestinationItem : selectedCommonDestinationItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,isTransferTypeLoading: null == isTransferTypeLoading ? _self.isTransferTypeLoading : isTransferTypeLoading // ignore: cast_nullable_to_non_nullable
as bool,homeTransferTypeDto: freezed == homeTransferTypeDto ? _self.homeTransferTypeDto : homeTransferTypeDto // ignore: cast_nullable_to_non_nullable
as HomeTransferTypeDto?,selectedTransferTypeItem: freezed == selectedTransferTypeItem ? _self.selectedTransferTypeItem : selectedTransferTypeItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,commonBankOrAgentSelectableDto: freezed == commonBankOrAgentSelectableDto ? _self.commonBankOrAgentSelectableDto : commonBankOrAgentSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,selectedBankOrAgentItem: freezed == selectedBankOrAgentItem ? _self.selectedBankOrAgentItem : selectedBankOrAgentItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,commonAgentSelectableDto: freezed == commonAgentSelectableDto ? _self.commonAgentSelectableDto : commonAgentSelectableDto // ignore: cast_nullable_to_non_nullable
as CommonSelectableDto?,isAgentNotRequired: null == isAgentNotRequired ? _self.isAgentNotRequired : isAgentNotRequired // ignore: cast_nullable_to_non_nullable
as bool,selectedAgentItem: freezed == selectedAgentItem ? _self.selectedAgentItem : selectedAgentItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,sendAgainAgentItem: freezed == sendAgainAgentItem ? _self.sendAgainAgentItem : sendAgainAgentItem // ignore: cast_nullable_to_non_nullable
as CommonSelectableItem?,homeBeneficiaryListDto: freezed == homeBeneficiaryListDto ? _self.homeBeneficiaryListDto : homeBeneficiaryListDto // ignore: cast_nullable_to_non_nullable
as HomeBeneficiaryListDto?,selectedBeneficiaryIndex: null == selectedBeneficiaryIndex ? _self.selectedBeneficiaryIndex : selectedBeneficiaryIndex // ignore: cast_nullable_to_non_nullable
as int,currentEmailAddress: null == currentEmailAddress ? _self.currentEmailAddress : currentEmailAddress // ignore: cast_nullable_to_non_nullable
as String,emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as EmailAddress,emailOtp: null == emailOtp ? _self.emailOtp : emailOtp // ignore: cast_nullable_to_non_nullable
as Otp,homeAdvertisementFailureOrSuccessOption: null == homeAdvertisementFailureOrSuccessOption ? _self.homeAdvertisementFailureOrSuccessOption : homeAdvertisementFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeAdvertisementDto>>,homeUserFailureOrSuccessOption: null == homeUserFailureOrSuccessOption ? _self.homeUserFailureOrSuccessOption : homeUserFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeUserDto>>,homeBeneficiaryListFailureOrSuccessOption: null == homeBeneficiaryListFailureOrSuccessOption ? _self.homeBeneficiaryListFailureOrSuccessOption : homeBeneficiaryListFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeBeneficiaryListDto>>,homeDeleteBeneficiaryFailureOrSuccessOption: null == homeDeleteBeneficiaryFailureOrSuccessOption ? _self.homeDeleteBeneficiaryFailureOrSuccessOption : homeDeleteBeneficiaryFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, String>>,homeMandatoryFieldCheckFailureOrSuccessOption: null == homeMandatoryFieldCheckFailureOrSuccessOption ? _self.homeMandatoryFieldCheckFailureOrSuccessOption : homeMandatoryFieldCheckFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>>,homeSendAgainAgentOption: null == homeSendAgainAgentOption ? _self.homeSendAgainAgentOption : homeSendAgainAgentOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, CommonSelectableDto>>,homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption: null == homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption ? _self.homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption : homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>>,homeRequestEmailOtpFailureOrSuccessOption: null == homeRequestEmailOtpFailureOrSuccessOption ? _self.homeRequestEmailOtpFailureOrSuccessOption : homeRequestEmailOtpFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, Unit>>,homeVerifyEmailOtpFailureOrSuccessOption: null == homeVerifyEmailOtpFailureOrSuccessOption ? _self.homeVerifyEmailOtpFailureOrSuccessOption : homeVerifyEmailOtpFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<HomeFailure, Unit>>,
  ));
}

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecentBeneficiaryListCopyWith<$Res>? get tappedRecentBeneficiary {
    if (_self.tappedRecentBeneficiary == null) {
    return null;
  }

  return $RecentBeneficiaryListCopyWith<$Res>(_self.tappedRecentBeneficiary!, (value) {
    return _then(_self.copyWith(tappedRecentBeneficiary: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeAdvertisementDtoCopyWith<$Res>? get homeAdvertisementDto {
    if (_self.homeAdvertisementDto == null) {
    return null;
  }

  return $HomeAdvertisementDtoCopyWith<$Res>(_self.homeAdvertisementDto!, (value) {
    return _then(_self.copyWith(homeAdvertisementDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeUserDtoCopyWith<$Res>? get homeUserDto {
    if (_self.homeUserDto == null) {
    return null;
  }

  return $HomeUserDtoCopyWith<$Res>(_self.homeUserDto!, (value) {
    return _then(_self.copyWith(homeUserDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeRecentBeneficiariesDtoCopyWith<$Res>? get homeRecentBeneficiariesDto {
    if (_self.homeRecentBeneficiariesDto == null) {
    return null;
  }

  return $HomeRecentBeneficiariesDtoCopyWith<$Res>(_self.homeRecentBeneficiariesDto!, (value) {
    return _then(_self.copyWith(homeRecentBeneficiariesDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonTransactionDtoCopyWith<$Res>? get homeRecentTransactionsDto {
    if (_self.homeRecentTransactionsDto == null) {
    return null;
  }

  return $CommonTransactionDtoCopyWith<$Res>(_self.homeRecentTransactionsDto!, (value) {
    return _then(_self.copyWith(homeRecentTransactionsDto: value));
  });
}/// Create a copy of HomeState
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
}/// Create a copy of HomeState
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
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeTransferTypeDtoCopyWith<$Res>? get homeTransferTypeDto {
    if (_self.homeTransferTypeDto == null) {
    return null;
  }

  return $HomeTransferTypeDtoCopyWith<$Res>(_self.homeTransferTypeDto!, (value) {
    return _then(_self.copyWith(homeTransferTypeDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedTransferTypeItem {
    if (_self.selectedTransferTypeItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedTransferTypeItem!, (value) {
    return _then(_self.copyWith(selectedTransferTypeItem: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonBankOrAgentSelectableDto {
    if (_self.commonBankOrAgentSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonBankOrAgentSelectableDto!, (value) {
    return _then(_self.copyWith(commonBankOrAgentSelectableDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedBankOrAgentItem {
    if (_self.selectedBankOrAgentItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedBankOrAgentItem!, (value) {
    return _then(_self.copyWith(selectedBankOrAgentItem: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableDtoCopyWith<$Res>? get commonAgentSelectableDto {
    if (_self.commonAgentSelectableDto == null) {
    return null;
  }

  return $CommonSelectableDtoCopyWith<$Res>(_self.commonAgentSelectableDto!, (value) {
    return _then(_self.copyWith(commonAgentSelectableDto: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get selectedAgentItem {
    if (_self.selectedAgentItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.selectedAgentItem!, (value) {
    return _then(_self.copyWith(selectedAgentItem: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonSelectableItemCopyWith<$Res>? get sendAgainAgentItem {
    if (_self.sendAgainAgentItem == null) {
    return null;
  }

  return $CommonSelectableItemCopyWith<$Res>(_self.sendAgainAgentItem!, (value) {
    return _then(_self.copyWith(sendAgainAgentItem: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeBeneficiaryListDtoCopyWith<$Res>? get homeBeneficiaryListDto {
    if (_self.homeBeneficiaryListDto == null) {
    return null;
  }

  return $HomeBeneficiaryListDtoCopyWith<$Res>(_self.homeBeneficiaryListDto!, (value) {
    return _then(_self.copyWith(homeBeneficiaryListDto: value));
  });
}
}

// dart format on
