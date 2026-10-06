import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/common/common_selectable_dto.dart';
import '../../../../domain/common/common_send_money_dto.dart';
import '../../theme/app_theme_ext.dart';

class AppSendMoneyRateBadge extends HookWidget {
  final bool isCalculating;
  final CommonSelectableItem? selectedCommonSourceItem;
  final CommonSelectableItem? selectedCommonDestinationItem;
  final CommonSendMoneyDto? commonSendMoneyDto;

  const AppSendMoneyRateBadge({
    super.key,
    this.isCalculating = false,
    this.selectedCommonSourceItem,
    this.selectedCommonDestinationItem,
    this.commonSendMoneyDto,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    // Subtle mount-in pop so the pill feels alive when the card appears.
    final mountCtrl = useAnimationController(
      duration: const Duration(milliseconds: 380),
    );
    final mountScale = useMemoized(
          () => Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(parent: mountCtrl, curve: Curves.easeOutBack),
      ),
      const [],
    );

    useEffect(() {
      mountCtrl.forward();
      return null;
    }, const []);

    final srcCode = selectedCommonSourceItem?.trailingCode?.toUpperCase();
    final dstCode = selectedCommonDestinationItem?.trailingCode?.toUpperCase();
    final rate = commonSendMoneyDto?.displayRate;
    final operator = commonSendMoneyDto?.rateOperator;

    // Backend signals the rate can't be computed until the user picks a bank /
    // agent. This must take priority over the rate row: in this case the
    // calculate API returns a placeholder rate (0.0, never null), which would
    // otherwise be rendered as a bogus "1 X = 0.000 Y".
    final showBankOrAgentPrompt =
        commonSendMoneyDto?.isBankOrAgentRequired ?? false;

    final hasRate =
        !showBankOrAgentPrompt &&
        rate != null &&
        rate != 0 &&
        srcCode != null &&
        dstCode != null;

    // operator '/' → "1 dstCode = rate srcCode", else → "1 srcCode = rate dstCode"
    final baseCode = hasRate ? (operator == '/' ? dstCode : srcCode) : '';
    final quoteCode = hasRate ? (operator == '/' ? srcCode : dstCode) : '';
    final rateStr = hasRate ? rate.toString(): '';

    final accent = isCalculating || hasRate
        ? cs.tertiary
        : cs.onSurface.withValues(alpha: 0.50);

    return RepaintBoundary(
      child: ScaleTransition(
        scale: mountScale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            gradient: hasRate && !isCalculating
                ? LinearGradient(
              colors: [
                cs.tertiary.withValues(alpha: 0.14),
                cs.tertiary.withValues(alpha: 0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
            color: hasRate && !isCalculating
                ? null
                : context.appColors.glass.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              color: accent.withValues(alpha: hasRate ? 0.60 : 0.35),
              width: 0.8,
            ),
            // Colored accent glow — reads as neon on the dark canvas.
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: hasRate ? 0.28 : 0.10),
                blurRadius: hasRate ? 18 : 8,
                spreadRadius: -2,
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, anim) =>
                FadeTransition(opacity: anim, child: child),
            child: isCalculating
                ? Row(
              key: const ValueKey('loading'),
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 13.w,
                  height: 13.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: cs.tertiary,
                  ),
                ),
                SizedBox(width: 7.w),
                Text(
                  'core.sendMoney.rateCalculating'.tr(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: cs.tertiary,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            )
                : hasRate
                ? Row(
              key: ValueKey('rate-$rateStr-$baseCode'),
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sync_alt_rounded,
                  size: 12.sp,
                  color: cs.tertiary,
                ),
                SizedBox(width: 6.w),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '1 ',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: cs.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                      TextSpan(
                        text: baseCode,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: cs.tertiary,
                          letterSpacing: 0.3,
                        ),
                      ),
                      TextSpan(
                        text: '  =  ',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: cs.onSurface.withValues(alpha: 0.40),
                        ),
                      ),
                      TextSpan(
                        text: rateStr,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                          letterSpacing: -0.2,
                        ),
                      ),
                      TextSpan(
                        text: ' $quoteCode',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: cs.tertiary,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  textDirection: ui.TextDirection.ltr,
                ),
              ],
            )
                : showBankOrAgentPrompt
                ? Row(
              key: const ValueKey('bank-or-agent'),
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.account_balance_rounded,
                  size: 12.sp,
                  color: accent,
                ),
                SizedBox(width: 5.w),
                Text(
                  'core.sendMoney.selectBankOrAgentFirst'.tr(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: accent,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            )
                : Row(
              key: const ValueKey('no-rate'),
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 12.sp,
                  color: accent,
                ),
                SizedBox(width: 5.w),
                Text(
                  'core.sendMoney.rateIsNotAvailable'.tr(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: accent,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}