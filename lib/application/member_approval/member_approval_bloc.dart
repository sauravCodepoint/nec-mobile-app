import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/member_approval/i_member_approval_facade.dart';
import '../../domain/member_approval/member_approval_failure.dart';
import '../../domain/member_approval/member_approval_status_dto.dart';

part 'member_approval_event.dart';
part 'member_approval_state.dart';
part 'member_approval_bloc.freezed.dart';

/// Polls the approval-status API while the awaiting-approval screen is
/// visible and the app is foregrounded. The page drives the lifecycle:
/// [MemberApprovalEvent.pollingStarted] on mount/resume,
/// [MemberApprovalEvent.pollingStopped] on dispose/pause.
///
/// Polling is a UX nicety, not load-bearing — approval is also resolved on
/// every login attempt (verify-OTP 406) and cold start, so every failure here
/// is treated as "still pending" and kept silent.
@injectable
class MemberApprovalBloc
    extends Bloc<MemberApprovalEvent, MemberApprovalState> {
  final IMemberApprovalFacade _memberApprovalFacade;
  Timer? _pollTimer;

  /// Approval takes hours — anything faster than this is wasted load on a
  /// backend that also serves transactions.
  static const _pollInterval = Duration(seconds: 25);

  /// Envelope status codes of the registration-status contract:
  /// 200 = approved, 403 = rejected, 430 = still pending.
  static const _approvedStatusCode = 200;
  static const _rejectedStatusCode = 403;

  MemberApprovalBloc(this._memberApprovalFacade)
    : super(MemberApprovalState.initial()) {
    on<_ScreenOpened>(_onScreenOpened);
    on<_PollingStarted>(_onPollingStarted);
    on<_PollingStopped>(_onPollingStopped);
    on<_CheckRequested>(_onCheckRequested);
  }

  FutureOr<void> _onScreenOpened(
    _ScreenOpened event,
    Emitter<MemberApprovalState> emit,
  ) {
    emit(
      state.copyWith(
        isApproved: false,
        isRejected: false,
        rejectionReason: null,
        isPollingDisabled: false,
        statusFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onPollingStarted(
    _PollingStarted event,
    Emitter<MemberApprovalState> emit,
  ) {
    // Rejection is terminal — never re-arm on resume; the screen stays on
    // its rejected variant until the user leaves for re-registration.
    if (state.isRejected) return null;
    // Re-arm from scratch: a fresh start may follow a re-registration that
    // restored the credentials a previous run found missing.
    emit(state.copyWith(isPollingDisabled: false));
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(
      _pollInterval,
      (_) => add(const MemberApprovalEvent.checkRequested()),
    );
    add(const MemberApprovalEvent.checkRequested());
  }

  FutureOr<void> _onPollingStopped(
    _PollingStopped event,
    Emitter<MemberApprovalState> emit,
  ) {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  FutureOr<void> _onCheckRequested(
    _CheckRequested event,
    Emitter<MemberApprovalState> emit,
  ) async {
    // A slow response must not stack a second in-flight check on top.
    if (state.isChecking || state.isPollingDisabled) return;

    emit(
      state.copyWith(isChecking: true, statusFailureOrSuccessOption: none()),
    );
    final failureOrSuccess = await _memberApprovalFacade.checkApprovalStatus();

    final approved = failureOrSuccess.fold(
      (_) => false,
      (dto) => dto.statusCode == _approvedStatusCode,
    );
    final rejected = failureOrSuccess.fold(
      (_) => false,
      (dto) => dto.statusCode == _rejectedStatusCode,
    );
    // The rejected envelope's message is backend-authored, user-facing copy
    // ("Your registration has been rejected because ...") — carry it into
    // state so the rejected screen shows it verbatim. Null keeps whatever
    // was already captured (the page falls back to translated copy).
    final rejectionReason = failureOrSuccess.fold(
      (_) => null,
      (dto) => rejected && (dto.message ?? '').isNotEmpty ? dto.message : null,
    );

    final disablePolling = failureOrSuccess.fold(
      // Missing credentials can never heal by retrying — stop the timer so
      // the screen stays on its static form without background churn. An
      // incomplete approved payload (unexpectedServerState) keeps polling:
      // the session install was refused, so the user is still awaiting.
      (failure) => failure.map(
        serverError: (_) => false,
        missingCredentials: (_) => true,
        unexpectedServerState: (_) => false,
      ),
      // Terminal answers: approved (the page navigates away) or rejected
      // (the page morphs into its rejected variant) — stop polling
      // immediately rather than waiting for its dispose.
      (_) => approved || rejected,
    );
    if (disablePolling) {
      _pollTimer?.cancel();
      _pollTimer = null;
    }

    emit(
      state.copyWith(
        isChecking: false,
        isPollingDisabled: disablePolling && failureOrSuccess.isLeft(),
        isApproved: state.isApproved || approved,
        isRejected: state.isRejected || rejected,
        rejectionReason: rejectionReason ?? state.rejectionReason,
        statusFailureOrSuccessOption: some(failureOrSuccess),
      ),
    );
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
