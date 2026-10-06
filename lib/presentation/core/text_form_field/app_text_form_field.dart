import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme_ext.dart';

class AppTextFormField extends HookWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool autofocus;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool autocorrect;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final bool showCursor;
  final bool isLabelVisible;
  final bool? enabled;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final String? errorText;

  /// Optional supporting widget rendered in the same slot as the error row
  /// (below the field, same gap). Shown only when there is no error, so a
  /// validation message always takes precedence. Use for quiet hints like the
  /// "previously selected" reminder — keeps the field's spacing consistent
  /// instead of stacking an extra block that inflates inter-field gaps.
  final Widget? helper;

  final BoxConstraints? prefixIconConstraints;
  final TextInputAction? textInputAction;
  final bool enableSuggestions;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLines;

  /// Overrides the dimmed value-text color applied when [enabled] is false.
  /// Use for locked-but-filled fields whose value must stay as readable as
  /// an editable field's (e.g. the lock-suffixed ID fields on Update KYC).
  final Color? disabledTextColor;

  const AppTextFormField({
    super.key,
    this.controller,
    this.inputFormatters,
    this.onTap,
    this.keyboardType,
    this.initialValue,
    this.labelText,
    this.labelStyle,
    this.autofocus = false,
    this.hintText,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.autocorrect = true,
    this.focusNode,
    this.enableInteractiveSelection = true,
    this.showCursor = true,
    this.isLabelVisible = true,
    this.enabled,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.errorText,
    this.helper,
    this.prefixIconConstraints,
    this.textInputAction,
    this.enableSuggestions = true,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.disabledTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final internalNode = useFocusNode();
    final effectiveNode = focusNode ?? internalNode;
    final hasFocus = useState(false);

    useEffect(() {
      void listener() => hasFocus.value = effectiveNode.hasFocus;
      effectiveNode.addListener(listener);
      return () => effectiveNode.removeListener(listener);
    }, [effectiveNode]);

    final validatorError = useState<String?>(null);
    final wrappedValidator = validator == null
        ? null
        : (String? v) {
            final result = validator!(v);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) validatorError.value = result;
            });
            return result;
          };

    final hasError = errorText != null || validatorError.value != null;
    final isDisabled = enabled == false;

    final borderRadius = BorderRadius.circular(10.r);

    final borderColor = isDisabled
        ? context.appColors.glassBorder.withValues(alpha: 0.12)
        : hasError
        ? cs.error
        : hasFocus.value
        ? cs.tertiary
        : context.appColors.glassBorder.withValues(alpha: 0.22);

    const borderWidth = 0.8;

    final border = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );

    final labelColor = isDisabled
        ? cs.onSurface.withValues(alpha: 0.30)
        : hasError
        ? cs.error
        : hasFocus.value
        ? cs.tertiary
        : cs.onSurface.withValues(alpha: 0.65);

    final iconColor = isDisabled
        ? context.appColors.glassBorder.withValues(alpha: 0.30)
        : hasError
        ? cs.error
        : hasFocus.value
        ? cs.tertiary
        : cs.onSurface.withValues(alpha: 0.55);

    final resolvedLabelStyle =
        (labelStyle ?? theme.textTheme.labelMedium ?? const TextStyle())
            .copyWith(
              fontSize: 12.sp,
              fontWeight: hasFocus.value ? FontWeight.w600 : FontWeight.w500,
              color: labelColor,
              letterSpacing: 0.3,
            );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            // Accent glow on focus only; a resting field carries no shadow on
            // the dark canvas.
            boxShadow: isDisabled || hasError || !hasFocus.value
                ? null
                : [
                    BoxShadow(
                      color: cs.tertiary.withValues(alpha: 0.13),
                      blurRadius: 12,
                      spreadRadius: -1,
                    ),
                  ],
          ),
          child: TextFormField(
            initialValue: initialValue,
            controller: controller,
            onChanged: onChanged,
            validator: wrappedValidator,
            inputFormatters: inputFormatters,
            cursorColor: cs.tertiary,
            cursorWidth: 1.5,
            onTap: onTap,
            keyboardType: keyboardType,
            autofocus: autofocus,
            autocorrect: autocorrect,
            focusNode: effectiveNode,
            showCursor: showCursor,
            maxLines: maxLines,
            enableInteractiveSelection: enableInteractiveSelection,
            enabled: enabled,
            readOnly: readOnly,
            textCapitalization: textCapitalization,
            textInputAction: textInputAction,
            enableSuggestions: enableSuggestions,
            onFieldSubmitted: onFieldSubmitted,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDisabled
                  ? disabledTextColor ?? cs.onSurface.withValues(alpha: 0.4)
                  : cs.onSurface,
            ),
            decoration: InputDecoration(
              filled: true,
              // null falls through to the theme's inputDecorationTheme fill.
              fillColor: null,
              isDense: true,
              labelText: isLabelVisible ? labelText : null,
              labelStyle: resolvedLabelStyle,
              floatingLabelStyle: resolvedLabelStyle,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: hintText,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: cs.onSurface.withValues(alpha: 0.32),
              ),
              suffixIcon: suffixIcon,
              prefix: prefix,
              prefixIcon: prefixIcon != null
                  ? IconTheme(
                      data: IconThemeData(color: iconColor, size: 18.sp),
                      child: prefixIcon!,
                    )
                  : null,
              prefixIconConstraints:
                  prefixIconConstraints ??
                  BoxConstraints(minWidth: 40.w, minHeight: 40.h),
              errorText: null,
              errorStyle: const TextStyle(fontSize: 0.001, height: 0.001),
              enabledBorder: border,
              focusedBorder: border,
              disabledBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
            ),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: 5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.5.h),
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 11.sp,
                  color: cs.error,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  errorText ?? validatorError.value!,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.error,
                    fontSize: 11.sp,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ] else if (helper != null) ...[
          SizedBox(height: 5.h),
          helper!,
        ],
      ],
    );
  }
}
