import 'package:flutter/material.dart';

import 'app_semantic_colors.dart';
import 'app_theme.dart';
import 'app_typography.dart';

/// BuildContext shortcuts for the theme system.
///
/// Typography:
///   context.textTheme                — full Material TextTheme
///   context.typography.secondary     — 13sp w400  secondary body content
///   context.typography.secondaryMedium — 13sp w500  secondary emphasized
///   context.typography.subheading    — 15sp w500  sub-headings / subtitles
///   context.typography.numeric       — 22sp w700  financial amounts
///
/// Colors:
///   context.appColors.brandFill    — brand yellow (CTA / accent)
///   context.colorScheme.onSurface   — primary text
///   context.appColors.success       — semantic status green
///   context.appColors.muted         — muted / hint text
///   context.appColors.onAccent      — text on the accent fill
///   context.appGradient?.background — brand gradient
extension AppThemeExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ThemeData get appTheme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  AppSemanticColors get appColors =>
      Theme.of(this).extension<AppSemanticColors>()!;
  AppGradient? get appGradient =>
      Theme.of(this).extension<AppGradient>();
  AppTypographyTokens get typography => AppTypographyTokens.instance;

  /// Decoration for elevated "glass" panels (cards / form containers that
  /// float over the scaffold gradient): a low-alpha white gradient fill, a
  /// hairline border and a soft shadow.
  ///
  /// [borderColor] overrides the hairline (e.g. a selected accent border).
  /// [border] fully replaces the computed [Border.all] — pass it for partial
  /// borders (stacked top/bottom cards).
  BoxDecoration glassPanel({
    required BorderRadius borderRadius,
    double fillTop = 0.08,
    double fillBottom = 0.03,
    double hairline = 0.18,
    double shadowAlpha = 0.14,
    double shadowBlur = 14,
    Offset shadowOffset = const Offset(0, 5),
    Color? borderColor,
    BoxBorder? border,
  }) {
    final colors = appColors;
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          colors.glass.withValues(alpha: fillTop),
          colors.glass.withValues(alpha: fillBottom),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: borderRadius,
      border: border ??
          Border.all(
            color: borderColor ?? colors.glassBorder.withValues(alpha: hairline),
            width: 0.8,
          ),
      boxShadow: [
        BoxShadow(
          color: colors.shadowInk.withValues(alpha: shadowAlpha),
          blurRadius: shadowBlur,
          offset: shadowOffset,
        ),
      ],
    );
  }
}
