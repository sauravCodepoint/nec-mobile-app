part of 'support_bloc.dart';

@freezed
sealed class SupportState with _$SupportState {
  const factory SupportState({
    SupportContactDto? contactDto,
    required Option<Either<SupportFailure, SupportContactDto>>
    contactFailureOrSuccessOption,
  }) = _SupportState;

  factory SupportState.initial() =>
      SupportState(contactFailureOrSuccessOption: none());
}