import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../../../domain/common/common_selectable_dto.dart';
import '../../formatter/universal_number_formatter.dart';
import '../../global/app_global.dart';
import '../../svg/app_svg.dart';
import '../../theme/app_theme_ext.dart';

class AppSendMoneyTopView extends HookWidget {
  final bool readOnly;
  final bool enableKeyboardActions;
  final bool showEditAffordance;
  // True when source is being recalculated (user typed destination).
  final bool isCalculating;
  final CommonSelectableDto? commonSourceSelectableDto;
  final CommonSelectableItem? selectedCommonSourceItem;
  final Function(String)? sourceAmountChanged;
  final FocusNode? sourceAmountFocusNode;
  final TextEditingController? sourceAmountController;
  const AppSendMoneyTopView({
    super.key,
    this.readOnly = false,
    this.enableKeyboardActions = true,
    this.showEditAffordance = false,
    this.isCalculating = false,
    this.commonSourceSelectableDto,
    this.selectedCommonSourceItem,
    this.sourceAmountChanged,
    this.sourceAmountFocusNode,
    this.sourceAmountController,
  });

  @override
  Widget build(BuildContext context) {
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

    final field = AppSendMoneyTopField(
      readOnly: readOnly,
      accentAmount: showEditAffordance && !readOnly,
      sourceAmountChanged: sourceAmountChanged,
      sourceAmountFocusNode: sourceAmountFocusNode,
      sourceAmountController: sourceAmountController,
    );

    final country = selectedCommonSourceItem?.titleName ?? '';

    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SectionHeader(
            icon: Icons.arrow_upward_rounded,
            label: 'core.sendMoney.topField.label'.tr(),
            color: cs.onSurface.withValues(alpha: 0.65),
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _FlagCurrencyChip(
                titleCode: selectedCommonSourceItem?.titleCode,
                trailingCode: selectedCommonSourceItem?.trailingCode,
                isAccent: false,
                colorScheme: cs,
                theme: theme,
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
                              focusNode: sourceAmountFocusNode,
                            ),
                            autoScroll: false,
                            disableScroll: true,
                            child: field,
                          )
                        : field,
                  ),
                ),
              ),
              // The EditStackButton in SummaryTransferDetailsView is
              // Positioned(top: -5, end: -5, size: 40×40). Keep clearance.
              if (readOnly) SizedBox(width: 40.w),
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
                  color: cs.onSurface.withValues(alpha: 0.60),
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

class AppSendMoneyTopField extends StatelessWidget {
  final bool readOnly;

  // Renders the amount in the accent colour — the "tinted text is
  // interactive" convention — for screens where editability isn't obvious.
  final bool accentAmount;
  final CommonSelectableDto? commonSourceSelectableDto;
  final CommonSelectableItem? selectedCommonSourceItem;
  final Function(String)? sourceAmountChanged;
  final FocusNode? sourceAmountFocusNode;
  final TextEditingController? sourceAmountController;
  const AppSendMoneyTopField({
    super.key,
    this.readOnly = false,
    this.accentAmount = false,
    this.commonSourceSelectableDto,
    this.selectedCommonSourceItem,
    this.sourceAmountChanged,
    this.sourceAmountFocusNode,
    this.sourceAmountController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return TextField(
      controller: sourceAmountController,
      onChanged: (value) {
        final numericValue = value.replaceAll(',', '');
        sourceAmountChanged?.call(numericValue);
      },
      cursorColor: cs.tertiary,
      cursorHeight: 18.h,
      focusNode: sourceAmountFocusNode,
      autofocus: false,
      readOnly: readOnly,
      textAlign: TextAlign.end,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        hintText: '0.000',
        hintStyle: theme.textTheme.headlineSmall?.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: (accentAmount ? cs.tertiary : cs.onSurface).withValues(
            alpha: 0.30,
          ),
        ),
        isDense: true,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      inputFormatters: [
        UniversalNumberFormatter(limitDigits: true, maxDecimals: 3),
      ],
      style: theme.textTheme.headlineSmall?.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: accentAmount ? cs.tertiary : cs.onSurface,
        letterSpacing: -0.3,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}

// ── Shared section header ─────────────────────────────────────────────────────
//
// Tiny uppercase label with a flow-direction icon. Both top and bottom views
// use this so the visual rhythm matches across the card.

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

// ── Flag + currency code chip (read-only, source section) ────────────────────

class _FlagCurrencyChip extends StatelessWidget {
  final String? titleCode;
  final String? trailingCode;
  final bool isAccent;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _FlagCurrencyChip({
    required this.colorScheme,
    required this.theme,
    this.titleCode,
    this.trailingCode,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    final accent =
    isAccent ? colorScheme.tertiary : colorScheme.onSurface;
    return AnimatedSwitcher(
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
        key: ValueKey(trailingCode),
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: context.appColors.glass.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: accent.withValues(alpha: isAccent ? 0.45 : 0.25),
            width: 0.8,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSvg(
              asset: AppGlobal.getFlagAsset(titleCode),
              width: 16.w,
              height: 12.w,
              fit: BoxFit.contain,
              showOutline: true,
            ),
            SizedBox(width: 5.w),
            Text(
              trailingCode?.toUpperCase() ?? '',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}