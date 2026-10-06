import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';

/// The brand logo: white CONNECT + brand-yellow NEC, which reads as-is on the
/// app's dark canvas. Never tinted, so the brand yellow is preserved exactly.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      width: width ?? 180.w,
      fit: BoxFit.contain,
    );
  }
}
