import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_bar/app_app_bar.dart';
import '../button/app_button.dart';
import '../global/app_global.dart';
import '../scaffold/app_scaffold.dart';
import '../theme/app_theme_ext.dart';

class AppOtp extends HookWidget {
  final String? appBarTitle;
  final String? contentTitle;
  final String? contentSubtitle;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTapContinue;
  final VoidCallback? onResend;
  final bool isSubmitting;
  final bool isLoading;
  final int restartTrigger;
  // When the current OTP was dispatched. Drives the countdown so reopening
  // mid-cooldown shows the actual remaining time, not a fresh 60s.
  final DateTime? requestedAt;

  const AppOtp({
    super.key,
    this.appBarTitle,
    this.contentTitle,
    this.contentSubtitle,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
    this.onTapContinue,
    this.onResend,
    this.isSubmitting = false,
    this.isLoading = false,
    this.restartTrigger = 0,
    this.requestedAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final aCtrl = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );
    useEffect(() {
      aCtrl.forward();
      return null;
    }, const []);

    final aIcon = CurvedAnimation(
      parent: aCtrl,
      curve: const Interval(0.00, 0.55, curve: Curves.easeOut),
    );
    final aTitle = CurvedAnimation(
      parent: aCtrl,
      curve: const Interval(0.18, 0.65, curve: Curves.easeOut),
    );
    final aBoxes = CurvedAnimation(
      parent: aCtrl,
      curve: const Interval(0.32, 0.80, curve: Curves.easeOut),
    );
    final aActions = CurvedAnimation(
      parent: aCtrl,
      curve: const Interval(0.50, 1.00, curve: Curves.easeOut),
    );

    return AppScaffold(
      isLoading: isLoading,
      appBar: AppAppBar(
        title: appBarTitle ?? 'core.otp.title'.tr(),
        titleColor: cs.onSurface,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 32.h),

                    // Illustration
                    _FadeSlide(
                      animation: aIcon,
                      offsetY: -18,
                      child: _OtpIllustration(cs: cs),
                    ),

                    SizedBox(height: 24.h),

                    // Title + subtitle
                    _FadeSlide(
                      animation: aTitle,
                      offsetY: 16,
                      child: Column(
                        children: [
                          Text(
                            contentTitle ?? 'core.otp.title'.tr(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: cs.onSurface,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            contentSubtitle ?? '',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              color: cs.onSurface.withValues(alpha: 0.72),
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 36.h),

                    // OTP digit boxes
                    _FadeSlide(
                      animation: aBoxes,
                      offsetY: 16,
                      child: _OtpBoxRow(
                        length: 4,
                        restartTrigger: restartTrigger,
                        autovalidateMode: autovalidateMode,
                        validator: validator,
                        isSubmitting: isSubmitting,
                        onChanged: onChanged,
                        onCompleted: () {
                          Future.delayed(
                            const Duration(milliseconds: 280),
                            () => onTapContinue?.call(),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Countdown / resend
                    _FadeSlide(
                      animation: aActions,
                      offsetY: 10,
                      child: _CountdownRow(
                        restartTrigger: restartTrigger,
                        onResend: onResend,
                        requestedAt: requestedAt,
                      ),
                    ),

                    const Spacer(),

                    // Continue button
                    _FadeSlide(
                      animation: aActions,
                      offsetY: 22,
                      child: AppButton(
                        text: 'buttons.continue'.tr(),
                        onTap: onTapContinue,
                        isLoading: isSubmitting,
                      ),
                    ),

                    SizedBox(height: 25.h),
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

// ── Illustration ──────────────────────────────────────────────────────────────

class _OtpIllustration extends StatelessWidget {
  final ColorScheme cs;
  const _OtpIllustration({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 96.w,
          height: 96.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: cs.tertiary.withValues(alpha: 0.06),
          ),
        ),
        Container(
          width: 72.w,
          height: 72.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: cs.tertiary.withValues(alpha: 0.11),
            border: Border.all(color: cs.tertiary.withValues(alpha: 0.18)),
          ),
        ),
        Icon(Icons.smartphone_rounded, size: 30.sp, color: cs.tertiary),
      ],
    );
  }
}

// ── OTP digit boxes ───────────────────────────────────────────────────────────

class _OtpBoxRow extends HookWidget {
  final int length;
  final int restartTrigger;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onCompleted;
  final bool isSubmitting;

  const _OtpBoxRow({
    required this.length,
    required this.restartTrigger,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
    this.onCompleted,
    this.isSubmitting = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    useListenable(controller);

    final hasFocus = useState(false);
    useEffect(() {
      void fn() => hasFocus.value = focusNode.hasFocus;
      focusNode.addListener(fn);
      return () => focusNode.removeListener(fn);
    }, [focusNode]);

    useEffect(() {
      controller.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) focusNode.requestFocus();
      });
      return null;
    }, [restartTrigger]);

    final errorText = useState<String?>(null);
    final text = controller.text;

    return Column(
      children: [
        GestureDetector(
          onTap: () => focusNode.requestFocus(),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Visual boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(length, (i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: _OtpBox(
                      digit: i < text.length ? text[i] : null,
                      isActive:
                          !isSubmitting && i == text.length && hasFocus.value,
                    ),
                  );
                }),
              ),
              // Invisible input receiving all key events
              Positioned.fill(
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.001,
                    child: Form(
                      autovalidateMode: autovalidateMode,
                      child: TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        validator: validator,
                        showCursor: false,
                        enableInteractiveSelection: false,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        onChanged: (val) {
                          onChanged?.call(val);
                          if (autovalidateMode == AutovalidateMode.always) {
                            errorText.value = validator?.call(val);
                          }
                          if (val.length == length) onCompleted?.call();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Inline error
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: errorText.value != null
              ? Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 12.sp,
                        color: cs.error,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        errorText.value!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: cs.error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ── Single OTP digit box ──────────────────────────────────────────────────────

class _OtpBox extends HookWidget {
  final String? digit;
  final bool isActive;

  const _OtpBox({this.digit, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Pop-in scale when digit appears
    final prevDigit = useRef<String?>(null);
    final scaleCtrl = useAnimationController(
      duration: const Duration(milliseconds: 280),
    );
    useEffect(() {
      if (prevDigit.value == null && digit != null) {
        scaleCtrl.forward(from: 0);
      } else if (prevDigit.value != null && digit == null) {
        scaleCtrl.value = 0;
      }
      prevDigit.value = digit;
      return null;
    }, [digit]);

    final scale = Tween<double>(
      begin: 0.55,
      end: 1.0,
    ).animate(CurvedAnimation(parent: scaleCtrl, curve: Curves.elasticOut));

    // Blinking cursor when active and empty
    final blinkCtrl = useAnimationController(
      duration: const Duration(milliseconds: 560),
    );
    useEffect(() {
      if (isActive && digit == null) {
        blinkCtrl.repeat(reverse: true);
      } else {
        blinkCtrl
          ..stop()
          ..value = 0;
      }
      return null;
    }, [isActive, digit]);

    final isFilled = digit != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 60.w,
      height: 64.h,
      decoration: BoxDecoration(
        color: isFilled
            ? cs.tertiary.withValues(alpha: 0.16)
            : context.appColors.glass.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isActive
              ? cs.tertiary
              : isFilled
                  ? cs.tertiary.withValues(alpha: 0.55)
                  : context.appColors.glassBorder.withValues(alpha: 0.22),
          width: isActive ? 1.2 : 0.8,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: cs.tertiary.withValues(alpha: 0.22),
                  blurRadius: 14,
                  spreadRadius: -1,
                ),
              ]
            : null,
      ),
      child: Center(
        child: isFilled
            ? ScaleTransition(
                scale: scale,
                child: Text(
                  digit!,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              )
            : isActive
            ? AnimatedBuilder(
                animation: blinkCtrl,
                builder: (_, _) => Opacity(
                  opacity: blinkCtrl.value,
                  child: Container(
                    width: 1.5,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: cs.tertiary,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

// ── Countdown / resend row ────────────────────────────────────────────────────

class _CountdownRow extends HookWidget {
  final int restartTrigger;
  final VoidCallback? onResend;
  final DateTime? requestedAt;

  static const int _cooldownSeconds = 60;

  const _CountdownRow({
    required this.restartTrigger,
    this.onResend,
    this.requestedAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final seconds = useState(0);
    final isExpired = useState(false);
    final timerRef = useRef<Timer?>(null);

    useEffect(() {
      timerRef.value?.cancel();

      // Derive remaining seconds from the actual dispatch time so a
      // kill-and-reopen mid-cooldown picks up where it left off.
      final origin = requestedAt ?? DateTime.now();
      final elapsed = DateTime.now().difference(origin).inSeconds;
      final remaining = _cooldownSeconds - 1 - elapsed;

      if (remaining <= 0) {
        seconds.value = 0;
        isExpired.value = true;
        return null;
      }

      seconds.value = remaining;
      isExpired.value = false;

      final timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (seconds.value <= 1) {
          seconds.value = 0;
          isExpired.value = true;
          t.cancel();
        } else {
          seconds.value--;
        }
      });

      timerRef.value = timer;
      return () => timer.cancel();
    }, [restartTrigger, requestedAt]);

    final canResend = isExpired.value && onResend != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'core.otp.resendOtp'.tr(),
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 13.sp,
            color: cs.onSurface.withValues(alpha: 0.72),
          ),
        ),
        SizedBox(width: 5.w),
        if (!canResend)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              'core.otp.resendIn'.tr(
                namedArgs: {'time': AppGlobal.formatTime(seconds.value)},
              ),
              key: ValueKey(seconds.value),
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: cs.tertiary,
              ),
            ),
          )
        else
          GestureDetector(
            onTap: onResend,
            child: Text(
              'core.otp.resendNow'.tr(),
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: cs.tertiary,
                decoration: TextDecoration.underline,
                decorationColor: cs.tertiary,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Fade + slide entrance helper ──────────────────────────────────────────────

class _FadeSlide extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final double offsetY;

  const _FadeSlide({
    required this.animation,
    required this.child,
    this.offsetY = 20,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (_, child) {
        final t = animation.value.clamp(0.0, 1.0);
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, offsetY * (1 - t)),
            child: child,
          ),
        );
      },
    );
  }
}
