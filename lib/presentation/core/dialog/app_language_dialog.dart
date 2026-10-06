import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../domain/core/push_notification/app_push_notification.dart';
import '../button/app_button.dart';
import '../global/app_global.dart';
import '../language/language_switch_animator.dart';
import '../theme/app_theme_ext.dart';

/// Animated entrance, instant exit. Closing must not animate: the language
/// dissolve snapshots the frame right after the pop, and a lingering exit
/// transition would freeze the half-dismissed dialog instead of the screen
/// behind it, masking the effect.
class _AppLanguageDialogRoute extends RawDialogRoute<void> {
  _AppLanguageDialogRoute()
    : super(
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, _, _) => Stack(
          children: [
            IgnorePointer(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
            ),
            const Center(child: AppLanguageDialog()),
          ],
        ),
        transitionBuilder: (_, animation, _, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween(begin: 0.9, end: 1.0).animate(curved),
              child: child,
            ),
          );
        },
      );

  @override
  Duration get reverseTransitionDuration => Duration.zero;
}

class AppLanguageDialog extends HookWidget {
  const AppLanguageDialog({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(
      context,
      rootNavigator: true,
    ).push(_AppLanguageDialogRoute());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appColors = context.appColors;

    final current = useState(context.locale.languageCode);

    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
    )..forward();

    final languages = [
      {'code': AppLocale.en.name, 'name': 'core.languages.english'.tr()},
      {'code': AppLocale.ar.name, 'name': 'core.languages.arabic'.tr()},
      // {'code': AppLocale.ml.name, 'name': 'core.languages.malayalam'.tr()},
      // {'code': AppLocale.hi.name, 'name': 'core.languages.hindi'.tr()},
      // {'code': AppLocale.fil.name, 'name': 'core.languages.tagalog'.tr()},
      // {'code': AppLocale.ms.name, 'name': 'core.languages.malay'.tr()},
    ];

    return Dialog(
      elevation: 0,
      backgroundColor: appColors.containerBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: context.appColors.glassBorder.withValues(alpha: 0.24), width: 0.8),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'core.languageDialog.title'.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),

            ...languages.map((lang) {
              final isSelected = current.value == lang['code'];

              return FadeTransition(
                opacity: controller,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(controller),
                  child: GestureDetector(
                    onTap: () => current.value = lang['code']!,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.tertiary.withValues(alpha: 0.08)
                            : context.appColors.glass.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: isSelected
                              ? colorScheme.tertiary
                              : context.appColors.glassBorder.withValues(alpha: 0.18),
                          width: 0.8,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: appColors.shadow,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              lang['name']!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 14.5.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: isSelected
                                ? Icon(
                                    Icons.check_circle,
                                    size: 22.sp,
                                    key: ValueKey(lang['code']),
                                    color: colorScheme.tertiary,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: AppButton(
                    backgroundColor: context.appColors.glassBorder.withValues(alpha: 0.12),
                    border: Border.all(color: colorScheme.tertiary.withValues(alpha: 0.24), width: 0.8),
                    height: 50.h,
                    onTap: () => context.router.pop(),
                    text: 'buttons.cancel'.tr(),
                    textStyle: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppButton(
                    height: 50.h,
                    onTap: () {
                      if (current.value == context.locale.languageCode) {
                        context.router.pop();
                        return;
                      }

                      final locale = context.supportedLocales.firstWhere(
                        (l) => l.languageCode == current.value,
                        orElse: () => context.supportedLocales.first,
                      );

                      // Capture before popping: after pop the dialog element
                      // is defunct and its context can't reach EasyLocalization.
                      final easyLoc = EasyLocalization.of(context)!;

                      context.router.pop();

                      // The route reverses instantly, so the next frame paints
                      // dialog-free; only then freeze it and dissolve into the
                      // new locale — snapshotting now would freeze the still-
                      // visible dialog and mask the effect behind it.
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        LanguageSwitchAnimator.dissolve(
                          applyLocale: () async {
                            await easyLoc.setLocale(locale);
                            // Keep backend push language in step with the app.
                            AppPushNotification.syncDeviceToken();
                          },
                        );
                      });
                    },
                    text: 'buttons.apply'.tr(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
