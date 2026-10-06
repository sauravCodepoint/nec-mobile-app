import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../text_form_field/app_text_form_field.dart';
import '../theme/app_theme_ext.dart';

class AppDatePickerField extends HookWidget {
  final String? value;
  final ValueChanged<String> onChanged;
  final String labelText;
  final String? hintText;
  final String? errorText;
  final Widget? suffixIcon;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  /// When true the picker can't be opened (tap is suppressed) — used for
  /// locked/prefilled fields. The caller typically supplies a lock/AI
  /// [suffixIcon] to signal the state.
  final bool readOnly;

  const AppDatePickerField({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.value,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.minimumDate,
    this.maximumDate,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ctrl = useTextEditingController(text: value ?? '');

    // Keep field in sync when value changes externally (e.g. OCR auto-fill).
    useEffect(() {
      if (ctrl.text != (value ?? '')) ctrl.text = value ?? '';
      return null;
    }, [value]);

    return AppTextFormField(
      controller: ctrl,
      labelText: labelText,
      hintText: hintText ?? 'DD/MM/YYYY',
      readOnly: true,
      showCursor: false,
      enableInteractiveSelection: false,
      onTap: readOnly ? null : () => _showPicker(context),
      errorText: errorText,
      suffixIcon:
          suffixIcon ??
          Icon(
            Icons.calendar_month_outlined,
            color: cs.onSurfaceVariant,
            size: 18.sp,
          ),
    );
  }

  void _showPicker(BuildContext context) {
    final min = minimumDate ?? DateTime(1900);
    final max = maximumDate ?? DateTime(2100);
    var initial = _parseDate(value) ?? DateTime.now();
    if (initial.isBefore(min)) initial = min;
    if (initial.isAfter(max)) initial = max;

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (_) => _DatePickerSheet(
        title: labelText,
        initialDate: initial,
        minimumDate: min,
        maximumDate: max,
        onConfirm: (date) {
          final dd = date.day.toString().padLeft(2, '0');
          final mm = date.month.toString().padLeft(2, '0');
          onChanged('$dd/$mm/${date.year}');
        },
      ),
    );
  }

  static DateTime? _parseDate(String? s) {
    if (s == null || s.isEmpty) return null;
    final parts = s.split('/');
    if (parts.length != 3) return null;
    try {
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (_) {
      return null;
    }
  }
}

// ── Bottom sheet ───────────────────────────────────────────────────────────────

class _DatePickerSheet extends HookWidget {
  final String title;
  final DateTime initialDate;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final ValueChanged<DateTime> onConfirm;

  const _DatePickerSheet({
    required this.title,
    required this.initialDate,
    required this.minimumDate,
    required this.maximumDate,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final selected = useState(initialDate);

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
                border: Border.all(color: context.appColors.glassBorder.withValues(alpha: 0.18), width: 0.8),
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
                  children: [
                    // Handle bar
                    Container(
                      width: 42.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: cs.tertiary,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Title row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'buttons.cancel'.tr(),
                            style: TextStyle(
                              color: cs.onSurface.withValues(alpha: 0.47),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onConfirm(selected.value);
                          },
                          child: Text(
                            'buttons.done'.tr(),
                            style: TextStyle(
                              color: cs.tertiary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    // Cupertino date picker
                    SizedBox(
                      height: 200.h,
                      child: CupertinoTheme(
                        data: CupertinoThemeData(
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                              fontSize: 16.sp,
                              color: cs.onSurface,
                              fontFamily:
                                  theme.textTheme.bodyMedium?.fontFamily,
                            ),
                          ),
                        ),
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: initialDate,
                          minimumDate: minimumDate,
                          maximumDate: maximumDate,
                          onDateTimeChanged: (date) => selected.value = date,
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
