import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/common/common_branches_dto.dart';
import '../../../domain/common/common_payment_result_dto.dart';
import '../app_bar/app_app_bar.dart';
import '../button/app_button.dart';
import '../theme/app_theme_ext.dart';
import '../helper/app_date_formatter_helper.dart';
import '../scaffold/app_scaffold.dart';
import '../sound/app_sounds.dart';
import '../widgets/confirm_pop_scope.dart';

@RoutePage()
class AppPaymentResultPage extends HookWidget {
  final CommonPaymentResultDto? paymentResult;
  final bool isPayAtBranch;
  final String? validTimeLimit;
  final BranchDto? selectedBranch;

  const AppPaymentResultPage({
    super.key,
    this.paymentResult,
    this.isPayAtBranch = false,
    this.validTimeLimit,
    this.selectedBranch,
  });

  // Every exit (OK, app-bar close, system back) must land on the main page:
  // the summary flow was popAndPush-ed away, so a plain pop would drop the
  // user onto a stale mid-flow screen under this one.
  void _popToMain(BuildContext context) => context.router.popUntilRoot();

  @override
  Widget build(BuildContext context) {
    final tx = paymentResult?.data?.paymentTransaction;
    final details = tx?.transactions;
    final isSuccessful = details?.isSuccessful ?? false;
    final appSemanticColors = context.appColors;
    final accentColor = isSuccessful
        ? appSemanticColors.success
        : appSemanticColors.statusFailed;

    final contentCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1350),
    );

    useEffect(() {
      final t = Timer(const Duration(milliseconds: 220), () {
        if (!contentCtrl.isAnimating && !contentCtrl.isCompleted) {
          contentCtrl.forward();
        }
      });
      return t.cancel;
    }, const []);

    // Play the result sound in sync with the hero icon reveal: the _HeroIcon
    // animation starts on mount and strokes the check / X between ~770ms and
    // ~1200ms. A ~500ms delay lands the chime's rise with the circle sweep so
    // the tone peaks as the mark completes. Matches whatever icon is shown.
    useEffect(() {
      final t = Timer(const Duration(milliseconds: 500), () {
        isSuccessful ? AppSounds.success() : AppSounds.failure();
      });
      return t.cancel;
    }, const []);

    // Build visible rows — skip null/empty values
    final rows = <_RowData>[];
    final refStr = (details?.transactionReference ?? tx?.transactionReference)
        ?.toString();
    if (refStr != null && refStr.isNotEmpty) {
      rows.add(
        _RowData(
          label: 'core.paymentResult.fields.referenceId'.tr(),
          value: '#$refStr',
        ),
      );
    }
    if (details?.beneficiaryName?.isNotEmpty == true) {
      rows.add(
        _RowData(
          label: 'core.paymentResult.fields.receiver'.tr(),
          value: details!.beneficiaryName!,
        ),
      );
    }
    if (details?.paymentMode?.isNotEmpty == true) {
      rows.add(
        _RowData(
          label: 'core.paymentResult.fields.paymentMethod'.tr(),
          value: details!.paymentMode!,
        ),
      );
    }
    if (details?.appStatus?.isNotEmpty == true) {
      rows.add(
        _RowData(
          label: 'core.paymentResult.fields.status'.tr(),
          value: details!.appStatus!,
          isStatus: true,
          isSuccessful: isSuccessful,
        ),
      );
    }
    final dateStr = AppDateFormatterHelper.format(
      paymentResult?.timeStamp,
      outputFormat: AppDateFormatterHelper.bankingDateTime,
    );
    if (dateStr.isNotEmpty) {
      rows.add(
        _RowData(
          label: 'core.paymentResult.fields.dateTime'.tr(),
          value: dateStr,
        ),
      );
    }

    final amount = tx?.netAmount ?? details?.netAmount;
    final amountText = amount != null ? _fmtAmount(amount) : null;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final timerHours = _parseHours(validTimeLimit);

    return ConfirmPopScope(
      // Intercept the system back (Android button/gesture) and redirect it to
      // the main page as well.
      title: 'core.paymentResult.leaveDialog.title'.tr(),
      message: 'core.paymentResult.leaveDialog.message'.tr(),
      confirmText: 'core.paymentResult.leaveDialog.confirm'.tr(),
      cancelText: 'core.paymentResult.leaveDialog.cancel'.tr(),
      onConfirm: () => _popToMain(context),
      child: AppScaffold(
        appBar: AppAppBar(
          title: 'core.paymentResult.title'.tr(),
          leading: IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () => _popToMain(context),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    _HeroIcon(
                      isSuccessful: isSuccessful,
                      accentColor: accentColor,
                    ),
                    SizedBox(height: 20.h),
                    AnimatedBuilder(
                      animation: contentCtrl,
                      builder: (_, child) {
                        final t = contentCtrl.value;
                        return Column(
                          children: [
                            // Title + subtitle
                            _Stagger(
                              t: t,
                              s: 0.0,
                              e: 0.28,
                              child: Column(
                                children: [
                                  Text(
                                    isPayAtBranch
                                        ? 'core.paymentResult.payAtBranch.title'
                                              .tr()
                                        : isSuccessful
                                        ? 'core.paymentResult.success.title'
                                              .tr()
                                        : 'core.paymentResult.failure.title'
                                              .tr(),
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w800,
                                          color: colorScheme.onSurface,
                                          letterSpacing: -0.4,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    isPayAtBranch
                                        ? 'core.paymentResult.payAtBranch.message'
                                              .tr()
                                        : isSuccessful
                                        ? 'core.paymentResult.success.message'
                                              .tr()
                                        : 'core.paymentResult.failure.message'
                                              .tr(),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: 13.sp,
                                      color: colorScheme.onSurfaceVariant,
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            // Countdown timer — PB only
                            if (isPayAtBranch && timerHours != null) ...[
                              SizedBox(height: 22.h),
                              _Stagger(
                                t: t,
                                s: 0.16,
                                e: 0.46,
                                child: _CountdownTimerCard(
                                  totalHours: timerHours,
                                ),
                              ),
                            ],

                            // Amount card
                            if (amountText != null) ...[
                              SizedBox(height: 22.h),
                              _Stagger(
                                t: t,
                                s: 0.16,
                                e: 0.46,
                                child: _AmountCard(
                                  amountText: amountText,
                                  accentColor: accentColor,
                                  isSuccessful: isSuccessful,
                                ),
                              ),
                            ],

                            // Details card with staggered rows
                            if (rows.isNotEmpty) ...[
                              SizedBox(height: 14.h),
                              _Stagger(
                                t: t,
                                s: 0.30,
                                e: 0.55,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: colorScheme.outline.withValues(
                                        alpha: 0.35,
                                      ),
                                      width: 0.5.w,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      for (int i = 0; i < rows.length; i++) ...[
                                        _Stagger(
                                          t: t,
                                          s: (0.40 + i * 0.09).clamp(0.0, 0.95),
                                          e: (0.60 + i * 0.09).clamp(0.0, 1.0),
                                          child: _InfoRow(data: rows[i]),
                                        ),
                                        if (i < rows.length - 1)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                            ),
                                            child: Divider(
                                              height: 1,
                                              thickness: 0.5.h,
                                              color: colorScheme.outline
                                                  .withValues(alpha: 0.25),
                                            ),
                                          ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],

                            // Branch details card — PB only, shown last
                            if (isPayAtBranch && selectedBranch != null) ...[
                              SizedBox(height: 14.h),
                              _Stagger(
                                t: t,
                                s: 0.55,
                                e: 0.80,
                                child: _BranchDetailsCard(
                                  branch: selectedBranch!,
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // OK button — fades in last
            AnimatedBuilder(
              animation: contentCtrl,
              builder: (_, child) => Opacity(
                opacity: _p(contentCtrl.value, 0.80, 1.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ).add(EdgeInsets.only(bottom: 24.h, top: 8.h)),
                  child: AppButton(
                    text: 'buttons.ok'.tr(),
                    onTap: () => _popToMain(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static int? _parseHours(String? s) {
    if (s == null || s.isEmpty) return null;
    final match = RegExp(r'\d+').firstMatch(s);
    return match != null ? int.tryParse(match.group(0)!) : null;
  }

  static double _p(double t, double s, double e) {
    if (e <= s) return 1.0;
    return Curves.easeOut.transform(((t - s) / (e - s)).clamp(0.0, 1.0));
  }

  static String _fmtAmount(double amount) {
    if (!amount.isFinite || amount < 0) return '0.000';
    final str = amount.toStringAsFixed(3);
    final parts = str.split('.');
    if (parts.length < 2) return str;
    final intStr = parts[0];
    final buf = StringBuffer();
    for (int i = 0; i < intStr.length; i++) {
      if (i > 0 && (intStr.length - i) % 3 == 0) buf.write(',');
      buf.write(intStr[i]);
    }
    return '${buf.toString()}.${parts[1]}';
  }
}

// ── Stagger helper ────────────────────────────────────────────────────────────
// Fades + slides a child into view over the given [s]tart to [e]nd interval.

class _Stagger extends StatelessWidget {
  final double t;
  final double s;
  final double e;
  final Widget child;

  const _Stagger({
    required this.t,
    required this.s,
    required this.e,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final p = e <= s
        ? 1.0
        : Curves.easeOutCubic.transform(((t - s) / (e - s)).clamp(0.0, 1.0));
    return Opacity(
      opacity: p,
      child: Transform.translate(
        offset: Offset(0, 22.h * (1.0 - p)),
        child: child,
      ),
    );
  }
}

// ── Branch details card ───────────────────────────────────────────────────────

class _BranchDetailsCard extends StatelessWidget {
  final BranchDto branch;

  const _BranchDetailsCard({required this.branch});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String? safe(String? v) =>
        (v == null || v.trim().isEmpty) ? null : v.trim();

    final name = safe(branch.branchName);
    // Each part may arrive with its own leading/trailing commas or stray
    // whitespace (e.g. "Building 5," or a bare ","). Strip those before
    // filtering so joining never yields doubled or dangling commas when only
    // some of the three lines are present.
    final address = [branch.address1, branch.address2, branch.address3]
        .map((e) => (e ?? '').replaceAll(RegExp(r'^[\s,]+|[\s,]+$'), '').trim())
        .where((e) => e.isNotEmpty)
        .join(', ');
    final phone = safe(branch.phone);
    final email = safe(branch.email);
    final hours = safe(branch.workingHours);

    final details = <_BranchItem>[
      if (address.isNotEmpty)
        _BranchItem(icon: Icons.location_on_outlined, text: address),
      if (hours != null)
        _BranchItem(icon: Icons.schedule_outlined, text: hours),
      if (phone != null) _BranchItem(icon: Icons.phone_outlined, text: phone),
      if (email != null) _BranchItem(icon: Icons.email_outlined, text: email),
    ];

    if (name == null && details.isEmpty) return const SizedBox.shrink();

    final accent = colorScheme.tertiary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.35),
            width: 0.5.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                border: Border(
                  bottom: BorderSide(
                    color: accent.withValues(alpha: 0.20),
                    width: 0.5.w,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_outlined,
                    size: 14.sp,
                    color: accent,
                  ),
                  SizedBox(width: 7.w),
                  Text(
                    'core.branchSelection.fields.branch'.tr().toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: accent,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),

            // ── Branch name ─────────────────────────────────────────────────
            if (name != null)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  14.h,
                  16.w,
                  details.isEmpty ? 14.h : 4.h,
                ),
                child: Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                    height: 1.3,
                  ),
                ),
              ),

            // ── Detail rows ─────────────────────────────────────────────────
            if (details.isNotEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  name != null ? 10.h : 14.h,
                  16.w,
                  14.h,
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < details.length; i++) ...[
                      if (i > 0)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Divider(
                            height: 1,
                            thickness: 0.5.h,
                            color: colorScheme.outline.withValues(alpha: 0.20),
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Icon(
                              details[i].icon,
                              size: 14.sp,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              details[i].text,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: colorScheme.onSurfaceVariant,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BranchItem {
  final IconData icon;
  final String text;

  const _BranchItem({required this.icon, required this.text});
}

// ── Countdown timer card ──────────────────────────────────────────────────────

class _CountdownTimerCard extends HookWidget {
  final int totalHours;

  const _CountdownTimerCard({required this.totalHours});

  @override
  Widget build(BuildContext context) {
    final totalSeconds = totalHours * 3600;
    final secondsLeft = useState(totalSeconds);

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (secondsLeft.value > 0) secondsLeft.value--;
      });
      return timer.cancel;
    }, const []);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isExpired = secondsLeft.value <= 0;
    final progress = totalSeconds > 0 ? secondsLeft.value / totalSeconds : 0.0;

    final hours = secondsLeft.value ~/ 3600;
    final minutes = (secondsLeft.value % 3600) ~/ 60;
    final seconds = secondsLeft.value % 60;
    final timeStr = hours > 0
        ? '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
        : '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    final accentColor = isExpired
        ? context.appColors.statusFailed
        : colorScheme.tertiary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.13),
            accentColor.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.35),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isExpired ? Icons.timer_off_outlined : Icons.timer_outlined,
                color: accentColor,
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                isExpired
                    ? 'core.paymentResult.payAtBranch.expired.title'.tr()
                    : 'core.paymentResult.payAtBranch.timerLabel'.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: accentColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            isExpired ? '--:--' : timeStr,
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: 42.sp,
              fontWeight: FontWeight.w800,
              color: accentColor,
              letterSpacing: -1.0,
              fontFeatures: [const FontFeature.tabularFigures()],
            ),
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: isExpired ? 0 : progress,
              minHeight: 4.h,
              backgroundColor: accentColor.withValues(alpha: 0.18),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
          if (isExpired) ...[
            SizedBox(height: 10.h),
            Text(
              'core.paymentResult.payAtBranch.expired.message'.tr(),
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Hero icon ─────────────────────────────────────────────────────────────────
// Animated circle + check / X, surrounded by a soft glow.
// Success: glow breathes after animation completes.

class _HeroIcon extends HookWidget {
  final bool isSuccessful;
  final Color accentColor;

  const _HeroIcon({required this.isSuccessful, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final iconCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );
    final glowCtrl = useAnimationController(
      duration: const Duration(milliseconds: 2200),
    );

    useEffect(() {
      var alive = true;
      iconCtrl.forward().whenComplete(() {
        if (alive && isSuccessful) glowCtrl.repeat(reverse: true);
      });
      return () => alive = false;
    }, const []);

    final entranceAnim = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: iconCtrl,
          curve: const Interval(0.0, 0.40, curve: Curves.elasticOut),
        ),
      ),
      const [],
    );

    final circleAnim = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: iconCtrl,
          curve: const Interval(0.15, 0.68, curve: Curves.easeInOut),
        ),
      ),
      const [],
    );

    final iconAnim = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: iconCtrl,
          curve: const Interval(0.64, 1.0, curve: Curves.easeOut),
        ),
      ),
      const [],
    );

    // Glow pulses between 0.10 and 0.26 opacity (success only)
    final glowAnim = useMemoized(
      () => Tween<double>(
        begin: 0.10,
        end: 0.26,
      ).animate(CurvedAnimation(parent: glowCtrl, curve: Curves.easeInOut)),
      const [],
    );

    return AnimatedBuilder(
      animation: Listenable.merge([iconCtrl, glowCtrl]),
      builder: (_, child) {
        final entrance = entranceAnim.value;
        final glow = glowAnim.value;

        return SizedBox(
          width: 150.w,
          height: 150.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer diffuse glow
              Container(
                width: 150.w,
                height: 150.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      accentColor.withValues(alpha: glow * 0.55 * entrance),
                      accentColor.withValues(alpha: 0.0),
                    ],
                    stops: const [0.25, 1.0],
                  ),
                ),
              ),
              // Tight inner halo
              Container(
                width: 114.w,
                height: 114.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      accentColor.withValues(alpha: glow * 0.18 * entrance),
                      accentColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              // Circle + check / X
              Transform.scale(
                scale: entrance,
                child: CustomPaint(
                  size: Size(108.w, 108.w),
                  painter: _ResultIconPainter(
                    isSuccessful: isSuccessful,
                    circleProgress: circleAnim.value,
                    iconProgress: iconAnim.value,
                    color: accentColor,
                    strokeWidth: 3.2.w,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Amount card ───────────────────────────────────────────────────────────────

class _AmountCard extends StatelessWidget {
  final String amountText;
  final Color accentColor;
  final bool isSuccessful;

  const _AmountCard({
    required this.amountText,
    required this.accentColor,
    required this.isSuccessful,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.13),
            accentColor.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.28),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'core.paymentResult.fields.totalAmount'.tr(),
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'OMR',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                amountText,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.8,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Info row ──────────────────────────────────────────────────────────────────

class _RowData {
  final String label;
  final String value;
  final bool isStatus;
  final bool isSuccessful;

  const _RowData({
    required this.label,
    required this.value,
    this.isStatus = false,
    this.isSuccessful = false,
  });
}

class _InfoRow extends StatelessWidget {
  final _RowData data;
  const _InfoRow({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              data.label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 6,
            child: data.isStatus
                ? Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: _StatusChip(
                      value: data.value,
                      isSuccessful: data.isSuccessful,
                    ),
                  )
                : Text(
                    data.value,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Status chip ───────────────────────────────────────────────────────────────

class _StatusChip extends StatelessWidget {
  final String value;
  final bool isSuccessful;
  const _StatusChip({required this.value, required this.isSuccessful});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final color = isSuccessful ? appColors.success : appColors.statusFailed;
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.38), width: 0.8.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          SizedBox(width: 5.w),
          Flexible(
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Custom painter ────────────────────────────────────────────────────────────

class _ResultIconPainter extends CustomPainter {
  final bool isSuccessful;
  final double circleProgress;
  final double iconProgress;
  final Color color;
  final double strokeWidth;

  const _ResultIconPainter({
    required this.isSuccessful,
    required this.circleProgress,
    required this.iconProgress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth;

    // Faint filled background circle
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = color.withValues(alpha: 0.10 * circleProgress),
    );

    // Animated circle arc (clockwise from top)
    if (circleProgress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * circleProgress,
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }

    if (iconProgress > 0) {
      if (isSuccessful) {
        _drawCheckmark(canvas, size);
      } else {
        _drawX(canvas, size);
      }
    }
  }

  void _drawCheckmark(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final p1 = Offset(w * 0.23, h * 0.52);
    final p2 = Offset(w * 0.41, h * 0.69);
    final p3 = Offset(w * 0.77, h * 0.33);

    final seg1 = (p2 - p1).distance;
    final seg2 = (p3 - p2).distance;
    final total = seg1 + seg2;
    final drawn = iconProgress * total;

    final path = Path()..moveTo(p1.dx, p1.dy);

    if (drawn <= seg1) {
      final t = drawn / seg1;
      path.lineTo(p1.dx + (p2.dx - p1.dx) * t, p1.dy + (p2.dy - p1.dy) * t);
    } else {
      path.lineTo(p2.dx, p2.dy);
      final t = (drawn - seg1) / seg2;
      path.lineTo(p2.dx + (p3.dx - p2.dx) * t, p2.dy + (p3.dy - p2.dy) * t);
    }

    canvas.drawPath(path, paint);
  }

  void _drawX(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;
    final m = w * 0.27;

    // First diagonal (top-left → bottom-right)
    final t1 = (iconProgress * 2).clamp(0.0, 1.0);
    canvas.drawLine(
      Offset(m, m),
      Offset(m + (w - 2 * m) * t1, m + (h - 2 * m) * t1),
      paint,
    );

    // Second diagonal (top-right → bottom-left)
    if (iconProgress > 0.5) {
      final t2 = ((iconProgress - 0.5) * 2).clamp(0.0, 1.0);
      canvas.drawLine(
        Offset(w - m, m),
        Offset(w - m - (w - 2 * m) * t2, m + (h - 2 * m) * t2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ResultIconPainter old) =>
      old.circleProgress != circleProgress || old.iconProgress != iconProgress;
}

// Kept for any external callers.
class PaymentInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isStatus;
  final bool isShowIcon;
  final bool isSuccessful;

  const PaymentInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isStatus = false,
    this.isShowIcon = false,
    this.isSuccessful = false,
  });

  @override
  Widget build(BuildContext context) {
    return _InfoRow(
      data: _RowData(
        label: label,
        value: value,
        isStatus: isStatus,
        isSuccessful: isSuccessful,
      ),
    );
  }
}
