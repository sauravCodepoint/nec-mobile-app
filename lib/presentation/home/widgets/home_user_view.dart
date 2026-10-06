import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/home/home_bloc.dart';
import '../../core/global/app_global.dart';
import '../../core/theme/app_theme_ext.dart';

class HomeUserView extends StatelessWidget {
  final HomeState state;
  const HomeUserView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final userDto = state.homeUserDto?.data?.user;
    final userName = userDto?.name;
    final userFirstName = userDto?.firstName;
    final userInitials = (userName != null && userName.trim().isNotEmpty)
        ? userName
              .trim()
              .split(RegExp(r'\s+'))
              .where((e) => e.isNotEmpty)
              .take(2)
              .map((e) => e[0].toUpperCase())
              .join()
        : '';

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 10.h),
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: context.appColors.glassBorder.withValues(alpha: 0.18),
              width: 0.8,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
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
                    color: cs.tertiary.withValues(alpha: 0.28),
                    blurRadius: 8,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Text(
                userInitials,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: cs.primary,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: AppGlobal.getGreeting(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: cs.onPrimary.withValues(alpha: 0.80),
                      ),
                      children: [
                        TextSpan(
                          text: ' $userFirstName',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: cs.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'home.welcome'.tr(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: cs.onSurface.withValues(alpha: 0.60),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
