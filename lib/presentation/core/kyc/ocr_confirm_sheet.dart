import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/kyc/kyc_ocr_result.dart';
import '../button/app_button.dart';
import '../theme/app_theme_ext.dart';

class KycOcrConfirmSheet extends StatelessWidget {
  final KycOcrResult result;

  const KycOcrConfirmSheet._({required this.result});

  static Future<bool> show(
    BuildContext context, {
    required KycOcrResult result,
  }) async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.45),
      builder: (_) => KycOcrConfirmSheet._(result: result),
    );
    return confirmed == true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    // ID type and number are never shown or applied here — they stay fixed to
    // the verified values the user entered on login. Only the dates are
    // surfaced for review/auto-fill.
    final rows = <_OcrRow>[
      if (result.issueDate != null)
        _OcrRow(
          icon: Icons.calendar_today_outlined,
          label: 'kyc.field.issueDate.label'.tr(),
          value: result.issueDate!,
        ),
      if (result.expiryDate != null)
        _OcrRow(
          icon: Icons.event_outlined,
          label: 'kyc.field.expiryDate.label'.tr(),
          value: result.expiryDate!,
        ),
      if (result.dateOfBirth != null)
        _OcrRow(
          icon: Icons.cake_outlined,
          label: 'kyc.field.dateOfBirth.label'.tr(),
          value: result.dateOfBirth!,
        ),
    ];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                color: context.appColors.containerBackground.withValues(alpha: 0.97),
                borderRadius: BorderRadius.circular(28.r),
                border: Border.all(
                  color: context.appColors.glassBorder.withValues(alpha: 0.18),
                  width: 0.8,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    spreadRadius: 0,
                    offset: const Offset(0, 10),
                    color: context.appColors.shadowInk.withValues(alpha: 0.12),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 42.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: context.appColors.glass.withValues(alpha: 0.30),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),
                            color: cs.tertiary.withValues(alpha: 0.12),
                          ),
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            color: cs.tertiary,
                            size: 22.w,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'kyc.ocr.sheet.title'.tr(),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'kyc.ocr.sheet.subtitle'.tr(),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Divider(
                      color: context.appColors.glassBorder.withValues(alpha: 0.12),
                      height: 1,
                    ),
                    SizedBox(height: 16.h),
                    ...rows.map((row) => _DataRow(row: row)),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'kyc.ocr.sheet.discardButton'.tr(),
                            backgroundColor: context.appColors.glassBorder.withValues(alpha: 0.12),
                            textStyle: TextStyle(
                              color: cs.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                            onTap: () => Navigator.of(context).pop(false),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: AppButton(
                            text: 'kyc.ocr.sheet.useButton'.tr(),
                            onTap: () => Navigator.of(context).pop(true),
                          ),
                        ),
                      ],
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

class _OcrRow {
  final IconData icon;
  final String label;
  final String value;
  const _OcrRow({required this.icon, required this.label, required this.value});
}

class _DataRow extends StatelessWidget {
  final _OcrRow row;
  const _DataRow({required this.row});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Icon(row.icon, size: 16.w, color: cs.onSurfaceVariant),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  row.value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
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