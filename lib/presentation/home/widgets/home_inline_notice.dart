import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_theme_ext.dart';

/// Semantic flavour of a [HomeInlineNotice], mapped onto the theme's semantic
/// status palette so both themes resolve correctly.
enum HomeNoticeType {
  /// Something worth knowing, nothing is wrong (e.g. "only one transfer type").
  info,

  /// A dead end the user has to route around, not retry (e.g. the corridor
  /// offers no transfer mode at all).
  warning,

  /// A request failed and can be retried.
  error,
}

/// The home screen's inline, in-place notice card.
///
/// Used for everything the page needs to say about a *section* rather than the
/// whole screen: a single-option explanation, a corridor with nothing to offer,
/// or an API that failed and can be retried. It sits in the layout where the
/// affected content would be, so the message is attached to the thing it is
/// about — unlike a toast, which is gone in three seconds and leaves the user
/// looking at a form that silently refuses to continue.
///
/// Layout is a tinted surface with a matching hairline, an icon chip, an
/// uppercase eyebrow, the message, and (for retryable failures) a compact
/// action pill. Passing [onAction] without [actionLabel] — or vice versa —
/// draws no button.
class HomeInlineNotice extends StatelessWidget {
  final HomeNoticeType type;

  /// Glyph for the icon chip.
  final IconData icon;

  /// Short uppercase eyebrow above the message.
  final String label;

  /// The body copy. Full sentences — this is the only explanation the user gets.
  final String message;

  /// Label of the action pill, e.g. "Retry".
  final String? actionLabel;

  /// Tapped handler for the action pill. Omit for notices nothing can be done
  /// about (a corridor with no options: retrying returns the same answer).
  final VoidCallback? onAction;

  /// Glyph on the action pill, ahead of its label.
  final IconData actionIcon;

  /// Outer padding. Defaults to the home page's section gutter.
  final EdgeInsetsGeometry? padding;

  const HomeInlineNotice({
    super.key,
    required this.type,
    required this.icon,
    required this.label,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.actionIcon = Icons.refresh_rounded,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colors = context.appColors;

    // `surface` is the tinted card, `accent` the ink drawn on it (border, icon
    // and eyebrow) — all theme-resolved tokens, so each reads correctly on both
    // canvases. The action pill takes its own fill/ink pair rather than reusing
    // `accent`: the dark theme's `error` is a muted rose that white text sits
    // poorly on, so the pill uses the same `errorDark` + `onError` pairing the
    // shared AppErrorView retry button already uses.
    final (Color surface, Color accent, Color actionFill, Color actionInk) =
        switch (type) {
      HomeNoticeType.info => (
        colors.infoSubtle,
        colors.infoBright,
        colors.info,
        colors.onInfo,
      ),
      HomeNoticeType.warning => (
        colors.warningSubtle,
        colors.warning,
        colors.warning,
        colors.onWarning,
      ),
      HomeNoticeType.error => (
        colors.errorSubtle,
        colors.error,
        colors.errorDark,
        colors.onError,
      ),
    };

    final showAction = actionLabel != null && onAction != null;

    return Padding(
      padding: padding ?? EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: accent.withValues(alpha: 0.28),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon chip — anchors the message and gives the card a purposeful,
            // branded focal point.
            Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, size: 16.sp, color: accent),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: textTheme.bodySmall?.copyWith(
                      color: accent,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    message,
                    style: textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 12.sp,
                      height: 1.35,
                    ),
                  ),
                  if (showAction) ...[
                    SizedBox(height: 10.h),
                    _NoticeAction(
                      label: actionLabel!,
                      icon: actionIcon,
                      fill: actionFill,
                      ink: actionInk,
                      onTap: onAction!,
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

/// Compact solid action pill for [HomeInlineNotice].
///
/// Solid accent fill with its paired ink rather than an alpha-faded tint: over
/// the light theme's near-white canvas a faded fill lightens and glares, and a
/// retry the user cannot pick out is a retry they won't tap.
class _NoticeAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color fill;
  final Color ink;
  final VoidCallback onTap;

  const _NoticeAction({
    required this.label,
    required this.icon,
    required this.fill,
    required this.ink,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(9.r);

    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: fill,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14.sp, color: ink),
                SizedBox(width: 6.w),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: ink,
                    letterSpacing: 0.2,
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
