import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_theme_ext.dart';

/// Full-screen skeleton shown while the summary's initial data is in flight —
/// every section is fetched in parallel and the page reveals once, fully
/// populated, rather than piecing itself together section by section.
///
/// Mirrors the real body top to bottom: the stepper, the beneficiary card (flag
/// column, dotted divider, label/value pairs), the send-money card (two amount
/// halves either side of the rate pill), the payment-method field, the
/// payment-details breakdown with its highlighted total, then the fixed footer
/// with the T&C row and the Confirm CTA. The app bar is rendered by the page and
/// deliberately not shimmered.
///
/// Authored the same way as `BeneficiaryShimmerView` and
/// `HomeBeneficiaryShimmerView`, for one consistent loading language across the
/// send-money flow:
/// * **One sweep for the whole screen.** A single [Shimmer] wraps every
///   placeholder, so the highlight travels across the page as one light instead
///   of each block pulsing on its own clock. Shimmer replaces its subtree's
///   colour and keeps its alpha, so the skeleton is authored purely in alpha:
///   bright blocks for primary content, faint ones for secondary, a
///   barely-there card fill and hairline.
/// * **Card interiors are drawn, not blocked out.** Solid full-card slabs give
///   no sense of what is arriving and collapse the page's rhythm; the rows,
///   dividers and pills below keep the skeleton legible as *this* screen.
///
/// The scroll area's bottom fades out so a page too tall for the viewport reads
/// as continuing rather than clipped, while the footer stays crisp — it is a
/// fixed bar on the real screen, not content that scrolls under the fold.
class SummaryShimmerView extends StatelessWidget {
  const SummaryShimmerView({super.key});

  /// Kept in sync with the real widgets so the reveal doesn't shift the page:
  /// `AppStepper`'s track band and label row, and `AppButton`'s fixed 55.w body.
  static const double _stepperTrack = 48;
  static const double _stepperLabels = 16;
  static const double _buttonHeight = 55;

  @override
  Widget build(BuildContext context) {
    final glass = context.appColors.glassBorder;

    return Shimmer.fromColors(
      baseColor: glass.withValues(alpha: 0.16),
      highlightColor: glass.withValues(alpha: 0.38),
      period: const Duration(milliseconds: 1400),
      child: Column(
        children: [
          Expanded(
            child: ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white, Colors.transparent],
                stops: [0, 0.9, 1],
              ).createShader(rect),
              blendMode: BlendMode.dstIn,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    const _StepperSkeleton(),
                    SizedBox(height: 15.h),
                    // Beneficiary details — title → card gap is 8.h here, 10.h
                    // on the two sections below.
                    _SectionTitle(width: 150),
                    SizedBox(height: 8.h),
                    const _BeneficiaryCardSkeleton(),
                    SizedBox(height: 15.h),
                    _SectionTitle(width: 130),
                    SizedBox(height: 10.h),
                    const _SendMoneyCardSkeleton(),
                    SizedBox(height: 15.h),
                    _SectionTitle(width: 140),
                    SizedBox(height: 10.h),
                    // Payment-method selector: a read-only field with the edit
                    // affordance stacked on its trailing edge.
                    _Card(
                      radius: 12,
                      height: 56,
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: _Line(factor: 0.45, height: 11, alpha: 0.70),
                          ),
                          _Block(width: 20, height: 20, radius: 6, alpha: 0.55),
                        ],
                      ),
                    ),
                    // Payment-details breakdown carries its own 12.h top margin
                    // and no section title, like AppPaymentDetailsView.
                    SizedBox(height: 12.h),
                    const _PaymentDetailsSkeleton(),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
          ),
          // Fixed footer: the T&C acknowledgement row above the Confirm CTA.
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.h,
              bottom: 10.h,
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _Block(width: 20, height: 20, radius: 4, alpha: 0.65),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Line(factor: 1, height: 10, alpha: 0.45),
                            SizedBox(height: 5.h),
                            _Line(factor: 0.55, height: 10, alpha: 0.45),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Real spacing between the T&C row and the button: 5.h + 8.h.
                  SizedBox(height: 13.h),
                  _Block(height: _buttonHeight, radius: 8, alpha: 0.30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stepper ──────────────────────────────────────────────────────────────────

/// Three nodes on a connecting track with a label under each — `AppStepper` on
/// its final step, so every node reads as reached.
class _StepperSkeleton extends StatelessWidget {
  const _StepperSkeleton();

  @override
  Widget build(BuildContext context) {
    const steps = 3;
    return Column(
      children: [
        SizedBox(
          height: SummaryShimmerView._stepperTrack.h,
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
                  (_) => _Block(width: 30, height: 30, radius: 15, alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: SummaryShimmerView._stepperLabels.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              steps,
              (i) => _Block(width: 54, height: 9, alpha: i == 2 ? 0.75 : 0.45),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Beneficiary card ─────────────────────────────────────────────────────────

/// Flag column on the left, dotted divider, then the name / transfer type /
/// bank / account label-value pairs on the right.
class _BeneficiaryCardSkeleton extends StatelessWidget {
  const _BeneficiaryCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return _Card(
      radius: 12,
      padding: EdgeInsets.all(10).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 76.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Block(width: 24, height: 24, radius: 4, alpha: 0.80),
                SizedBox(height: 4.h),
                _Line(factor: 0.60, height: 9, alpha: 0.45),
                SizedBox(height: 2.h),
                _Line(factor: 0.90, height: 11, alpha: 0.85),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          _Block(width: 1, height: 96, radius: 1, alpha: 0.24),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LabelValue(labelFactor: 0.30, valueFactor: 0.80),
                _PairDivider(),
                _LabelValue(labelFactor: 0.38, valueFactor: 0.52),
                _PairDivider(),
                _LabelValue(labelFactor: 0.34, valueFactor: 0.66),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A muted caption over its bolder value — the shape every field in the
/// beneficiary card uses.
class _LabelValue extends StatelessWidget {
  final double labelFactor;
  final double valueFactor;

  const _LabelValue({required this.labelFactor, required this.valueFactor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Line(factor: labelFactor, height: 9, alpha: 0.45),
        SizedBox(height: 2.h),
        _Line(factor: valueFactor, height: 11, alpha: 0.85),
      ],
    );
  }
}

class _PairDivider extends StatelessWidget {
  const _PairDivider();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: _Block(height: 0.8, radius: 1, alpha: 0.24),
  );
}

// ─── Send-money card ──────────────────────────────────────────────────────────

/// The two amount halves either side of the floating rate pill.
class _SendMoneyCardSkeleton extends StatelessWidget {
  const _SendMoneyCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return _Card(
      radius: 14,
      child: Column(
        children: [
          const _AmountHalf(),
          // Divider with the centred rate pill.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(child: _Block(height: 0.5, radius: 1, alpha: 0.24)),
                SizedBox(width: 8.w),
                _Block(width: 96, height: 22, radius: 11, alpha: 0.45),
                SizedBox(width: 8.w),
                Expanded(child: _Block(height: 0.5, radius: 1, alpha: 0.24)),
              ],
            ),
          ),
          const _AmountHalf(),
        ],
      ),
    );
  }
}

/// A caption, the large amount, and the currency chip on the trailing edge.
class _AmountHalf extends StatelessWidget {
  const _AmountHalf();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Line(factor: 0.40, height: 9, alpha: 0.45),
                SizedBox(height: 6.h),
                _Line(factor: 0.62, height: 22, alpha: 0.90),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          _Block(width: 64, height: 34, radius: 8, alpha: 0.50),
        ],
      ),
    );
  }
}

// ─── Payment details ──────────────────────────────────────────────────────────

/// Label/value rows over a highlighted total row, as
/// `AppPaymentDetailsView` lays out the breakdown.
class _PaymentDetailsSkeleton extends StatelessWidget {
  const _PaymentDetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return _Card(
      radius: 12,
      child: Column(
        children: [
          _BreakdownRow(labelFactor: 0.42, valueWidth: 64),
          _RowDivider(),
          _BreakdownRow(labelFactor: 0.30, valueWidth: 48),
          _RowDivider(),
          _BreakdownRow(labelFactor: 0.36, valueWidth: 56),
          _RowDivider(),
          // Total row: the real one is a tinted strip on the card's rounded
          // bottom with a heavier value.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                Expanded(child: _Line(factor: 0.34, height: 12, alpha: 0.70)),
                _Block(width: 84, height: 14, radius: 4, alpha: 0.90),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  final double labelFactor;
  final double valueWidth;

  const _BreakdownRow({required this.labelFactor, required this.valueWidth});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
    child: Row(
      children: [
        Expanded(child: _Line(factor: labelFactor, height: 10, alpha: 0.50)),
        // A fixed width, not a fraction: a Row hands its non-flex children
        // unbounded width, which a fractional box cannot resolve.
        _Block(width: valueWidth, height: 10, alpha: 0.75),
      ],
    ),
  );
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) =>
      _Block(height: 1, radius: 0, alpha: 0.20);
}

// ─── Primitives ───────────────────────────────────────────────────────────────

/// A section heading bar.
class _SectionTitle extends StatelessWidget {
  final double width;

  const _SectionTitle({required this.width});

  @override
  Widget build(BuildContext context) =>
      _Block(width: width, height: 12, alpha: 0.80);
}

/// A faint card so the skeleton keeps the real page's rhythm of separate cards
/// instead of reading as one solid slab.
class _Card extends StatelessWidget {
  final double radius;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  const _Card({
    required this.radius,
    required this.child,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: height?.h,
    padding: padding,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius.r),
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
///
/// Only valid where the parent's width is bounded — inside an [Expanded], a
/// sized box, or a [Column] that is itself bounded. A bare [Row] child gets
/// unbounded width and the fractional box then fails layout, which in turn
/// leaves the semantics tree dirty and trips '!semantics.parentDataDirty' in
/// the next frame's semantics pass. Use [_Block] with an explicit width there.
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
