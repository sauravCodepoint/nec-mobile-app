import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme_ext.dart';

enum SideWidgetPosition { left, right }

class AppButton extends HookWidget {
  final String text;
  final Widget? sideWidget;
  final SideWidgetPosition sideWidgetPosition;
  final bool useSpaceBetween;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool isLoading;
  final bool showAcknowledgement;

  /// Greys the button out and swallows taps — for a CTA that is visible but
  /// not yet actionable (e.g. a Continue button waiting on a selection).
  /// Prefer this over conditionally removing the button, which shifts the
  /// layout around it the moment the user acts.
  final bool isDisabled;

  /// Optional plain acknowledgement label. When provided it replaces the
  /// default Terms & Conditions consent row (prefix + tappable T&C link) with
  /// static consent text — used when the acknowledgement is a policy statement
  /// the user simply consents to, with no link to open (so [onPolicyTap] and
  /// [requireReadBeforeAcknowledge] don't apply).
  final String? acknowledgementLabel;
  final ValueChanged<bool>? onAcknowledgementChanged;
  final Border? border;
  final VoidCallback? onPolicyTap;

  /// When true the checkbox is locked until the user taps the T&C link.
  final bool requireReadBeforeAcknowledge;

  /// Called when the button is tapped while the acknowledgement checkbox is
  /// unchecked. Use this to show a toast prompting the user to read and accept.
  final VoidCallback? onUnacknowledgedTap;

  const AppButton({
    super.key,
    required this.text,
    this.sideWidget,
    this.sideWidgetPosition = SideWidgetPosition.left,
    this.useSpaceBetween = false,
    this.onTap,
    this.width,
    this.height,
    this.textStyle,
    this.backgroundColor,
    this.isLoading = false,
    this.isDisabled = false,
    this.showAcknowledgement = false,
    this.acknowledgementLabel,
    this.onAcknowledgementChanged,
    this.onPolicyTap,
    this.border,
    this.requireReadBeforeAcknowledge = false,
    this.onUnacknowledgedTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isAcknowledged = useState(false);
    final hasReadTerms = useState(false);

    final mustReadFirst = requireReadBeforeAcknowledge && !hasReadTerms.value;

    final buttonBlocked = showAcknowledgement && !isAcknowledged.value;

    // Disabled and blocked share one muted fill; they differ only in what a
    // tap does — blocked nudges the user to accept the terms, disabled
    // ignores the tap outright.
    final isMuted = isDisabled || buttonBlocked;

    // Matches the AppSlideButton acknowledgement styling so both confirm
    // controls render the same T&C row.
    final baseTextStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: colorScheme.onSurface,
    );

    // A plain consent label is usually a long policy paragraph — render it as
    // muted fine print (smaller, comfortable line height) so it doesn't shout,
    // and top-align the checkbox to the first line instead of floating it
    // against the centre of a tall block.
    final isPlainLabel = acknowledgementLabel != null;
    final plainLabelStyle = baseTextStyle?.copyWith(
      fontSize: 12.5.sp,
      color: context.appColors.muted,
      height: 1.4,
    );

    final linkStyle = baseTextStyle?.copyWith(
      color: colorScheme.tertiary,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
      fontSize: 14.5.sp,
    );

    void handlePolicyTap() {
      if (requireReadBeforeAcknowledge) hasReadTerms.value = true;
      onPolicyTap?.call();
    }

    void handleCheckboxToggle() {
      if (isLoading || isDisabled) return;
      if (mustReadFirst) {
        onUnacknowledgedTap?.call();
        return;
      }
      final newValue = !isAcknowledged.value;
      isAcknowledged.value = newValue;
      onAcknowledgementChanged?.call(newValue);
    }

    // Stable recognizer instance — onTap is updated every build so it always
    // closes over the latest handlePolicyTap without recreating the object.
    final policyRecognizer = useMemoized(() => TapGestureRecognizer());
    useEffect(() => policyRecognizer.dispose, const []);
    policyRecognizer.onTap = handlePolicyTap;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showAcknowledgement) ...[
          Row(
            crossAxisAlignment: isPlainLabel
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: handleCheckboxToggle,
                child: IgnorePointer(
                  child: Checkbox(
                    value: isAcknowledged.value,
                    onChanged: (_) {},
                    checkColor: colorScheme.surface,
                    activeColor: colorScheme.onPrimaryContainer,
                    side: BorderSide(
                      color: colorScheme.onSurface,
                      width: 1.5.w,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: handleCheckboxToggle,
                  child: isPlainLabel
                      ? Padding(
                          // Nudge the paragraph down so its first line sits
                          // level with the top-aligned checkbox.
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            acknowledgementLabel!,
                            style: plainLabelStyle,
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                            style: baseTextStyle,
                            children: [
                              TextSpan(text: 'core.tncConsent.prefix'.tr()),
                              TextSpan(
                                text: 'core.tncConsent.termsAndConditions'.tr(),
                                style: linkStyle,
                                recognizer: policyRecognizer,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
        ],
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: isLoading || isDisabled
              ? null
              : buttonBlocked
              ? onUnacknowledgedTap
              : onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            width: width ?? 1.sw,
            height: height ?? 55.w,
            decoration: BoxDecoration(
              color: isMuted
                  ? colorScheme.onSurface.withValues(alpha: 0.39)
                  : backgroundColor ?? context.appColors.brandFill,
              borderRadius: BorderRadius.circular(8.r),
              border: border,
            ),
            child: Center(
              child: isLoading
                  ? CupertinoActivityIndicator(
                      radius: 12.r,
                      color: colorScheme.primary,
                    )
                  : Row(
                      mainAxisSize: useSpaceBetween
                          ? MainAxisSize.max
                          : MainAxisSize.min,
                      mainAxisAlignment: useSpaceBetween
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        if (sideWidget != null &&
                            sideWidgetPosition == SideWidgetPosition.left) ...[
                          sideWidget!,
                          if (!useSpaceBetween) SizedBox(width: 8.w),
                        ],
                        Flexible(
                          // Scale long labels down instead of ellipsizing —
                          // side-by-side dialog buttons (e.g. the Arabic
                          // "use anyway" label) get ~half the dialog width
                          // and would otherwise truncate mid-word.
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              text,
                              maxLines: 1,
                              style:
                                  textStyle ??
                                  theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.primary,
                                  ),
                            ),
                          ),
                        ),
                        if (sideWidget != null &&
                            sideWidgetPosition == SideWidgetPosition.right) ...[
                          if (!useSpaceBetween) SizedBox(width: 8.w),
                          sideWidget!,
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
