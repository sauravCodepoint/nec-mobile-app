import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/home/home_bloc.dart';
import '../../../domain/common/common_selectable_dto.dart';
import '../../routes/app_routes.gr.dart';
import 'home_select_field.dart';

/// Read-only Agent row of the home Send Money group, sitting just below the
/// Bank / Agent row. Like bank/agent it is corridor-scoped (same country /
/// currency / disbursal params) and resolves as the last link in the corridor
/// chain; tapping opens the searchable picker. Each list item carries the
/// display name and the agent code (as titleCode). The row is absent entirely
/// when there is nothing to choose (empty list, or a single option that's
/// auto-selected upstream).
///
/// Whether the row occupies a slot is [isVisible]; the home page asks before
/// adding it to the group so a hairline is never drawn against an empty row.
class HomeAgentView extends StatelessWidget {
  final HomeState state;
  const HomeAgentView({super.key, required this.state});

  static List<CommonSelectableItem> _list(HomeState state) =>
      state.commonAgentSelectableDto?.data?.list ??
      const <CommonSelectableItem>[];

  /// A transfer type is chosen and the agent list is still resolving — the row
  /// holds its place with a shimmer instead of popping in late.
  static bool isResolving(HomeState state) =>
      _list(state).isEmpty &&
      state.selectedTransferTypeItem != null &&
      state.isCorridorLoading;

  /// True when the row takes space at all: either it is still resolving, or the
  /// corridor offered a real choice (more than one agent).
  static bool isVisible(HomeState state) =>
      isResolving(state) || _list(state).length > 1;

  @override
  Widget build(BuildContext context) {
    if (isResolving(state)) return const HomeSelectFieldShimmer();

    final dto = state.commonAgentSelectableDto;
    final list = _list(state);
    // Nothing to pick, or only a single agent option (auto-selected upstream):
    // there's no choice to make, so take no space.
    if (list.length <= 1) return const SizedBox.shrink();

    return HomeSelectField(
      icon: Icons.support_agent_rounded,
      label: 'home.agent.label'.tr(),
      value: state.selectedAgentItem?.titleName,
      placeholder: 'home.agent.placeholder'.tr(),
      onTap: () {
        HapticFeedback.selectionClick();
        context.router.push(
          AppSelectableRoute(
            title: 'home.agent.label'.tr(),
            initialSelectedItem: state.selectedAgentItem,
            commonSelectableDto: dto,
            onSelected: (value) => context.read<HomeBloc>().add(
              HomeEvent.agentSelected(
                selectedAgent: value.titleName ?? '',
                // titleCode carries the agent code.
                selectedAgentCode: value.titleCode ?? '',
                fromUser: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
