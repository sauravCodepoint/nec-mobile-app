import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bottom_sheet/app_action_sheet.dart';
import 'dashed_border.dart';
import '../theme/app_theme_ext.dart';

class KycDocumentCard extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final String? filePath;
  final bool isLoading;

  /// Draws the empty state's dashed border in the error color — set after a
  /// submit attempt while this document is still missing.
  final bool hasError;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const KycDocumentCard({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.onPick,
    required this.onRemove,
    this.filePath,
    this.isLoading = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 380),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween(begin: 0.93, end: 1.0).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          ),
          child: child,
        ),
      ),
      child: filePath == null
          ? _DocEmptyState(
              key: const ValueKey('empty'),
              label: label,
              hint: hint,
              icon: icon,
              hasError: hasError,
              onTap: onPick,
            )
          : _DocUploadedState(
              key: const ValueKey('uploaded'),
              label: label,
              filePath: filePath!,
              icon: icon,
              isLoading: isLoading,
              onReplace: isLoading ? () {} : onPick,
              onRemove: onRemove,
            ),
    );
  }
}

// ── Empty state with breathing pulse ─────────────────────────────────────────

class _DocEmptyState extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool hasError;
  final VoidCallback onTap;

  const _DocEmptyState({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.hasError,
    required this.onTap,
  });

  @override
  State<_DocEmptyState> createState() => _DocEmptyStateState();
}

class _DocEmptyStateState extends State<_DocEmptyState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _breathe;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _breathe = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _breathe, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _breathe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (_, child) {
          final iconAlpha = 0.08 + 0.10 * _pulse.value;
          final borderAlpha = 0.28 + 0.22 * _pulse.value;
          // Error keeps the breathing rhythm but in the error color and at a
          // stronger baseline, so the missing card is unmistakable.
          final borderColor = widget.hasError
              ? context.appColors.error
                  .withValues(alpha: 0.65 + 0.25 * _pulse.value)
              : cs.tertiary.withValues(alpha: borderAlpha);
          return KycDashedBorderBox(
            color: borderColor,
            borderRadius: 14.r,
            child: Container(
              height: 168.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: context.appColors.containerBackground,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.tertiary.withValues(alpha: iconAlpha),
                      border: Border.all(
                        color: cs.tertiary.withValues(alpha: borderAlpha * 0.55),
                        width: 1.w,
                      ),
                    ),
                    child: Icon(widget.icon, color: cs.tertiary, size: 22.sp),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    widget.label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: cs.onSurface,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    widget.hint,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10.sp,
                      color: cs.onSurface.withValues(alpha: 0.45),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: cs.tertiary.withValues(alpha: iconAlpha + 0.04),
                      borderRadius: BorderRadius.circular(99.r),
                      border: Border.all(
                        color: cs.tertiary.withValues(alpha: borderAlpha * 0.65),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: cs.tertiary,
                          size: 11.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'kyc.document.action.capture'.tr(),
                          style: TextStyle(
                            color: cs.tertiary,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Uploaded state ────────────────────────────────────────────────────────────

class _DocUploadedState extends StatefulWidget {
  final String label;
  final String filePath;
  final IconData icon;
  final bool isLoading;
  final VoidCallback onReplace;
  final VoidCallback onRemove;

  const _DocUploadedState({
    super.key,
    required this.label,
    required this.filePath,
    required this.icon,
    required this.onReplace,
    required this.onRemove,
    this.isLoading = false,
  });

  @override
  State<_DocUploadedState> createState() => _DocUploadedStateState();
}

class _DocUploadedStateState extends State<_DocUploadedState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _successCtrl;
  late final Animation<double> _borderGlow;

  @override
  void initState() {
    super.initState();
    _successCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _borderGlow = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _successCtrl, curve: Curves.easeOut),
    );
    _successCtrl.forward();
  }

  @override
  void dispose() {
    _successCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: widget.isLoading
          ? null
          : () => AppActionSheet.show(
                context,
                title: widget.label,
                items: [
                  AppActionSheetItem(
                    title: 'kyc.document.action.replace'.tr(),
                    subtitle: 'kyc.document.action.replaceSubtitle'.tr(),
                    icon: Icons.refresh_rounded,
                    onTap: widget.onReplace,
                  ),
                  AppActionSheetItem(
                    title: 'kyc.document.action.remove'.tr(),
                    subtitle: 'kyc.document.action.removeSubtitle'.tr(),
                    icon: Icons.delete_outline_rounded,
                    isDestructive: true,
                    onTap: widget.onRemove,
                  ),
                ],
              ),
      child: AnimatedBuilder(
        animation: _successCtrl,
        builder: (_, child) {
          final extraGlow = _borderGlow.value * 0.35;
          return Stack(
            children: [
              Container(
                height: 168.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.appColors.containerBackground,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: context.appColors.success
                        .withValues(alpha: 0.5 + extraGlow * 0.35),
                    width: (1 + extraGlow).w,
                  ),
                  boxShadow: extraGlow > 0.02
                      ? [
                          BoxShadow(
                            color: context.appColors.success
                                .withValues(alpha: extraGlow * 0.18),
                            blurRadius: extraGlow * 18,
                            spreadRadius: extraGlow * 2,
                          ),
                        ]
                      : null,
                ),
                child: child,
              ),
              if (widget.isLoading)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: ColoredBox(
                      color: cs.scrim.withValues(alpha: 0.45),
                      child: Center(
                        child: SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Row(
                children: [
                  Icon(widget.icon, color: context.appColors.success, size: 14.sp),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      widget.label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: context.appColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: context.appColors.onSuccess,
                      size: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    File(widget.filePath),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: context.appColors.glass.withValues(alpha: 0.06),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: context.appColors.glassBorder.withValues(alpha: 0.3),
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'kyc.document.action.tapToReplace'.tr(),
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: cs.onSurface.withValues(alpha: 0.35),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Icon(
                    Icons.touch_app_outlined,
                    color: context.appColors.glassBorder.withValues(alpha: 0.3),
                    size: 10.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}