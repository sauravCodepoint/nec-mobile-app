import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/summary/summary_bloc.dart';
import '../../core/send_money_card/app_send_money_card.dart';

class SummaryTransferDetailsView extends StatelessWidget {
  final SummaryState state;
  final FocusNode sourceAmountFocusNode;
  final FocusNode destinationAmountFocusNode;
  final TextEditingController sourceAmountController;
  final TextEditingController destinationAmountController;
  const SummaryTransferDetailsView({
    super.key,
    required this.state,
    required this.sourceAmountFocusNode,
    required this.destinationAmountFocusNode,
    required this.sourceAmountController,
    required this.destinationAmountController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'summary.transferDetails.title'.tr(),
          style: theme.textTheme.titleSmall?.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        // Amounts are edited inline: tapping the source or destination
        // field brings up the keyboard directly (the edit-icon bottom sheet
        // was removed at the client's request). Editability is signalled by
        // the accent tint on both amounts (showEditAffordance) plus the
        // one-time coach mark — no extra chrome on the card. Currency
        // selection stays locked on this screen.
        AppSendMoneyCard(
          showSelectable: false,
          showEditAffordance: true,
          // The full-page shimmer covers the very first calculation, so here
          // the rate badge only needs to reflect subsequent recalculations.
          // isRateLoading is never set on this bloc, so fold the amount-calc
          // flags into it.
          isRateLoading:
              state.isSourceAmountCalculating ||
              state.isDestinationAmountCalculating,
          isSourceAmountCalculating: state.isSourceAmountCalculating,
          isDestinationAmountCalculating: state.isDestinationAmountCalculating,
          commonSourceSelectableDto: state.commonSourceSelectableDto,
          selectedCommonSourceItem: state.selectedCommonSourceItem,
          commonDestinationSelectableDto: state.commonDestinationSelectableDto,
          selectedCommonDestinationItem: state.selectedCommonDestinationItem,
          sourceAmountChanged: (p0) => context.read<SummaryBloc>().add(
            SummaryEvent.sourceAmountChanged(sourceAmount: p0),
          ),
          destinationAmountChanged: (p0) => context.read<SummaryBloc>().add(
            SummaryEvent.destinationAmountChanged(destinationAmount: p0),
          ),
          sourceAmountFocusNode: sourceAmountFocusNode,
          destinationAmountFocusNode: destinationAmountFocusNode,
          sourceAmountController: sourceAmountController,
          destinationAmountController: destinationAmountController,
          commonSendMoneyDto: state.commonSendMoneyDto,
        ),
      ],
    );
  }
}
