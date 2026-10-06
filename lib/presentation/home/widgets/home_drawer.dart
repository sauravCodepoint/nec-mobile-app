import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/branches/branches_bloc.dart';
import '../../../application/home/home_bloc.dart';
import '../../../application/profile/profile_bloc.dart';
import '../../../application/transaction_history/transaction_history_bloc.dart';
import '../../../domain/company_info/company_info_type.dart';
import '../../core/button/app_button.dart';
import '../../core/dialog/app_language_dialog.dart';
import '../../core/theme/app_theme_ext.dart';
import '../../routes/app_routes.gr.dart';

class HomeDrawer extends StatelessWidget {
  final HomeState state;
  const HomeDrawer({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final borderRadius = BorderRadius.only(
      topRight: Radius.circular(24.r),
      bottomRight: Radius.circular(24.r),
    );

    return Drawer(
      width: 0.82.sw,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: cs.surface,
            gradient: context.appGradient?.background,
          ),
          // Guard only the bottom inset: without it the pinned logout button and
          // the tail of the scroll list render under the system navigation bar /
          // gesture area, so logout looks "missing" and the list can't be seen
          // in full. Top is left to the header, which already pads for the status
          // bar via statusBarHeight — a full SafeArea would double that padding.
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                _DrawerHeader(state: state),
                Divider(
                  color: context.appColors.glassBorder.withValues(alpha: 0.12),
                  thickness: 0.5,
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        _DrawerItem(
                          icon: Icons.home_outlined,
                          label: 'home.drawer.home'.tr(),
                          isActive: true,
                          onTap: () {},
                        ),
                        _DrawerItem(
                          icon: Icons.person_outline_rounded,
                          label: 'home.drawer.profile'.tr(),
                          onTap: () {
                            context.read<ProfileBloc>().add(
                              const ProfileEvent.getUserInfo(),
                            );
                            context.router.push(const ProfileRoute());
                          },
                        ),
                        _DrawerItem(
                          icon: Icons.history_rounded,
                          label: 'home.drawer.transactionHistory'.tr(),
                          onTap: () {
                            context.read<TransactionHistoryBloc>().add(
                              const TransactionHistoryEvent.getTransactionHistory(
                                resetSort: true,
                              ),
                            );
                            context.router.push(
                              const TransactionHistoryRoute(),
                            );
                          },
                        ),
                        _DrawerItem(
                          icon: Icons.location_on_outlined,
                          label: 'home.drawer.ourBranches'.tr(),
                          onTap: () {
                            context.read<BranchesBloc>().add(
                              const BranchesEvent.getBranchesList(),
                            );
                            context.router.push(const BranchesRoute());
                          },
                        ),
                        _DrawerItem(
                          icon: Icons.language_outlined,
                          label: 'home.drawer.language'.tr(),
                          onTap: () {
                            AppLanguageDialog.show(context);
                          },
                        ),
                        _DrawerItem(
                          icon: Icons.description_outlined,
                          label: 'home.drawer.termsAndConditions'.tr(),
                          onTap: () {
                            context.router.push(
                              CompanyInfoRoute(
                                companyInfoType:
                                    CompanyInfoType.termsAndConditions,
                              ),
                            );
                          },
                        ),
                        _DrawerItem(
                          icon: Icons.privacy_tip_outlined,
                          label: 'home.drawer.privacyPolicy'.tr(),
                          onTap: () {
                            context.router.push(
                              CompanyInfoRoute(
                                companyInfoType: CompanyInfoType.privacyPolicy,
                              ),
                            );
                          },
                        ),
                        _DrawerItem(
                          icon: Icons.info_outline_rounded,
                          label: 'home.drawer.aboutUs'.tr(),
                          onTap: () {
                            context.router.push(
                              CompanyInfoRoute(
                                companyInfoType: CompanyInfoType.aboutUs,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AppButton(
                    text: 'buttons.logout'.tr(),
                    onTap: () {
                      context.router.replaceAll([MpinRoute()]);
                    },
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────

class _DrawerHeader extends StatelessWidget {
  final HomeState state;
  const _DrawerHeader({required this.state});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final topPadding = ScreenUtil().statusBarHeight;
    final userDto = state.homeUserDto;
    final user = userDto?.data?.user;
    final userName = user?.firstName ?? '';
    final userFullName = user?.name ?? '';
    final userInitials = userFullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .map((e) => e[0])
        .take(2)
        .join();
    final isUserActive = user?.status?.toLowerCase() == 'active';
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h + topPadding, 20.w, 20.h),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  context.appColors.brandFill,
                  Color.lerp(context.appColors.brandFill, Colors.black, 0.12)!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: cs.tertiary.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Center(
              child: Text(
                userInitials,
                style: TextStyle(
                  color: cs.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.drawer.hi'.tr(namedArgs: {'userName': userName}),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isUserActive
                        ? context.appColors.success.withValues(alpha: 0.15)
                        : context.appColors.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    isUserActive
                        ? 'home.drawer.active'.tr()
                        : 'home.drawer.inactive'.tr(),
                    style: TextStyle(
                      color: isUserActive
                          ? context.appColors.success
                          : context.appColors.error,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Drawer Item ───────────────────────────────────────────────────────────

class _DrawerItem extends HookWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    final pressController = useAnimationController(
      duration: const Duration(milliseconds: 60),
      reverseDuration: const Duration(milliseconds: 180),
    );

    final scale = useAnimation(
      Tween<double>(begin: 1.0, end: 0.97).animate(
        CurvedAnimation(parent: pressController, curve: Curves.easeOut),
      ),
    );

    final p = pressController.value;

    final inactiveIconBg = Color.lerp(
      context.appColors.glass.withValues(alpha: 0.08),
      context.appColors.glass.withValues(alpha: 0.14),
      p,
    )!;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        pressController.forward();
        HapticFeedback.selectionClick();
      },
      onTapUp: (_) {
        pressController.reverse();
        context.router.pop();
        onTap();
      },
      onTapCancel: () => pressController.reverse(),
      child: Transform.scale(
        scale: scale,
        child: Container(
          margin: EdgeInsets.only(bottom: 4.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    colors: [
                      cs.tertiary.withValues(alpha: 0.12),
                      cs.tertiary.withValues(alpha: 0.06),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isActive ? null : cs.onSurface.withValues(alpha: p * 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: isActive
                ? Border.all(
                    color: cs.tertiary.withValues(alpha: 0.25),
                    width: 0.8,
                  )
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  gradient: isActive
                      ? LinearGradient(
                          colors: [
                            cs.tertiary.withValues(alpha: 0.28),
                            cs.tertiary.withValues(alpha: 0.14),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isActive ? null : inactiveIconBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 18.sp,
                  color: isActive
                      ? cs.tertiary
                      : cs.onSurface.withValues(alpha: 0.75),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isActive
                        ? cs.tertiary
                        : cs.onSurface.withValues(alpha: 0.90),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 18.sp,
                color: context.appColors.glassBorder.withValues(alpha: 0.25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
