import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme_ext.dart';

class KycRequirementsBar extends StatelessWidget {
  final List<String> items;
  const KycRequirementsBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 8.w,
      children: items.map((item) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: context.appColors.glass.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(99.r),
            border: Border.all(
              color: context.appColors.glassBorder.withValues(alpha: 0.18),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 10.sp,
                color: cs.onSurface.withValues(alpha: 0.4),
              ),
              SizedBox(width: 4.w),
              Text(
                item,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: cs.onSurface.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}