import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_theme_ext.dart';

/// Skeletons for the two parts of Settings that resolve asynchronously: the
/// user card (`getUserInfo`) and the biometric row (`checkBiometricSupport`).
///
/// Both mirror the geometry of the widget they stand in for — same margin,
/// padding, radius and, crucially, the same tallest child (the 48.w avatar /
/// 38.w icon square) — so the card height is identical before and after the
/// swap and nothing below it jumps.
///
/// Authored the same way as `BeneficiaryShimmerView`: one [Shimmer] per card so
/// the highlight travels across it as a single light, and every placeholder is
/// written purely in alpha ([Shimmer] replaces the subtree's colour and keeps
/// its alpha) — bright blocks for primary content, faint ones for secondary and
/// for the card frame. That keeps the skeleton correct in both themes without
/// reading any colour token.
class SettingsUserBoxShimmer extends StatelessWidget {
  const SettingsUserBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _Sweep(
      child: Container(
        width: 1.sw,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: _frame(BorderRadius.circular(12.r)),
        child: Row(
          children: [
            // Initials avatar — the element that sets the card's height.
            _Block(width: 48, height: 48, radius: 24, alpha: 0.85),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name.
                  _Line(factor: 0.58, height: 13, alpha: 0.95),
                  SizedBox(height: 9.h),
                  // Status pill.
                  _Block(width: 58, height: 18, radius: 4, alpha: 0.45),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Stand-in for one [SettingsTile] — used for the biometric row while support
/// is still being probed, so the real tile fades in where the skeleton sat
/// instead of shoving the rest of the list down.
class SettingsTileShimmer extends StatelessWidget {
  const SettingsTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _Sweep(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: _frame(BorderRadius.circular(12.r)),
        child: Row(
          children: [
            // Leading icon square.
            _Block(width: 38, height: 38, radius: 10, alpha: 0.80),
            SizedBox(width: 14.w),
            Expanded(child: _Line(factor: 0.55, height: 11, alpha: 0.90)),
            SizedBox(width: 10.w),
            // Trailing control (switch / chevron).
            _Block(width: 34, height: 18, radius: 9, alpha: 0.40),
          ],
        ),
      ),
    );
  }
}

// ─── Primitives ───────────────────────────────────────────────────────────────

/// Faint card frame, so the skeleton keeps the page's rhythm of separate cards
/// instead of reading as one solid slab. Alpha-only (no shadow): a [BoxShadow]
/// inside a [Shimmer] subtree gets painted by the shader as a grey blob.
BoxDecoration _frame(BorderRadius radius) => BoxDecoration(
  borderRadius: radius,
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withValues(alpha: 0.20),
      Colors.white.withValues(alpha: 0.09),
    ],
  ),
  border: Border.all(color: Colors.white.withValues(alpha: 0.40), width: 0.8),
);

/// One shimmer sweep over a card's placeholders.
class _Sweep extends StatelessWidget {
  final Widget child;

  const _Sweep({required this.child});

  @override
  Widget build(BuildContext context) {
    final glass = context.appColors.glassBorder;

    return Shimmer.fromColors(
      baseColor: glass.withValues(alpha: 0.16),
      highlightColor: glass.withValues(alpha: 0.38),
      period: const Duration(milliseconds: 1400),
      child: child,
    );
  }
}

/// A placeholder block. Only its alpha matters — [Shimmer] paints the colour.
class _Block extends StatelessWidget {
  final double? width;
  final double height;
  final double radius;
  final double alpha;

  const _Block({
    this.width,
    required this.height,
    this.radius = 4,
    this.alpha = 1,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: width?.w,
    height: height.h,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: alpha),
      borderRadius: BorderRadius.circular(radius.r),
    ),
  );
}

/// A text-line placeholder sized as a fraction of its parent's width, aligned to
/// the reading direction so it mirrors in Arabic.
class _Line extends StatelessWidget {
  final double factor;
  final double height;
  final double alpha;

  const _Line({
    required this.factor,
    required this.height,
    required this.alpha,
  });

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
    alignment: AlignmentDirectional.centerStart,
    widthFactor: factor,
    child: _Block(height: height, alpha: alpha),
  );
}