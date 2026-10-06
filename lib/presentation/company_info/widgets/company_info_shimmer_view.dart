import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/shimmer/app_shimmer.dart';

/// Document-style skeleton shown while the company-info HTML loads.
/// Each section is a shimmering card container with a header line and text
/// lines nested inside, so the placeholder has visible fill on the gradient
/// background.
class CompanyInfoShimmerView extends StatelessWidget {
  const CompanyInfoShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Heading + meta line ─────────────────────────────────────────
          AppShimmer(width: 200.w, height: 16.h),
          SizedBox(height: 10.h),
          AppShimmer(width: 130.w, height: 10.h),

          SizedBox(height: 20.h),

          // ── Section cards ───────────────────────────────────────────────
          _SectionCard(headerWidth: 150.w, lines: 6, lastLineWidth: 190.w),
          SizedBox(height: 14.h),
          _SectionCard(headerWidth: 120.w, lines: 5, lastLineWidth: 140.w),
          SizedBox(height: 14.h),
          _SectionCard(headerWidth: 170.w, lines: 6, lastLineWidth: 220.w),
          SizedBox(height: 14.h),
          _SectionCard(headerWidth: 130.w, lines: 4, lastLineWidth: 170.w),
          SizedBox(height: 14.h),
          _SectionCard(headerWidth: 160.w, lines: 5, lastLineWidth: 200.w),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final double headerWidth;
  final int lines;
  final double lastLineWidth;

  const _SectionCard({
    required this.headerWidth,
    required this.lines,
    required this.lastLineWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppShimmer(width: headerWidth, height: 12.h),
            SizedBox(height: 12.h),
            for (var i = 0; i < lines - 1; i++) ...[
              AppShimmer(height: 10.h),
              SizedBox(height: 8.h),
            ],
            AppShimmer(width: lastLineWidth, height: 10.h),
          ],
        ),
      ),
    );
  }
}