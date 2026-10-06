import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme_ext.dart';

class AppActionSheetItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final bool isDestructive;

  const AppActionSheetItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
    this.color,
    this.isDestructive = false,
  });
}

class AppActionSheet extends StatelessWidget {
  final List<AppActionSheetItem> items;
  final String? title;
  final String? description;

  const AppActionSheet({
    super.key,
    required this.items,
    this.title,
    this.description,
  });

  static Future<void> show(
    BuildContext context, {
    required List<AppActionSheetItem> items,
    String? title,
    String? description,
  }) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.45),
      builder: (_) =>
          AppActionSheet(items: items, title: title, description: description),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        // The sheet is `isScrollControlled`, so the only height bound is the
        // screen itself. Cap it and let the body scroll — a plain min-size
        // Column overflowed its box as soon as a channel carried several
        // values, and on Android the overflowing sheet painted nothing at all.
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.85,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: context.appColors.containerBackground.withValues(
                    alpha: 0.97,
                  ),
                  borderRadius: BorderRadius.circular(28.r),
                  border: Border.all(
                    color: context.appColors.glassBorder.withValues(
                      alpha: 0.18,
                    ),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 30,
                      spreadRadius: 0,
                      offset: const Offset(0, 10),
                      color: context.appColors.glass.withValues(alpha: 0.12),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Grab handle stays pinned above the scrolling body.
                    Padding(
                      padding: EdgeInsets.only(top: 14.h),
                      child: Container(
                        width: 42.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: context.appColors.glass.withValues(
                            alpha: 0.30,
                          ),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                    ),

                    Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (title != null) ...[
                              SizedBox(height: 20.h),

                              Text(
                                title!,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],

                            if (description != null) ...[
                              SizedBox(height: 8.h),

                              Text(
                                description!,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: cs.onSurfaceVariant,
                                  height: 1.4,
                                ),
                              ),
                            ],

                            SizedBox(height: 20.h),

                            ...List.generate(items.length, (index) {
                              final item = items[index];

                              final itemColor =
                                  item.color ??
                                  (item.isDestructive
                                      ? cs.error
                                      : cs.onSurface);

                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: index == items.length - 1 ? 0 : 12.h,
                                ),
                                child: _ActionTile(
                                  item: item,
                                  color: itemColor,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final AppActionSheetItem item;
  final Color color;

  const _ActionTile({required this.item, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22.r),
        onTap: () {
          Navigator.pop(context);
          item.onTap();
        },
        child: Ink(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),

            color: color.withValues(alpha: item.isDestructive ? 0.10 : 0.08),

            border: Border.all(
              color: color.withValues(alpha: item.isDestructive ? 0.20 : 0.14),
              width: 0.8,
            ),

            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: color.withValues(alpha: 0.12),
                  border: Border.all(
                    color: color.withValues(alpha: 0.25),
                    width: 0.8,
                  ),
                ),
                child: Icon(item.icon, color: color, size: 22.w),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),

                    if (item.subtitle != null) ...[
                      SizedBox(height: 4.h),

                      Text(
                        item.subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.w,
                color: color.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
