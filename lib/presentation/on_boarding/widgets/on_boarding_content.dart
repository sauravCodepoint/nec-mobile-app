import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../on_boarding_page.dart';
import 'on_boarding_visual.dart';

class OnBoardingContent extends StatelessWidget {
  final OnBoardingData data;
  final int pageIndex;
  final AnimationController entrance;

  const OnBoardingContent({
    super.key,
    required this.data,
    required this.pageIndex,
    required this.entrance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        OnBoardingVisual(
          pageIndex: pageIndex,
          entrance: entrance,
          height: 260.h,
        ),
        SizedBox(height: 24.h),
        Expanded(
          flex: 4,
          child: _TextSection(data: data, entrance: entrance),
        ),
      ],
    );
  }
}

class _TextSection extends StatelessWidget {
  final OnBoardingData data;
  final AnimationController entrance;

  const _TextSection({required this.data, required this.entrance});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleAnim = CurvedAnimation(
      parent: entrance,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    final descAnim = CurvedAnimation(
      parent: entrance,
      curve: const Interval(0.25, 0.85, curve: Curves.easeOut),
    );
    final titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(titleAnim);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(28.w, 28.h, 28.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: titleAnim,
            child: SlideTransition(
              position: titleSlide,
              child: Text(
                data.title.tr(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.tertiary,
                  height: 1.25,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: FadeTransition(
              opacity: descAnim,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Text(
                    data.description.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      color: theme.colorScheme.onSurface,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
