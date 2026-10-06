import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/complete_profile/complete_profile_bloc.dart';
import '../../domain/complete_profile/complete_profile_failure.dart';
import '../../domain/core/di/injection.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../routes/app_routes.gr.dart';
import '../../domain/common/common_member_field_dto.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/app_states/app_state_view.dart';
import '../core/button/app_button.dart';
import '../core/global/app_global.dart';
import '../core/notify/app_notify.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/theme/app_theme_ext.dart';
import '../core/video/app_video_player_page.dart';
import '../core/video/app_video_recorder_page.dart';
import '../core/widgets/confirm_pop_scope.dart';
import '../core/kyc/kyc_video_card.dart';
import 'widgets/complete_profile_date_picker.dart';
import 'widgets/complete_profile_dropdown.dart';
import 'widgets/complete_profile_text_field.dart';

@RoutePage()
class CompleteProfilePage extends HookWidget {
  const CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CompleteProfileBloc>();

    final isFieldError = useState(false);

    final entranceCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1100),
    );

    useEffect(() {
      // This page is entered from OTP, which may still have the soft keyboard
      // up when its route is swapped out. An inherited inset shrinks the
      // Scaffold body, and the bottom CTA — pinned under the Expanded scroll
      // area — is drawn at the top edge of the keyboard instead of the bottom
      // of the screen. Drop any keyboard we inherited before the entrance
      // animation reveals the button, so it only ever fades in at rest.
      AppGlobal.dismissKeyboard();
      bloc.add(const CompleteProfileEvent.getMemberFieldSettings());
      Future.delayed(const Duration(milliseconds: 60), () {
        if (!entranceCtrl.isCompleted) entranceCtrl.forward();
      });
      return null;
    }, const []);

    return BlocConsumer<CompleteProfileBloc, CompleteProfileState>(
      listenWhen: (p, c) =>
      p.memberFieldSettingFailureOrSuccessOption !=
          c.memberFieldSettingFailureOrSuccessOption ||
          p.submitFailureOrSuccessOption != c.submitFailureOrSuccessOption ||
          p.videoFailureOption != c.videoFailureOption,
      listener: (context, state) {
        state.memberFieldSettingFailureOrSuccessOption.fold(
              () => isFieldError.value = false,
              (result) => result.fold(
                (_) => isFieldError.value = true,
                (_) => isFieldError.value = false,
          ),
        );

        state.videoFailureOption.fold(() {}, (failure) {
          final message = failure.maybeMap(
            selfieVideoUploadFailed: (f) => f.message.isNotEmpty
                ? f.message
                : 'completeProfile.toast.videoUploadFailed'.tr(),
            selfieVideoDeleteFailed: (f) => f.message.isNotEmpty
                ? f.message
                : 'completeProfile.toast.videoRemoveFailed'.tr(),
            orElse: () => 'completeProfile.toast.serverError'.tr(),
          );
          AppNotify.toast(
            message,
            type: AppToastType.error,
            position: AppToastPosition.bottom,
          );
        });

        state.submitFailureOrSuccessOption.fold(
              () {},
              (result) => result.fold(
                (failure) {
              failure.maybeMap(
                // The submit itself succeeded but the response was missing
                // session fields — the repo refused to install a broken
                // session. Show the error ID so support can pinpoint the
                // missing field; re-logging in via OTP will still resume.
                unexpectedServerState: (f) {
                  AppNotify.dialog(
                    title: 'completeProfile.unexpectedStateDialog.title'.tr(),
                    message: 'completeProfile.unexpectedStateDialog.message'
                        .tr(namedArgs: {'errorId': f.errorId}),
                    type: AppDialogType.error,
                  );
                },
                unableToSubmit: (f) {
                  AppNotify.toast(
                    f.message.isNotEmpty
                        ? f.message
                        : 'completeProfile.toast.submitFailed'.tr(),
                    type: AppToastType.error,
                    position: AppToastPosition.bottom,
                  );
                },
                orElse: () {
                  AppNotify.toast(
                    'completeProfile.toast.serverError'.tr(),
                    type: AppToastType.error,
                    position: AppToastPosition.bottom,
                  );
                },
              );
            },
                (_) async {
              await AppNotify.dialog(
                title: 'completeProfile.dialog.successTitle'.tr(),
                message: 'completeProfile.dialog.successMessage'.tr(),
                type: AppDialogType.success,
                buttonText: 'completeProfile.dialog.successButton'.tr(),
              );
              // The repo installed the fresh session returned by the submit
              // response, so the user is already authenticated. Continue the
              // onboarding chain directly: SetMpin → biometrics → home.
              // replaceAll resets the stack so the back button cannot return
              // to CompleteProfile.
              if (context.mounted) {
                context.router.replaceAll([const SetMpinRoute()]);
              }
            },
          ),
        );
      },
      builder: (context, state) {
        final fields =
        (state.memberFieldSettingDto?.data?.allMemberFieldSettingList ?? [])
            .where((f) => f.visible ?? true)
            .toList()
          ..sort(
                (a, b) => (a.displayOrder ?? 0).compareTo(b.displayOrder ?? 0),
          );

        return ConfirmPopScope(
          title: 'completeProfile.exitDialog.title'.tr(),
          message: 'completeProfile.exitDialog.message'.tr(),
          type: AppDialogType.warning,
          onConfirm: () {
            // User explicitly chose to leave registration — drop the
            // resume marker so a future cold-start follows the normal
            // session routing instead of bringing them back here.
            getIt<SharedPrefs>().clearPendingRegistration();
            context.router.pop();
          },
          child: AppScaffold(
            onTapOutside: () => FocusScope.of(context).unfocus(),
            appBar: AppAppBar(title: 'completeProfile.appBar'.tr()),
            isLoading: state.isLoading,
            body: Stack(
              children: [
                Positioned.fill(
                  child: RepaintBoundary(child: _AmbientBackground()),
                ),
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionReveal(
                              parent: entranceCtrl,
                              interval: const Interval(
                                0.00,
                                0.45,
                                curve: Curves.easeOutCubic,
                              ),
                              child: const _PageHeader(),
                            ),
                            SizedBox(height: 20.h),
                            _SectionReveal(
                              parent: entranceCtrl,
                              interval: const Interval(
                                0.10,
                                0.55,
                                curve: Curves.easeOutCubic,
                              ),
                              child: RepaintBoundary(
                                child: const _MigrationBanner(),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            _SectionReveal(
                              parent: entranceCtrl,
                              interval: const Interval(
                                0.20,
                                0.68,
                                curve: Curves.easeOutCubic,
                              ),
                              child: isFieldError.value
                                  ? AppErrorView(
                                onRetry: () => bloc.add(
                                  const CompleteProfileEvent.getMemberFieldSettings(),
                                ),
                                retryLabel: 'completeProfile.errorView.retry'.tr(),
                                title: 'completeProfile.errorView.title'.tr(),
                                subtitle: 'completeProfile.errorView.subtitle'.tr(),
                              )
                                  : fields.isNotEmpty
                                  ? _FieldsCard(fields: fields, state: state)
                                  : const SizedBox.shrink(),
                            ),
                            SizedBox(height: 16.h),
                            _SectionReveal(
                              parent: entranceCtrl,
                              interval: const Interval(
                                0.30,
                                0.78,
                                curve: Curves.easeOutCubic,
                              ),
                              child: _VideoCard(state: state),
                            ),
                            SizedBox(height: 14.h),
                            _SectionReveal(
                              parent: entranceCtrl,
                              interval: const Interval(
                                0.42,
                                0.88,
                                curve: Curves.easeOutCubic,
                              ),
                              child: const _PrivacyNote(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    _SectionReveal(
                      parent: entranceCtrl,
                      interval: const Interval(
                        0.50,
                        0.95,
                        curve: Curves.easeOutCubic,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ).add(EdgeInsets.only(bottom: 10.h)),
                        child: AppButton(
                          text: 'completeProfile.submit'.tr(),
                          isLoading: state.isSubmitting,
                          onTap: () {
                            final hasFieldErrors = state
                                .dynamicFieldValues
                                .values
                                .any((v) => v.value.isLeft());

                            if (hasFieldErrors) {
                              context.read<CompleteProfileBloc>().add(
                                const CompleteProfileEvent.submitPressed(),
                              );
                              return;
                            }

                            if (state.selfieVideoEId == null) {
                              AppNotify.toast(
                                'completeProfile.toast.videoRequired'.tr(),
                                type: AppToastType.warning,
                                position: AppToastPosition.bottom,
                              );
                              return;
                            }

                            context.read<CompleteProfileBloc>().add(
                              const CompleteProfileEvent.submitPressed(),
                            );
                          },
                          sideWidget: Icon(
                            Icons.arrow_forward_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20.sp,
                          ),
                          sideWidgetPosition: SideWidgetPosition.right,
                          useSpaceBetween: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section reveal
// ─────────────────────────────────────────────────────────────────────────────

class _SectionReveal extends StatelessWidget {
  final AnimationController parent;
  final Interval interval;
  final Widget child;

  const _SectionReveal({
    required this.parent,
    required this.interval,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final drive = CurvedAnimation(parent: parent, curve: interval);
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(drive);
    final fade = Tween<double>(begin: 0.0, end: 1.0).animate(drive);

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Ambient background orbs
// ─────────────────────────────────────────────────────────────────────────────

class _AmbientBackground extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final appColors = context.appColors;

    final ctrl = useAnimationController(duration: const Duration(seconds: 7))
      ..repeat(reverse: true);

    final anim = CurvedAnimation(parent: ctrl, curve: Curves.easeInOut);

    return AnimatedBuilder(
      animation: anim,
      builder: (context2, child2) {
        final t = anim.value;
        return Stack(
          children: [
            Positioned(
              top: -40 + t * 28,
              left: -60 + t * 12,
              child: _Orb(
                size: 230.w,
                color: cs.tertiary.withValues(alpha: 0.06),
              ),
            ),
            Positioned(
              bottom: 80 - t * 35,
              right: -70 + t * 14,
              child: _Orb(
                size: 250.w,
                color: appColors.info.withValues(alpha: 0.04),
              ),
            ),
            Positioned(
              top: 320.h + t * 18,
              left: 20.w + t * 6,
              child: _Orb(
                size: 90.w,
                color: cs.tertiary.withValues(alpha: 0.04),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;

  const _Orb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Page header
// ─────────────────────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'completeProfile.header.title'.tr(),
          style: TextStyle(
            color: cs.onSurface,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'completeProfile.header.subtitle'.tr(),
          style: TextStyle(
            color: cs.onSurface.withValues(alpha: 0.5),
            fontSize: 12.sp,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Migration info banner
// ─────────────────────────────────────────────────────────────────────────────

class _MigrationBanner extends HookWidget {
  const _MigrationBanner();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final appColors = context.appColors;

    final shimmerCtrl = useAnimationController(
      duration: const Duration(milliseconds: 2800),
    )..repeat();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.appColors.glass.withValues(alpha: 0.08),
            context.appColors.glass.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: appColors.info.withValues(alpha: 0.3),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: context.appColors.shadowInk.withValues(alpha: 0.12,),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: Stack(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 4.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          appColors.info,
                          appColors.info.withValues(alpha: 0.3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(14.w, 14.h, 16.w, 14.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _PulsingIcon(
                            size: 44.w,
                            color: appColors.info,
                            icon: Icons.manage_accounts_rounded,
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'completeProfile.banner.title'.tr(),
                                      style: TextStyle(
                                        color: cs.onSurface,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: appColors.info.withValues(
                                          alpha: 0.12,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                      child: Text(
                                        'completeProfile.banner.badge'.tr(),
                                        style: TextStyle(
                                          color: appColors.info,
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'completeProfile.banner.subtitle'.tr(),
                                  style: TextStyle(
                                    color: cs.onSurface.withValues(alpha: 0.5),
                                    fontSize: 11.sp,
                                    height: 1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: shimmerCtrl,
                  builder: (context3, child3) {
                    final x = -1.5 + shimmerCtrl.value * 3.5;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(x - 0.6, -1),
                          end: Alignment(x + 0.6, 1),
                          colors: [
                            Colors.transparent,
                            context.appColors.glass.withValues(alpha: 0.06),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingIcon extends HookWidget {
  final double size;
  final Color color;
  final IconData icon;

  const _PulsingIcon({
    required this.size,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = useAnimationController(
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    return AnimatedBuilder(
      animation: ctrl,
      builder: (_, child) {
        final r1 = ctrl.value;
        final r2 = (ctrl.value + 0.45) % 1.0;

        Widget ring(double t) {
          return Transform.scale(
            scale: 1.0 + t * 0.9,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(
                    alpha: (1.0 - t).clamp(0.0, 1.0) * 0.4,
                  ),
                  width: 1.w,
                ),
              ),
            ),
          );
        }

        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [ring(r1), ring(r2), child!],
          ),
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Icon(icon, color: color, size: 22.sp),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Fields card with shake animation
// ─────────────────────────────────────────────────────────────────────────────

class _FieldsCard extends HookWidget {
  final List<MemberFieldSetting> fields;
  final CompleteProfileState state;

  const _FieldsCard({required this.fields, required this.state});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final shakeCtrl = useAnimationController(
      duration: const Duration(milliseconds: 480),
    );

    final shakeAnim = useMemoized(
          () => TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 7.0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 7.0, end: -7.0), weight: 2),
        TweenSequenceItem(tween: Tween(begin: -7.0, end: 5.0), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 5.0, end: -5.0), weight: 2),
        TweenSequenceItem(tween: Tween(begin: -5.0, end: 2.0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 2.0, end: 0.0), weight: 1),
      ]).animate(CurvedAnimation(parent: shakeCtrl, curve: Curves.easeInOut)),
    );

    final prevShowErrors = usePrevious(state.showErrorMessages);
    useEffect(() {
      if (state.showErrorMessages && prevShowErrors == false) {
        final hasErrors = state.dynamicFieldValues.values.any(
              (v) => v.value.isLeft(),
        );
        if (hasErrors) shakeCtrl.forward(from: 0);
      }
      return null;
    }, [state.showErrorMessages]);

    return AnimatedBuilder(
      animation: shakeAnim,
      builder: (_, child) =>
          Transform.translate(offset: Offset(shakeAnim.value, 0), child: child),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.appColors.glass.withValues(alpha: 0.08),
              context.appColors.glass.withValues(alpha: 0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: context.appColors.glassBorder.withValues(alpha: 0.18),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: context.appColors.shadowInk.withValues(alpha: 0.12,),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              child: Row(
                children: [
                  Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: cs.tertiary.withValues(alpha: 0.12),
                      border: Border.all(
                        color: cs.tertiary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Icon(
                      Icons.edit_document,
                      color: cs.tertiary,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'completeProfile.fieldsCard.title'.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: cs.onSurface,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'completeProfile.fieldsCard.subtitle'.tr(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: cs.onSurface.withValues(alpha: 0.45),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: context.appColors.glassBorder.withValues(alpha: 0.08)),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: fields.mapIndexed((index, f) {
                  final normalized = (f.fieldName ?? '')
                      .toLowerCase()
                      .replaceAll(RegExp(r'[\s_]+'), '');
                  final showLeading =
                      normalized.contains('country') ||
                          normalized.contains('nationalit');
                  return _FieldItem(
                    key: ValueKey(f.fieldName),
                    index: index,
                    field: f,
                    state: state,
                    isShowLeading: showLeading,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldItem extends HookWidget {
  final int index;
  final MemberFieldSetting field;
  final CompleteProfileState state;
  final bool isShowLeading;

  const _FieldItem({
    super.key,
    required this.index,
    required this.field,
    required this.state,
    this.isShowLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    final entranceCtrl = useAnimationController(
      duration: const Duration(milliseconds: 380),
    );

    useEffect(() {
      var mounted = true;
      Future.delayed(Duration(milliseconds: 120 + index * 65), () {
        if (mounted && !entranceCtrl.isCompleted) entranceCtrl.forward();
      });
      return () => mounted = false;
    }, const []);

    final slide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(
      CurvedAnimation(parent: entranceCtrl, curve: Curves.easeOutCubic),
    );
    final fade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: entranceCtrl, curve: Curves.easeOut));

    final key = field.fieldName ?? '';
    final fieldType = AppGlobal.mapFieldType(field.type);

    // The bloc validates prefills before adding them to lockedFields, so the
    // set is authoritative — never re-derive the lock from the live value or
    // the user's own selection would freeze the field.
    final isReadOnly = state.lockedFields.contains(key);

    // Normalised name for dependency checks.
    final normalizedFieldName = key
        .toLowerCase()
        .replaceAll(RegExp(r'[\s_]+'), '');

    // City-field specific states.
    final isCityField = normalizedFieldName == 'cityid';
    final isStateField = normalizedFieldName == 'statecode';
    final isAwaitingState = isCityField && !_isStatePicked(state);
    final isCityLoading = isCityField && state.isLoadingCities;

    // For dropdown fields: null entry in comboOptions means data hasn't
    // arrived yet (state field loads async; others have no API options).
    final comboEntry = fieldType == BeneficiaryFieldType.dropdown
        ? state.comboOptions[key]
        : null;
    final isDropdownLoadingInBackground = isStateField && comboEntry == null;
    final isDropdownUnavailable =
        fieldType == BeneficiaryFieldType.dropdown &&
            !isCityField &&
            !isStateField &&
            comboEntry == null;

    void dispatchFieldChanged(
        String fieldName,
        String value,
        MemberFieldSetting f,
        ) {
      context.read<CompleteProfileBloc>().add(
        CompleteProfileEvent.fieldChanged(
          fieldName: fieldName,
          value: value,
          field: f,
        ),
      );
    }

    final fieldWidget = switch (fieldType) {
      BeneficiaryFieldType.dropdown => CompleteProfileDropdown(
        field: field,
        dynamicFieldValues: state.dynamicFieldValues,
        comboOptions: state.comboOptions,
        showErrorMessages: state.showErrorMessages,
        isShowLeading: isShowLeading,
        readOnly: isReadOnly,
        isLoading: isCityLoading || isDropdownLoadingInBackground,
        isAwaitingParent: isAwaitingState,
        isUnavailable: isDropdownUnavailable,
        awaitingHint: isAwaitingState
            ? 'completeProfile.city.awaitingState'.tr()
            : null,
        onChanged: dispatchFieldChanged,
      ),
      BeneficiaryFieldType.date => CompleteProfileDatePicker(
        field: field,
        dynamicFieldValues: state.dynamicFieldValues,
        showErrorMessages: state.showErrorMessages,
        readOnly: isReadOnly,
        onChanged: dispatchFieldChanged,
      ),
      _ => CompleteProfileTextField(
        field: field,
        dynamicFieldValues: state.dynamicFieldValues,
        showErrorMessages: state.showErrorMessages,
        readOnly: isReadOnly,
        onChanged: dispatchFieldChanged,
      ),
    };

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: Padding(
          padding: EdgeInsets.only(top: 14.h),
          child: fieldWidget,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Video card section
// ─────────────────────────────────────────────────────────────────────────────

class _VideoCard extends StatelessWidget {
  final CompleteProfileState state;

  const _VideoCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final hasVideo =
        state.selfieVideoEId != null ||
            state.selfieVideoThumbnailPath != null ||
            state.selfieVideoPath != null;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.appColors.glass.withValues(alpha: 0.08),
            context.appColors.glass.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: hasVideo
              ? cs.tertiary.withValues(alpha: 0.25)
              : context.appColors.glassBorder.withValues(alpha: 0.18),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: context.appColors.shadowInk.withValues(alpha: 0.12,),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: Row(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: cs.tertiary.withValues(alpha: 0.12),
                    border: Border.all(
                      color: cs.tertiary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Icon(
                    Icons.videocam_rounded,
                    color: cs.tertiary,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'completeProfile.videoCard.title'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.sp,
                          color: cs.onSurface,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'completeProfile.videoCard.subtitle'.tr(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: cs.onSurface.withValues(alpha: 0.45),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: cs.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'completeProfile.videoCard.required'.tr(),
                    style: TextStyle(
                      color: cs.error,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: context.appColors.glassBorder.withValues(alpha: 0.08)),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
            child: KycVideoCard(
              videoPath: state.selfieVideoPath,
              thumbnailPath: state.selfieVideoThumbnailPath,
              isUploading: state.isSelfieVideoUploading,
              isDeleting: state.isSelfieVideoDeleting,
              onRecord: () async {
                final result = await AppVideoRecorderPage.show(context);
                if (result != null) {
                  context.read<CompleteProfileBloc>().add(
                    CompleteProfileEvent.selfieVideoConfirmed(
                      videoPath: result.videoPath,
                      thumbnailPath: result.thumbnailPath,
                    ),
                  );
                }
              },
              onPlay: () {
                final path = state.selfieVideoPath;
                if (path != null) AppVideoPlayerPage.show(context, path);
              },
              onDelete: () => context.read<CompleteProfileBloc>().add(
                const CompleteProfileEvent.selfieVideoRemoved(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Privacy note
// ─────────────────────────────────────────────────────────────────────────────

class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: cs.tertiary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: cs.tertiary.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            color: cs.tertiary.withValues(alpha: 0.7),
            size: 13.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'completeProfile.privacyNote'.tr(),
              style: TextStyle(
                color: cs.onSurface.withValues(alpha: 0.4),
                fontSize: 10.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Returns true when a statecode field exists in dynamicFieldValues and has a
// non-empty selection. Used by _FieldItem to gate the city dropdown.
bool _isStatePicked(CompleteProfileState state) {
  for (final entry in state.dynamicFieldValues.entries) {
    final normalized = entry.key.toLowerCase().replaceAll(
      RegExp(r'[\s_]+'),
      '',
    );
    if (normalized == 'statecode') {
      return entry.value.value.getOrElse(() => '').isNotEmpty;
    }
  }
  return false;
}

// ─────────────────────────────────────────────────────────────────────────────
// List extension
// ─────────────────────────────────────────────────────────────────────────────

extension<T> on List<T> {
  List<R> mapIndexed<R>(R Function(int index, T item) f) {
    final result = <R>[];
    for (var i = 0; i < length; i++) {
      result.add(f(i, this[i]));
    }
    return result;
  }
}
