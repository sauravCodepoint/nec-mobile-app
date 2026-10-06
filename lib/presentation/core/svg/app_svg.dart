import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme_ext.dart';

class AppSvg extends StatelessWidget {
  final String asset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final String? semanticsLabel;
  final double borderRadius;

  final bool showOutline;
  final double strokeWidth;

  const AppSvg({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.semanticsLabel,
    this.borderRadius = 3.0,
    this.showOutline = false,
    this.strokeWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: showOutline
            ? Border.all(color: context.appColors.glassBorder.withValues(alpha: 0.18), width: strokeWidth.w)
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SvgPicture.asset(
          asset,
          width: width,
          height: height,
          fit: fit,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
          semanticsLabel: semanticsLabel,
          placeholderBuilder: (context) =>
              CircularProgressIndicator(color: cs.primary),
          errorBuilder: (context, error, _) =>
              _FlagFallback(width: width, height: height),
        ),
      ),
    );
  }
}

class _FlagFallback extends StatelessWidget {
  final double? width;
  final double? height;

  const _FlagFallback({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.appColors.glass.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Icon(
        Icons.flag_outlined,
        size: (width ?? 24) * 0.6,
        color: context.appColors.glassBorder.withValues(alpha: 0.3),
      ),
    );
  }
}
