import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme_ext.dart';

class KycSectionHeader extends StatefulWidget {
  final int step;
  final String title;
  final String subtitle;
  final bool isComplete;
  final bool isOptional;

  const KycSectionHeader({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
    required this.isComplete,
    this.isOptional = false,
  });

  @override
  State<KycSectionHeader> createState() => _KycSectionHeaderState();
}

class _KycSectionHeaderState extends State<KycSectionHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _checkScale;
  late final Animation<double> _glowFade;
  bool _wasComplete = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _checkScale = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.0, 0.7),
          ),
        );
    _glowFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
      ),
    );
    _wasComplete = widget.isComplete;
    if (_wasComplete) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(KycSectionHeader old) {
    super.didUpdateWidget(old);
    if (!_wasComplete && widget.isComplete) {
      _wasComplete = true;
      _ctrl.forward(from: 0.0);
    } else if (_wasComplete && !widget.isComplete) {
      _wasComplete = false;
      _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AnimatedBuilder(
      animation: _ctrl,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            width: 26.w,
            height: 26.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isComplete
                  ? context.appColors.success
                  : cs.tertiary.withValues(alpha: 0.15),
              border: widget.isComplete
                  ? null
                  : Border.all(
                      color: cs.tertiary.withValues(alpha: 0.45),
                      width: 1.w,
                    ),
            ),
            child: Center(
              child: widget.isComplete
                  ? ScaleTransition(
                      scale: _checkScale,
                      child: Icon(
                        Icons.check_rounded,
                        color: context.appColors.onSuccess,
                        size: 13.sp,
                      ),
                    )
                  : Text(
                      '${widget.step}',
                      style: TextStyle(
                        color: cs.tertiary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: widget.isComplete
                              ? context.appColors.success
                              : cs.onSurface,
                        ),
                        child: Text(widget.title),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    _RequirementChip(isOptional: widget.isOptional),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.subtitle,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 11.sp,
                    color: cs.onSurface.withValues(alpha: 0.55),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      builder: (context, child) {
        final isFlashing =
            widget.isComplete && _ctrl.isAnimating && _ctrl.value < 1.0;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: isFlashing
                ? context.appColors.success.withValues(alpha: _glowFade.value * 0.07)
                : Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: child,
        );
      },
    );
  }
}

// ── Required / Optional chip ─────────────────────────────────────────────────

class _RequirementChip extends StatelessWidget {
  final bool isOptional;

  const _RequirementChip({required this.isOptional});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final color = isOptional ? appColors.infoBright : appColors.warning;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99.r),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 0.8),
      ),
      child: Text(
        isOptional
            ? 'kyc.section.tag.optional'.tr()
            : 'kyc.section.tag.required'.tr(),
        style: TextStyle(
          color: color,
          fontSize: 8.5.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}