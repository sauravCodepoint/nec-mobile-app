import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routes/app_routes.gr.dart';
import '../theme/app_theme_ext.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Color? backgroundColor;
  final Color? bottomBorderColor;
  final Color? titleColor;
  final Color? foregroundColor;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final double? toolbarHeight;

  /// Appends a support-agent icon to [actions] that opens the Support page.
  /// Disable on the Support page itself (it would link to itself).
  final bool showSupport;

  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.backgroundColor,
    this.bottomBorderColor,
    this.titleColor,
    this.foregroundColor,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.toolbarHeight,
    this.showSupport = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appBarTheme = theme.appBarTheme;

    // Screens with no actions of their own surface a support entry point by
    // default. A screen that passes its own [actions] keeps only those; the
    // Support page can also opt out explicitly via [showSupport].
    final hasCustomActions = actions != null && actions!.isNotEmpty;
    final List<Widget>? resolvedActions = hasCustomActions
        ? actions
        : (showSupport
              ? [
                  const _SupportAction(),
                  SizedBox(width: 12.w),
                ]
              : null);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
      color: backgroundColor ?? Colors.transparent,
      child: AppBar(
        centerTitle: centerTitle,
        forceMaterialTransparency: true,
        toolbarHeight: toolbarHeight,
        leadingWidth: 68.w,
        leading: leading,
        title:
            titleWidget ??
            Text(
              title ?? '',
              maxLines: 1,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
        actions: resolvedActions,
        titleSpacing: 0,
        foregroundColor: foregroundColor ?? colorScheme.onSurface,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: appBarTheme.iconTheme,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: bottomBorderColor ?? context.appColors.glassBorder.withValues(alpha: 0.18),
            height: 0.5,
          ),
        ),
      ),
    );
  }
}

/// Default app-bar support affordance: a circular glass button with an
/// accent-tinted support-agent glyph that opens the Support page. Mirrors the
/// home action-button feel (press-scale + haptics) so it sits consistently
/// alongside other app-bar actions.
class _SupportAction extends HookWidget {
  const _SupportAction();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final appColors = context.appColors;

    final pressCtrl = useAnimationController(
      duration: const Duration(milliseconds: 60),
      reverseDuration: const Duration(milliseconds: 200),
    );
    final pressScale = useAnimation(
      Tween<double>(begin: 1.0, end: 0.86).animate(
        CurvedAnimation(parent: pressCtrl, curve: Curves.easeOut),
      ),
    );
    final p = pressCtrl.value;

    return Tooltip(
      message: 'support.title'.tr(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) {
          pressCtrl.forward();
          HapticFeedback.lightImpact();
        },
        onTapUp: (_) {
          pressCtrl.reverse();
          context.router.push(const SupportRoute());
        },
        onTapCancel: () => pressCtrl.reverse(),
        child: Transform.scale(
          scale: pressScale,
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.lerp(
                appColors.glass.withValues(alpha: 0.08),
                appColors.glass.withValues(alpha: 0.18),
                p,
              ),
              border: Border.all(
                color: Color.lerp(
                  appColors.brandFill.withValues(alpha: 0.26),
                  appColors.brandFill.withValues(alpha: 0.50),
                  p,
                )!,
                width: 0.8,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.support_agent_rounded,
                size: 21.sp,
                color: cs.tertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
