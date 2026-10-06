import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/home/home_bloc.dart';
import '../../../domain/common/common_selectable_dto.dart';
import '../../routes/app_routes.gr.dart';
import 'home_inline_notice.dart';
import 'home_select_field.dart';

/// Read-only transfer-type row of the home Send Money group. Displays the
/// current selection and opens the searchable picker on tap. A single available
/// mode is auto-selected upstream: the row then drops its caret (there is
/// nothing to open) and [HomeTransferTypeNote] explains why, just under the
/// group.
class HomeTransferTypeView extends StatelessWidget {
  final HomeState state;
  const HomeTransferTypeView({super.key, required this.state});

  /// True while the transfer-type list is still being fetched for the chosen
  /// destination — the row holds its place with a shimmer.
  static bool isLoading(HomeState state) => state.isTransferTypeLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading(state)) {
      return const HomeSelectFieldShimmer();
    }

    final list = state.homeTransferTypeDto?.data?.transferModeList ?? [];

    return HomeSelectField(
      icon: Icons.swap_horiz_rounded,
      label: 'home.transferType.label'.tr(),
      value: state.selectedTransferTypeItem?.titleName?.toUpperCase(),
      placeholder: 'home.transferType.placeholder'.tr(),
      // Only offer the caret when there is genuinely a picker to open. A single
      // option was auto-selected upstream, and an empty list means the fetch
      // failed or the corridor has nothing — both used to render a tappable
      // caret whose tap did nothing at all.
      enabled: list.length > 1,
      onTap: () {
        if (list.isEmpty) return;
        HapticFeedback.selectionClick();
        context.router.push(
          AppSelectableRoute(
            title: 'home.transferType.label'.tr(),
            initialSelectedItem: state.selectedTransferTypeItem,
            commonSelectableDto: CommonSelectableDto(
              data: CommonSelectableData(
                list: list
                    .map(
                      (e) => CommonSelectableItem(
                        titleName: (e.name ?? '').toUpperCase(),
                        titleCode: e.code,
                      ),
                    )
                    .toList(),
              ),
            ),
            onSelected: (value) => context.read<HomeBloc>().add(
              HomeEvent.transferTypeSelected(
                selectedTransferTypeItem: value,
                fromUser: true,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Informational note shown beneath the selector group when only one transfer
/// type is available, replacing the previous info toast. Renders through the
/// shared [HomeInlineNotice] so it sits in the same visual family as the
/// corridor failure / unavailable cards that occupy the same slot — the user
/// reads one kind of section message, in three semantic tones. Collapses to
/// nothing whenever there is a real choice to make.
class HomeTransferTypeNote extends StatelessWidget {
  final HomeState state;
  const HomeTransferTypeNote({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final list = state.homeTransferTypeDto?.data?.transferModeList ?? [];
    if (state.isTransferTypeLoading || list.length != 1) {
      return const SizedBox.shrink();
    }

    return HomeInlineNotice(
      type: HomeNoticeType.info,
      icon: Icons.info_outline_rounded,
      label: 'home.transferType.single'.tr(),
      message: 'home.transferType.onlyOneOption'.tr(
        namedArgs: {'transferType': list.first.name ?? ''},
      ),
    );
  }
}
