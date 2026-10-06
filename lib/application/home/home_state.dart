part of 'home_bloc.dart';

/// A link of the home corridor chain, in the order it is fetched. Recorded on
/// [HomeState.failedCorridorStage] so a failed corridor can be retried at the
/// exact request that broke, without re-running the whole home load.
enum HomeCorridorStage { transferType, bankOrAgent, agent }

/// Why the send-money flow cannot continue yet, resolved in priority order by
/// [HomeStateX.transactionBlocker].
///
/// Every corridor API must have succeeded before a transaction may start, so
/// this enum — not a scatter of checks at the call site — is the single gate
/// the Choose-Beneficiary CTA consults. `null` from [HomeStateX.transactionBlocker]
/// means every dependency resolved and the user may proceed.
enum HomeTransactionBlocker {
  /// The receive-country list itself failed to load. It is the root of the
  /// corridor, so nothing below it can be trusted — recoverable, the UI offers
  /// a retry.
  destinationLoadFailed,

  /// The receive-country list loaded but is empty: there is no corridor to
  /// build at all. Not recoverable by retrying.
  destinationUnavailable,

  /// No receive country chosen yet.
  destinationMissing,

  /// A corridor API is still in flight; the selections aren't final.
  corridorResolving,

  /// A corridor API failed — recoverable, the UI offers a retry.
  corridorLoadFailed,

  /// The corridor resolved with no transfer mode at all — not recoverable by
  /// retrying; the user has to choose a different receive country.
  transferTypeUnavailable,

  /// No transfer mode chosen yet.
  transferTypeMissing,

  /// The corridor resolved with no payout bank/agent at all. The beneficiary
  /// list is fetched *by* product code, which only a payout option can supply,
  /// so an empty list is a dead end rather than "no selection required".
  bankOrAgentUnavailable,

  /// The corridor offers several payout banks/agents and none is chosen.
  bankOrAgentMissing,

  /// The corridor answered with no agent, and did so with a 200 rather than the
  /// 406 that means "this corridor needs no agent". Only the 406 earns a pass;
  /// an empty 200 is a corridor that can't be paid out through.
  agentUnavailable,

  /// The corridor offers several agents and none is chosen.
  agentMissing,
}

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default(true) bool isUserLoading,
    @Default(true) bool isRecentBeneficiariesLoading,
    @Default(true) bool isRecentTransactionsLoading,
    @Default(true) bool isSendMoneyFormLoading,
    @Default(false) bool isRefreshing,
    // True when an API the home screen cannot be drawn without failed on first
    // load: the user record and the destination-currency list. A failure in
    // either leaves nothing to render, so it drives the full-screen retry.
    // Best-effort endpoints are excluded and degrade in place instead — the
    // recent-beneficiaries strip carries its own inline retry
    // (`isRecentBeneficiariesLoadFailed`) and the advertisement is a promo
    // dialog that simply doesn't appear. Never set on refresh — stale data
    // stays on screen and the global retry dialog handles refresh failures.
    @Default(false) bool criticalLoadFailed,
    // True when the recent-beneficiaries ("Send Again") fetch failed. The strip
    // is best-effort — it degrades to an inline retry card instead of blanking
    // the screen — but the failure must still be visible, otherwise an outage
    // is indistinguishable from "you have no recent beneficiaries".
    @Default(false) bool isRecentBeneficiariesLoadFailed,
    // True when the recent-transactions fetch failed. Best-effort in exactly
    // the same way as the strip above it: the section carries its own inline
    // retry rather than blanking home, because an empty list and an outage
    // otherwise look identical.
    @Default(false) bool isRecentTransactionsLoadFailed,
    required bool isSubmitting,
    required bool isOtpSubmitting,
    required bool showErrorMessages,
    required bool showOtpErrorMessages,
    // True while the corridor chain (transfer type → bank/agent) is still
    // resolving after a destination is chosen. Home no longer calculates a
    // rate, so this only gates the coach-mark tour / bottom-nav lock until the
    // send-money selections settle.
    @Default(false) bool isCorridorLoading,
    // Which link of the corridor chain (transfer type → bank/agent → agent)
    // failed to load, or null when the chain is healthy. The bank/agent and
    // agent fetches only null their lists on failure, and an empty list is
    // otherwise read as "no selection required", so without this the Pay Now
    // button would wrongly go ready on a broken corridor. Recording the stage
    // (rather than a bare bool) lets the inline retry re-run exactly the
    // request that broke instead of reloading the whole page. Reset at the
    // start of each corridor link's fetch.
    HomeCorridorStage? failedCorridorStage,
    // True when the corridor resolved successfully but the backend offers no
    // transfer mode for it at all. Distinct from a load failure: retrying
    // changes nothing, so the UI tells the user to pick another receive
    // country instead of offering a retry.
    @Default(false) bool isTransferTypeUnavailable,
    required bool isBeneficiaryListLoading,
    // True when the choose-beneficiary fetch failed. Without it an outage
    // rendered as an empty list — "no beneficiary found", next to an Add New
    // Beneficiary button — which invites the user to re-create a recipient they
    // already have. This is also the last API before a transaction starts, so
    // its failure must be unmistakable and retryable.
    @Default(false) bool isBeneficiaryListLoadFailed,
    required bool isDeletingBeneficiary,
    @Default(false) bool isMandatoryFieldCheckLoading,
    RecentBeneficiaryList? tappedRecentBeneficiary,
    HomeAdvertisementDto? homeAdvertisementDto,
    HomeUserDto? homeUserDto,
    HomeRecentBeneficiariesDto? homeRecentBeneficiariesDto,
    // Newest-first transaction list backing the home "Recent Transactions"
    // section. The fetch returns a full first page; the view renders only the
    // first five and sends the user to the history screen for the rest.
    CommonTransactionDto? homeRecentTransactionsDto,
    CommonSelectableDto? commonDestinationSelectableDto,
    // True when the receive-country fetch failed and left nothing usable.
    // `criticalLoadFailed` already blanks the page for a first load, but a
    // *refresh* deliberately never trips it — stale data stays on screen — and
    // that path also skips the corridor chain, so without this flag a failed
    // refresh left the CTA sitting ready over a corridor nothing had
    // re-validated. Recoverable: the inline notice retries the load.
    @Default(false) bool isDestinationLoadFailed,
    // True when the receive-country fetch succeeded but came back empty. There
    // is no corridor to build at all, so — unlike a load failure — retrying
    // changes nothing and the UI says so instead of offering a retry.
    @Default(false) bool isDestinationUnavailable,
    CommonSelectableItem? selectedCommonDestinationItem,
    @Default(false) bool isTransferTypeLoading,
    HomeTransferTypeDto? homeTransferTypeDto,
    CommonSelectableItem? selectedTransferTypeItem,
    CommonSelectableDto? commonBankOrAgentSelectableDto,
    CommonSelectableItem? selectedBankOrAgentItem,
    // Agent picker — corridor-scoped like bank/agent (same country/currency/
    // disbursal params) and shown just below it. A single option is
    // auto-selected and the field self-hides.
    CommonSelectableDto? commonAgentSelectableDto,
    // True when the backend answered the agent fetch with 406 — "this corridor
    // needs no agent". That is the single legitimate reason an empty agent list
    // may still let the flow continue, so it is recorded explicitly rather than
    // inferred from the empty list: a 200 carrying an empty list is a corridor
    // with no agent at all and must block. Overwritten by every agent fetch.
    @Default(false) bool isAgentNotRequired,
    CommonSelectableItem? selectedAgentItem,
    // Send-again (recent-beneficiary tap) flow only: the agent resolved for
    // that tap — auto-selected when the corridor offers a single option, or the
    // user's pick from the multi-option dialog. Kept separate from
    // selectedAgentItem so the quick flow never mutates the home send-money
    // corridor's own agent selection. Carried into the summary; null means "no
    // agent" (406 / not required) and the summary falls back to the
    // beneficiary's own agent.
    CommonSelectableItem? sendAgainAgentItem,
    HomeBeneficiaryListDto? homeBeneficiaryListDto,
    required int selectedBeneficiaryIndex,
    required String currentEmailAddress,
    required EmailAddress emailAddress,
    required Otp emailOtp,
    required Option<Either<HomeFailure, HomeAdvertisementDto>>
    homeAdvertisementFailureOrSuccessOption,
    required Option<Either<HomeFailure, HomeUserDto>>
    homeUserFailureOrSuccessOption,
    required Option<Either<HomeFailure, HomeBeneficiaryListDto>>
    homeBeneficiaryListFailureOrSuccessOption,
    required Option<Either<HomeFailure, String>>
    homeDeleteBeneficiaryFailureOrSuccessOption,
    required Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>>
    homeMandatoryFieldCheckFailureOrSuccessOption,
    // Send-again flow one-shot for the agent step that now runs *before* the
    // mandatory check. Only fires for the two cases needing UI: a Left(failure)
    // → error dialog, or a Right(agent list) with multiple options → picker
    // dialog. The single-option and 406/empty cases resolve silently in the
    // bloc and go straight to the mandatory check.
    required Option<Either<HomeFailure, CommonSelectableDto>>
    homeSendAgainAgentOption,
    required Option<Either<HomeFailure, HomeMandatoryFieldCheckDto>>
    homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption,
    required Option<Either<HomeFailure, Unit>>
    homeRequestEmailOtpFailureOrSuccessOption,
    required Option<Either<HomeFailure, Unit>>
    homeVerifyEmailOtpFailureOrSuccessOption,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
    isSubmitting: false,
    isOtpSubmitting: false,
    showErrorMessages: false,
    showOtpErrorMessages: false,
    isBeneficiaryListLoading: false,
    isDeletingBeneficiary: false,
    selectedBeneficiaryIndex: -1,
    currentEmailAddress: '',
    emailAddress: EmailAddress(''),
    emailOtp: Otp(''),
    homeAdvertisementFailureOrSuccessOption: none(),
    homeUserFailureOrSuccessOption: none(),
    homeBeneficiaryListFailureOrSuccessOption: none(),
    homeDeleteBeneficiaryFailureOrSuccessOption: none(),
    homeMandatoryFieldCheckFailureOrSuccessOption: none(),
    homeSendAgainAgentOption: none(),
    homeBeneficiaryListMandatoryFieldCheckFailureOrSuccessOption: none(),
    homeRequestEmailOtpFailureOrSuccessOption: none(),
    homeVerifyEmailOtpFailureOrSuccessOption: none(),
  );
}

extension HomeStateX on HomeState {
  /// True while any section of the home page's first render is still loading.
  /// `isCorridorLoading` covers the whole dependent chain (transfer type →
  /// bank/agent), so this only settles once the send-money selections are in
  /// their final shape. Shared by the home coach-mark tour's ready gate and the
  /// bottom-nav lock so both always agree on when "loading" ends.
  bool get isInitialSectionsLoading =>
      isUserLoading ||
          isRecentBeneficiariesLoading ||
          isRecentTransactionsLoading ||
          isSendMoneyFormLoading ||
          isCorridorLoading;

  /// True while ANY API feeding the send-money corridor is still in flight:
  /// the initial form load, the transfer-type fetch, the bank/agent → agent
  /// chain, or a pull-to-refresh. The Choose-Beneficiary button must stay idle
  /// until every one settles — otherwise a stale or half-loaded corridor could
  /// let the user advance. This is the single source of truth for that gate, so
  /// no future loading flag can be forgotten at the call site.
  bool get isCorridorResolving =>
      isSendMoneyFormLoading ||
          isTransferTypeLoading ||
          isCorridorLoading ||
          isRefreshing;

  /// True when any link of the corridor chain failed to load. Recoverable —
  /// [HomeEvent.retryCorridor] re-runs the failed request.
  bool get corridorLoadFailed => failedCorridorStage != null;

  /// The reason the send-money flow cannot continue, or null when every
  /// dependency has resolved and the user may proceed to pick a beneficiary.
  ///
  /// Resolved in the order the user meets them, so the first unmet condition is
  /// the one reported. This is the ONLY gate on starting a transaction: the
  /// corridor is built from several chained APIs and all of them must have
  /// succeeded, so both the CTA's ready state and its explanatory copy read
  /// from here rather than re-deriving the rules in the widget tree.
  HomeTransactionBlocker? get transactionBlocker {
    // The receive-country list is the root of the corridor: every request below
    // it is keyed by the country/currency it supplies. Checked before anything
    // else because a failed or empty list also means the corridor chain never
    // ran, which leaves every flag it owns (loading, failure, unavailable) at
    // its innocent default — the exact shape that used to read as "ready".
    if (isDestinationLoadFailed) {
      return HomeTransactionBlocker.destinationLoadFailed;
    }
    if (isDestinationUnavailable) {
      return HomeTransactionBlocker.destinationUnavailable;
    }
    if (selectedCommonDestinationItem == null) {
      return HomeTransactionBlocker.destinationMissing;
    }
    // Any corridor/form API still in flight (initial form load, transfer-type
    // fetch, the bank/agent → agent chain, or refresh): the payout lists aren't
    // known yet, so the user must not proceed on an unsettled or stale
    // corridor. Also covers the brief window before a single option
    // auto-selects.
    if (isCorridorResolving) return HomeTransactionBlocker.corridorResolving;
    // A corridor link failed. Its lists are empty, which the checks below would
    // read as "nothing to pick" and wave the user through onto a broken
    // corridor — block instead, and let the UI offer a retry.
    if (corridorLoadFailed) return HomeTransactionBlocker.corridorLoadFailed;
    // The corridor loaded but carries no transfer mode: a dead end that
    // retrying can't fix, reported separately from a load failure so the UI can
    // point at the receive country instead of showing a pointless retry.
    if (isTransferTypeUnavailable) {
      return HomeTransactionBlocker.transferTypeUnavailable;
    }
    if (selectedTransferTypeItem == null) {
      return HomeTransactionBlocker.transferTypeMissing;
    }
    // Past this point the corridor has settled and nothing failed, so an empty
    // list means the backend genuinely offered nothing — never "still loading".
    //
    // The payout list must carry at least one option: the beneficiary list is
    // fetched *by* product code and only a payout option supplies one, so an
    // empty list would send `product_code=''` down the wire. It used to be read
    // as "no selection required" and let the user straight through.
    final bankList =
        commonBankOrAgentSelectableDto?.data?.list ??
            const <CommonSelectableItem>[];
    if (bankList.isEmpty) {
      return HomeTransactionBlocker.bankOrAgentUnavailable;
    }
    // A single option is auto-selected upstream, so in practice this only
    // prompts with multiple options and no pick yet.
    if (selectedBankOrAgentItem == null) {
      return HomeTransactionBlocker.bankOrAgentMissing;
    }
    // The agent is the one field allowed to be absent — but only on the
    // backend's explicit 406 ("agent not required for this corridor"), which
    // the repository records as `isAgentNotRequired`. An empty list on a 200 is
    // a different thing: a corridor that offers no agent at all, which used to
    // be indistinguishable from the 406 and waved the user through.
    final agentList =
        commonAgentSelectableDto?.data?.list ??
            const <CommonSelectableItem>[];
    if (agentList.isEmpty) {
      return isAgentNotRequired
          ? null
          : HomeTransactionBlocker.agentUnavailable;
    }
    if (selectedAgentItem == null) return HomeTransactionBlocker.agentMissing;
    return null;
  }
}
