import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';

import '../theme/app_theme_ext.dart';

// Re-exported so callers can pin a step's tooltip position (e.g. force a
// bottom-edge target's card above it) without importing showcaseview directly.
export 'package:showcaseview/showcaseview.dart' show TooltipPosition;

/// Position of the active step within the running tour, or `null` when no tour
/// is active. Driven by `useShowcaseTour` and read by the tooltip card so it
/// can render the "n of m" indicator and decide the Back/Next labels.
final ValueNotifier<({int index, int total})?> showcaseProgress =
ValueNotifier(null);

/// A brand-styled coach-mark target.
///
/// Wrap any widget you want to spotlight during a guided tour with this. The
/// tour itself is driven by `useShowcaseTour`, which registers the controller
/// and starts the sequence; this widget only describes a single step.
///
/// The tooltip is a fully custom [_ShowcaseCard] — elevated brand surface, a
/// tertiary accent bar, a step icon, a progress indicator and Back / Next
/// actions — built entirely from the shared theme so it drops into any project
/// using the same theme extensions unchanged.
class AppShowcase extends StatelessWidget {
  const AppShowcase({
    super.key,
    required this.showcaseKey,
    required this.title,
    required this.description,
    required this.child,
    this.icon = Icons.touch_app_rounded,
    this.targetBorderRadius,
    this.targetPadding = const EdgeInsets.all(6),
    this.tooltipPosition,
  });

  /// The [GlobalKey] that identifies this step. Pass the same key, in order, to
  /// `useShowcaseTour`'s `steps` list.
  final GlobalKey showcaseKey;

  /// Bold heading shown at the top of the card.
  final String title;

  /// Supporting copy shown beneath the [title].
  final String description;

  /// Icon shown in the accent badge next to the title.
  final IconData icon;

  /// The widget being spotlighted.
  final Widget child;

  /// Border radius of the spotlight cut-out. Defaults to a 12.r rounded rect.
  final BorderRadius? targetBorderRadius;

  /// Padding between the target and the spotlight edge.
  final EdgeInsets targetPadding;

  /// Force the tooltip above/below the target. Leave null to auto-position.
  final TooltipPosition? tooltipPosition;

  @override
  Widget build(BuildContext context) {
    // showcaseview positions the tooltip against the full screen using a single
    // symmetric edge margin and has no notion of system insets. Feed it the
    // largest safe-area inset so the card is never tucked under the status bar
    // (top) or the navigation/gesture bar (bottom). Read straight from the
    // FlutterView so it is immune to any MediaQuery overrides in the tree.
    final view = View.of(context);
    final safeInset =
        math.max(view.viewPadding.top, view.viewPadding.bottom) /
        view.devicePixelRatio;

    return Showcase.withWidget(
      key: showcaseKey,
      tooltipPosition: tooltipPosition,
      targetPadding: targetPadding,
      targetBorderRadius: targetBorderRadius ?? BorderRadius.circular(12.r),
      overlayColor: Colors.black,
      overlayOpacity: 0.74,
      disableBarrierInteraction: true,
      toolTipMargin: 12 + safeInset,
      container: _ShowcaseCard(
        icon: icon,
        title: title,
        description: description,
      ),
      child: child,
    );
  }
}

/// The premium branded tooltip card.
class _ShowcaseCard extends StatelessWidget {
  const _ShowcaseCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300.w),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: cs.tertiary.withValues(alpha: 0.30),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: context.appColors.shadowInk.withValues(alpha: 0.38,),
                blurRadius: 26,
                spreadRadius: -4,
                offset: Offset(0, 12.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            // Stack (not IntrinsicHeight + Row) so the full-height accent bar
            // works even when the content scrolls. IntrinsicHeight is
            // incompatible with the scroll view below and was forcing the card
            // to its full natural height — overflowing when showcaseview gave
            // the tooltip a tight maxHeight (the "overflowed by 36px" error).
            child: Stack(
              children: [
                // Content scrolls instead of overflowing when the available
                // tooltip height is smaller than the natural card height.
                Padding(
                  padding: EdgeInsets.fromLTRB(14.w + 4.w, 14.h, 14.w, 12.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(7.w),
                              decoration: BoxDecoration(
                                color: cs.tertiary.withValues(alpha: 0.16),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                icon,
                                size: 16.sp,
                                color: cs.tertiary,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                title,
                                style: context.typography.subheading.copyWith(
                                  color: cs.onPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        const _StepIndicator(),
                        SizedBox(height: 10.h),
                        Text(
                          description,
                          style: context.typography.secondary.copyWith(
                            color: context.appColors.muted,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        const _ShowcaseActions(),
                      ],
                    ),
                  ),
                ),
                // Tertiary accent bar pinned to the leading edge, stretched to
                // the full card height by the top/bottom anchors.
                PositionedDirectional(
                  start: 0,
                  top: 0,
                  bottom: 0,
                  child: SizedBox(width: 4.w, child: ColoredBox(color: cs.tertiary)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Row of dots + "n / m" fraction for the current step.
class _StepIndicator extends StatelessWidget {
  const _StepIndicator();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ValueListenableBuilder<({int index, int total})?>(
      valueListenable: showcaseProgress,
      builder: (context, progress, _) {
        final total = progress?.total ?? 0;
        final index = progress?.index ?? 0;
        if (total <= 1) return const SizedBox.shrink();

        return Row(
          children: [
            for (int i = 0; i < total; i++)
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: i == index ? 16.w : 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: i == index
                        ? cs.tertiary
                        : context.appColors.glass.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
            const Spacer(),
            Text(
              '${index + 1} / $total',
              style: context.typography.secondary.copyWith(
                color: context.appColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Back / Next (or Done) controls, wired to the active showcase controller.
class _ShowcaseActions extends StatelessWidget {
  const _ShowcaseActions();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<({int index, int total})?>(
      valueListenable: showcaseProgress,
      builder: (context, progress, _) {
        final total = progress?.total ?? 1;
        final index = progress?.index ?? 0;
        final isFirst = index <= 0;
        final isLast = index >= total - 1;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isFirst)
              _GhostButton(
                label: 'showcase.actions.back'.tr(),
                onTap: () => ShowcaseView.get().previous(),
              )
            else
              const SizedBox.shrink(),
            _AccentButton(
              label: isLast
                  ? 'showcase.actions.done'.tr()
                  : 'showcase.actions.next'.tr(),
              showArrow: !isLast,
              onTap: () => ShowcaseView.get().next(force: true),
            ),
          ],
        );
      },
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Text(
          label,
          style: context.typography.secondaryMedium.copyWith(
            color: context.appColors.muted,
          ),
        ),
      ),
    );
  }
}

class _AccentButton extends StatelessWidget {
  const _AccentButton({
    required this.label,
    required this.onTap,
    this.showArrow = true,
  });

  final String label;
  final VoidCallback onTap;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: context.appColors.brandFill,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: cs.tertiary.withValues(alpha: 0.30),
              blurRadius: 12,
              spreadRadius: -2,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: context.typography.secondaryMedium.copyWith(
                color: context.appColors.onAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (showArrow) ...[
              SizedBox(width: 6.w),
              Icon(
                Icons.arrow_forward_rounded,
                size: 15.sp,
                color: context.appColors.onAccent,
              ),
            ],
          ],
        ),
      ),
    );
  }
}