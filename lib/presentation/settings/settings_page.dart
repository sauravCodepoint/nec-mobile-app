import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/branches/branches_bloc.dart';
import '../../application/profile/profile_bloc.dart';
import '../../application/settings/settings_bloc.dart';
import '../../application/transaction_history/transaction_history_bloc.dart';
import '../../domain/company_info/company_info_type.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/dialog/app_language_dialog.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/user_box/app_user_box.dart';
import '../core/widgets/locale_bloc_builder.dart';
import '../routes/app_routes.gr.dart';
import '../core/theme/app_theme_ext.dart';
import 'widgets/settings_shimmer_view.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<SettingsBloc>().add(const SettingsEvent.getUserInfo());
      context.read<SettingsBloc>().add(
        const SettingsEvent.checkBiometricSupport(),
      );
      return null;
    }, const []);

    return LocaleBlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final user = state.settingsUserInfo?.data?.user;
        final userName = user?.name ?? '';
        final userInitials = userName
            .split(' ')
            .where((n) => n.isNotEmpty)
            .take(2)
            .map((n) => n[0])
            .join();
        final isUserActive = user?.status?.toLowerCase() == 'active';
        // Also true on the very first frame, before the useEffect's event has
        // been handled — otherwise the page flashes an empty name and a red
        // "Inactive" pill before the shimmer even starts.
        final isUserPending =
            state.isUserLoading || state.userInfoFailureOrSuccessOption.isNone();

        return AppScaffold(
          appBar: AppAppBar(title: 'settings.title'.tr()),
          body: SingleChildScrollView(
            child: Column(
              spacing: 12.h,
              children: [
                SizedBox(height: 4.h),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 260),
                  child: isUserPending
                      ? const SettingsUserBoxShimmer()
                      : AppUserBox(
                          userName: userName,
                          userInitials: userInitials,
                          isActive: isUserActive,
                          userStatus: isUserActive
                              ? 'settings.active'.tr()
                              : 'settings.inactive'.tr(),
                        ),
                ),
                SettingsTile(
                  title: 'settings.profile.title'.tr(),
                  icon: Icons.person,
                  onTap: () {
                    context.read<ProfileBloc>().add(
                      const ProfileEvent.getUserInfo(),
                    );
                    context.router.push(const ProfileRoute());
                  },
                ),
                SettingsTile(
                  title: 'settings.transactionHistory.title'.tr(),
                  icon: Icons.history,
                  onTap: () {
                    context.read<TransactionHistoryBloc>().add(
                      const TransactionHistoryEvent.getTransactionHistory(
                        resetSort: true,
                      ),
                    );
                    context.router.push(const TransactionHistoryRoute());
                  },
                ),
                SettingsTile(
                  title: 'settings.ourBranches.title'.tr(),
                  icon: Icons.location_on,
                  onTap: () {
                    context.read<BranchesBloc>().add(
                      const BranchesEvent.getBranchesList(),
                    );
                    context.router.push(const BranchesRoute());
                  },
                ),
                if (state.isBiometricChecking)
                  const SettingsTileShimmer()
                else if (state.isBiometricAvailable)
                  SettingsTile(
                    title: 'settings.biometricAuthentication.title'.tr(),
                    icon: Icons.fingerprint,
                    value: state.isBiometricEnabled,
                    onChanged: (_) => context.read<SettingsBloc>().add(
                      SettingsEvent.toggleBiometricAuth(),
                    ),
                  ),
                SettingsTile(
                  title: 'settings.language.title'.tr(),
                  icon: Icons.language,
                  onTap: () => AppLanguageDialog.show(context),
                ),
                SettingsTile(
                  title: 'settings.changeMpin.title'.tr(),
                  icon: Icons.lock,
                  onTap: () =>
                      context.router.push(const ChangeCurrentMpinRoute()),
                ),
                SettingsTile(
                  title: 'settings.termsAndConditions.title'.tr(),
                  icon: Icons.description,
                  onTap: () {
                    context.router.push(
                      CompanyInfoRoute(
                        companyInfoType:
                        CompanyInfoType.termsAndConditions,
                      ),
                    );
                  },
                ),
                SettingsTile(
                  title: 'settings.privacyPolicy.title'.tr(),
                  icon: Icons.privacy_tip,
                  onTap: () {
                    context.router.push(
                      CompanyInfoRoute(
                        companyInfoType:
                        CompanyInfoType.privacyPolicy,
                      ),
                    );
                  },
                ),
                SettingsTile(
                  title: 'settings.aboutUs.title'.tr(),
                  icon: Icons.info,
                  onTap: () {
                    context.router.push(
                      CompanyInfoRoute(
                        companyInfoType:
                        CompanyInfoType.aboutUs,
                      ),
                    );
                  },
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingsTile extends HookWidget {
  final String title;
  final IconData icon;
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    this.value,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final pressCtrl = useAnimationController(
      duration: const Duration(milliseconds: 60),
      reverseDuration: const Duration(milliseconds: 200),
    );
    final scale = useAnimation(
      Tween<double>(begin: 1.0, end: 0.97).animate(
        CurvedAnimation(parent: pressCtrl, curve: Curves.easeOut),
      ),
    );

    return GestureDetector(
      onTapDown: onTap != null ? (_) => pressCtrl.forward() : null,
      onTapUp: onTap != null
          ? (_) {
              pressCtrl.reverse();
              HapticFeedback.lightImpact();
              onTap!();
            }
          : null,
      onTapCancel: onTap != null ? () => pressCtrl.reverse() : null,
      child: Transform.scale(
        scale: scale,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: context.glassPanel(
            borderRadius: BorderRadius.circular(12.r),
            shadowAlpha: 0.12,
            shadowBlur: 10.r,
            shadowOffset: Offset(0, 4.h),
          ),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.appColors.brandFill.withValues(alpha: 0.26),
                      context.appColors.brandFill.withValues(alpha: 0.12),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: context.appColors.brandFill.withValues(
                        alpha: 0.15,
                      ),
                      blurRadius: 6,
                      spreadRadius: -1,
                    ),
                  ],
                ),
                child: Icon(icon, size: 20.sp, color: cs.tertiary),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface.withValues(alpha: 0.90),
                  ),
                ),
              ),
              if (value != null)
                Transform.scale(
                  scale: 0.85,
                  child: Switch.adaptive(
                    value: value!,
                    onChanged: (v) {
                      HapticFeedback.lightImpact();
                      onChanged?.call(v);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              else
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.sp,
                  color: context.appColors.glassBorder.withValues(alpha: 0.30),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
