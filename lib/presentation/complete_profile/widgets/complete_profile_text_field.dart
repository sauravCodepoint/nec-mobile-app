import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/complete_profile/value_validators.dart';
import '../../../domain/common/common_member_field_dto.dart';
import '../../../domain/core/failures.dart';
import '../../core/global/app_global.dart';
import '../../core/input_formatter/app_no_extra_space_input_formatter.dart';
import '../../core/input_formatter/app_western_digits_input_formatter.dart';
import '../../core/text_form_field/app_text_form_field.dart';

class CompleteProfileTextField extends HookWidget {
  final MemberFieldSetting field;
  final Map<String, DynamicFieldInput> dynamicFieldValues;
  final bool showErrorMessages;
  final bool readOnly;
  final void Function(
    String fieldName,
    String value,
    MemberFieldSetting field,
  ) onChanged;

  const CompleteProfileTextField({
    super.key,
    required this.field,
    required this.dynamicFieldValues,
    required this.showErrorMessages,
    required this.onChanged,
    this.readOnly = false,
  });

  /// Escapes a backend-provided character list for use inside a regex
  /// character class. `RegExp.escape` alone leaves `-` bare, which would
  /// otherwise be interpreted as a range. (Mirrors BeneficiaryTextField.)
  static String _escapeForCharClass(String chars) => chars
      .split('')
      .map((c) => c == '-' ? r'\-' : RegExp.escape(c))
      .join();

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final key = field.fieldName ?? '';
    final label = field.displayFieldName ?? field.fieldName ?? '';
    final isRequired = field.mandatory ?? false;
    final isNumeric =
        (field.supportedDataType ?? '').trim().toUpperCase() == 'N';
    final isMobileField =
        (field.fieldName ?? '').toLowerCase().contains('mobile') ||
        (field.fieldName ?? '').toLowerCase().contains('phone');
    final isEmailField = (field.fieldName ?? '').toLowerCase().contains(
      'email',
    );

    final initialValue = dynamicFieldValues[key]?.value.fold(
      (_) => controller.text,
      (v) => v,
    );

    useEffect(() {
      final text = initialValue ?? '';
      if (controller.text != text) controller.text = text;
      return null;
    }, [initialValue]);

    final errorText = showErrorMessages
        ? dynamicFieldValues[key]?.value.fold(
            (failure) => failure.maybeMap(
              empty: (_) =>
                  'core.validation.empty'.tr(namedArgs: {'fieldName': label}),
              tooShort: (_) =>
                  'core.validation.tooShort'.tr(namedArgs: {'fieldName': label}),
              tooLong: (_) =>
                  'core.validation.tooLong'.tr(namedArgs: {'fieldName': label}),
              invalidFormat: (_) => 'core.validation.invalidFormat'.tr(
                namedArgs: {'fieldName': label},
              ),
              orElse: () => null,
            ),
            (_) => null,
          )
        : null;

    final effectiveField = isMobileField
        ? field.copyWith(
            minimumLength: AppGlobal.omanMobileLength,
            maximumLength: AppGlobal.omanMobileLength,
          )
        : field;

    // Whitelist driven by the backend field settings, mirroring
    // BeneficiaryTextField: digits only for numeric/mobile fields; otherwise
    // letters, digits, single spaces and only the special characters the
    // backend explicitly allows for this field.
    final maxLength = isMobileField
        ? AppGlobal.omanMobileLength
        : (field.maximumLength ?? 0);
    final allowedSpecials = _escapeForCharClass(
      field.allowedSpecialCharacters ?? '',
    );
    // Email chars (@, . …) come from the backend's allowed_special_characters
    // for that field — no client-side carve-out.
    final allowedPattern = RegExp('[a-zA-Z0-9 $allowedSpecials]');

    final formatters = <TextInputFormatter>[
      if (isNumeric || isMobileField) ...[
        WesternDigitsInputFormatter(),
        FilteringTextInputFormatter.digitsOnly,
      ] else ...[
        FilteringTextInputFormatter.allow(allowedPattern),
        AppNoExtraSpaceInputFormatter(),
      ],
      if (maxLength > 0) LengthLimitingTextInputFormatter(maxLength),
    ];

    return AppTextFormField(
      controller: controller,
      labelText: isRequired ? '$label *' : label,
      hintText: 'core.actionTypes.enter'.tr(namedArgs: {'fieldName': label}),
      textCapitalization: isEmailField
          ? TextCapitalization.none
          : TextCapitalization.characters,
      keyboardType: isMobileField
          ? TextInputType.phone
          : isNumeric
          ? TextInputType.number
          : isEmailField
          ? TextInputType.emailAddress
          : TextInputType.text,
      inputFormatters: formatters,
      readOnly: readOnly,
      prefixIcon: isMobileField
          ? Center(
              widthFactor: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  '+${AppGlobal.appCountryCode}',
                  textDirection: ui.TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            )
          : null,
      prefixIconConstraints: isMobileField
          ? BoxConstraints(minWidth: 0, minHeight: 44.h)
          : null,
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
      errorText: errorText,
      textInputAction: TextInputAction.next,
      onChanged: readOnly ? null : (value) => onChanged(key, value, effectiveField),
    );
  }
}