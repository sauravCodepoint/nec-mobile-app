part of 'support_bloc.dart';

@freezed
sealed class SupportEvent with _$SupportEvent {
  const factory SupportEvent.getContactDetails({required String languageCode}) =
      _GetContactDetails;
}