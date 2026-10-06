import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme_ext.dart';

class KycSecurityNote extends StatefulWidget {
  const KycSecurityNote({super.key});

  @override
  State<KycSecurityNote> createState() => _KycSecurityNoteState();
}

class _KycSecurityNoteState extends State<KycSecurityNote>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _iconScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.18)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 12.5,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.18, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 12.5,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 75,
      ),
    ]).animate(_ctrl);

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) _ctrl.repeat();
    });
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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.appColors.info.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.appColors.info.withValues(alpha: 0.25),
          width: 0.75.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: _iconScale,
            builder: (_, child) => Transform.scale(
              scale: _iconScale.value,
              child: child,
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              color: context.appColors.infoBright,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'kyc.security.note'.tr(),
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 11.sp,
                color: cs.onSurface.withValues(alpha: 0.6),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}