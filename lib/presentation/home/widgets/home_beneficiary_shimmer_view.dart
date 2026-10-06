import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_theme_ext.dart';

/// Full-screen skeleton shown while the first "choose beneficiary" list fetch is
/// in flight.
///
/// Mirrors the whole body of `HomeBeneficiaryView` top to bottom — the three-step
/// stepper, the country / transfer-type context card, the "Add New Beneficiary"
/// button, then [AppBeneficiaryTile]-shaped selection rows (radio indicator, name
/// over the two detail lines the home list passes, trailing flag / currency /
/// overflow) — so the swap to the real screen barely shifts anything.
///
/// Authored the same way as `BeneficiaryShimmerView` on the manage-beneficiary
/// page, for one consistent loading language across the two sibling lists:
/// * **One sweep for the whole screen.** A single [Shimmer] wraps every
///   placeholder, so the highlight travels across the page as one light instead
///   of each block pulsing on its own clock. Shimmer replaces its subtree's
///   colour and keeps its alpha, so the skeleton is authored purely in alpha:
///   bright blocks for primary content, faint ones for secondary, a
///   barely-there card fill and hairline.
/// * **Rows are sized to the viewport**, not a fixed count, and the bottom of
///   the skeleton fades out so it reads as a list continuing past the fold
///   rather than one chopped off mid-row.
class HomeBeneficiaryShimmerView extends StatelessWidget {
  const HomeBeneficiaryShimmerView({super.key});

  /// Heights of the chrome above the list, kept in sync with the real widgets so
  /// the skeleton hands over without a jump: the stepper's track band and label
  /// row (`AppStepper`), the context summary card's padded two-column content,
  /// and `AppButton`'s fixed 55.w body.
  static const double _stepperTrack = 48;
  static const double _stepperLabels = 16;
  static const double _contextCard = 85;
  static const double _buttonHeight = 55;

  /// Height of one skeleton row — one title line over two detail lines inside
  /// the tile's 6.h vertical content padding. Kept here so the row count can be
  /// derived from the viewport.
  static const double _tileHeight = 68;
  static const double _tileGap = 12;

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
          stops: [0, 0.78, 1],
        ).createShader(rect),
        blendMode: BlendMode.dstIn,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Stepper's own vertical padding.
              SizedBox(height: 12.h),
              const _StepperSkeleton(),
              SizedBox(height: 12.h),
              const _ContextCardSkeleton(),
              // Card bottom margin + the gap before the button.
              SizedBox(height: 15.h),
              // "Add New Beneficiary" — AppButton's leading 8.h gap, then its
              // body.
              SizedBox(height: 8.h),
              _Block(height: _buttonHeight, radius: 8, alpha: 0.30),
              SizedBox(height: 15.h),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final rowExtent = (_tileHeight + _tileGap).h;
                    final count = constraints.maxHeight.isFinite
                        // +1 so a partially visible row always reaches the
                        // bottom.
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
      ),
    );
  }
}

// ─── Chrome above the list ────────────────────────────────────────────────────

/// Three nodes on a connecting track with a label under each — the shape of
/// `AppStepper` at step 2 of 3.
class _StepperSkeleton extends StatelessWidget {
  const _StepperSkeleton();

  @override
  Widget build(BuildContext context) {
    const steps = 3;
    return Column(
      children: [
        SizedBox(
          height: HomeBeneficiaryShimmerView._stepperTrack.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Connecting track, inset by half a node on each side.
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: _Block(height: 2, radius: 1, alpha: 0.30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  steps,
                  (i) => _Block(
                    width: 30,
                    height: 30,
                    radius: 15,
                    // The reached steps carry the accent in the real stepper.
                    alpha: i <= 1 ? 0.85 : 0.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: HomeBeneficiaryShimmerView._stepperLabels.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              steps,
              (i) => _Block(width: 54, height: 9, alpha: i == 1 ? 0.75 : 0.45),
            ),
          ),
        ),
      ],
    );
  }
}

/// The country / transfer-type summary card: two icon-over-label-over-value
/// columns either side of a dotted divider.
class _ContextCardSkeleton extends StatelessWidget {
  const _ContextCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return _Card(
      height: HomeBeneficiaryShimmerView._contextCard,
      padding: EdgeInsets.all(10).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(child: _ContextColumn()),
          SizedBox(width: 10.w),
          _Block(width: 0.8, height: 45, radius: 1, alpha: 0.28),
          SizedBox(width: 10.w),
          const Expanded(child: _ContextColumn()),
        ],
      ),
    );
  }
}

class _ContextColumn extends StatelessWidget {
  const _ContextColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Flag / transfer-type icon.
        _Block(width: 22, height: 22, radius: 4, alpha: 0.80),
        SizedBox(height: 6.h),
        _Line(factor: 0.55, height: 9, alpha: 0.45),
        SizedBox(height: 4.h),
        _Line(factor: 0.80, height: 11, alpha: 0.85),
      ],
    );
  }
}

// ─── Tile ─────────────────────────────────────────────────────────────────────

/// Text-line widths cycled per row so the skeleton doesn't read as a comb of
/// identical bars. Fractions of the available text column, so they stay sane on
/// every screen width and flip correctly in RTL.
const _titleWidths = <double>[0.52, 0.42, 0.60, 0.47, 0.55];
const _detailWidths = <double>[0.38, 0.46, 0.33, 0.43, 0.36];
const _metaWidths = <double>[0.58, 0.50, 0.64, 0.54, 0.60];

class _SkeletonTile extends StatelessWidget {
  final int index;

  const _SkeletonTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final i = index % _titleWidths.length;

    return _Card(
      height: HomeBeneficiaryShimmerView._tileHeight,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          // Radio indicator — this list selects rather than edits, so the
          // leading slot is the 18.w circle, not the initials avatar the manage
          // list shows.
          _Block(width: 18, height: 18, radius: 9, alpha: 0.75),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name.
                _Line(factor: _titleWidths[i], height: 11, alpha: 0.95),
                SizedBox(height: 7.h),
                // Masked account, then disbursal mode — the two subtitle lines
                // the home list renders (it passes no bank name).
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

/// A faint card so the skeleton keeps the real screen's rhythm of separate
/// cards instead of reading as one solid slab.
class _Card extends StatelessWidget {
  final double height;
  final EdgeInsetsGeometry padding;
  final Widget child;

  const _Card({
    required this.height,
    required this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Container(
    height: height.h,
    padding: padding,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
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
    child: child,
  );
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
