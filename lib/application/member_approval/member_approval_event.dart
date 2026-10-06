part of 'member_approval_bloc.dart';

@freezed
sealed class MemberApprovalEvent with _$MemberApprovalEvent {
  /// Screen mounted: clears any terminal state left by a previous visit —
  /// the bloc is app-scoped, so after a rejection the "Register Again" →
  /// re-registration path re-enters this screen with stale isRejected state
  /// that would otherwise resurrect the old rejection and block polling.
  const factory MemberApprovalEvent.screenOpened() = _ScreenOpened;

  /// Screen became active (mounted / app resumed): check immediately and
  /// keep checking on an interval.
  const factory MemberApprovalEvent.pollingStarted() = _PollingStarted;

  /// Screen became inactive (disposed / app backgrounded): stop the timer.
  const factory MemberApprovalEvent.pollingStopped() = _PollingStopped;

  /// One status check — a timer tick.
  const factory MemberApprovalEvent.checkRequested() = _CheckRequested;
}
