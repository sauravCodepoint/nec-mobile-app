import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

import '../../../application/beneficiary/beneficiary_bloc.dart';
import '../../../domain/beneficiary/beneficiary_field_keys.dart';
import '../../../domain/beneficiary/beneficiary_product_field_settings_dto.dart';
import '../../../domain/common/common_selectable_dto.dart';
import '../../../domain/core/failures.dart';
import '../../core/global/app_global.dart';
import '../../core/text_form_field/app_text_form_field.dart';
import '../../routes/app_routes.gr.dart';
import 'beneficiary_animations.dart';
import 'beneficiary_previous_value_hint.dart';
import '../../core/theme/app_theme_ext.dart';

class BeneficiaryDropdown extends HookWidget {
  final Beneficiary field;
  final BeneficiaryState state;

  const BeneficiaryDropdown({
    super.key,
    required this.field,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final controller = useTextEditingController();

    final fieldKey = BeneficiaryFieldKeys.normalize(field.fieldName);
    final isBankField = fieldKey == BeneficiaryFieldKeys.bankCode;
    final isBranchField = fieldKey == BeneficiaryFieldKeys.branchCode;
    final isRouteField = fieldKey == BeneficiaryFieldKeys.routeCode;
    // Cascade fields load their options after a parent selection, so an empty
    // list is a normal transient state for them — but for every other dropdown
    // it means the field has no mapped option source.
    final isCascadeField = isBankField || isBranchField || isRouteField;

    // Server-disabled field with a prefilled value — rendered read-only.
    final isLocked = state.lockedFields.contains(field.fieldName ?? '');

    // Stored codes are clean at ingestion (composite "bank|branch" values are
    // split once in the BLoC) and keep their original case for exact matching.
    final selectedCode =
        state.dynamicFieldValues[field.fieldName]?.value.getOrElse(() => '') ??
            '';

    final isFieldLoading =
        (isBranchField && state.isLoading) ||
            (isRouteField && state.isRouteCodeLoading);

    final comboList = state.comboLists[fieldKey] ?? [];

    final matchedItem = comboList.firstWhereOrNull(
          (item) => item.code.trim() == selectedCode.trim(),
    );

    // Fall back to the raw code so a stored value is never invisible while its
    // combo list is still loading. Once a list has actually arrived the BLoC
    // clears any code it doesn't contain (see _pruneUnmatchedComboValues), so
    // this fallback only shows during load or when the list came back empty.
    final displayName = matchedItem?.name ?? selectedCode;

    // Backend-provided reminder of the previously chosen option (re-KYC /
    // update flows). Resolve the stored code to its display name through the
    // same combo list, falling back to the inline dropdown_items and finally
    // the raw code. Hidden once it matches the current selection.
    final previousCode = (field.previousValue ?? '').trim();
    final previousName =
        comboList
            .firstWhereOrNull((item) => item.code.trim() == previousCode)
            ?.name ??
        (field.dropdownItems ?? const [])
            .firstWhereOrNull((item) => (item.code ?? '').trim() == previousCode)
            ?.name ??
        previousCode;
    final showPreviousValue =
        previousCode.isNotEmpty && previousCode != selectedCode.trim();

    useEffect(() {
      final text = displayName.toUpperCase();

      if (controller.text != text) {
        controller.text = text;
      }

      return null;
    }, [displayName]);

    // Branch field requires a bank to be selected first.
    if (isBranchField) {
      final bankCode =
          state.dynamicFieldValues[FieldNames.beneficiaryBankCode.name]
              ?.value
              .getOrElse(() => '') ??
              '';
      // The bank is a dynamic form field, but its `beneficiaryBankCode` entry
      // isn't always in dynamicFieldValues yet (e.g. edit prefill loads the
      // branch combo via getBranchCombo without going through
      // beneficiaryBankComboChanged). Fall back to the bank code the branch
      // list was actually loaded for; without this, editing shows the "select
      // bank first" placeholder even though a bank is already chosen.
      final hasBankSelected =
          bankCode.isNotEmpty || state.selectedBankComboCode.isNotEmpty;
      if (!hasBankSelected) {
        return AppTextFormField(
          controller: TextEditingController(),
          labelText: field.displayFieldName,
          hintText: 'beneficiaries.beneficiaryForm.branchDisabled'.tr(),
          readOnly: true,
          showCursor: false,
          enabled: false,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.appColors.glassBorder.withValues(alpha: 0.3),
          ),
        );
      }
    }

    // A non-cascade dropdown with no options is a mapping/backend gap: render
    // it visibly disabled instead of a dead tap so the form isn't silently
    // stuck on a mandatory field the user can never fill.
    if (comboList.isEmpty && !isCascadeField && !isFieldLoading) {
      if (kDebugMode) {
        debugPrint(
          'BeneficiaryDropdown: no combo options for field '
              '"${field.fieldName}" (key "$fieldKey") — check the field-key '
              'mapping and the combo API response.',
        );
      }
      return AppTextFormField(
        controller: controller,
        labelText: field.displayFieldName,
        hintText: 'beneficiaries.beneficiaryForm.noOptions'.tr(),
        readOnly: true,
        showCursor: false,
        enabled: false,
        errorText:
        state.showErrorMessages &&
            (field.mandatory ?? false) &&
            selectedCode.isEmpty
            ? 'beneficiaries.beneficiaryForm.noOptions'.tr()
            : null,
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: context.appColors.glassBorder.withValues(alpha: 0.3),
        ),
      );
    }

    Widget fieldWidget = AppTextFormField(
      controller: controller,
      labelText: field.displayFieldName,
      helper: showPreviousValue
          ? BeneficiaryPreviousValueHint(
              value: previousName,
              isSelection: true,
            )
          : null,
      hintText: 'core.actionTypes.select'.tr(
        namedArgs: {'fieldName': field.displayFieldName ?? ''},
      ),
      readOnly: true,
      showCursor: false,
      suffixIcon: isLocked
          ? Icon(
        Icons.lock_outline_rounded,
        size: 16.sp,
        color: theme.colorScheme.onSurfaceVariant,
      )
          : AnimatedDropdownSuffix(
        isLoading: isFieldLoading,
        color: colorScheme.tertiary,
      ),

      // Validity comes from the stored code, never from whether the combo list
      // has finished loading — a filled field must not error while its display
      // name is still being resolved.
      errorText: state.showErrorMessages
          ? (selectedCode.isEmpty && (field.mandatory ?? false))
          ? 'core.validation.empty'.tr(
        namedArgs: {'fieldName': field.displayFieldName ?? ''},
      )
          : state.dynamicFieldValues[field.fieldName]?.value.fold(
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
          orElse: () => null,
        ),
            (_) => null,
      )
          : null,

      onTap: () {
        if (isLocked) return;
        if (isFieldLoading) return;
        if (comboList.isEmpty) return;

        final commonSelectableDto = CommonSelectableDto(
          data: CommonSelectableData(
            list: comboList
                .map(
                  (item) => CommonSelectableItem(
                titleName: item.name.toUpperCase(),
                titleCode: item.code,
                trailingCode: item.code,
              ),
            )
                .toList(),
          ),
        );

        final selectedItem = commonSelectableDto.data?.list?.firstWhereOrNull(
              (item) => item.titleCode == selectedCode,
        );

        final uiConfig = AppGlobal.getDropdownUiConfig(field.fieldName);

        context.router.push(
          AppSelectableRoute(
            title: field.displayFieldName ?? '',
            isShowLeading: uiConfig.isShowLeading,
            isShowTrailing: uiConfig.isShowTrailing,
            initialSelectedItem: selectedItem,
            commonSelectableDto: commonSelectableDto,
            onSelected: (value) {
              final selectedCode = value.titleCode ?? '';
              final selectedName = value.titleName ?? '';

              if (isBranchField) {
                // Branch selected: triggers route-code fetch for this branch.
                context.read<BeneficiaryBloc>().add(
                  BeneficiaryEvent.beneficiaryBranchComboChanged(
                    branchCode: selectedCode,
                    branchName: selectedName,
                  ),
                );
              } else if (isRouteField) {
                // IFSC/route-code selected from dropdown: trigger immediate reverse
                // lookup to auto-fill the matching Bank and Branch dropdowns.
                // Uses beneficiaryRouteCodeSelected (no debounce) rather than the
                // text-field variant which is debounced for keystroke efficiency.
                context.read<BeneficiaryBloc>().add(
                  BeneficiaryEvent.beneficiaryRouteCodeSelected(selectedCode),
                );
              } else if (isBankField) {
                // Bank changed: stores the bank, clears the dependent branch
                // and route-code fields, and fetches the branch list only when
                // the product configures a branch field.
                context.read<BeneficiaryBloc>().add(
                  BeneficiaryEvent.beneficiaryBankComboChanged(
                    bankCode: selectedCode,
                    bankName: selectedName,
                  ),
                );
              } else {
                context.read<BeneficiaryBloc>().add(
                  BeneficiaryEvent.beneficiaryProductFieldChanged(
                    backendField: field,
                    value: selectedCode,
                  ),
                );
              }
            },
          ),
        );
      },
    );

    // Apply per-field animation wrappers.
    if (isBankField || isBranchField) {
      fieldWidget = AutoFillGlow(observedValue: displayName, child: fieldWidget);
    } else if (isRouteField) {
      fieldWidget = LookupBorderPulse(
        isActive: state.isRouteLookupLoading,
        child: fieldWidget,
      );
    }

    return fieldWidget;
  }
}