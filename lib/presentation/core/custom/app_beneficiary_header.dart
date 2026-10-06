import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/dotted_border/app_dotted_border.dart';
import '../../core/global/app_global.dart';
import '../../core/svg/app_svg.dart';
import '../../core/theme/app_theme_ext.dart';

class AppBeneficiaryHeader extends StatelessWidget {
  final String? beneficiaryCountryCode;
  final String? beneficiaryCountryName;
  final String? transferTypeName;
  const AppBeneficiaryHeader({
    super.key,
    this.beneficiaryCountryCode,
    this.beneficiaryCountryName,
    this.transferTypeName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      decoration: context.glassPanel(
        borderRadius: BorderRadius.circular(12.r),
        shadowBlur: 12.r,
        shadowOffset: Offset(0, 4.h),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppSvg(
                  asset: AppGlobal.getFlagAsset(beneficiaryCountryCode ?? ''),
                  width: 28.w,
                  height: 28.w,
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'core.beneficiaryHeader.country'.tr(),
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      beneficiaryCountryName ?? '',
                      style: context.typography.secondary.copyWith(
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 14.w),
            SizedBox(
              width: 8.w,
              child: AppDottedDivider(
                color: context.appColors.glassBorder.withValues(alpha: 0.18),
                dotSize: 0.75,
                dotLength: 3,
                space: 5,
                height: 8,
                direction: Axis.vertical,
              ),
            ),
            SizedBox(width: 14.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'core.beneficiaryHeader.transferType'.tr(),
                    style: theme.textTheme.bodySmall,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    transferTypeName ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
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
