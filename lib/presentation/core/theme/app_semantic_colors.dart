import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

/// Semantic color tokens exposed as a ThemeExtension.
///
/// Access in widgets via:
///   context.appColors.success
///   context.appColors.muted
///   context.appColors.onAccent
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  // ── Status: Success ────────────────────────────────────────────────────────
  final Color success;
  final Color onSuccess;
  final Color successDark;
  final Color successSubtle;

  // ── Status: Warning ────────────────────────────────────────────────────────
  final Color warning;
  final Color onWarning;
  final Color warningSubtle;

  // ── Status: Info ──────────────────────────────────────────────────────────
  final Color info;
  final Color onInfo;
  final Color infoSubtle;
  final Color infoBright; // brighter info — use for icons/accents on dark or colored surfaces

  // ── Status: Error ─────────────────────────────────────────────────────────
  final Color error;
  final Color onError;
  final Color errorDark;
  final Color errorSubtle;

  // ── Transaction States ────────────────────────────────────────────────────
  final Color statusInitiated; // blue — just kicked off
  final Color statusPending; // orange — awaiting action
  final Color statusProcessing; // brand yellow — in progress
  final Color statusFailed; // red — terminal failure
  final Color statusUnknown; // muted — unknown state

  // ── UI Tokens ─────────────────────────────────────────────────────────────
  final Color muted; // placeholder / hint / secondary text
  final Color border; // default thin border
  final Color glass; // white ink behind translucent "glass" FILLS (never for text)
  final Color glassBorder; // white ink for glass hairline borders / dividers
  final Color shadow; // box-shadow tint (alpha baked in)
  final Color shadowInk; // base ink for BoxShadow colors — call sites apply
  // their own alpha
  final Color onAccent; // text / icons drawn ON the accent fill (black on yellow)
  final Color brandFill; // solid brand-yellow #FFD503 for FILLED buttons/CTAs
  // (matches the client logo yellow)
  final Color onBrandFill; // dark ink drawn ON brandFill (readable on yellow)
  final Color containerBackground; // deep container / overlay background

  const AppSemanticColors({
    required this.success,
    required this.onSuccess,
    required this.successDark,
    required this.successSubtle,
    required this.warning,
    required this.onWarning,
    required this.warningSubtle,
    required this.info,
    required this.onInfo,
    required this.infoSubtle,
    required this.infoBright,
    required this.error,
    required this.onError,
    required this.errorDark,
    required this.errorSubtle,
    required this.statusInitiated,
    required this.statusPending,
    required this.statusProcessing,
    required this.statusFailed,
    required this.statusUnknown,
    required this.muted,
    required this.border,
    required this.glass,
    required this.glassBorder,
    required this.shadow,
    required this.shadowInk,
    required this.onAccent,
    required this.brandFill,
    required this.onBrandFill,
    required this.containerBackground,
  });

  /// Rotating palette for notification / category dot indicators (5 entries).
  List<Color> get notificationCategoryColors => [
    info,
    success,
    warning,
    error,
    AppColors.warningLight,
  ];

  // ── Pre-built instance ────────────────────────────────────────────────────
  //
  // Dark only: the app has no light theme, so there is a single instance. The
  // [copyWith]/[lerp] boilerplate below stays — ThemeExtension requires it.

  static const dark = AppSemanticColors(
    success: AppColors.success,
    onSuccess: AppColors.brandWhite,
    successDark: AppColors.successDark,
    successSubtle: Color(0xFF1A3A2A),
    warning: AppColors.warning,
    onWarning: AppColors.brandBlack,
    warningSubtle: Color(0xFF3A2D0A),
    info: AppColors.info,
    onInfo: AppColors.brandWhite,
    infoSubtle: Color(0xFF0A1A3A),
    infoBright: AppColors.infoLight,
    error: AppColors.error,
    onError: AppColors.brandWhite,
    errorDark: AppColors.errorDark,
    errorSubtle: Color(0xFF3A0D15),
    statusInitiated: AppColors.infoLight,
    statusPending: AppColors.warningLight,
    statusProcessing: AppColors.brandYellow,
    statusFailed: AppColors.errorLight,
    statusUnknown: AppColors.brandMuted,
    muted: AppColors.brandMuted,
    border: AppColors.brandMid,
    glass: AppColors.brandWhite,
    glassBorder: AppColors.brandWhite,
    shadow: Color(0x33000000),
    shadowInk: Color(0xFF000000),
    onAccent: AppColors.brandBlack,
    brandFill: AppColors.brandYellow,
    onBrandFill: AppColors.brandBlack,
    containerBackground: AppColors.brandDeep,
  );

  // ── ThemeExtension boilerplate ────────────────────────────────────────────

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successDark,
    Color? successSubtle,
    Color? warning,
    Color? onWarning,
    Color? warningSubtle,
    Color? info,
    Color? onInfo,
    Color? infoSubtle,
    Color? infoBright,
    Color? error,
    Color? onError,
    Color? errorDark,
    Color? errorSubtle,
    Color? statusInitiated,
    Color? statusPending,
    Color? statusProcessing,
    Color? statusFailed,
    Color? statusUnknown,
    Color? muted,
    Color? border,
    Color? glass,
    Color? glassBorder,
    Color? shadow,
    Color? shadowInk,
    Color? onAccent,
    Color? brandFill,
    Color? onBrandFill,
    Color? containerBackground,
  }) => AppSemanticColors(
    success: success ?? this.success,
    onSuccess: onSuccess ?? this.onSuccess,
    successDark: successDark ?? this.successDark,
    successSubtle: successSubtle ?? this.successSubtle,
    warning: warning ?? this.warning,
    onWarning: onWarning ?? this.onWarning,
    warningSubtle: warningSubtle ?? this.warningSubtle,
    info: info ?? this.info,
    onInfo: onInfo ?? this.onInfo,
    infoSubtle: infoSubtle ?? this.infoSubtle,
    infoBright: infoBright ?? this.infoBright,
    error: error ?? this.error,
    onError: onError ?? this.onError,
    errorDark: errorDark ?? this.errorDark,
    errorSubtle: errorSubtle ?? this.errorSubtle,
    statusInitiated: statusInitiated ?? this.statusInitiated,
    statusPending: statusPending ?? this.statusPending,
    statusProcessing: statusProcessing ?? this.statusProcessing,
    statusFailed: statusFailed ?? this.statusFailed,
    statusUnknown: statusUnknown ?? this.statusUnknown,
    muted: muted ?? this.muted,
    border: border ?? this.border,
    glass: glass ?? this.glass,
    glassBorder: glassBorder ?? this.glassBorder,
    shadow: shadow ?? this.shadow,
    shadowInk: shadowInk ?? this.shadowInk,
    onAccent: onAccent ?? this.onAccent,
    brandFill: brandFill ?? this.brandFill,
    onBrandFill: onBrandFill ?? this.onBrandFill,
    containerBackground: containerBackground ?? this.containerBackground,
  );

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successDark: Color.lerp(successDark, other.successDark, t)!,
      successSubtle: Color.lerp(successSubtle, other.successSubtle, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningSubtle: Color.lerp(warningSubtle, other.warningSubtle, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      infoSubtle: Color.lerp(infoSubtle, other.infoSubtle, t)!,
      infoBright: Color.lerp(infoBright, other.infoBright, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorDark: Color.lerp(errorDark, other.errorDark, t)!,
      errorSubtle: Color.lerp(errorSubtle, other.errorSubtle, t)!,
      statusInitiated: Color.lerp(statusInitiated, other.statusInitiated, t)!,
      statusPending: Color.lerp(statusPending, other.statusPending, t)!,
      statusProcessing: Color.lerp(
        statusProcessing,
        other.statusProcessing,
        t,
      )!,
      statusFailed: Color.lerp(statusFailed, other.statusFailed, t)!,
      statusUnknown: Color.lerp(statusUnknown, other.statusUnknown, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      border: Color.lerp(border, other.border, t)!,
      glass: Color.lerp(glass, other.glass, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      shadowInk: Color.lerp(shadowInk, other.shadowInk, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      brandFill: Color.lerp(brandFill, other.brandFill, t)!,
      onBrandFill: Color.lerp(onBrandFill, other.onBrandFill, t)!,
      containerBackground: Color.lerp(containerBackground, other.containerBackground, t)!,
    );
  }
}
