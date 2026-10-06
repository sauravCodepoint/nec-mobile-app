import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/home/home_bloc.dart';
import '../../../domain/common/common_selectable_dto.dart';
import '../../routes/app_routes.gr.dart';
import 'home_select_field.dart';

/// Read-only Bank / Agent row of the home Send Money group, shown below the
/// transfer type once a corridor resolves a payout list with more than one
/// option; tapping opens the searchable picker. Each list item carries just the
/// display name and the product code (as titleCode) — the only bank/agent value
/// the downstream beneficiary list needs. The row is absent entirely when there
/// is nothing to choose (empty list, or a single option that's auto-selected
/// upstream), so it only appears when the user actually has a choice to make.
///
/// Whether the row occupies a slot is [isVisible]; the home page asks before
/// adding it to the group so a hairline is never drawn against an empty row.
class HomeBankOrAgentView extends StatelessWidget {
  final HomeState state;
  const HomeBankOrAgentView({super.key, required this.state});

  static List<CommonSelectableItem> _list(HomeState state) =>
      state.commonBankOrAgentSelectableDto?.data?.list ??
      const <CommonSelectableItem>[];

  /// A transfer type is chosen and the payout list is still resolving — the row
  /// holds its place with a shimmer instead of popping in late.
  static bool isResolving(HomeState state) =>
      _list(state).isEmpty &&
      state.selectedTransferTypeItem != null &&
      state.isCorridorLoading;

  /// True when the row takes space at all: either it is still resolving, or the
  /// corridor offered a real choice (more than one payout option).
  static bool isVisible(HomeState state) =>
      isResolving(state) || _list(state).length > 1;

  @override
  Widget build(BuildContext context) {
    if (isResolving(state)) return const HomeSelectFieldShimmer();

    final dto = state.commonBankOrAgentSelectableDto;
    final list = _list(state);
    // Nothing to pick, or only a single payout option (auto-selected upstream):
    // there's no choice to make, so take no space.
    if (list.length <= 1) return const SizedBox.shrink();

    return HomeSelectField(
      icon: Icons.account_balance_rounded,
      label: 'home.bankOrAgent.label'.tr(),
      value: state.selectedBankOrAgentItem?.titleName,
      placeholder: 'home.bankOrAgent.placeholder'.tr(),
      onTap: () {
        HapticFeedback.selectionClick();
        context.router.push(
          AppSelectableRoute(
            title: 'home.bankOrAgent.label'.tr(),
            initialSelectedItem: state.selectedBankOrAgentItem,
            commonSelectableDto: dto,
            onSelected: (value) => context.read<HomeBloc>().add(
              HomeEvent.bankOrAgentSelected(
                selectedBankOrAgent: value.titleName ?? '',
                // titleCode carries the product code.
                selectedBankOrAgentCode: value.titleCode ?? '',
                fromUser: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
