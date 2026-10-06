import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/home/home_bloc.dart';
import '../../../domain/common/common_selectable_dto.dart';
import '../../core/global/app_global.dart';
import '../../core/svg/app_svg.dart';
import '../../routes/app_routes.gr.dart';
import 'home_select_field.dart';

/// Receive-country selector — the first row of the home Send Money group. A
/// single API-driven field: the destination currency list is fetched on home
/// init (`getHomeDestinationCurrencyList`) and rendered as a flag-anchored
/// [HomeSelectField], so it sits as a sibling of the transfer-type and
/// bank/agent rows in the same panel. The country name is the value and the
/// currency code rides along as the accent badge. Tapping opens the searchable
/// picker; selecting a destination re-runs the corridor chain (transfer types →
/// bank/agent). The source (send) country is fixed — the account base currency
/// — so only the destination is selectable here.
class HomeSendReceiveView extends StatelessWidget {
  final HomeState state;
  const HomeSendReceiveView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final destDto = state.commonDestinationSelectableDto;
    // The group only builds once the form load has settled, so a null dto here
    // is not "still loading" — it is a receive-country fetch that failed and
    // left nothing behind. Shimmering on it spun forever on a row that was
    // never going to arrive; render the row disabled instead and let
    // HomeCorridorNotice carry the reason and the retry.
    if (destDto == null && state.isRefreshing) {
      return const HomeSelectFieldShimmer();
    }
    final dest = state.selectedCommonDestinationItem;
    final destList =
        destDto?.data?.list ?? const <CommonSelectableItem>[];

    final country = (dest?.titleName ?? '').toUpperCase();
    final hasValue = country.isNotEmpty;

    return HomeSelectField(
      icon: Icons.public_rounded,
      leading: hasValue
          ? AppSvg(
              asset: AppGlobal.getFlagAsset(dest?.titleCode),
              width: 32.w,
              height: 23.w,
              fit: BoxFit.cover,
              borderRadius: 6,
              showOutline: true,
            )
          : null,
      label: 'home.destination.label'.tr(),
      value: country,
      placeholder: 'home.destination.placeholder'.tr(),
      badge: (dest?.trailingCode ?? '').toUpperCase(),
      enabled: destList.isNotEmpty,
      onTap: () {
        if (destList.isEmpty) return;
        HapticFeedback.selectionClick();
        context.router.push(
          AppSelectableRoute(
            title: 'home.destination.label'.tr(),
            isShowLeading: true,
            isShowTrailing: true,
            initialSelectedItem: dest,
            commonSelectableDto: destDto!,
            onSelected: (value) => context.read<HomeBloc>().add(
              HomeEvent.destinationCountrySelected(
                selectedCommonDestinationItem: value,
              ),
            ),
          ),
        );
      },
    );
  }
}
