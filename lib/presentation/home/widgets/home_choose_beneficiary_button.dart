import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_theme_ext.dart';

/// Primary home CTA that moves the user from the send-money form (destination +
/// transfer type) into the beneficiary-selection step. Two states only:
///
/// * [_CtaState.idle] — a required selection is still missing; the button keeps
///   its real label but goes muted, and the missing input is spelled out in a
///   hint line directly above it. (It used to wear that sentence as its own
///   label, which read as a disabled panel rather than a button.) Tapping it
///   still surfaces the same message as a toast.
/// * [_CtaState.ready] — everything's set; the button becomes a confident
///   accent CTA that reads as "pick who receives the money".
///
/// There is no calculating state — home no longer computes a rate.
enum _CtaState { idle, ready }

class HomeChooseBeneficiaryButton extends HookWidget {
  final bool isReady;
  final VoidCallback? onTap;
  final VoidCallback? onIdleTap;

  /// Message describing the next required input (e.g. "Please select a transfer
  /// type to continue"), shown as the hint line above the idle button. Falls
  /// back to a generic prompt when null.
  final String? idleLabel;

  const HomeChooseBeneficiaryButton({
    super.key,
    required this.isReady,
    this.onTap,
    this.onIdleTap,
    this.idleLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final ctaState = isReady ? _CtaState.ready : _CtaState.idle;

    // One-shot mount
    final mountCtrl = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    useEffect(() {
      final timer = Timer(const Duration(milliseconds: 100), mountCtrl.forward);
      return timer.cancel;
    }, const []);

    final pressCtrl = useAnimationController(
      duration: const Duration(milliseconds: 75),
      reverseDuration: const Duration(milliseconds: 280),
    );
    final glowCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1800),
    );
    // 3200ms cycle — sweep in first 30%, rest 70%
    final shimmerCtrl = useAnimationController(
      duration: const Duration(milliseconds: 3200),
    );

    useEffect(() {
      switch (ctaState) {
        case _CtaState.ready:
          glowCtrl.repeat(reverse: true);
          shimmerCtrl.repeat();
        case _CtaState.idle:
          glowCtrl
            ..stop()
            ..value = 0.0;
          shimmerCtrl.stop();
          pressCtrl.reverse();
      }
      return null;
    }, [ctaState]);

    final mountAnim = useMemoized(
      () => CurvedAnimation(parent: mountCtrl, curve: Curves.easeOutCubic),
      const [],
    );
    final pressScale = useMemoized(
      () => Tween<double>(
        begin: 1.0,
        end: 0.962,
      ).animate(CurvedAnimation(parent: pressCtrl, curve: Curves.easeOut)),
      const [],
    );
    final glowAnim = useMemoized(
      () => Tween<double>(
        begin: 0.22,
        end: 1.0,
      ).animate(CurvedAnimation(parent: glowCtrl, curve: Curves.easeInOut)),
      const [],
    );
    final arrowOffset = useMemoized(
      () => Tween<double>(
        begin: 0.0,
        end: 8.0,
      ).animate(CurvedAnimation(parent: pressCtrl, curve: Curves.easeOut)),
      const [],
    );

    // Brand fill (the logo yellow) and its contrasting ink.
    final primary = context.appColors.brandFill;
    final onPrimary = colorScheme.primary;
    // Matches AppButton's geometry (8.r radius / 55.w height) so the two
    // primary CTAs read as the same control.
    final borderRadius = BorderRadius.circular(8.r);

    final button = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: ctaState == _CtaState.ready
          ? (_) {
              pressCtrl.forward();
              HapticFeedback.mediumImpact();
            }
          : (_) => HapticFeedback.lightImpact(),
      onTapUp: ctaState == _CtaState.ready
          ? (_) {
              pressCtrl.reverse();
              onTap?.call();
            }
          : (_) => onIdleTap?.call(),
      onTapCancel: ctaState == _CtaState.ready
          ? () => pressCtrl.reverse()
          : null,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: Listenable.merge([pressCtrl, glowCtrl, shimmerCtrl]),
          builder: (context, child) {
            final g = glowAnim.value;
            final sweepT = (shimmerCtrl.value / 0.30).clamp(0.0, 1.0);
            final shimmerOpacity = ctaState == _CtaState.ready
                ? (1.0 - (2.0 * sweepT - 1.0).abs()).clamp(0.0, 1.0) * 0.22
                : 0.0;

            // Each state gets its own gradient personality
            final (Color c0, Color c1) = switch (ctaState) {
              _CtaState.ready => (
                primary,
                Color.lerp(primary, Colors.black, 0.12)!,
              ),
              _CtaState.idle => (
                context.appColors.glass.withValues(alpha: 0.10),
                context.appColors.glass.withValues(alpha: 0.05),
              ),
            };

            return Transform.scale(
              scale: pressScale.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: g * 0.28),
                      blurRadius: 22,
                      spreadRadius: -2,
                      offset: Offset(0, 6.h),
                    ),
                  ],
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 420),
                  curve: Curves.easeInOut,
                  width: double.infinity,
                  height: 55.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [c0, c1],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: borderRadius,
                    border: ctaState == _CtaState.idle
                        ? Border.all(
                            color: context.appColors.glassBorder.withValues(
                              alpha: 0.22,
                            ),
                            width: 0.8,
                          )
                        : Border.all(
                            color: onPrimary.withValues(alpha: 0.15),
                            width: 0.8,
                          ),
                  ),
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: Stack(
                      children: [
                        // Top-edge gloss highlight (ready only)
                        if (ctaState == _CtaState.ready)
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: 28.h,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    context.appColors.glass.withValues(
                                      alpha: 0.13,
                                    ),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        // Shimmer sweep
                        Positioned.fill(
                          child: Opacity(
                            opacity: shimmerOpacity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(-2.5 + sweepT * 5.5, -0.3),
                                  end: Alignment(-1.0 + sweepT * 5.5, 0.3),
                                  colors: [
                                    Colors.transparent,
                                    context.colorScheme.onPrimary,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Content — the label is the same in both states; only
                        // its ink changes, so the control always reads as the
                        // "Choose Beneficiary" button rather than swapping into
                        // a sentence when something is missing.
                        Center(
                          child: _CtaLabel(
                            arrowOffset: arrowOffset.value,
                            foreground: ctaState == _CtaState.ready
                                ? onPrimary
                                : context.appColors.muted,
                            chipFill: ctaState == _CtaState.ready
                                ? onPrimary.withValues(alpha: 0.15)
                                : context.appColors.glass.withValues(
                                    alpha: 0.10,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    return AnimatedBuilder(
      animation: mountCtrl,
      builder: (_, child) => Opacity(
        opacity: mountAnim.value,
        child: Transform.translate(
          offset: Offset(0, 16.h * (1.0 - mountAnim.value)),
          child: child,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Collapses to zero height the moment everything is selected, so the
          // ready state is just the button with nothing hanging above it.
          AnimatedSize(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            alignment: Alignment.bottomCenter,
            child: ctaState == _CtaState.idle
                ? _IdleHint(label: idleLabel)
                : const SizedBox(width: double.infinity),
          ),
          button,
        ],
      ),
    );
  }
}

/// The "what's still missing" line above the idle button. Deliberately quiet —
/// an outline icon and muted copy — so it guides without competing with the
/// CTA underneath.
class _IdleHint extends StatelessWidget {
  final String? label;
  const _IdleHint({this.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final text = (label != null && label!.isNotEmpty)
        ? label!
        : 'home.chooseBeneficiaryCta.idle'.tr();

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 15.sp, color: colors.muted),
          SizedBox(width: 7.w),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: colors.muted,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaLabel extends StatelessWidget {
  final double arrowOffset;
  final Color foreground;
  final Color chipFill;

  const _CtaLabel({
    required this.arrowOffset,
    required this.foreground,
    required this.chipFill,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Keeps the row off the pill's rounded ends on narrow screens, and gives
      // the label's scale-down something to work against.
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Leading beneficiary icon badge — signals "pick a recipient"
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: chipFill,
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Center(
              child: Icon(
                Icons.person_search_rounded,
                color: foreground,
                size: 14.sp,
              ),
            ),
          ),
          SizedBox(width: 9.w),
          Flexible(
            // A notch under AppButton's 16.sp: this row also carries the badge
            // and the arrow, so the same size read oversized next to the rest
            // of the card. FittedBox scales longer locales down instead of
            // letting them ellipsize or overflow.
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'home.chooseBeneficiaryCta.button'.tr(),
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Transform.translate(
            offset: Offset(arrowOffset, 0),
            child: Icon(
              Icons.arrow_forward_rounded,
              color: foreground.withValues(alpha: 0.85),
              size: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
