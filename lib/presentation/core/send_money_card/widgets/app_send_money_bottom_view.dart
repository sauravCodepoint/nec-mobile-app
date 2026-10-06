import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../../../domain/common/common_selectable_dto.dart';
import '../../../../domain/core/di/injection.dart';
import '../../../routes/app_routes.dart';
import '../../../routes/app_routes.gr.dart';
import '../../formatter/universal_number_formatter.dart';
import '../../global/app_global.dart';
import '../../notify/app_notify.dart';
import '../../svg/app_svg.dart';
import '../../theme/app_theme_ext.dart';

class AppSendMoneyBottomView extends HookWidget {
  final bool readOnly;
  final bool enableKeyboardActions;
  final bool showSelectable;
  // True when destination is being recalculated (user typed source).
  final bool isCalculating;
  final CommonSelectableDto? commonDestinationSelectableDto;
  final CommonSelectableItem? selectedCommonDestinationItem;
  final Function(String)? destinationAmountChanged;
  final FocusNode? destinationAmountFocusNode;
  final TextEditingController? destinationAmountController;
  final void Function(CommonSelectableItem)? onSelectedDestinationCurrency;
  final Widget? currencyPickerWidget;
  const AppSendMoneyBottomView({
    super.key,
    this.readOnly = false,
    this.enableKeyboardActions = true,
    this.showSelectable = true,
    this.isCalculating = false,
    this.commonDestinationSelectableDto,
    this.selectedCommonDestinationItem,
    this.destinationAmountChanged,
    this.destinationAmountFocusNode,
    this.destinationAmountController,
    this.onSelectedDestinationCurrency,
    this.currencyPickerWidget,
  });

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final pulseCtrl = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final pulseAnim = useMemoized(
      () => Tween<double>(
        begin: 1.0,
        end: 0.35,
      ).animate(CurvedAnimation(parent: pulseCtrl, curve: Curves.easeInOut)),
      const [],
    );

    useEffect(() {
      if (isCalculating) {
        pulseCtrl.repeat(reverse: true);
      } else {
        pulseCtrl
          ..stop()
          ..animateTo(0.0, duration: const Duration(milliseconds: 150));
      }
      return null;
    }, [isCalculating]);

    final field = AppSendMoneyBottomField(
      readOnly: readOnly,
      showSelectable: showSelectable,
      commonDestinationSelectableDto: commonDestinationSelectableDto,
      selectedCommonDestinationItem: selectedCommonDestinationItem,
      destinationAmountChanged: destinationAmountChanged,
      destinationAmountFocusNode: destinationAmountFocusNode,
      destinationAmountController: destinationAmountController,
      onSelectedDestinationCurrency: onSelectedDestinationCurrency,
    );

    final country = selectedCommonDestinationItem?.titleName ?? '';

    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SectionHeader(
            icon: Icons.arrow_downward_rounded,
            label: 'core.sendMoney.bottomField.label'.tr(),
            color: cs.tertiary.withValues(alpha: 0.85),
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (currencyPickerWidget != null)
                currencyPickerWidget!
              else
                _CurrencyButton(
                  showSelectable: showSelectable,
                  selectedCommonDestinationItem: selectedCommonDestinationItem,
                  onTap: () {
                    if (isCalculating) {
                      AppNotify.toast(
                        'core.sendMoney.calculating'.tr(),
                        type: AppToastType.info,
                        position: AppToastPosition.top,
                      );
                      return;
                    }
                    HapticFeedback.lightImpact();
                    router.push(
                      AppSelectableRoute(
                        title: 'core.sendMoney.currencyOrCountry'.tr(),
                        commonSelectableDto: commonDestinationSelectableDto,
                        isShowLeading: true,
                        isShowTrailing: true,
                        initialSelectedItem: selectedCommonDestinationItem,
                        onSelected: onSelectedDestinationCurrency,
                      ),
                    );
                  },
                ),
              SizedBox(width: 14.w),
              Expanded(
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: pulseCtrl,
                    builder: (_, child) =>
                        Opacity(opacity: pulseAnim.value, child: child),
                    child: enableKeyboardActions
                        ? KeyboardActions(
                            config: AppGlobal.buildKeyboardConfigs(
                              context: context,
                              focusNode: destinationAmountFocusNode,
                            ),
                            autoScroll: false,
                            disableScroll: true,
                            child: field,
                          )
                        : field,
                  ),
                ),
              ),
            ],
          ),
          if (country.isNotEmpty) ...[
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                country,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: cs.tertiary.withValues(alpha: 0.70),
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Shared section header ─────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 12.sp, color: color),
        SizedBox(width: 5.w),
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: color,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}

class _CurrencyButton extends HookWidget {
  final bool showSelectable;
  final CommonSelectableItem? selectedCommonDestinationItem;
  final VoidCallback onTap;

  const _CurrencyButton({
    required this.showSelectable,
    required this.onTap,
    this.selectedCommonDestinationItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final pressCtrl = useAnimationController(
      duration: const Duration(milliseconds: 90),
      reverseDuration: const Duration(milliseconds: 200),
    );
    final fadeCtrl = useAnimationController(
      duration: const Duration(milliseconds: 200),
      initialValue: 1.0,
    );

    final pressScale = useMemoized(
      () => Tween<double>(
        begin: 1.0,
        end: 0.93,
      ).animate(CurvedAnimation(parent: pressCtrl, curve: Curves.easeInOut)),
      const [],
    );
    final fadeAnim = useMemoized(
      () => CurvedAnimation(parent: fadeCtrl, curve: Curves.easeOut),
      const [],
    );

    final prevCodeRef = useRef<String?>(null);
    final currentCode = selectedCommonDestinationItem?.trailingCode;

    useEffect(() {
      final prev = prevCodeRef.value;
      prevCodeRef.value = currentCode;
      if (prev != null && prev != currentCode) {
        fadeCtrl
          ..stop()
          ..value = 0.0
          ..forward();
      }
      return null;
    }, [currentCode]);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: showSelectable ? (_) => pressCtrl.forward() : null,
      onTapUp: showSelectable
          ? (_) {
              pressCtrl.reverse();
              onTap();
            }
          : null,
      onTapCancel: showSelectable ? () => pressCtrl.reverse() : null,
      child: ScaleTransition(
        scale: pressScale,
        child: FadeTransition(
          opacity: fadeAnim,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.88, end: 1.0).animate(animation),
                child: child,
              ),
            ),
            child: Container(
              key: ValueKey(currentCode),
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: context.appColors.glass.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: cs.tertiary.withValues(alpha: 0.45),
                  width: 0.8,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSvg(
                    asset: AppGlobal.getFlagAsset(
                      selectedCommonDestinationItem?.titleCode?.toUpperCase(),
                    ),
                    width: 16.w,
                    height: 12.w,
                    fit: BoxFit.contain,
                    showOutline: true,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    selectedCommonDestinationItem?.trailingCode
                            ?.toUpperCase() ??
                        '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                      letterSpacing: 0.3,
                    ),
                  ),
                  if (showSelectable) ...[
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: cs.tertiary,
                      size: 14.w,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppSendMoneyBottomField extends StatelessWidget {
  final bool readOnly;
  final bool showSelectable;
  final CommonSelectableDto? commonDestinationSelectableDto;
  final CommonSelectableItem? selectedCommonDestinationItem;
  final Function(String)? destinationAmountChanged;
  final FocusNode? destinationAmountFocusNode;
  final TextEditingController? destinationAmountController;
  final void Function(CommonSelectableItem)? onSelectedDestinationCurrency;
  const AppSendMoneyBottomField({
    super.key,
    this.readOnly = false,
    this.showSelectable = true,
    this.commonDestinationSelectableDto,
    this.selectedCommonDestinationItem,
    this.destinationAmountChanged,
    this.destinationAmountFocusNode,
    this.destinationAmountController,
    this.onSelectedDestinationCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final decimals = selectedCommonDestinationItem?.decimalPlaces ?? 3;
    final hintText = decimals > 0 ? '0.${'0' * decimals}' : '0';
    return TextField(
      controller: destinationAmountController,
      onChanged: (value) {
        final numericValue = value.replaceAll(',', '');
        destinationAmountChanged?.call(numericValue);
      },
      cursorColor: cs.tertiary,
      cursorHeight: 18.h,
      focusNode: destinationAmountFocusNode,
      autofocus: false,
      readOnly: readOnly,
      textAlign: TextAlign.end,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: theme.textTheme.headlineSmall?.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: cs.tertiary.withValues(alpha: 0.35),
        ),
        isDense: true,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      inputFormatters: [
        UniversalNumberFormatter(limitDigits: false, maxDecimals: decimals),
      ],
      style: theme.textTheme.headlineSmall?.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: cs.tertiary,
        letterSpacing: -0.3,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}