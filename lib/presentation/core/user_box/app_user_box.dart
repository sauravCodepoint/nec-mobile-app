import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme_ext.dart';

class AppUserBox extends StatelessWidget {
  final String userName;
  final String userInitials;
  final String userStatus;
  final bool isActive;

  const AppUserBox({
    super.key,
    required this.userName,
    required this.userInitials,
    required this.userStatus,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final appColors = context.appColors;

    return Container(
      width: 1.sw,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: context.glassPanel(
        borderRadius: BorderRadius.circular(12.r),
        fillTop: 0.10,
        fillBottom: 0.04,
        shadowBlur: 12.r,
        shadowOffset: Offset(0, 4.h),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.appColors.brandFill,
                  Color.lerp(context.appColors.brandFill, Colors.black, 0.12)!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: cs.tertiary.withValues(alpha: 0.32),
                  blurRadius: 10,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: Text(
              userInitials,
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: cs.primary,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: isActive
                        ? appColors.success.withValues(alpha: 0.15)
                        : appColors.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: isActive
                          ? appColors.success.withValues(alpha: 0.35)
                          : appColors.error.withValues(alpha: 0.35),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    userStatus,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: isActive ? appColors.success : appColors.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}