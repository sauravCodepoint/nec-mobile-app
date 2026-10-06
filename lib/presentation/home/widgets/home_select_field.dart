import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/shimmer/app_shimmer.dart';
import '../../core/theme/app_theme_ext.dart';

/// A single selector row of the home Send Money form.
///
/// Every selector in the section (receive country, transfer type, bank / agent,
/// agent) renders through this one widget so they read as one control set. They
/// used to each carry their own look — the receive country was a filled
/// caption-over-value box while the rest were Material outlined fields with
/// floating labels — which made a stack of them look like controls borrowed
/// from different screens.
///
/// The row is: a fixed leading slot (a country flag, or the [icon] in a tinted
/// brand chip), an uppercase caption, the current value (or [placeholder] in
/// muted ink), an optional accent [badge] and the "tap to change" caret. Rows
/// carry no border of their own — [HomeSelectFieldGroup] draws the single
/// surrounding panel and the hairlines between them.
class HomeSelectField extends StatelessWidget {
  /// Leading visual for the row, e.g. a country flag. When null the [icon] is
  /// drawn inside a tinted brand chip instead.
  final Widget? leading;

  /// Fallback leading glyph, used whenever [leading] is null.
  final IconData icon;

  /// Caption above the value. Rendered uppercase.
  final String label;

  /// The current selection. Empty or null renders [placeholder] in muted ink.
  final String? value;

  /// Shown in place of [value] while nothing is selected.
  final String placeholder;

  /// Optional accent chip pinned just before the caret — the destination
  /// currency code on the receive-country row.
  final String? badge;

  /// False when there is nothing to open (empty list, or a single option that
  /// was auto-selected upstream). The caret and the ripple are both dropped so
  /// the row never implies a control that can't be opened.
  final bool enabled;

  final VoidCallback? onTap;

  const HomeSelectField({
    super.key,
    this.leading,
    required this.icon,
    required this.label,
    required this.value,
    required this.placeholder,
    this.badge,
    this.enabled = true,
    this.onTap,
  });

  /// Width of the leading slot. [HomeSelectFieldGroup] indents its hairlines by
  /// this much (plus the row's own padding) so the dividers start under the
  /// text column, the way a grouped list reads.
  static const double leadingExtent = 38;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final colors = context.appColors;

    final text = (value ?? '').trim();
    final hasValue = text.isNotEmpty;
    final badgeText = (badge ?? '').trim();

    final row = Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      child: Row(
        children: [
          SizedBox(
            width: leadingExtent.w,
            height: leadingExtent.w,
            child: leading != null
                ? Center(child: leading)
                : Container(
                    decoration: BoxDecoration(
                      color: colors.brandFill.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(11.r),
                    ),
                    child: Icon(icon, size: 18.sp, color: cs.tertiary),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: colors.muted,
                    letterSpacing: 0.6,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  hasValue ? text : placeholder,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: hasValue ? FontWeight.w700 : FontWeight.w500,
                    color: hasValue ? cs.onSurface : colors.muted,
                    letterSpacing: 0.1,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          if (badgeText.isNotEmpty) ...[
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: colors.brandFill.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: colors.brandFill.withValues(alpha: 0.30),
                  width: 0.8,
                ),
              ),
              child: Text(
                badgeText,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  color: cs.tertiary,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
          if (enabled) ...[
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 22.sp,
              color: cs.tertiary,
            ),
          ],
        ],
      ),
    );

    return Semantics(
      button: enabled,
      label:
          '$label, ${hasValue ? text : placeholder}'
          '${badgeText.isNotEmpty ? ', $badgeText' : ''}',
      child: enabled
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: cs.tertiary.withValues(alpha: 0.09),
                highlightColor: cs.tertiary.withValues(alpha: 0.04),
                child: row,
              ),
            )
          : row,
    );
  }
}

/// The single panel holding the Send Money selector rows.
///
/// One elevated glass surface with hairlines between the rows, rather than a
/// stack of individually bordered fields — the selections read as one step, and
/// the section loses a level of box-in-box nesting.
class HomeSelectFieldGroup extends StatelessWidget {
  final List<Widget> children;

  const HomeSelectFieldGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.r);

    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) rows.add(const _RowDivider());
      rows.add(children[i]);
    }

    return DecoratedBox(
      decoration: context.glassPanel(
        borderRadius: borderRadius,
        fillTop: 0.09,
        fillBottom: 0.03,
        hairline: 0.18,
        shadowAlpha: 0.18,
        shadowBlur: 16,
        shadowOffset: Offset(0, 6.h),
      ),
      // Rounds the rows' ink ripples to the panel.
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Column(mainAxisSize: MainAxisSize.min, children: rows),
      ),
    );
  }
}

/// Hairline between two selector rows, indented past the leading slot so it
/// starts under the text column instead of cutting the panel in half.
class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 12.w + HomeSelectField.leadingExtent.w + 12.w,
      ),
      child: Container(
        height: 1,
        color: context.appColors.glassBorder.withValues(alpha: 0.12),
      ),
    );
  }
}

/// Placeholder for a selector row whose list is still resolving. Mirrors the
/// row's own geometry (leading chip, caption line, value line) so the panel
/// doesn't resize when the real row lands.
class HomeSelectFieldShimmer extends StatelessWidget {
  const HomeSelectFieldShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      child: Row(
        children: [
          AppShimmer(
            width: HomeSelectField.leadingExtent,
            height: HomeSelectField.leadingExtent,
            borderRadius: BorderRadius.circular(11.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(width: 84, height: 9),
                SizedBox(height: 7.h),
                AppShimmer(width: 140, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
