part of 'login_bloc.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.getIdentityTypes() = _GetIdentityTypes;
  const factory LoginEvent.identityTypeChanged({
    required CommonSelectableItem selectedIdentityType
  }) = _IdentityTypeChanged;
  const factory LoginEvent.identityNumberChanged(String identityNumberStr) =
      _IdentityNumberChanged;
  const factory LoginEvent.mobileNumberChanged(String mobileNumberStr) =
      _MobileNumberChanged;
  const factory LoginEvent.requestOtpPressed() = _RequestOtpPressed;
  const factory LoginEvent.getContactUs({required String languageCode}) =
      _GetContactUs;
  const factory LoginEvent.reset() = _Reset;
}
