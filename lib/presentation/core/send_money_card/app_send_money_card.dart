import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/common/common_selectable_dto.dart';
import '../../../domain/common/common_send_money_dto.dart';
import 'widgets/app_send_money_bottom_view.dart';
import 'widgets/app_send_money_rate_badge.dart';
import 'widgets/app_send_money_top_view.dart';
import '../theme/app_theme_ext.dart';

class AppSendMoneyCard extends HookWidget {
  final bool isRateLoading;
  final bool isSourceAmountCalculating;
  final bool isDestinationAmountCalculating;
  final bool showSelectable;
  final bool readOnly;
  final bool enableKeyboardActions;

  /// Renders the source amount in the accent colour — the "tinted text is
  /// interactive" convention (the destination amount is always accent) — so
  /// screens that otherwise read as a static summary still communicate
  /// "tap to edit". Off by default: on form-like screens (home) the fields
  /// are obviously editable.
  final bool showEditAffordance;
  final CommonSelectableDto? commonSourceSelectableDto;
  final CommonSelectableDto? commonDestinationSelectableDto;
  final CommonSelectableItem? selectedCommonSourceItem;
  final CommonSelectableItem? selectedCommonDestinationItem;
  final Function(String)? sourceAmountChanged;
  final Function(String)? destinationAmountChanged;
  final FocusNode? sourceAmountFocusNode;
  final FocusNode? destinationAmountFocusNode;
  final TextEditingController? sourceAmountController;
  final TextEditingController? destinationAmountController;
  final CommonSendMoneyDto? commonSendMoneyDto;
  final void Function(CommonSelectableItem)? onSelectedDestinationCurrency;

  const AppSendMoneyCard({
    super.key,
    this.isRateLoading = false,
    this.isSourceAmountCalculating = false,
    this.isDestinationAmountCalculating = false,
    this.showSelectable = true,
    this.readOnly = false,
    this.enableKeyboardActions = true,
    this.showEditAffordance = false,
    this.commonSourceSelectableDto,
    this.commonDestinationSelectableDto,
    this.selectedCommonSourceItem,
    this.selectedCommonDestinationItem,
    this.sourceAmountChanged,
    this.destinationAmountChanged,
    this.sourceAmountFocusNode,
    this.destinationAmountFocusNode,
    this.sourceAmountController,
    this.destinationAmountController,
    this.commonSendMoneyDto,
    this.onSelectedDestinationCurrency,
  });

  @override
  Widget build(BuildContext context) {
    // Backend note flagging that the returned source/destination amount differs
    // from what the user calculated. Hidden while a calculation is in flight so
    // a stale note never flashes over an amount that's still being computed.
    final variation = commonSendMoneyDto?.amountVariation?.trim();
    final showVariation =
        variation != null &&
        variation.isNotEmpty &&
        !isRateLoading &&
        !isSourceAmountCalculating &&
        !isDestinationAmountCalculating;

    final entranceCtrl = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    useEffect(() {
      entranceCtrl.forward();
      return null;
    }, const []);

    final fadeAnim = useMemoized(
      () => CurvedAnimation(parent: entranceCtrl, curve: Curves.easeOut),
      const [],
    );
    final slideAnim = useMemoized(
      () =>
          Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
            CurvedAnimation(parent: entranceCtrl, curve: Curves.easeOutCubic),
          ),
      const [],
    );

    return FadeTransition(
      opacity: fadeAnim,
      child: SlideTransition(
        position: slideAnim,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: context.glassPanel(
            borderRadius: BorderRadius.circular(14.r),
            fillTop: 0.10,
            fillBottom: 0.04,
            hairline: 0.22,
            shadowAlpha: 0.28,
            shadowBlur: 22,
            shadowOffset: Offset(0, 10.h),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSendMoneyTopView(
                readOnly: readOnly,
                enableKeyboardActions: enableKeyboardActions,
                showEditAffordance: showEditAffordance,
                isCalculating: isSourceAmountCalculating,
                commonSourceSelectableDto: commonSourceSelectableDto,
                selectedCommonSourceItem: selectedCommonSourceItem,
                sourceAmountChanged: sourceAmountChanged,
                sourceAmountFocusNode: sourceAmountFocusNode,
                sourceAmountController: sourceAmountController,
              ),

              // ── Divider with floating rate pill ──────────────────────────
              // Spin the rate pill whenever the rate is refreshing *or* either
              // amount is being recalculated — the displayed rate is stale
              // until the in-flight calculation lands.
              _RateDivider(
                isRateLoading:
                    isRateLoading ||
                    isSourceAmountCalculating ||
                    isDestinationAmountCalculating,
                selectedCommonSourceItem: selectedCommonSourceItem,
                selectedCommonDestinationItem: selectedCommonDestinationItem,
                commonSendMoneyDto: commonSendMoneyDto,
              ),

              AppSendMoneyBottomView(
                readOnly: readOnly,
                enableKeyboardActions: enableKeyboardActions,
                showSelectable: showSelectable,
                isCalculating: isDestinationAmountCalculating || isRateLoading,
                commonDestinationSelectableDto: commonDestinationSelectableDto,
                selectedCommonDestinationItem: selectedCommonDestinationItem,
                destinationAmountChanged: destinationAmountChanged,
                destinationAmountController: destinationAmountController,
                destinationAmountFocusNode: destinationAmountFocusNode,
                onSelectedDestinationCurrency: onSelectedDestinationCurrency,
              ),

              // ── Amount-variation notice ──────────────────────────────────
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: showVariation
                    ? _AmountVariationNotice(message: variation)
                    : const SizedBox(width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Amount-variation notice ──────────────────────────────────────────────────
//
// A subtle warning strip at the foot of the card, carrying the backend's note
// that the returned amount differs from what the user calculated. Clipped to
// the card's rounded bottom so it reads as part of the card, not a detached
// banner.

class _AmountVariationNotice extends StatelessWidget {
  final String message;

  const _AmountVariationNotice({required this.message});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final accent = context.appColors.warning;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14.r),
          bottomRight: Radius.circular(14.r),
        ),
        color: context.appColors.warningSubtle,
        border: Border(
          top: BorderSide(
            color: context.appColors.glassBorder.withValues(alpha: 0.18),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: accent, size: 16.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: cs.onSurface.withValues(alpha: 0.9),
                fontSize: 11.5.sp,
                height: 1.3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Divider with centered rate pill ──────────────────────────────────────────
//
// A hairline drawn across the card with the rate badge floating in its centre,
// visually communicating "this becomes that" between the source and destination
// sections.

class _RateDivider extends StatelessWidget {
  final bool isRateLoading;
  final CommonSelectableItem? selectedCommonSourceItem;
  final CommonSelectableItem? selectedCommonDestinationItem;
  final CommonSendMoneyDto? commonSendMoneyDto;

  const _RateDivider({
    required this.isRateLoading,
    this.selectedCommonSourceItem,
    this.selectedCommonDestinationItem,
    this.commonSendMoneyDto,
  });

  @override
  Widget build(BuildContext context) {
    final dividerColor = context.appColors.glassBorder.withValues(alpha: 0.18);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          Expanded(child: Container(height: 0.5, color: dividerColor)),
          SizedBox(width: 8.w),
          AppSendMoneyRateBadge(
            isCalculating: isRateLoading,
            selectedCommonSourceItem: selectedCommonSourceItem,
            selectedCommonDestinationItem: selectedCommonDestinationItem,
            commonSendMoneyDto: commonSendMoneyDto,
          ),
          SizedBox(width: 8.w),
          Expanded(child: Container(height: 0.5, color: dividerColor)),
        ],
      ),
    );
  }
}
