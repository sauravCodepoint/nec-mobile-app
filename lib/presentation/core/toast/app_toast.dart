import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/core/di/injection.dart';
import '../../routes/app_routes.dart';
import '../theme/app_theme_ext.dart';

enum AppToastType { success, error, warning, info }

enum AppToastPosition { top, bottom }

class AppToastManager {
  AppToastManager._();

  static OverlayEntry? _activeEntry;
  static VoidCallback? _dismissActive;

  static void show(
    String message, {
    AppToastType type = AppToastType.success,
    AppToastPosition position = AppToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    final navigatorState = getIt<AppRouter>().navigatorKey.currentState;
    if (navigatorState == null) return;

    // Tear down the current toast through its own guarded remover, so its
    // pending auto-dismiss can't remove the same OverlayEntry a second time.
    _dismissActive?.call();

    late OverlayEntry entry;
    var removed = false;
    // Removing an OverlayEntry twice throws; this makes removal idempotent
    // whether it's triggered by the auto-dismiss, a tap, or a replacing toast.
    void safeRemove() {
      if (removed) return;
      removed = true;
      entry.remove();
      if (_activeEntry == entry) {
        _activeEntry = null;
        _dismissActive = null;
      }
    }

    entry = OverlayEntry(
      builder: (_) => _AppToastOverlay(
        message: message,
        type: type,
        position: position,
        duration: duration,
        onDismissed: safeRemove,
      ),
    );
    _activeEntry = entry;
    _dismissActive = safeRemove;
    navigatorState.overlay?.insert(entry);
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _AppToastOverlay extends StatefulWidget {
  final String message;
  final AppToastType type;
  final AppToastPosition position;
  final Duration duration;
  final VoidCallback onDismissed;

  const _AppToastOverlay({
    required this.message,
    required this.type,
    required this.position,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<_AppToastOverlay> createState() => _AppToastOverlayState();
}

class _AppToastOverlayState extends State<_AppToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _slide;

  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
      reverseDuration: const Duration(milliseconds: 260),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
      ),
    );

    _slide = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
    Future.delayed(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    if (_dismissed || !mounted) return;
    _dismissed = true;
    await _controller.reverse();
    // A replacing toast may have removed this entry during the reverse; don't
    // fire onDismissed if we're no longer mounted.
    if (!mounted) return;
    widget.onDismissed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTop = widget.position == AppToastPosition.top;
    final slideDir = isTop ? -1.0 : 1.0;
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.padding;
    // The toast lives in the navigator overlay, above every Scaffold, so the
    // keyboard would otherwise cover a bottom-anchored toast (form screens
    // such as add/edit beneficiary show validation errors while the keyboard
    // is open). Lift it above whichever is taller: the keyboard or the safe
    // area inset.
    final keyboardInset = mediaQuery.viewInsets.bottom;
    final bottomInset = math.max(padding.bottom, keyboardInset);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      top: isTop ? padding.top + 12.h : null,
      bottom: !isTop ? bottomInset + 12.h : null,
      left: 16.w,
      right: 16.w,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, slideDir * 56.h * _slide.value),
          child: Opacity(opacity: _opacity.value, child: child),
        ),
        child: _ToastCard(
          message: widget.message,
          type: widget.type,
          onDismiss: _dismiss,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ToastCard extends StatelessWidget {
  final String message;
  final AppToastType type;
  final VoidCallback onDismiss;

  const _ToastCard({
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    final (color, background, icon) = switch (type) {
      AppToastType.success => (
        appColors.success,
        appColors.successSubtle,
        Icons.check_circle_outline_rounded,
      ),
      AppToastType.error => (
        appColors.error,
        appColors.errorSubtle,
        Icons.error_outline_rounded,
      ),
      AppToastType.warning => (
        appColors.warning,
        appColors.warningSubtle,
        Icons.warning_amber_rounded,
      ),
      AppToastType.info => (
        appColors.info,
        appColors.infoSubtle,
        Icons.info_outline_rounded,
      ),
    };

    return Material(
      color: Colors.transparent,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
          boxShadow: [
            BoxShadow(
              color: context.appColors.shadowInk.withValues(alpha: 0.22,),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: color.withValues(alpha: 0.32),
              blurRadius: 18,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Solid colored accent bar for instant visual recognition.
              Container(width: 5.w, color: color),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.22),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: color.withValues(alpha: 0.45),
                            width: 1,
                          ),
                        ),
                        child: Icon(icon, color: color, size: 20.w),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          message,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.35,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: onDismiss,
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Icon(
                            Icons.close_rounded,
                            size: 18.w,
                            color: appColors.muted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
