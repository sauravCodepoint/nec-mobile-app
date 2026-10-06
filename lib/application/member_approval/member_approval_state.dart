part of 'member_approval_bloc.dart';

@freezed
sealed class MemberApprovalState with _$MemberApprovalState {
  const factory MemberApprovalState({
    required bool isChecking,

    /// Set when a check found the stored credentials missing — retrying is
    /// pointless, so the timer is stopped and the screen stays static.
    required bool isPollingDisabled,

    /// Terminal: the back office approved the member (200). The page reacts
    /// by sending the user to Login with a success toast.
    required bool isApproved,

    /// Terminal: the back office rejected the registration (403). The page
    /// morphs into its rejected variant and polling never re-arms.
    required bool isRejected,

    /// Backend-authored reason shown on the rejected screen; null falls back
    /// to the translated default.
    String? rejectionReason,

    /// One-shot result of the latest check. Failures are deliberately never
    /// surfaced to the user (they mean "still pending"); the page only reacts
    /// to an approved success.
    required Option<Either<MemberApprovalFailure, MemberApprovalStatusDto>>
    statusFailureOrSuccessOption,
  }) = _MemberApprovalState;

  factory MemberApprovalState.initial() => MemberApprovalState(
    isChecking: false,
    isPollingDisabled: false,
    isApproved: false,
    isRejected: false,
    statusFailureOrSuccessOption: none(),
  );
}
