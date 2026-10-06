import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_theme_ext.dart';

/// Skeleton shown while the first beneficiary list fetch is in flight.
///
/// Mirrors the real page: the search field the list header gains once records
/// arrive, then [AppBeneficiaryTile]-shaped cards (avatar, name + three detail
/// lines, trailing flag / currency / overflow button) — so the swap to the real
/// list barely shifts anything.
///
/// Two deliberate choices:
/// * **One sweep for the whole screen.** A single [Shimmer] wraps every
///   placeholder, so the highlight travels across the page as one light instead
///   of each row pulsing on its own clock. Shimmer replaces its subtree's colour
///   and keeps its alpha, so the skeleton is authored purely in alpha: bright
///   blocks for primary content, faint ones for secondary, a barely-there card
///   fill and hairline.
/// * **Rows are sized to the viewport**, not a fixed count, and the last of them
///   fades out so the skeleton reads as a list continuing past the fold rather
///   than one chopped off mid-row.
class BeneficiaryShimmerView extends StatelessWidget {
  const BeneficiaryShimmerView({super.key});

  /// Height of one skeleton card — kept in sync with [_SkeletonTile]'s own
  /// padding + content so the row count can be derived from the viewport.
  static const double _tileHeight = 74;
  static const double _tileGap = 10;

  @override
  Widget build(BuildContext context) {
    final glass = context.appColors.glassBorder;

    return Shimmer.fromColors(
      baseColor: glass.withValues(alpha: 0.16),
      highlightColor: glass.withValues(alpha: 0.38),
      period: const Duration(milliseconds: 1400),
      child: ShaderMask(
        // Softens the hard clip where the skeleton meets the bottom of the
        // viewport; the list looks like it keeps going.
        shaderCallback: (rect) => const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white, Colors.transparent],
          stops: [0, 0.72, 1],
        ).createShader(rect),
        blendMode: BlendMode.dstIn,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Stand-ins for the divider + search field the page reveals once the
            // list resolves, so the real header doesn't push the rows down.
            SizedBox(
              height: 32.h,
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: _Block(height: 0.8, alpha: 0.35),
                ),
              ),
            ),
            _Block(height: 52, radius: 10, alpha: 0.22),
            SizedBox(height: 16.h),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final rowExtent = (_tileHeight + _tileGap).h;
                  final count = constraints.maxHeight.isFinite
                      // +1 so a partially visible row always reaches the bottom.
                      ? (constraints.maxHeight / rowExtent).ceil() + 1
                      : 8;
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: count,
                    separatorBuilder: (_, _) => SizedBox(height: _tileGap.h),
                    itemBuilder: (_, i) => _SkeletonTile(index: i),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tile ─────────────────────────────────────────────────────────────────────

/// Text-line widths cycled per row so the skeleton doesn't read as a comb of
/// identical bars. Fractions of the available text column, so they stay sane on
/// every screen width and flip correctly in RTL.
const _titleWidths = <double>[0.52, 0.42, 0.60, 0.47, 0.55];
const _detailWidths = <double>[0.74, 0.64, 0.80, 0.68, 0.76];
const _metaWidths = <double>[0.38, 0.46, 0.33, 0.43, 0.36];

class _SkeletonTile extends StatelessWidget {
  final int index;

  const _SkeletonTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final i = index % _titleWidths.length;
    final radius = BorderRadius.circular(8.r);

    return Container(
      height: BeneficiaryShimmerView._tileHeight.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: radius,
        // Faint card so the skeleton keeps the real list's rhythm of separate
        // cards instead of reading as one solid slab.
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.20),
            Colors.white.withValues(alpha: 0.09),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.40),
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          // Initials avatar.
          _Block(width: 36, height: 36, radius: 18, alpha: 0.85),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Line(factor: _titleWidths[i], height: 11, alpha: 0.95),
                SizedBox(height: 7.h),
                _Line(factor: _detailWidths[i], height: 9, alpha: 0.55),
                SizedBox(height: 6.h),
                _Line(factor: _metaWidths[i], height: 9, alpha: 0.38),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          // Flag + currency code.
          _Block(width: 22, height: 16, radius: 3, alpha: 0.75),
          SizedBox(width: 6.w),
          _Block(width: 28, height: 9, alpha: 0.55),
          SizedBox(width: 10.w),
          // Overflow ("more") button.
          _Block(width: 3.5, height: 15, radius: 2, alpha: 0.45),
        ],
      ),
    );
  }
}

// ─── Primitives ───────────────────────────────────────────────────────────────

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