import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Full-screen camera/video overlay: renders on a black surface in both themes,
// so it deliberately uses the fixed brand palette instead of theme tokens.
import '../colors/app_colors.dart';

/// Friendly fallback shown when a camera page fails to initialise —
/// permission denied, no camera hardware, or driver error.
///
/// Pairs the localized [message] with a "Try Again" CTA so the user always
/// has a way forward. The retry handler should re-run the camera init,
/// which will re-trigger the permission flow (and pick up a fresh status if
/// the user just granted access from Settings).
class CameraInitErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CameraInitErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.no_photography_outlined,
                color: AppColors.brandYellow,
                size: 36.sp,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.88),
                fontSize: 14.sp,
                height: 1.45,
              ),
            ),
            SizedBox(height: 22.h),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.brandYellow,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'core.permission.tryAgain'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}