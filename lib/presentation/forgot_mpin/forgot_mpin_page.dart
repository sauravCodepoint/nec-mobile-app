import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/forgot_mpin/forgot_mpin_bloc.dart';
import '../../domain/common/common_selectable_dto.dart';
import '../../domain/core/failures.dart';
import '../../domain/core/value_validators.dart';
import '../../domain/forgot_mpin/forgot_mpin_failure.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/button/app_button.dart';
import '../core/extension/common_string_format_extensions.dart';
import '../core/global/app_global.dart';
import '../core/input_formatter/app_western_digits_input_formatter.dart';
import '../core/notify/app_notify.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/text_form_field/app_text_form_field.dart';
import '../core/theme/app_theme_ext.dart';
import '../routes/app_navigation_guard.dart';
import '../routes/app_routes.gr.dart';

@RoutePage()
class ForgotMpinPage extends HookWidget {
  const ForgotMpinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    useEffect(() {
      context.read<ForgotMpinBloc>().add(
        const ForgotMpinEvent.getIdentityTypes(),
      );
      return null;
    }, const []);

    final idTypeController = useTextEditingController();

    final idController = useTextEditingController();
    final mobileController = useTextEditingController();

    final idFocusNode = useFocusNode();
    final mobileFocusNode = useFocusNode();

    final prevIdTypeRef = useRef<CommonSelectableItem?>(null);

    // ── Entrance animation ──────────────────────────────────────────────────
    final ctrl = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );
    final aTitle = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.00, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    final aForm = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.22, 0.80, curve: Curves.easeOutCubic),
      ),
    );
    final aButton = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.45, 1.00, curve: Curves.easeOutCubic),
      ),
    );
    useEffect(() {
      ctrl.forward();
      return null;
    }, const []);

    return BlocConsumer<ForgotMpinBloc, ForgotMpinState>(
      listenWhen: (prev, curr) =>
          prev.selectedIdentityType != curr.selectedIdentityType ||
          prev.requestOtpFailureOrSuccessOption !=
              curr.requestOtpFailureOrSuccessOption ||
          prev.identityTypeFailureOrSuccessOption !=
              curr.identityTypeFailureOrSuccessOption,
      buildWhen: (prev, curr) =>
          prev.isLoading != curr.isLoading ||
          prev.isSubmitting != curr.isSubmitting ||
          prev.selectedIdentityType != curr.selectedIdentityType ||
          prev.showErrorMessages != curr.showErrorMessages ||
          prev.forgotIdIdentityDto != curr.forgotIdIdentityDto,
      listener: (context, state) {
        // Sync controllers only when identity type actually changes
        if (state.selectedIdentityType != prevIdTypeRef.value) {
          prevIdTypeRef.value = state.selectedIdentityType;
          idTypeController.text = state.selectedIdentityType?.titleName ?? '';
          // A different ID type means a different number format — drop any
          // previously typed input.
          idController.clear();
        }

        // Show error if identity types failed to load
        state.identityTypeFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => AppNotify.toast(
              failure.maybeMap(
                unableToFetchIdentityTypes: (value) => value.message.toString(),
                serverError: (_) => 'errors.serverError'.tr(),
                orElse: () => 'errors.unknownError'.tr(),
              ),
              type: AppToastType.info,
              position: AppToastPosition.top,
            ),
            (_) {},
          ),
        );

        // Handle OTP request result
        state.requestOtpFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => AppNotify.toast(
              failure.maybeMap(
                invalidCredentials: (value) => value.message.toString(),
                serverError: (_) => 'errors.serverError'.tr(),
                orElse: () => 'errors.unknownError'.tr(),
              ),
              type: AppToastType.error,
              position: AppToastPosition.top,
            ),
            (_) {
              FocusScope.of(context).unfocus();
              context.pushIfActive(const ForgotOtpView());
            },
          ),
        );
      },
      builder: (context, state) {
        // Only offer the ID-type selector when there is a real choice. With a
        // single type the BLoC auto-selects it, so the dropdown is redundant.
        final showIdTypeSelector =
            (state.forgotIdIdentityDto?.data?.identityTypesList ?? []).length >
                1;
        // Title-cased ID type name (backend stores it upper case) used to make
        // the ID-number field self-documenting, e.g. "Civil ID Number".
        final selectedIdTypeName =
            state.selectedIdentityType?.titleName?.toTitleCase() ?? '';
        return AppScaffold(
          isLoading: state.isLoading || state.isSubmitting,
          onTapOutside: () => FocusScope.of(context).unfocus(),
          appBar: AppAppBar(title: 'forgotMpin.title'.tr()),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                physics: constraints.maxHeight < 600
                    ? const ClampingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 30.h),

                      // ── Title + accent bar + subtitle ─────────────────────
                      _FadeSlide(
                        animation: aTitle,
                        slideOffset: 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'forgotMpin.title'.tr(),
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              width: 30.w,
                              height: 3.h,
                              decoration: BoxDecoration(
                                color: context.appColors.brandFill,
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'forgotMpin.subtitle'.tr(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 13.sp,
                                color: context.appColors.muted,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // ── Form fields ───────────────────────────────────────
                      _FadeSlide(
                        animation: aForm,
                        slideOffset: 28,
                        child: Form(
                          autovalidateMode: state.showErrorMessages
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (showIdTypeSelector)
                                AppTextFormField(
                                  controller: idTypeController,
                                  labelText: 'forgotMpin.idType.label'.tr(),
                                  hintText: 'forgotMpin.idType.placeholder'.tr(),
                                  readOnly: true,
                                  showCursor: false,
                                  suffixIcon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: colorScheme.tertiary,
                                  ),
                                  onTap: () {
                                    final list =
                                        state
                                            .forgotIdIdentityDto
                                            ?.data
                                            ?.identityTypesList ??
                                        [];
                                    if (list.length <= 1) return;
                                    context.router.push(
                                      AppSelectableRoute(
                                        title: 'forgotMpin.idType.label'.tr(),
                                        initialSelectedItem:
                                            state.selectedIdentityType,
                                        commonSelectableDto: CommonSelectableDto(
                                          data: CommonSelectableData(
                                            list: list
                                                .map(
                                                  (e) => CommonSelectableItem(
                                                    titleName: (e.name ?? '')
                                                        .toUpperCase(),
                                                    titleCode: e.code,
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                        onSelected: (value) =>
                                            context.read<ForgotMpinBloc>().add(
                                              ForgotMpinEvent.identityTypeChanged(
                                                selectedIdentityType: value,
                                              ),
                                            ),
                                      ),
                                    );
                                  },
                                ),

                              // Animated reveal: ID number + mobile
                              AnimatedSize(
                                duration: const Duration(milliseconds: 360),
                                curve: Curves.easeOutCubic,
                                alignment: Alignment.topCenter,
                                child: state.selectedIdentityType != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          // Only pad below the ID-type field
                                          // when it is actually shown.
                                          if (showIdTypeSelector)
                                            SizedBox(height: 12.h),
                                          AppTextFormField(
                                            controller: idController,
                                            focusNode: idFocusNode,
                                            labelText:
                                                'forgotMpin.idNumber.label'.tr(
                                                  namedArgs: {
                                                    'idType': selectedIdTypeName,
                                                  },
                                                ),
                                            hintText:
                                                'forgotMpin.idNumber.placeholder'
                                                    .tr(
                                                      namedArgs: {
                                                        'idType':
                                                            selectedIdTypeName,
                                                      },
                                                    ),
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            inputFormatters: [
                                              WesternDigitsInputFormatter(),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              // CPR has no fixed length — cap
                                              // at the same upper bound the
                                              // validator enforces.
                                              LengthLimitingTextInputFormatter(
                                                kIdentityNumberMaxLength,
                                              ),
                                            ],
                                            onChanged: (_) =>
                                                context.read<ForgotMpinBloc>().add(
                                                  ForgotMpinEvent.identityNumberChanged(
                                                    idController.text,
                                                  ),
                                                ),
                                            onFieldSubmitted: (_) =>
                                                mobileFocusNode.requestFocus(),
                                            validator: (p0) => context
                                                .read<ForgotMpinBloc>()
                                                .state
                                                .identityNumber
                                                .value
                                                .fold(
                                                  (failure) =>
                                                      switch (failure) {
                                                        InvalidIdentityNumber() =>
                                                          'forgotMpin.idNumber.validationError'
                                                              .tr(),
                                                        _ => null,
                                                      },
                                                  (_) => null,
                                                ),
                                          ),
                                          SizedBox(height: 12.h),
                                          AppTextFormField(
                                            controller: mobileController,
                                            focusNode: mobileFocusNode,
                                            labelText:
                                                'forgotMpin.mobileNumber.label'
                                                    .tr(),
                                            hintText:
                                                'forgotMpin.mobileNumber.placeholder'
                                                    .tr(),
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            autocorrect: false,
                                            enableSuggestions: false,
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                left: 12.w,
                                                right: 12.w,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '+${AppGlobal.appCountryCode}',
                                                    textDirection:
                                                        ui.TextDirection.ltr,
                                                    style: theme
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Container(
                                                    width: 1,
                                                    height: 20.h,
                                                    color: colorScheme.onSurface
                                                        .withValues(alpha: 0.3),
                                                  ),
                                                  SizedBox(width: 4.w),
                                                ],
                                              ),
                                            ),
                                            prefixIconConstraints:
                                                const BoxConstraints(
                                                  minWidth: 0,
                                                  minHeight: 0,
                                                ),
                                            inputFormatters: [
                                              WesternDigitsInputFormatter(),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                AppGlobal.omanMobileLength,
                                              ),
                                            ],
                                            onChanged: (_) =>
                                                context.read<ForgotMpinBloc>().add(
                                                  ForgotMpinEvent.mobileNumberChanged(
                                                    mobileController.text,
                                                  ),
                                                ),
                                            onFieldSubmitted: (_) =>
                                                context.read<ForgotMpinBloc>().add(
                                                  const ForgotMpinEvent.requestOtpPressed(),
                                                ),
                                            validator: (p0) => context
                                                .read<ForgotMpinBloc>()
                                                .state
                                                .mobileNumber
                                                .value
                                                .fold(
                                                  (failure) =>
                                                      switch (failure) {
                                                        InvalidMobileNumber() =>
                                                          'forgotMpin.mobileNumber.validationError'
                                                              .tr(),
                                                        _ => null,
                                                      },
                                                  (_) => null,
                                                ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Security note ─────────────────────────────────────
                      SizedBox(height: 16.h),
                      _FadeSlide(
                        animation: aButton,
                        slideOffset: 10,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shield_outlined,
                              size: 13.sp,
                              color: context.appColors.success,
                            ),
                            SizedBox(width: 5.w),
                            Flexible(
                              child: Text(
                                'core.securityNote'.tr(),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 11.5.sp,
                                  color: context.appColors.muted,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Continue button ───────────────────────────────────
                      SizedBox(height: 16.h),
                      _FadeSlide(
                        animation: aButton,
                        slideOffset: 18,
                        child: AppButton(
                          isLoading: state.isSubmitting,
                          text: 'buttons.continue'.tr(),
                          onTap: () => context.read<ForgotMpinBloc>().add(
                            const ForgotMpinEvent.requestOtpPressed(),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ── Fade + slide entrance wrapper ─────────────────────────────────────────────

class _FadeSlide extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  /// Positive → slides up into place. Negative → slides down into place.
  final double slideOffset;

  const _FadeSlide({
    required this.animation,
    required this.child,
    this.slideOffset = 20,
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
            offset: Offset(0, slideOffset * (1 - t)),
            child: child,
          ),
        );
      },
    );
  }
}
