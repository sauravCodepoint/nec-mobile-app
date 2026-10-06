import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../global/app_global.dart';
import '../progress/app_progress_indicator.dart';
import '../theme/app_theme.dart';
import '../theme/app_theme_ext.dart';

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final void Function()? onTapOutside;
  final Color? backgroundColor;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;

  final bool isLoading;
  final String? loadingMessage;

  const AppScaffold({
    super.key,
    this.scaffoldKey,
    this.drawer,
    this.appBar,
    this.body,
    this.onTapOutside,
    this.backgroundColor,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.isLoading = false,
    this.loadingMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradient = theme.extension<AppGradient>()!.background;

    return _KeyboardPopScope(
      onTapOutside: onTapOutside,
      child: Stack(
        children: [
          Positioned.fill(
            child: _DecorBackdrop(
              gradient: gradient,
              accentColor: context.appColors.brandFill,
            ),
          ),
          SafeArea(
            top: false,
            // Guard the bottom inset on Android as before. On iOS guard it only
            // when a large inset is present — i.e. a bottom nav overlaps the body
            // (MainPage uses extendBody), not the ~34px home indicator on
            // ordinary full-screen routes — so tabbed pages keep their content
            // clear of the nav (no hidden tail, no scroll spring-back) while
            // every other screen stays edge-to-edge as designed. The gradient
            // (Positioned.fill above) still fills behind the nav, so the nav's
            // transparent overhang reveals it.
            bottom:
                Platform.isAndroid || MediaQuery.paddingOf(context).bottom > 48,
            child: Scaffold(
              key: scaffoldKey,
              drawer: drawer,
              backgroundColor: backgroundColor ?? Colors.transparent,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              appBar: appBar,
              bottomSheet: bottomSheet,
              body: Stack(
                children: [
                  body ?? const SizedBox(),
                  _LoadingOverlay(
                    isLoading: isLoading,
                    loadingMessage: loadingMessage,
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Reads `MediaQuery.viewInsetsOf` in its own subtree so the IME show/hide
/// rebuild stays scoped to [PopScope]+[GestureDetector] instead of cascading
/// through the gradient, wave painter and loading overlay above.
class _KeyboardPopScope extends StatelessWidget {
  final VoidCallback? onTapOutside;
  final Widget child;

  const _KeyboardPopScope({required this.child, this.onTapOutside});

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.viewInsetsOf(context).bottom > 0;
    return PopScope(
      canPop: !isKeyboardVisible,
      onPopInvokedWithResult: (didPop, _) {
        // Global dismiss, not FocusScope.of(context).unfocus(): the focused
        // node may live on a route buried in the stack (focus restored there
        // during a popAndPush/replace), where a scoped unfocus no-ops and the
        // back button would be permanently swallowed by canPop=false.
        if (!didPop && isKeyboardVisible) AppGlobal.dismissKeyboard();
      },
      child: GestureDetector(
        onTap: () {
          AppGlobal.dismissKeyboard();
          onTapOutside?.call();
        },
        behavior: HitTestBehavior.translucent,
        child: child,
      ),
    );
  }
}

/// Static gradient + signal-wave layer. Hoisted into its own widget so the
/// [CustomPainter] is allocated once per route and isolated behind a
/// [RepaintBoundary] — keyboard, loading and BLoC rebuilds above never
/// retrigger its paint pass.
///
/// Dark theme only: the app ships a single black/brand-yellow canvas, so this
/// layer carries no brightness branching — the alphas below are tuned for
/// brand yellow over near-black and would wash out on a light canvas.
class _DecorBackdrop extends StatelessWidget {
  final Gradient gradient;
  final Color accentColor;

  const _DecorBackdrop({required this.gradient, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
          // Primary focal glow, anchored on the wave origin just off the
          // top-left corner so the arcs appear to radiate out of the light.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.95, -1.0),
                radius: 1.05,
                colors: [
                  accentColor.withValues(alpha: 0.10),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Counterweight glow: keeps the opposite corner from reading as a
          // dead black void once the arcs have faded out down there.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.95, 0.9),
                radius: 0.9,
                colors: [
                  accentColor.withValues(alpha: 0.035),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          ClipRect(
            child: IgnorePointer(
              child: CustomPaint(painter: _SignalWavePainter(accentColor)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Modal loading overlay. The [BackdropFilter] is the most expensive widget
/// in this tree on low-end GPUs, so it lives behind a [RepaintBoundary] (its
/// blurred layer is cached as long as the source beneath it is stable) and
/// only rebuilds when [isLoading] flips — never on keyboard events.
class _LoadingOverlay extends HookWidget {
  final bool isLoading;
  final String? loadingMessage;
  final ColorScheme colorScheme;

  const _LoadingOverlay({
    required this.isLoading,
    required this.loadingMessage,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 250),
    );

    final fade = useMemoized(
      () => CurvedAnimation(parent: controller, curve: Curves.easeOut),
      [controller],
    );
    useEffect(() => fade.dispose, [fade]);

    final scaleCurve = useMemoized(
      () => CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
      [controller],
    );
    useEffect(() => scaleCurve.dispose, [scaleCurve]);

    final scale = useMemoized(
      () => Tween<double>(begin: 0.95, end: 1).animate(scaleCurve),
      [scaleCurve],
    );

    useEffect(() {
      if (isLoading) {
        controller.forward();
      } else {
        controller.reverse();
      }
      return null;
    }, [isLoading]);

    if (!isLoading) return const SizedBox.shrink();

    return Positioned.fill(
      child: FadeTransition(
        opacity: fade,
        child: RepaintBoundary(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: ColoredBox(
              color: colorScheme.scrim.withValues(alpha: 0.25),
              child: Center(
                child: ScaleTransition(
                  scale: scale,
                  child: _PremiumLoaderCard(
                    message: loadingMessage,
                    colorScheme: colorScheme,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Concentric brand-yellow arcs radiating from just outside the top-left
/// corner, with a few small "node" dots riding them — a transmission/ripple
/// motif that reads as value moving outward, and that stays quiet enough
/// behind dense form and list screens.
///
/// Everything is expressed as a fraction of the canvas so the motif scales
/// identically from a small phone to a tablet, and the whole thing is
/// stroke-only so it costs one path per ring.
class _SignalWavePainter extends CustomPainter {
  final Color color;

  const _SignalWavePainter(this.color);

  /// Radius (as a fraction of width), alpha and stroke width per ring. Alpha
  /// decays outward so the motif resolves into the canvas rather than ending
  /// on a hard line, and the widths alternate slightly so the rings don't
  /// read as a mechanical radar sweep.
  static const _rings = <(double, double, double)>[
    (0.34, 0.16, 1.5),
    (0.52, 0.13, 1.2),
    (0.72, 0.11, 1.5),
    (0.96, 0.08, 1.1),
    (1.24, 0.06, 1.4),
    (1.56, 0.045, 1.0),
    (1.92, 0.03, 1.2),
  ];

  /// Node dots: (ring index, angle in radians measured from the +x axis,
  /// dot radius as a fraction of width, alpha).
  static const _nodes = <(int, double, double, double)>[
    (1, 0.52, 0.0085, 0.26),
    (2, 1.18, 0.0064, 0.20),
    (3, 0.28, 0.0075, 0.16),
    (4, 0.92, 0.0059, 0.12),
  ];

  @override
  void paint(Canvas canvas, Size s) {
    final origin = Offset(s.width * -0.12, s.height * -0.04);

    for (final (scale, alpha, strokeWidth) in _rings) {
      canvas.drawCircle(
        origin,
        s.width * scale,
        Paint()
          ..color = color.withValues(alpha: alpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth,
      );
    }

    for (final (ringIndex, angle, dotRadius, alpha) in _nodes) {
      final ringRadius = s.width * _rings[ringIndex].$1;
      canvas.drawCircle(
        origin + Offset(cos(angle) * ringRadius, sin(angle) * ringRadius),
        s.width * dotRadius,
        Paint()..color = color.withValues(alpha: alpha),
      );
    }
  }

  @override
  bool shouldRepaint(_SignalWavePainter old) => old.color != color;
}

class _PremiumLoaderCard extends StatelessWidget {
  final String? message;
  final ColorScheme colorScheme;

  const _PremiumLoaderCard({this.message, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: context.appColors.containerBackground.withValues(alpha: 0.95),
        border: Border.all(
          color: context.appColors.glassBorder.withValues(alpha: 0.18),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: context.appColors.shadowInk.withValues(alpha: 0.14),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppProgressIndicator(size: AppIndicatorSize.large),
          if (message != null) ...[
            SizedBox(height: 12.h),
            Text(
              message!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
