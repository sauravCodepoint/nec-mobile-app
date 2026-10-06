import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_theme_ext.dart';

/// Skeleton shown while `getContactDetails` resolves, in place of the old
/// full-screen [AppOverlayLoading] spinner.
///
/// Authored the same way as `SettingsUserBoxShimmer`: one [Shimmer] per card so
/// the highlight travels across each surface as a single light, and every
/// placeholder written purely in alpha ([Shimmer] replaces the subtree's colour
/// and keeps its alpha) — bright blocks for primary content, faint ones for
/// secondary and for the card frame. That keeps it correct in both themes
/// without reading a colour token.
///
/// The geometry mirrors `_SupportContent` element for element — same page
/// padding, the same 24.w hero card with its 66.w icon square, the same 46.w
/// icon in each 16.w-padded contact card, and text bars boxed at the real
/// line heights — so the payload swaps in without the layout shifting.
class SupportShimmerView extends StatelessWidget {
  /// Contact cards to draw. Phone, WhatsApp and email each depend on what the
  /// backend enables, so the skeleton assumes the common case of all three.
  final int cardCount;

  const SupportShimmerView({super.key, this.cardCount = 3});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),

          // ── Hero card ───────────────────────────────────────────────────
          const _HeroSkeleton(),

          SizedBox(height: 34.h),

          // ── "Contact Us" section title (titleMedium, 16.sp) ─────────────
          const _Sweep(
            child: _TextLine(lineHeight: 19, barHeight: 13, factor: 0.32),
          ),

          SizedBox(height: 18.h),

          // ── Contact cards ───────────────────────────────────────────────
          for (var i = 0; i < cardCount; i++) ...[
            const _CardSkeleton(),
            if (i != cardCount - 1) SizedBox(height: 16.h),
          ],

          SizedBox(height: 42.h),

          // ── Footer instruction (bodySmall, 12.sp, centred, ~3 lines) ────
          const _Sweep(
            child: Column(
              children: [
                _TextLine(
                  lineHeight: 15,
                  barHeight: 10,
                  factor: 0.92,
                  alpha: 0.45,
                  alignment: Alignment.center,
                ),
                _TextLine(
                  lineHeight: 15,
                  barHeight: 10,
                  factor: 0.88,
                  alpha: 0.45,
                  alignment: Alignment.center,
                ),
                _TextLine(
                  lineHeight: 15,
                  barHeight: 10,
                  factor: 0.46,
                  alpha: 0.45,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

// ─── Skeleton pieces ─────────────────────────────────────────────────────────

/// Stand-in for the gradient hero panel: floating icon square, headline and a
/// two-line description.
class _HeroSkeleton extends StatelessWidget {
  const _HeroSkeleton();

  @override
  Widget build(BuildContext context) {
    return _Sweep(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: _frame(BorderRadius.circular(18.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The support-agent badge — the element that anchors the card's
            // height.
            const _Block(width: 66, height: 66, radius: 22, alpha: 0.85),
            SizedBox(height: 24.h),
            // 'support.subtitle' — titleLarge @16.sp, w800.
            const _TextLine(lineHeight: 19, barHeight: 14, factor: 0.34),
            SizedBox(height: 10.h),
            // 'support.description' — bodyMedium @14.sp, height 1.5.
            const _TextLine(
              lineHeight: 21,
              barHeight: 11,
              factor: 1,
              alpha: 0.5,
            ),
            const _TextLine(
              lineHeight: 21,
              barHeight: 11,
              factor: 0.62,
              alpha: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}

/// Stand-in for one `_AnimatedSupportCard`: icon square, title, subtitle and the
/// trailing chevron.
class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton();

  @override
  Widget build(BuildContext context) {
    return _Sweep(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: _frame(BorderRadius.circular(12.r)),
        child: Row(
          children: [
            // Leading icon tile — sets the card's height.
            const _Block(width: 46, height: 46, radius: 12, alpha: 0.80),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title — titleSmall @14.sp.
                  const _TextLine(
                    lineHeight: 17,
                    barHeight: 12,
                    factor: 0.52,
                    alpha: 0.95,
                  ),
                  SizedBox(height: 3.h),
                  // Subtitle — bodySmall @12.sp; the messages wrap to two
                  // lines in the ~223.w the row leaves them.
                  const _TextLine(
                    lineHeight: 14,
                    barHeight: 10,
                    factor: 0.92,
                    alpha: 0.45,
                  ),
                  const _TextLine(
                    lineHeight: 14,
                    barHeight: 10,
                    factor: 0.48,
                    alpha: 0.45,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Trailing chevron.
            const _Block(width: 12, height: 18, radius: 3, alpha: 0.35),
          ],
        ),
      ),
    );
  }
}

// ─── Primitives ──────────────────────────────────────────────────────────────

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

/// A text-line placeholder: a [barHeight] bar spanning [factor] of the parent's
/// width, centred inside a box of the real text's [lineHeight] so the skeleton
/// reserves exactly the space the string will take. Aligned to the reading
/// direction by default, so it mirrors in Arabic.
class _TextLine extends StatelessWidget {
  final double lineHeight;
  final double barHeight;
  final double factor;
  final double alpha;
  final AlignmentGeometry alignment;

  const _TextLine({
    required this.lineHeight,
    required this.barHeight,
    required this.factor,
    this.alpha = 0.9,
    this.alignment = AlignmentDirectional.centerStart,
  });

  // [Align] sits outside the [FractionallySizedBox] on purpose: it loosens the
  // box's tight height before the fraction is applied, so the bar keeps its own
  // [barHeight] instead of being stretched to the full line box.
  @override
  Widget build(BuildContext context) => SizedBox(
    height: lineHeight.h,
    child: Align(
      alignment: alignment,
      child: FractionallySizedBox(
        widthFactor: factor,
        child: _Block(height: barHeight, alpha: alpha),
      ),
    ),
  );
}