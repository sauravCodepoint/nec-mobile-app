import 'dart:async';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/common/common_send_money_dto.dart';
import '../../images/app_image.dart';
import '../../svg/app_svg.dart';
import '../../theme/app_theme_ext.dart';

// Wraps [s] with Unicode LTR embedding marks so currency/rate strings always
// read left-to-right in RTL locales (e.g. Arabic).
String _ltr(String s) =>
    '${String.fromCharCode(0x202A)}$s${String.fromCharCode(0x202C)}';

class AppPaymentDetailsView extends HookWidget {
  final CommonSendMoneyDto dto;
  final bool isCalculating;
  final String srcCode;
  final String dstCode;
  // Decimal places for the destination currency. Source is always OMR (3).
  final int destinationDecimalPlaces;
  final EdgeInsetsGeometry? margin;

  const AppPaymentDetailsView({
    super.key,
    required this.dto,
    required this.isCalculating,
    required this.srcCode,
    required this.dstCode,
    this.destinationDecimalPlaces = 3,
    this.margin,
  });

  // Builds a "#,##0.000"-style pattern for [decimals] fraction digits.
  static String _amountPattern(int decimals) {
    final d = decimals < 0 ? 0 : decimals;
    return d > 0 ? '#,##0.${'0' * d}' : '#,##0';
  }

  @override
  Widget build(BuildContext context) {
    // One-shot mount: slides up + fades in
    final mountCtrl = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    useEffect(() {
      final timer = Timer(const Duration(milliseconds: 120), mountCtrl.forward);
      return timer.cancel;
    }, const []);

    // Pulse while calculating: drives opacity of every value cell
    final pulseCtrl = useAnimationController(
      duration: const Duration(milliseconds: 650),
    );
    useEffect(() {
      if (isCalculating) {
        pulseCtrl.repeat(reverse: true);
      } else {
        pulseCtrl
          ..stop()
          ..animateTo(0.0, duration: const Duration(milliseconds: 220));
      }
      return null;
    }, [isCalculating]);

    // Stagger rows whenever a successful result arrives
    final staggerCtrl = useAnimationController(
      duration: const Duration(milliseconds: 580),
    );
    final prevTotalPayable = useRef(0.0);
    useEffect(() {
      final total = dto.totalPayableAmount ?? 0.0;
      if (total > 0 && total != prevTotalPayable.value) {
        staggerCtrl.forward(from: 0.0);
      }
      prevTotalPayable.value = total;
      return null;
    }, [dto.totalPayableAmount]);

    final rate = dto.displayRate;
    // Source is OMR (3 dp); destination uses its own currency's decimals.
    final srcRate = NumberFormat(_amountPattern(3), 'en_US');
    final dstRate = NumberFormat(
      _amountPattern(destinationDecimalPlaces),
      'en_US',
    );
    final rateText =
        (rate != null && rate > 0 && srcCode.isNotEmpty && dstCode.isNotEmpty)
        ? (dto.rateOperator == '/'
              ? _ltr('1 $dstCode = ${srcRate.format(rate)} $srcCode')
              : _ltr('1 $srcCode = ${dstRate.format(rate)} $dstCode'))
        : null;

    final hasFee = (dto.commission ?? 0) > 0;
    final hasTax = (dto.tax ?? 0) > 0;
    final hasTotal = (dto.totalPayableAmount ?? 0) > 0;

    // Nothing to show yet — don't render the card at all
    if (rateText == null && !hasFee && !hasTax && !hasTotal) {
      return const SizedBox.shrink();
    }

    final mountCurve = useMemoized(
      () => CurvedAnimation(parent: mountCtrl, curve: Curves.easeOutCubic),
      const [],
    );
    final pulseAnim = useMemoized(
      () => Tween<double>(
        begin: 1.0,
        end: 0.32,
      ).animate(CurvedAnimation(parent: pulseCtrl, curve: Curves.easeInOut)),
      const [],
    );

    return AnimatedBuilder(
      animation: mountCtrl,
      builder: (_, child) => Opacity(
        opacity: mountCurve.value,
        child: Transform.translate(
          offset: Offset(0, 16.h * (1.0 - mountCurve.value)),
          child: child,
        ),
      ),
      child: _Card(
        dto: dto,
        rateText: rateText,
        hasFee: hasFee,
        hasTax: hasTax,
        hasTotal: hasTotal,
        pulseAnim: pulseAnim,
        staggerCtrl: staggerCtrl,
        margin: margin,
      ),
    );
  }
}

// ── Card ──────────────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final CommonSendMoneyDto dto;
  final String? rateText;
  final bool hasFee;
  final bool hasTax;
  final bool hasTotal;
  final Animation<double> pulseAnim;
  final AnimationController staggerCtrl;
  final EdgeInsetsGeometry? margin;

  const _Card({
    required this.dto,
    required this.rateText,
    required this.hasFee,
    required this.hasTax,
    required this.hasTotal,
    required this.pulseAnim,
    required this.staggerCtrl,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin:
          margin ??
          EdgeInsets.symmetric(
            horizontal: 16.w,
          ).add(EdgeInsets.only(top: 12.h)),
      clipBehavior: Clip.antiAlias,
      decoration: context.glassPanel(
        borderRadius: BorderRadius.circular(12.r),
        shadowAlpha: 0.18,
        shadowBlur: 14.r,
        shadowOffset: Offset(0, 6.h),
      ),
      child: _Rows(
        dto: dto,
        rateText: rateText,
        hasFee: hasFee,
        hasTax: hasTax,
        hasTotal: hasTotal,
        pulseAnim: pulseAnim,
        staggerCtrl: staggerCtrl,
        colorScheme: colorScheme,
        theme: theme,
        taxPercentage: dto.taxPercentage ?? 0,
      ),
    );
  }
}

// ── Rows ──────────────────────────────────────────────────────────────────────

class _Rows extends StatelessWidget {
  final CommonSendMoneyDto dto;
  final String? rateText;
  final bool hasFee;
  final bool hasTax;
  final bool hasTotal;
  final Animation<double> pulseAnim;
  final AnimationController staggerCtrl;
  final ColorScheme colorScheme;
  final ThemeData theme;
  final double taxPercentage;

  const _Rows({
    required this.dto,
    required this.rateText,
    required this.hasFee,
    required this.hasTax,
    required this.hasTotal,
    required this.pulseAnim,
    required this.staggerCtrl,
    required this.colorScheme,
    required this.theme,
    required this.taxPercentage,
  });

  static const _staggerIntervals = [
    Interval(0.00, 0.55, curve: Curves.easeOutCubic),
    Interval(0.18, 0.68, curve: Curves.easeOutCubic),
    Interval(0.32, 0.82, curve: Curves.easeOutCubic),
    Interval(0.46, 1.00, curve: Curves.easeOutCubic),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([staggerCtrl, pulseAnim]),
      builder: (_, child) {
        // Build only the rows that have data, tracking stagger index separately
        final rows = <(int, Widget)>[];

        if (rateText != null) {
          rows.add((
            rows.length,
            _RateRow(
              rateText: rateText!,
              pulseOpacity: pulseAnim.value,
              colorScheme: colorScheme,
              theme: theme,
              showDivider: hasFee || hasTax || hasTotal,
            ),
          ));
        }

        if (hasFee) {
          rows.add((
            rows.length,
            _AmountRow(
              icon: Icons.receipt_long_rounded,
              iconColor: context.colorScheme.tertiary,
              label: 'home.paymentDetails.serviceCharge'.tr(),
              amount: dto.commission ?? 0.0,
              pulseOpacity: pulseAnim.value,
              colorScheme: colorScheme,
              theme: theme,
              showDivider: hasTax || hasTotal,
            ),
          ));
        }

        if (hasTax) {
          rows.add((
            rows.length,
            _AmountRow(
              icon: Icons.account_balance_rounded,
              iconColor: context.appColors.successDark,
              label: 'home.paymentDetails.vat'.tr(
                namedArgs: {'percent': '$taxPercentage'},
              ),
              amount: dto.tax ?? 0.0,
              pulseOpacity: pulseAnim.value,
              colorScheme: colorScheme,
              theme: theme,
              showDivider: hasTotal,
            ),
          ));
        }

        if (hasTotal) {
          rows.add((
            rows.length,
            _TotalRow(
              amount: dto.totalPayableAmount ?? 0.0,
              pulseOpacity: pulseAnim.value,
              colorScheme: colorScheme,
              theme: theme,
            ),
          ));
        }

        return Column(
          children: rows.map((r) => _buildRow(r.$1, r.$2)).toList(),
        );
      },
    );
  }

  Widget _buildRow(int i, Widget row) {
    final t = CurvedAnimation(
      parent: staggerCtrl,
      curve: _staggerIntervals[i],
    ).value;
    final staggered = staggerCtrl.value > 0;
    return Opacity(
      opacity: staggered ? t.clamp(0.0, 1.0) : 1.0,
      child: Transform.translate(
        offset: Offset(0, staggered ? 12.h * (1.0 - t.clamp(0.0, 1.0)) : 0),
        child: row,
      ),
    );
  }
}

// ── Exchange rate row ─────────────────────────────────────────────────────────

class _RateRow extends StatelessWidget {
  final String rateText;
  final double pulseOpacity;
  final ColorScheme colorScheme;
  final ThemeData theme;
  final bool showDivider;

  const _RateRow({
    required this.rateText,
    required this.pulseOpacity,
    required this.colorScheme,
    required this.theme,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
          child: Row(
            children: [
              _IconBubble(
                icon: Icons.sync_alt_rounded,
                colorScheme: colorScheme,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'home.paymentDetails.exchangeRate'.tr(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Opacity(
                opacity: pulseOpacity,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.35),
                        end: Offset.zero,
                      ).animate(anim),
                      child: child,
                    ),
                  ),
                  child: Text(
                    rateText,
                    key: ValueKey(rateText),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1.h,
            color: context.appColors.glassBorder.withValues(alpha: 0.12),
            thickness: 0.5,
            indent: 14.w,
            endIndent: 14.w,
          ),
      ],
    );
  }
}

// ── Amount row (fee / tax) ────────────────────────────────────────────────────

class _AmountRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final double amount;
  final double pulseOpacity;
  final ColorScheme colorScheme;
  final ThemeData theme;
  final bool showDivider;

  const _AmountRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.amount,
    required this.pulseOpacity,
    required this.colorScheme,
    required this.theme,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
          child: Row(
            children: [
              _IconBubble(
                icon: icon,
                colorScheme: colorScheme,
                iconColor: iconColor,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Opacity(
                opacity: pulseOpacity,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(end: amount),
                  duration: const Duration(milliseconds: 520),
                  curve: Curves.easeOutCubic,
                  builder: (_, val, child) => _CurrencyValue(
                    value: val,
                    color: colorScheme.onSurface,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    theme: theme,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1.h,
            color: context.appColors.glassBorder.withValues(alpha: 0.12),
            thickness: 0.5,
            indent: 14.w,
            endIndent: 14.w,
          ),
      ],
    );
  }
}

// ── Total row ─────────────────────────────────────────────────────────────────

class _TotalRow extends StatelessWidget {
  final double amount;
  final double pulseOpacity;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _TotalRow({
    required this.amount,
    required this.pulseOpacity,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.tertiary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
        border: Border(
          top: BorderSide(
            color: context.appColors.glassBorder.withValues(alpha: 0.18),
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            _IconBubble(icon: Icons.payments_rounded, colorScheme: colorScheme),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'home.paymentDetails.totalPayable'.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Opacity(
              opacity: pulseOpacity,
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: amount),
                duration: const Duration(milliseconds: 580),
                curve: Curves.easeOutCubic,
                builder: (_, val, child) => _CurrencyValue(
                  value: val,
                  color: colorScheme.tertiary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  theme: theme,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Currency symbol + amount ──────────────────────────────────────────────────

// Renders the Omani-rial glyph (SVG) followed by the formatted amount, forced
// LTR so the symbol stays before the number in RTL locales (e.g. Arabic).
class _CurrencyValue extends StatelessWidget {
  final double value;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final ThemeData theme;

  const _CurrencyValue({
    required this.value,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSvg(
            asset: AppImages.currency,
            height: fontSize,
            color: color,
            borderRadius: 0,
          ),
          SizedBox(width: 4.w),
          Text(
            NumberFormat('#,##0.000', 'en_US').format(value),
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared icon bubble ────────────────────────────────────────────────────────

class _IconBubble extends StatelessWidget {
  final IconData icon;
  final ColorScheme colorScheme;
  final Color? iconColor;

  const _IconBubble({
    required this.icon,
    required this.colorScheme,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.w,
      decoration: BoxDecoration(
        color: context.appColors.glass.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor ?? colorScheme.tertiary,
          size: 17.sp,
        ),
      ),
    );
  }
}
