import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_theme_ext.dart';

/// Small informational chip rendered directly beneath a product field when the
/// backend sends a `previous_value` for it — reminding the user what they had
/// entered/selected before (e.g. on a re-KYC / update flow).
///
/// Pass [isSelection] true for dropdown-style fields ("Previously selected: …")
/// and false for free-text fields ("Previously entered: …"). [value] is the
/// already-resolved, human-readable text (display name for dropdowns, raw value
/// for text fields) — never a bare backend code.
class BeneficiaryPreviousValueHint extends StatelessWidget {
  final String value;
  final bool isSelection;

  const BeneficiaryPreviousValueHint({
    super.key,
    required this.value,
    required this.isSelection,
  });

  @override
  Widget build(BuildContext context) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return const SizedBox.shrink();

    final colors = context.appColors;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final label = (isSelection
            ? 'beneficiaries.beneficiaryForm.previousValueSelected'
            : 'beneficiaries.beneficiaryForm.previousValue')
        .tr(namedArgs: {'value': trimmed});

    // No outer padding: this renders inside AppTextFormField's helper slot,
    // which already supplies the gap below the field (matching the error row).
    // Full-width instructional note so it reads as a "take note" reminder.
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: colors.warningSubtle,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: colors.warning.withValues(alpha: 0.35),
          width: 0.8,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Icon(
              Icons.info_outline_rounded,
              size: 13.sp,
              color: colors.warning,
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 11.sp,
                height: 1.35,
                color: onSurface.withValues(alpha: 0.85),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}