import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme_ext.dart';

class AppSlideButton extends HookWidget {
  final double amount;
  final String currencyCode;
  final VoidCallback onConfirm;
  final bool canConfirm;
  final VoidCallback? onValidationFailed;

  /// Gates whether the slide can actually complete. While `false` (e.g. the
  /// screen is still loading its data) the track is dimmed; a slide attempt
  /// snaps back and fires [onNotReady]. When it flips to `true` the button
  /// smoothly fades in to life.
  final bool enabled;

  /// Called when the user slides far enough to confirm while [enabled] is
  /// `false` — use it to surface a "please wait" message.
  final VoidCallback? onNotReady;

  final bool showAcknowledgement;
  final ValueChanged<bool>? onAcknowledgementChanged;

  final VoidCallback? onTncTap;

  const AppSlideButton({
    super.key,
    required this.amount,
    required this.currencyCode,
    required this.onConfirm,
    this.canConfirm = true,
    this.onValidationFailed,
    this.enabled = true,
    this.onNotReady,
    this.showAcknowledgement = false,
    this.onAcknowledgementChanged,
    this.onTncTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final position = useState(0.0);
    final completed = useState(false);

    final controller = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    final animation = useRef<Animation<double>?>(null);

    final isAcknowledged = useState(false);

    final tncRecognizer = useMemoized(() => TapGestureRecognizer());
    final kfsRecognizer = useMemoized(() => TapGestureRecognizer());
    final dppRecognizer = useMemoized(() => TapGestureRecognizer());

    useEffect(() {
      tncRecognizer.onTap = onTncTap;

      return () {
        tncRecognizer.dispose();
        kfsRecognizer.dispose();
        dppRecognizer.dispose();
      };
    }, [onTncTap]);

    useEffect(() {
      void listener() {
        if (animation.value != null) {
          position.value = animation.value!.value;
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    void animateTo(double target) {
      controller.stop();

      animation.value = Tween<double>(begin: position.value, end: target)
          .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
          );

      controller
        ..reset()
        ..forward();
    }

    // When the button gets disabled mid-slide, snap the thumb back so it never
    // sits half-way while dimmed.
    useEffect(() {
      if (!enabled && position.value != 0) {
        completed.value = false;
        animateTo(0);
      }
      return null;
    }, [enabled]);

    // The thumb can be dragged once the acknowledgement (if any) is given —
    // even while not [enabled], so a slide attempt can surface feedback.
    final canDrag = !showAcknowledgement || isAcknowledged.value;

    // Fully interactive (undimmed) only once enabled and acknowledged.
    final isInteractive = enabled && canDrag;

    final baseTextStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: colorScheme.onSurface,
    );

    final linkStyle = baseTextStyle?.copyWith(
      color: colorScheme.tertiary,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
      fontSize: 14.5.sp,
    );

    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showAcknowledgement) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: isAcknowledged.value,
                onChanged: (value) {
                  if (value != null) {
                    isAcknowledged.value = value;
                    onAcknowledgementChanged?.call(value);
                  }
                },
                visualDensity: VisualDensity.compact,
                activeColor: colorScheme.onPrimaryContainer,
                checkColor: colorScheme.surface,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                side: BorderSide(color: colorScheme.onSurface, width: 1.5.w),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: baseTextStyle,
                    children: [
                      TextSpan(text: 'core.tncConsent.prefix'.tr()),
                      TextSpan(
                        text: 'core.tncConsent.termsAndConditions'.tr(),
                        style: linkStyle,
                        recognizer: tncRecognizer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],

        LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final halfWidth = totalWidth / 2;
            final maxSlide = halfWidth;

            // In RTL the thumb starts on the right (offset = maxSlide) and
            // slides left toward 0. In LTR the thumb starts at 0 and slides right.
            final thumbOffset = isRTL
                ? Offset(maxSlide - position.value.clamp(0, maxSlide), 0)
                : Offset(position.value.clamp(0, maxSlide), 0);

            return AnimatedOpacity(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              opacity: isInteractive ? 1 : 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  height: 55.w,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.appColors.glass.withValues(alpha: 0.08),
                        context.appColors.glass.withValues(alpha: 0.03),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: context.appColors.glassBorder.withValues(alpha: 0.18),
                      width: 0.8,
                    ),
                  ),
                  child: Stack(
                    // Force absolute top-left origin so Transform.translate
                    // offsets are always in screen coordinates. The default
                    // AlignmentDirectional.topStart flips to top-right in RTL,
                    // which would double-offset the thumb out of view.
                    alignment: Alignment.topLeft,
                    children: [
                      // Amount label — fills the stack and shows on the
                      // opposite side to the thumb's start position.
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft:
                                isRTL ? Radius.circular(8.r) : Radius.zero,
                            bottomLeft:
                                isRTL ? Radius.circular(8.r) : Radius.zero,
                            topRight:
                                isRTL ? Radius.zero : Radius.circular(8.r),
                            bottomRight:
                                isRTL ? Radius.zero : Radius.circular(8.r),
                          ),
                          child: Align(
                            alignment: isRTL
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: SizedBox(
                              width: halfWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 4.w),
                                  Text(
                                    '${amount.toStringAsFixed(3)} $currencyCode',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Draggable thumb — always laid out at x=0, then moved
                      // by Transform.translate into the correct start position.
                      Transform.translate(
                        offset: thumbOffset,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if (completed.value) return;
                            if (!canDrag) return;

                            // RTL: dragging left (negative dx) advances the thumb.
                            position.value += isRTL
                                ? -details.delta.dx
                                : details.delta.dx;

                            if (position.value < 0) position.value = 0;
                            if (position.value > maxSlide) {
                              position.value = maxSlide;
                            }
                          },
                          onHorizontalDragEnd: (_) async {
                            if (!canDrag) {
                              animateTo(0);
                              return;
                            }

                            final shouldComplete =
                                position.value > maxSlide * 0.7;

                            if (shouldComplete) {
                              if (!enabled) {
                                HapticFeedback.mediumImpact();
                                animateTo(0);
                                onNotReady?.call();
                                return;
                              }
                              if (!canConfirm) {
                                HapticFeedback.mediumImpact();
                                animateTo(0);
                                onValidationFailed?.call();
                                return;
                              }

                              completed.value = true;
                              animateTo(maxSlide);

                              await Future.delayed(
                                const Duration(milliseconds: 250),
                              );

                              onConfirm();

                              await Future.delayed(
                                const Duration(milliseconds: 250),
                              );

                              animateTo(0);
                              completed.value = false;
                            } else {
                              animateTo(0);
                            }
                          },
                          child: Container(
                            width: halfWidth,
                            height: 55.w,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: context.appColors.brandFill,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isRTL) ...[
                                  Icon(
                                    Icons.keyboard_double_arrow_left,
                                    color: colorScheme.primary,
                                    size: 22.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                ],
                                Flexible(
                                  child: Text(
                                    'buttons.slideToConfirm'.tr(),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.primary,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                if (!isRTL) ...[
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.keyboard_double_arrow_right,
                                    color: colorScheme.primary,
                                    size: 22.sp,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
