import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/common/common_selectable_dto.dart';
import '../../../domain/complete_profile/value_validators.dart';
import '../../../domain/common/common_member_field_dto.dart';
import '../../../domain/core/failures.dart';
import '../../core/text_form_field/app_text_form_field.dart';
import '../../routes/app_routes.gr.dart';
import '../../core/theme/app_theme_ext.dart';

class CompleteProfileDropdown extends HookWidget {
  final MemberFieldSetting field;
  final Map<String, DynamicFieldInput> dynamicFieldValues;
  final Map<String, List<CommonSelectableItem>> comboOptions;
  final bool showErrorMessages;
  final bool isShowLeading;

  /// True when the value is fixed by the app (e.g. Nationality pinned to Oman).
  /// The field renders with a lock icon and tapping is suppressed.
  final bool readOnly;

  /// True while the dependent data for this field is being fetched (e.g. cities
  /// after a state is selected). Tapping is suppressed and a spinner is shown.
  final bool isLoading;

  /// True when this field depends on another field that has not yet been
  /// selected. The field is rendered disabled with [awaitingHint] as guidance.
  final bool isAwaitingParent;

  /// Hint shown in the field when [isAwaitingParent] is true.
  final String? awaitingHint;

  /// True when the API returned no options for this field. Renders disabled
  /// with a dash icon so the user knows it is intentionally inactive.
  final bool isUnavailable;

  final void Function(
    String fieldName,
    String value,
    MemberFieldSetting field,
  ) onChanged;

  const CompleteProfileDropdown({
    super.key,
    required this.field,
    required this.dynamicFieldValues,
    required this.comboOptions,
    required this.showErrorMessages,
    required this.onChanged,
    this.isShowLeading = false,
    this.readOnly = false,
    this.isLoading = false,
    this.isAwaitingParent = false,
    this.awaitingHint,
    this.isUnavailable = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final controller = useTextEditingController();

    final key = field.fieldName ?? '';
    final label = field.displayFieldName ?? field.fieldName ?? '';
    final isRequired = field.mandatory ?? false;

    final selectedCode =
        dynamicFieldValues[key]?.value.getOrElse(() => '') ?? '';
    final comboList = comboOptions[key] ?? [];
    final matchedItem = comboList.firstWhereOrNull(
      (item) => (item.titleCode ?? '') == selectedCode,
    );
    final displayName = matchedItem?.titleName ?? '';

    // Treat an empty option list as unavailable too. Without this, a dropdown
    // whose API returned zero options renders as a normal tappable field that
    // silently does nothing on tap (the onTap guard bails on an empty list),
    // which reads as an app bug. Loading/awaiting-parent states are excluded
    // because their emptiness is transient, not a genuine "no options" result.
    final effectiveUnavailable = isUnavailable ||
        (comboList.isEmpty && !isLoading && !isAwaitingParent && !readOnly);

    // When unavailable, surface the message as the controller value so it
    // renders at full opacity instead of as a faint disabled hint.
    final unavailableText =
        effectiveUnavailable ? 'completeProfile.dropdown.noOptions'.tr() : null;

    useEffect(() {
      final text = unavailableText ??
          (displayName.isNotEmpty ? displayName.toUpperCase() : '');
      if (controller.text != text) controller.text = text;
      return null;
    }, [displayName, unavailableText]);

    // Suppress validation error while field is in a non-interactive state.
    final isBlocked = isAwaitingParent || isLoading || effectiveUnavailable;
    final isValueValid = selectedCode.isNotEmpty && matchedItem != null;

    final errorText = (!isBlocked && showErrorMessages)
        ? (!isValueValid && isRequired)
              ? 'core.validation.empty'.tr(namedArgs: {'fieldName': label})
              : dynamicFieldValues[key]?.value.fold(
                  (failure) => failure.maybeMap(
                    empty: (_) => 'core.validation.empty'.tr(
                      namedArgs: {'fieldName': label},
                    ),
                    orElse: () => null,
                  ),
                  (_) => null,
                )
        : null;

    final Widget suffixWidget;
    if (readOnly) {
      suffixWidget = field.isFromMalaa == true
          ? Icon(
              Icons.auto_awesome_rounded,
              size: 16.sp,
              color: colorScheme.tertiary,
            )
          : Icon(
              Icons.lock_outline_rounded,
              size: 16.sp,
              color: colorScheme.onSurfaceVariant,
            );
    } else if (isLoading) {
      suffixWidget = Padding(
        padding: EdgeInsets.all(12.w),
        child: SizedBox(
          width: 18.w,
          height: 18.w,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colorScheme.tertiary.withValues(alpha: 0.6),
          ),
        ),
      );
    } else if (isAwaitingParent) {
      suffixWidget = Icon(
        Icons.lock_outline_rounded,
        color: context.appColors.glassBorder.withValues(alpha: 0.3),
        size: 18.sp,
      );
    } else if (effectiveUnavailable) {
      suffixWidget = Icon(
        Icons.remove_rounded,
        color: context.appColors.glassBorder.withValues(alpha: 0.25),
        size: 18.sp,
      );
    } else {
      suffixWidget = Icon(
        Icons.keyboard_arrow_down_rounded,
        color: colorScheme.tertiary,
      );
    }

    final effectiveHint = isAwaitingParent
        ? (awaitingHint ??
            'core.actionTypes.select'.tr(namedArgs: {'fieldName': label}))
        : isLoading
            ? 'completeProfile.city.loading'.tr()
            : effectiveUnavailable
                ? 'completeProfile.dropdown.noOptions'.tr()
                : 'core.actionTypes.select'.tr(namedArgs: {'fieldName': label});

    return AppTextFormField(
      controller: controller,
      labelText: isRequired ? '$label *' : label,
      hintText: effectiveHint,
      readOnly: true,
      showCursor: false,
      enabled: null,
      errorText: errorText,
      suffixIcon: suffixWidget,
      onTap: () {
        if (readOnly || isBlocked || comboList.isEmpty) return;
        context.router.push(
          AppSelectableRoute(
            title: label,
            isShowLeading: isShowLeading,
            initialSelectedItem: comboList.firstWhereOrNull(
              (item) => item.titleCode == selectedCode,
            ),
            commonSelectableDto: CommonSelectableDto(
              data: CommonSelectableData(list: comboList),
            ),
            onSelected: (value) => onChanged(key, value.titleCode ?? '', field),
          ),
        );
      },
    );
  }
}