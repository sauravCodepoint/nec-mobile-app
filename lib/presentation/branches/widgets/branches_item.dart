import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/branches/branches_dto.dart';
import '../../core/theme/app_theme_ext.dart';

class BranchesItem extends HookWidget {
  final BranchList? branch;
  final int index;

  const BranchesItem({super.key, this.branch, required this.index});

  Future<void> _call(String phone) async {
    final cleaned = phone.split(RegExp(r'[/,]')).first.trim();
    await launchUrl(Uri.parse('tel:$cleaned'));
  }

  Future<void> _whatsapp(String phone) async {
    final cleaned = phone
        .split(RegExp(r'[/,]'))
        .first
        .trim()
        .replaceAll(RegExp(r'[^\d+]'), '');
    await launchUrl(
      Uri.parse('https://wa.me/$cleaned'),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _email(String email) async {
    await launchUrl(Uri(scheme: 'mailto', path: email.trim()));
  }

  Future<void> _openMap({
    required String? lat,
    required String? lng,
    required String address,
  }) async {
    final parsedLat = double.tryParse(lat ?? '');
    final parsedLng = double.tryParse(lng ?? '');

    final Uri uri;
    if (parsedLat != null && parsedLng != null) {
      uri = Uri.parse('https://maps.google.com/?q=$parsedLat,$parsedLng');
    } else if (address.isNotEmpty) {
      uri = Uri.parse(
        'https://maps.google.com/?q=${Uri.encodeComponent(address)}',
      );
    } else {
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final appColors = context.appColors;

    final controller = useAnimationController(
      duration: const Duration(milliseconds: 380),
    );

    useEffect(() {
      var cancelled = false;
      final delay = Duration(milliseconds: (index.clamp(0, 8)) * 55);
      Future.delayed(delay, () {
        if (!cancelled && controller.status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
      return () => cancelled = true;
    }, const []);

    final opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.14),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));

    final branchName = branch?.branchName ?? '';
    final phone = branch?.phone ?? '';
    final email = branch?.email ?? '';
    final lat = branch?.latitude;
    final lng = branch?.longitude;

    // Each part may arrive with its own leading/trailing commas or stray
    // whitespace (e.g. "Building 5," or a bare ","). Strip those before
    // filtering so joining never yields doubled or dangling commas when only
    // some of the three lines are present.
    final addressParts = [branch?.address1, branch?.address2, branch?.address3]
        .map((e) => (e ?? '').replaceAll(RegExp(r'^[\s,]+|[\s,]+$'), '').trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final fullAddress = addressParts.join(', ');

    final hasPhone = phone.isNotEmpty;
    final hasEmail = email.isNotEmpty;
    final hasMap =
        (double.tryParse(lat ?? '') != null &&
            double.tryParse(lng ?? '') != null) ||
        fullAddress.isNotEmpty;

    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: Container(
          decoration: context.glassPanel(
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: colorScheme.tertiary.withValues(alpha: 0.28),
                          width: 0.8,
                        ),
                      ),
                      child: Icon(
                        Icons.account_balance_rounded,
                        size: 20.sp,
                        color: colorScheme.tertiary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            branchName,
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                          ),
                          if (fullAddress.isNotEmpty) ...[
                            SizedBox(height: 6.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h),
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    size: 13.sp,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text(
                                    fullAddress,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (hasPhone) ...[
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_rounded,
                                  size: 12.sp,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  phone,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (hasPhone)
                      GestureDetector(
                        onTap: () => _whatsapp(phone),
                        child: Container(
                          width: 34.w,
                          height: 34.w,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF25D366,
                            ).withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF25D366).withValues(alpha: 0.30),
                              width: 0.8,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/svg/whatsapp.svg',
                              width: 17.sp,
                              height: 17.sp,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFF25D366),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // ── Divider ──────────────────────────────────────────────────
              Divider(
                height: 1,
                thickness: 0.5,
                color: context.appColors.glassBorder.withValues(alpha: 0.12),
              ),

              // ── Action row ──────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasPhone) ...[
                      _ActionChip(
                        iconWidget: Icon(
                          Icons.call_rounded,
                          size: 12.sp,
                          color: appColors.success,
                        ),
                        label: 'ourBranches.actions.call'.tr(),
                        color: appColors.success,
                        onTap: () => _call(phone),
                      ),
                      SizedBox(width: 8.w),
                    ],
                    if (hasEmail) ...[
                      _ActionChip(
                        iconWidget: Icon(
                          Icons.mail_rounded,
                          size: 12.sp,
                          color: appColors.info,
                        ),
                        label: 'ourBranches.actions.email'.tr(),
                        color: appColors.info,
                        onTap: () => _email(email),
                      ),
                      SizedBox(width: 8.w),
                    ],
                    if (hasMap)
                      _ActionChip(
                        iconWidget: Icon(
                          Icons.directions_rounded,
                          size: 12.sp,
                          color: colorScheme.tertiary,
                        ),
                        label: 'ourBranches.actions.directions'.tr(),
                        color: colorScheme.tertiary,
                        onTap: () =>
                            _openMap(lat: lat, lng: lng, address: fullAddress),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Action chip ───────────────────────────────────────────────────────────────

class _ActionChip extends StatelessWidget {
  final Widget iconWidget;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionChip({
    required this.iconWidget,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: color.withValues(alpha: 0.30), width: 0.8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            SizedBox(width: 5.w),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
