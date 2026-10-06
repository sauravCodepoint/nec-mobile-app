import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/notification/notification_dto.dart';
import '../../core/app_bar/app_app_bar.dart';
import '../../core/helper/app_date_formatter_helper.dart';
import '../../core/scaffold/app_scaffold.dart';
import '../../core/theme/app_theme_ext.dart';

@RoutePage()
class NotificationDetailView extends HookWidget {
  final NotificationList? notification;

  const NotificationDetailView({super.key, this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final animController = useAnimationController(
      duration: const Duration(milliseconds: 480),
    );

    useEffect(() {
      animController.forward();
      return null;
    }, const []);

    final fade = CurvedAnimation(
      parent: animController,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOut),
    );
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.07),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animController,
        curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
      ),
    );
    final iconScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: animController,
        curve: const Interval(0.1, 0.65, curve: Curves.easeOutBack),
      ),
    );
    final contentFade = CurvedAnimation(
      parent: animController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    );

    final title = notification?.title ?? '';
    final message = notification?.message ?? '';
    final dateTime = AppDateFormatterHelper.format(
      notification?.createdOn,
      outputFormat: AppDateFormatterHelper.bankingDateTime,
    );

    return AppScaffold(
      appBar: AppAppBar(title: 'notifications.title'.tr()),
      body: FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon header
                Center(
                  child: ScaleTransition(
                    scale: iconScale,
                    child: Container(
                      width: 68.w,
                      height: 68.w,
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: colorScheme.tertiary,
                        size: 34.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                // Main content card
                FadeTransition(
                  opacity: contentFade,
                  child: Container(
                    width: double.infinity,
                    // Same glass recipe as the list cards on NotificationPage
                    // so the card border matches in both themes (the previous
                    // colorScheme.outline border read differently in dark mode).
                    decoration: context.glassPanel(
                      borderRadius: BorderRadius.circular(16.r),
                      shadowBlur: 12,
                      shadowOffset: Offset(0, 4.h),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title section
                        Padding(
                          padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 14.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 4.w,
                                height: 20.h,
                                margin: EdgeInsets.only(top: 1.h),
                                decoration: BoxDecoration(
                                  color: context.appColors.brandFill,
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 16.sp,
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w700,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: context.appColors.glassBorder.withValues(
                            alpha: 0.18,
                          ),
                        ),
                        // Message body
                        Padding(
                          padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
                          child: Text(
                            message,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w400,
                              height: 1.65,
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: context.appColors.glassBorder.withValues(
                            alpha: 0.18,
                          ),
                        ),
                        // Date footer
                        Padding(
                          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 14.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 13.w,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  dateTime,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: 12.sp,
                                    color: colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
