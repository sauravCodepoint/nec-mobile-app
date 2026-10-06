import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/home/home_bloc.dart';
import 'home_inline_notice.dart';

/// Explains — in place, directly under the Send Money selector group — why the
/// corridor behind the form isn't usable, and offers the way out.
///
/// The corridor is assembled from a chain of APIs (transfer type → bank/agent →
/// agent) and a transaction may only start once every one of them has
/// succeeded. When a link breaks, the lists it feeds come back empty and the
/// rows that render them disappear, so without this card the screen looked
/// merely half-finished: the CTA sat inert with a one-line hint, the only
/// explanation was a toast the user had to tap the dead button to see, and the
/// sole way to recover was a full pull-to-refresh that also discarded their
/// selections. This card names what failed and retries just that request.
///
/// Two distinct states, deliberately not conflated:
///
/// * **Load failure** — recoverable, so it carries a retry: the corridor links
///   re-run only the request that broke ([HomeEvent.retryCorridor]), and a
///   failed receive-country list re-runs the home load itself.
/// * **Nothing available** — the corridor answered successfully but with an
///   empty list (no receive country, no transfer mode, no payout bank/agent,
///   or no agent on a 200 rather than the 406 that means "agent not required").
///   Retrying returns the same empty answer, so the card carries no button and
///   points the user at the receive country instead.
///
/// It reads its state from [HomeStateX.transactionBlocker] — the same gate the
/// Choose-Beneficiary CTA consults — so the card and the button can never
/// disagree about why the form is stuck.
///
/// Collapses to nothing while the corridor is still resolving (the rows are
/// shimmering then) and whenever the chain is healthy.
class HomeCorridorNotice extends StatelessWidget {
  final HomeState state;

  const HomeCorridorNotice({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final blocker = state.transactionBlocker;

    // Mid-retry / mid-load: the selector rows are shimmering, so a stale
    // failure card next to them would contradict the screen. Likewise, a
    // blocker that just means "you haven't picked yet" is already spelled out
    // by the hint line above the CTA — this card is only for the cases the user
    // cannot resolve by tapping a row.
    if (blocker == null ||
        blocker == HomeTransactionBlocker.corridorResolving ||
        blocker == HomeTransactionBlocker.destinationMissing ||
        blocker == HomeTransactionBlocker.transferTypeMissing ||
        blocker == HomeTransactionBlocker.bankOrAgentMissing ||
        blocker == HomeTransactionBlocker.agentMissing) {
      return const SizedBox.shrink();
    }

    // The receive-country list is the root of the corridor and is fetched by
    // the home load rather than the chain, so its retry re-runs that load.
    if (blocker == HomeTransactionBlocker.destinationLoadFailed) {
      return HomeInlineNotice(
        type: HomeNoticeType.error,
        icon: Icons.cloud_off_rounded,
        label: 'home.corridorError.label'.tr(),
        message: 'home.corridorError.destination'.tr(),
        actionLabel: 'buttons.retry'.tr(),
        onAction: () => context.read<HomeBloc>().add(
          const HomeEvent.initialize(isRefresh: true),
        ),
      );
    }

    final stage = state.failedCorridorStage;
    if (blocker == HomeTransactionBlocker.corridorLoadFailed && stage != null) {
      return HomeInlineNotice(
        type: HomeNoticeType.error,
        icon: Icons.cloud_off_rounded,
        label: 'home.corridorError.label'.tr(),
        // Name the step that actually failed — "transfer types" and "payout
        // agents" are things the user just chose between, so the message lands
        // as being about their corridor rather than a generic outage.
        message: switch (stage) {
          HomeCorridorStage.transferType =>
            'home.corridorError.transferType'.tr(),
          HomeCorridorStage.bankOrAgent =>
            'home.corridorError.bankOrAgent'.tr(),
          HomeCorridorStage.agent => 'home.corridorError.agent'.tr(),
        },
        actionLabel: 'buttons.retry'.tr(),
        onAction: () =>
            context.read<HomeBloc>().add(const HomeEvent.retryCorridor()),
      );
    }

    // Everything left is a corridor that answered, but with nothing in it.
    // Retrying would return the same empty answer, so no button — the copy
    // sends the user back to the receive country instead.
    final country = state.selectedCommonDestinationItem?.titleName ?? '';
    final message = switch (blocker) {
      HomeTransactionBlocker.destinationUnavailable =>
        'home.corridorUnavailable.destinationMessage'.tr(),
      HomeTransactionBlocker.bankOrAgentUnavailable => country.isEmpty
          ? 'home.corridorUnavailable.bankOrAgentMessageGeneric'.tr()
          : 'home.corridorUnavailable.bankOrAgentMessage'.tr(
              namedArgs: {'country': country},
            ),
      HomeTransactionBlocker.agentUnavailable => country.isEmpty
          ? 'home.corridorUnavailable.agentMessageGeneric'.tr()
          : 'home.corridorUnavailable.agentMessage'.tr(
              namedArgs: {'country': country},
            ),
      // transferTypeUnavailable, and the defensive tail: a corridor reported as
      // failed without a recorded stage still has nothing to offer.
      _ => country.isEmpty
          ? 'home.corridorUnavailable.messageGeneric'.tr()
          : 'home.corridorUnavailable.message'.tr(
              namedArgs: {'country': country},
            ),
    };

    return HomeInlineNotice(
      type: HomeNoticeType.warning,
      icon: Icons.block_rounded,
      label: 'home.corridorUnavailable.label'.tr(),
      message: message,
    );
  }
}
