import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/complete_profile/value_validators.dart';
import '../../../domain/common/common_member_field_dto.dart';
import '../../../domain/core/failures.dart';
import '../../core/date_picker/app_date_picker_field.dart';

class CompleteProfileDatePicker extends StatelessWidget {
  final MemberFieldSetting field;
  final Map<String, DynamicFieldInput> dynamicFieldValues;
  final bool showErrorMessages;
  final bool readOnly;
  final void Function(
    String fieldName,
    String value,
    MemberFieldSetting field,
  ) onChanged;

  const CompleteProfileDatePicker({
    super.key,
    required this.field,
    required this.dynamicFieldValues,
    required this.showErrorMessages,
    required this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final key = field.fieldName ?? '';
    final label = field.displayFieldName ?? field.fieldName ?? '';
    final isRequired = field.mandatory ?? false;

    final currentValue =
        dynamicFieldValues[key]?.value.getOrElse(() => '') ?? '';

    final errorText = showErrorMessages
        ? dynamicFieldValues[key]?.value.fold(
            (failure) => failure.maybeMap(
              empty: (_) =>
                  'core.validation.empty'.tr(namedArgs: {'fieldName': label}),
              orElse: () => null,
            ),
            (_) => null,
          )
        : null;

    final normalized = key.toLowerCase().replaceAll(RegExp(r'[\s_]+'), '');
    final isDob =
        normalized.contains('dateofbirth') || normalized.contains('dob');
    final now = DateTime.now();
    final maximumDate = isDob
        ? DateTime(now.year - 18, now.month, now.day)
        : null;

    final picker = AppDatePickerField(
      value: currentValue.isEmpty ? null : currentValue,
      labelText: isRequired ? '$label *' : label,
      hintText: 'core.dateHint'.tr(),
      errorText: errorText,
      maximumDate: maximumDate,
      suffixIcon: readOnly
          ? (field.isFromMalaa == true
                ? Icon(
                    Icons.auto_awesome_rounded,
                    size: 16.sp,
                    color: Theme.of(context).colorScheme.tertiary,
                  )
                : Icon(
                    Icons.lock_outline_rounded,
                    size: 16.sp,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ))
          : null,
      onChanged: (value) => onChanged(key, value, field),
    );

    if (readOnly) return AbsorbPointer(child: picker);
    return picker;
  }
}