import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/common/common_branches_dto.dart';
import '../../../domain/common/common_selectable_dto.dart';
import '../../routes/app_routes.gr.dart';
import '../button/app_button.dart';
import '../dotted_border/app_dotted_border.dart';
import '../notify/app_notify.dart';
import '../text_form_field/app_text_form_field.dart';
import '../theme/app_theme_ext.dart';

class AppBranchBottomSheet extends HookWidget {
  final CommonBranchesDto? commonBranchesDto;
  final void Function()? onSubmit;
  final void Function(CommonSelectableItem)? onSelected;

  const AppBranchBottomSheet({
    super.key,
    this.commonBranchesDto,
    this.onSubmit,
    this.onSelected,
  });

  static Future<void> show(
    BuildContext context, {
    CommonBranchesDto? commonBranchesDto,
    void Function()? onSubmit,
    void Function(CommonSelectableItem)? onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AppBranchBottomSheet(
        commonBranchesDto: commonBranchesDto,
        onSubmit: onSubmit,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final branchController = useTextEditingController();
    final selectedBranch = useState<CommonSelectableItem?>(null);

    final branchList = commonBranchesDto?.data?.branchList ?? [];
    final selected = selectedBranch.value;

    final selectedBranchData = branchList.firstWhereOrNull(
      (branch) =>
          branch.branchCode == selected?.titleCode ||
          branch.branchName == selected?.titleName,
    );

    String safe(String? value) => value?.trim() ?? '';

    // Each part may arrive with its own leading/trailing commas or stray
    // whitespace (e.g. "Building 5," or a bare ","). Strip those before
    // filtering so joining never yields doubled or dangling commas when only
    // some of the three lines are present.
    String buildAddress() {
      return [
            selectedBranchData?.address1,
            selectedBranchData?.address2,
            selectedBranchData?.address3,
          ]
          .map(
            (e) => (e ?? '').replaceAll(RegExp(r'^[\s,]+|[\s,]+$'), '').trim(),
          )
          .where((e) => e.isNotEmpty)
          .join(', ');
    }

    final message = [
      selectedBranchData?.appMessage1,
      selectedBranchData?.validTimeLimit,
      selectedBranchData?.appMessage2,
    ].whereType<String>().join();

    // The backend authors this message in its own language, independent of
    // the app locale — under an Arabic (RTL) locale a Latin-script message
    // inherits the ambient RTL base direction and renders right-aligned
    // with scrambled punctuation/digits. Lay the text out by its own
    // script instead of the locale.
    final messageDirection = RegExp(r'[؀-ۿ]').hasMatch(message)
        ? ui.TextDirection.rtl
        : ui.TextDirection.ltr;

    final hasSelection =
        safe(selectedBranchData?.branchName).isNotEmpty ||
        safe(selectedBranchData?.branchCode).isNotEmpty;

    final hasLocation =
        (selectedBranchData?.latitude?.isNotEmpty ?? false) &&
        (selectedBranchData?.longitude?.isNotEmpty ?? false);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 1.sw,
              margin: EdgeInsets.only(top: 50.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: context.appColors.containerBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: context.appColors.glassBorder.withValues(alpha: 0.18),
                  width: 0.8,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextFormField(
                    controller: branchController,
                    labelText: 'core.branchSelection.selectBranch.label'.tr(),
                    labelStyle: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: 'core.branchSelection.selectBranch.hint'.tr(),
                    readOnly: true,
                    showCursor: false,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: colorScheme.tertiary,
                    ),
                    onTap: () {
                      final dto = CommonSelectableDto(
                        data: CommonSelectableData(
                          list: branchList.map((e) {
                            return CommonSelectableItem(
                              titleName: safe(e.branchName).toUpperCase(),
                              titleCode: e.branchCode,
                            );
                          }).toList(),
                        ),
                      );

                      context.router.push(
                        AppSelectableRoute(
                          title: 'core.branchSelection.selectBranch.title'.tr(),
                          initialSelectedItem: selected,
                          commonSelectableDto: dto,
                          onSelected: (value) {
                            selectedBranch.value = value;
                            branchController.text = value.titleName ?? '';
                            onSelected?.call(value);
                          },
                        ),
                      );
                    },
                  ),

                  if (hasSelection) ...[
                    SizedBox(height: 12.h),

                    AppInfoRow(
                      title: 'core.branchSelection.fields.branch'.tr(),
                      value: safe(selectedBranchData?.branchName),
                    ),

                    AppDottedDivider(
                      color: context.appColors.glassBorder.withValues(
                        alpha: 0.18,
                      ),
                      dotSize: 0.75,
                      dotLength: 2,
                      space: 3,
                      height: 8,
                    ),

                    AppInfoRow(
                      title: 'core.branchSelection.fields.contact'.tr(),
                      value: safe(selectedBranchData?.phone),
                    ),

                    AppDottedDivider(
                      color: context.appColors.glassBorder.withValues(
                        alpha: 0.18,
                      ),
                      dotSize: 0.75,
                      dotLength: 2,
                      space: 3,
                      height: 8,
                    ),

                    AppInfoRow(
                      title: 'core.branchSelection.fields.address'.tr(),
                      value: buildAddress(),
                    ),

                    AppDottedDivider(
                      color: context.appColors.glassBorder.withValues(
                        alpha: 0.18,
                      ),
                      dotSize: 0.75,
                      dotLength: 2,
                      space: 3,
                      height: 8,
                    ),

                    AppInfoRow(
                      title: 'core.branchSelection.fields.workingHours'.tr(),
                      value: safe(selectedBranchData?.workingHours),
                    ),

                    SizedBox(height: 16.h),

                    if (message.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: context.appColors.error.withValues(
                            alpha: 0.18,
                          ),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: context.appColors.error,
                              size: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                message,
                                textDirection: messageDirection,
                                textAlign: TextAlign.start,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 12.sp,
                                  color: context.appColors.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 16.h),

                    if (hasLocation)
                      GestureDetector(
                        onTap: () async {
                          final lat = selectedBranchData?.latitude;
                          final lng = selectedBranchData?.longitude;

                          if (lat != null && lng != null) {
                            final url = Uri.parse(
                              'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
                            );

                            final launched = await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                            if (!launched) {
                              if (!context.mounted) return;
                              DialogHelper.show(
                                context,
                                message:
                                    'core.branchSelection.messages.mapError'
                                        .tr(),
                                type: AppDialogType.warning,
                                barrierDismissible: false,
                                buttonText: 'buttons.ok'.tr(),
                                onPressed: () {
                                  context.router.pop();
                                },
                              );
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: context.appColors.glass.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.center_focus_strong,
                                size: 18.w,
                                color: colorScheme.tertiary,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'core.branchSelection.actions.viewLocation'
                                    .tr(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],

                  SizedBox(height: 16.h),

                  AppButton(
                    onTap: () {
                      if (selected == null) {
                        AppNotify.toast(
                          'core.branchSelection.selectBranchRequired'.tr(),
                          type: AppToastType.error,
                          position: AppToastPosition.top,
                        );
                        return;
                      }
                      onSubmit?.call();
                    },
                    height: 48.h,
                    text: 'buttons.submit'.tr(),
                    useSpaceBetween: true,
                    sideWidgetPosition: SideWidgetPosition.right,
                    sideWidget: Icon(
                      Icons.arrow_forward,
                      size: 18.w,
                      color: colorScheme.primary,
                    ),
                    textStyle: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: context.appColors.glass.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 22.w,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const AppInfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    if (value.trim().isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
