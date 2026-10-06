import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/login/login_bloc.dart';
import '../../application/otp/otp_bloc.dart';
import '../../domain/common/common_selectable_dto.dart';
import '../../domain/core/failures.dart';
import '../../domain/core/value_validators.dart';
import '../../domain/login/login_failure.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/button/app_button.dart';
import '../core/dialog/app_language_dialog.dart';
import '../core/extension/common_string_format_extensions.dart';
import '../core/global/app_global.dart';
import '../core/images/app_logo.dart';
import '../core/input_formatter/app_masked_digit_controller.dart';
import '../core/input_formatter/app_western_digits_input_formatter.dart';
import '../core/notify/app_notify.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/text_form_field/app_text_form_field.dart';
import '../routes/app_navigation_guard.dart';
import '../routes/app_routes.gr.dart';
import 'widgets/login_visual.dart';
import '../core/theme/app_theme_ext.dart';

@RoutePage()
class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    // ── Controllers & focus ────────────────────────────────────────────────────
    final idTypeController = useTextEditingController();

    // ID number is a plain field (hint-driven, no `XXXX` mask); CPR carries no
    // fixed length, so it is only capped at kIdentityNumberMaxLength.
    final idController = useTextEditingController();
    // Mobile keeps the fixed-length masked field: shows the `XXXX` mask,
    // auto-limits length, locks the cursor, and exposes `.rawValue`.
    final mobileController = useMemoized(
      () => MaskedDigitController(maskLength: AppGlobal.omanMobileLength),
    );

    final idFocusNode = useFocusNode();
    final mobileFocusNode = useFocusNode();
    final prevIdTypeRef = useRef<CommonSelectableItem?>(null);

    // ── Entrance animation ─────────────────────────────────────────────────────
    final ctrl = useAnimationController(
      duration: const Duration(milliseconds: 1100),
    );

    final aHero = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.00, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    final aTitle = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.12, 0.62, curve: Curves.easeOutCubic),
      ),
    );
    final aForm = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.28, 0.80, curve: Curves.easeOutCubic),
      ),
    );
    final aButton = useMemoized(
      () => CurvedAnimation(
        parent: ctrl,
        curve: const Interval(0.52, 1.00, curve: Curves.easeOutCubic),
      ),
    );

    useEffect(() {
      context.read<LoginBloc>().add(const LoginEvent.getIdentityTypes());
      ctrl.forward();
      // idController is auto-disposed by useTextEditingController.
      return () {
        mobileController.dispose();
      };
    }, const []);

    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, curr) =>
          prev.selectedIdentityType != curr.selectedIdentityType ||
          prev.loginFailureOrSuccessOption !=
              curr.loginFailureOrSuccessOption ||
          prev.identityTypesFailureOrSuccessOption !=
              curr.identityTypesFailureOrSuccessOption,
      buildWhen: (prev, curr) =>
          prev.isLoading != curr.isLoading ||
          prev.isSubmitting != curr.isSubmitting ||
          prev.selectedIdentityType != curr.selectedIdentityType ||
          prev.showErrorMessages != curr.showErrorMessages ||
          prev.loginIdIdentityDto != curr.loginIdIdentityDto,
      listener: (context, state) {
        if (state.selectedIdentityType != prevIdTypeRef.value) {
          prevIdTypeRef.value = state.selectedIdentityType;
          idTypeController.text = state.selectedIdentityType?.titleName ?? '';
          // A different ID type means a different number format — clear any
          // typed input.
          idController.clear();
        }

        state.identityTypesFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => AppNotify.toast(
              failure.maybeMap(
                unableToFetchIdentityTypes: (v) => v.message.toString(),
                serverError: (_) => 'errors.serverError'.tr(),
                orElse: () => 'errors.unknownError'.tr(),
              ),
              type: AppToastType.info,
              position: AppToastPosition.top,
            ),
            (_) {},
          ),
        );

        state.loginFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => AppNotify.toast(
              failure.maybeMap(
                invalidCredentials: (v) => v.message.toString(),
                serverError: (_) => 'errors.serverError'.tr(),
                orElse: () => 'errors.unknownError'.tr(),
              ),
              type: AppToastType.error,
              position: AppToastPosition.top,
            ),
            (_) {
              context.read<OtpBloc>().add(
                OtpEvent.initial(
                  idType: state.selectedIdentityType?.titleCode ?? '',
                  idNumber: idController.text,
                  mobileNumber: mobileController.rawValue,
                ),
              );
              FocusScope.of(context).unfocus();
              context.pushIfActive(const OtpRoute());
              idController.clear();
              mobileController.resetMask(AppGlobal.omanMobileLength);
              context.read<LoginBloc>().add(const LoginEvent.reset());
            },
          ),
        );
      },
      builder: (context, state) {
        final hasIdType =
            state.selectedIdentityType?.titleCode?.isNotEmpty ?? false;
        // Always show the ID-type dropdown whenever any type exists — even a
        // single type — so it never restricts to one silent auto-selection.
        final showIdTypeSelector =
            (state.loginIdIdentityDto?.data?.identityTypesList ?? [])
                .isNotEmpty;
        // Title-cased ID type name (backend stores it upper case) used to make
        // the ID-number field self-documenting, e.g. "Civil ID Number".
        final selectedIdTypeName =
            state.selectedIdentityType?.titleName?.toTitleCase() ?? '';

        return AppScaffold(
          isLoading: state.isLoading || state.isSubmitting,
          onTapOutside: () => FocusScope.of(context).unfocus(),
          appBar: AppAppBar(
            centerTitle: true,
            titleWidget: const AppLogo(),
            actions: [
              InkWell(
                onTap: () => AppLanguageDialog.show(context),
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.language, size: 20.sp, color: cs.onPrimary),
                      SizedBox(width: 3.w),
                      Text(
                        context.locale.languageCode.toUpperCase(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              // ── Ambient background orbs ──────────────────────────────────────
              Positioned(
                top: -55.h,
                right: -55.w,
                child: IgnorePointer(
                  child: Container(
                    width: 260.w,
                    height: 260.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.appColors.brandFill.withValues(
                        alpha: 0.35,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30.h,
                left: -70.w,
                child: IgnorePointer(
                  child: Container(
                    width: 210.w,
                    height: 210.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.appColors.brandFill.withValues(
                        alpha: 0.15,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Scrollable content ───────────────────────────────────────────
              CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6.h),

                          // ── Illustration ─────────────────────────────────────
                          _FadeSlide(
                            animation: aHero,
                            slideOffset: -22,
                            child: Center(child: LoginVisual(height: 260.h)),
                          ),
                          SizedBox(height: 18.h),

                          // ── Title + accent bar ────────────────────────────────
                          _FadeSlide(
                            animation: aTitle,
                            slideOffset: 14,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'login.title'.tr(),
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w700,
                                        color: cs.onPrimary,
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
                                SizedBox(height: 6.h),
                                Text(
                                  'login.subtitle'.tr(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 13.sp,
                                    color: cs.onSecondary,
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
                                children: [
                                  if (showIdTypeSelector)
                                    AppTextFormField(
                                      controller: idTypeController,
                                      labelText: 'login.idType.label'.tr(),
                                      hintText: 'login.idType.placeholder'.tr(),
                                      readOnly: true,
                                      showCursor: false,
                                      suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: context.appColors.brandFill,
                                      ),
                                      onTap: () {
                                        final list =
                                            state
                                                .loginIdIdentityDto
                                                ?.data
                                                ?.identityTypesList ??
                                            [];
                                        if (list.isEmpty) return;
                                        context.router.push(
                                          AppSelectableRoute(
                                            title: 'login.idType.label'.tr(),
                                            initialSelectedItem:
                                                state.selectedIdentityType,
                                            commonSelectableDto: CommonSelectableDto(
                                              data: CommonSelectableData(
                                                list: list
                                                    .map(
                                                      (
                                                        e,
                                                      ) => CommonSelectableItem(
                                                        titleName:
                                                            (e.name ?? '')
                                                                .toUpperCase(),
                                                        titleCode: e.code,
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            onSelected: (value) =>
                                                context.read<LoginBloc>().add(
                                                  LoginEvent.identityTypeChanged(
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
                                    child: hasIdType
                                        ? Column(
                                            children: [
                                              // Only pad below the ID-type field
                                              // when it is actually shown.
                                              if (showIdTypeSelector)
                                                SizedBox(height: 12.h),
                                              AppTextFormField(
                                                controller: idController,
                                                focusNode: idFocusNode,
                                                labelText:
                                                    'login.idNumber.label'.tr(
                                                      namedArgs: {
                                                        'idType':
                                                            selectedIdTypeName,
                                                      },
                                                    ),
                                                hintText:
                                                    'login.idNumber.placeholder'
                                                        .tr(
                                                          namedArgs: {
                                                            'idType':
                                                                selectedIdTypeName,
                                                          },
                                                        ),
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                autocorrect: false,
                                                enableSuggestions: false,
                                                inputFormatters: [
                                                  WesternDigitsInputFormatter(),
                                                  // CPR has no fixed length —
                                                  // cap at the same upper bound
                                                  // the validator enforces.
                                                  LengthLimitingTextInputFormatter(
                                                    kIdentityNumberMaxLength,
                                                  ),
                                                ],
                                                onChanged: (_) => context
                                                    .read<LoginBloc>()
                                                    .add(
                                                      LoginEvent.identityNumberChanged(
                                                        idController.text,
                                                      ),
                                                    ),
                                                onFieldSubmitted: (_) =>
                                                    mobileFocusNode
                                                        .requestFocus(),
                                                validator: (p0) => context
                                                    .read<LoginBloc>()
                                                    .state
                                                    .identityNumber
                                                    .value
                                                    .fold(
                                                      (
                                                        failure,
                                                      ) => switch (failure) {
                                                        InvalidIdentityNumber() =>
                                                          'login.idNumber.validationError'
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
                                                    'login.mobileNumber.label'
                                                        .tr(),
                                                hintText:
                                                    'login.mobileNumber.placeholder'
                                                        .tr(),
                                                keyboardType:
                                                    TextInputType.number,
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        '+${AppGlobal.appCountryCode}',
                                                        textDirection: ui
                                                            .TextDirection
                                                            .ltr,
                                                        style: theme
                                                            .textTheme
                                                            .titleSmall
                                                            ?.copyWith(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                      ),
                                                      SizedBox(width: 8.w),
                                                      Container(
                                                        width: 1,
                                                        height: 20.h,
                                                        color: cs.onSurface
                                                            .withValues(
                                                              alpha: 0.3,
                                                            ),
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
                                                ],
                                                onChanged: (_) => context
                                                    .read<LoginBloc>()
                                                    .add(
                                                      LoginEvent.mobileNumberChanged(
                                                        mobileController
                                                            .rawValue,
                                                      ),
                                                    ),
                                                onFieldSubmitted: (_) {
                                                  FocusScope.of(
                                                    context,
                                                  ).unfocus();
                                                  context.read<LoginBloc>().add(
                                                    const LoginEvent.requestOtpPressed(),
                                                  );
                                                },
                                                validator: (p0) => context
                                                    .read<LoginBloc>()
                                                    .state
                                                    .mobileNumber
                                                    .value
                                                    .fold(
                                                      (
                                                        failure,
                                                      ) => switch (failure) {
                                                        InvalidMobileNumber() =>
                                                          'login.mobileNumber.validationError'
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

                          SizedBox(height: 10.h),

                          // ── Submit button ─────────────────────────────────────
                          _FadeSlide(
                            animation: aButton,
                            slideOffset: 18,
                            child: AppButton(
                              isLoading: state.isSubmitting,
                              text: 'buttons.requestOtp'.tr(),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                context.read<LoginBloc>().add(
                                  const LoginEvent.requestOtpPressed(),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // ── Need help? Contact Us ──────────────────────────────
                          _FadeSlide(
                            animation: aButton,
                            slideOffset: 10,
                            child: Center(
                              child: GestureDetector(
                                onTap: () => context.router.push(
                                  const LoginContactUsView(),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontSize: 13.sp,
                                      color: cs.onSecondary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${'login.needHelp'.tr()} ',
                                      ),
                                      TextSpan(
                                        text: 'login.contactUsLink'.tr(),
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              fontSize: 13.sp,
                                              color: cs.tertiary,
                                              fontWeight: FontWeight.w600,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: cs.tertiary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
