import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/beneficiary/beneficiary_bloc.dart';
import '../../../domain/beneficiary/beneficiary_product_field_settings_dto.dart';
import '../../../domain/core/failures.dart';
import '../../core/country/app_country.dart';
import '../../core/global/app_global.dart';
import '../../core/input_formatter/app_no_extra_space_input_formatter.dart';
import '../../core/input_formatter/app_upper_case_input_formatter.dart';
import '../../core/input_formatter/app_western_digits_input_formatter.dart';
import '../../core/text_form_field/app_text_form_field.dart';
import '../../core/theme/app_theme_ext.dart';
import 'beneficiary_previous_value_hint.dart';

class BeneficiaryTextField extends HookWidget {
  final Beneficiary field;
  final BeneficiaryState state;
  const BeneficiaryTextField({
    super.key,
    required this.field,
    required this.state,
  });

  /// Escapes a backend-provided character list for use inside a regex
  /// character class. `RegExp.escape` alone leaves `-` bare, which would
  /// otherwise be interpreted as a range.
  static String _escapeForCharClass(String chars) => chars
      .split('')
      .map((c) => c == '-' ? r'\-' : RegExp.escape(c))
      .join();

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    // Every ValueFailure carries the exact input that produced it, so read the
    // value back through failedValue rather than keeping controller.text: a
    // field the BLoC clears validates to Empty (failedValue '') and must go
    // blank on screen, while a value the user typed that failed validation is
    // still their own text and stays put. Falling back to controller.text made
    // a cleared mandatory field — e.g. the route code reset by a bank/branch
    // change — keep displaying its old value forever.
    final initialValue = state.dynamicFieldValues[field.fieldName]?.value.fold(
      (failure) => failure.failedValue,
      (value) => value,
    );
    final selectedCountry = CountryUtils.getCountryByCode(
      state.selectedBeneficiaryCountry?.titleCode ?? '',
    );
    useEffect(() {
      // Uppercase prefill / auto-fill too, so the shown value matches the
      // always-uppercase rule enforced on typed input below.
      final newText = (initialValue ?? '').toUpperCase();
      // Only push state back into the controller when it actually differs
      // (prefill / auto-fill). Re-assigning the same text on the bloc echo of
      // the user's own keystroke resets the selection, jumping the cursor to
      // the end while editing mid-text.
      if (controller.text != newText) {
        controller.text = newText;
      }
      return null;
    }, [initialValue]);
    final isMobileField = AppGlobal.isMobileNumberField(field.fieldName) != null;
    // Server-disabled field with a prefilled value — rendered read-only.
    final isLocked = state.lockedFields.contains(field.fieldName ?? '');
    final isNumeric =
        (field.supportedDataType ?? '').trim().toUpperCase() == 'N';
    final maxLength = field.maximumLength ?? 0;
    // Whitelist driven by the backend field settings: digits only for numeric
    // fields; otherwise letters, digits, single spaces and only the special
    // characters the backend explicitly allows for this field. Arabic fields
    // additionally accept the Arabic letter range.
    final allowedSpecials = _escapeForCharClass(
      field.allowedSpecialCharacters ?? '',
    );
    final arabicRange = (field.isArabic ?? false) ? '\u0600-\u06FF' : '';
    final allowedPattern = RegExp('[a-zA-Z0-9 $arabicRange$allowedSpecials]');

    // Backend-provided reminder of what was entered before (re-KYC / update
    // flows). Hidden once the current value already matches it — no point
    // reminding the user of a value they already have in the field.
    final previousValue = (field.previousValue ?? '').trim();
    final showPreviousValue =
        previousValue.isNotEmpty &&
        previousValue.toLowerCase() != (initialValue ?? '').trim().toLowerCase();

    return AppTextFormField(
      controller: controller,
      helper: showPreviousValue
          ? BeneficiaryPreviousValueHint(
              value: previousValue,
              isSelection: false,
            )
          : null,
      labelText: field.displayFieldName,
      hintText: 'core.actionTypes.enter'.tr(
        namedArgs: {'fieldName': field.displayFieldName ?? ''},
      ),
      textCapitalization: TextCapitalization.characters,
      keyboardType: isMobileField
          ? TextInputType.phone
          : isNumeric
          ? TextInputType.number
          : TextInputType.text,
      inputFormatters: [
        if (isNumeric || isMobileField) ...[
          WesternDigitsInputFormatter(),
          FilteringTextInputFormatter.digitsOnly,
        ] else ...[
          FilteringTextInputFormatter.allow(allowedPattern),
          AppNoExtraSpaceInputFormatter(),
          // Force every text value to uppercase — covers typing, paste and IME
          // input, which TextCapitalization.characters alone does not guarantee.
          AppUpperCaseTextFormatter(),
        ],
        if (maxLength > 0) LengthLimitingTextInputFormatter(maxLength),
      ],
      prefixIcon:
          field.fieldName == AppGlobal.isMobileNumberField(field.fieldName) &&
              selectedCountry?.dialCode != null
          ? Container(
              padding: EdgeInsetsDirectional.only(start: 12.w, end: 8.w),
              margin: EdgeInsetsDirectional.only(end: 8.w),
              decoration: BoxDecoration(
                border: BorderDirectional(
                  end: BorderSide(
                    color: context.appColors.glassBorder.withValues(alpha: 0.18),
                    width: 0.8,
                  ),
                ),
              ),
              child: Text(
                '${selectedCountry?.dialCode}',
                // Force LTR so the leading '+' stays on the left in Arabic (RTL)
                // instead of rendering as "91+".
                textDirection: ui.TextDirection.ltr,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : null,
      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      readOnly: isLocked,
      suffixIcon: isLocked
          ? Icon(
              Icons.lock_outline_rounded,
              size: 16.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            )
          : null,
      onChanged: isLocked
          ? null
          : (value) {
        // Route code is a free-text field: typing it triggers the debounced
        // reverse lookup (getBeneficiaryBankBranchFromRoute) which auto-fills the
        // matching Bank and Branch fields. Mirrors the dropdown's
        // beneficiaryRouteCodeSelected path.
        if (field.fieldName?.toLowerCase() ==
            FieldNames.routeCode.name.toLowerCase()) {
          context.read<BeneficiaryBloc>().add(
            BeneficiaryEvent.beneficiaryRouteCodeChanged(value),
          );
        } else {
          context.read<BeneficiaryBloc>().add(
            BeneficiaryEvent.beneficiaryProductFieldChanged(
              backendField: field,
              value: value,
            ),
          );
        }
      },
      errorText: state.showErrorMessages
          ? state.dynamicFieldValues[field.fieldName]?.value.fold(
              (failure) => failure.maybeMap(
                empty: (_) => 'core.validation.empty'.tr(
                  namedArgs: {'fieldName': field.displayFieldName ?? ''},
                ),
                tooShort: (_) => 'core.validation.tooShort'.tr(
                  namedArgs: {'fieldName': field.displayFieldName ?? ''},
                ),
                tooLong: (_) => 'core.validation.tooLong'.tr(
                  namedArgs: {'fieldName': field.displayFieldName ?? ''},
                ),
                invalidFormat: (_) => 'core.validation.invalidFormat'.tr(
                  namedArgs: {'fieldName': field.displayFieldName ?? ''},
                ),
                invalidMobileNumber: (_) => null,
                invalidOtp: (_) => null,
                orElse: () => null,
              ),
              (_) => null,
            )
          : null,
    );
  }
}
