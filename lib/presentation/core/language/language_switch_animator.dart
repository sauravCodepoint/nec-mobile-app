import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Wraps the app content and plays a "re-typeset" dissolve when the locale
/// changes: the current frame is captured as an image and frozen on top, the
/// new locale is applied underneath (and given a frame to paint), then the old
/// frame drifts slightly forward while defocusing and fading away — as if the
/// interface falls out of focus in one language and resolves in the other.
///
/// Deliberately a blur-dissolve rather than a reveal wipe, and
/// direction-agnostic so it reads the same across an LTR↔RTL (en↔ar) flip,
/// where a directional wipe would fight the mirrored layout.
///
/// The defocus is a crossfade between a sharp and a constant-sigma blurred
/// copy of the snapshot, so the blur is rasterized once and every animation
/// frame only updates layer opacities — no per-frame re-filtering to stutter.
///
/// There is exactly one instance (installed in `app_widget.dart`); its static
/// [_instanceKey] keeps the element (and hook state) alive across the
/// MaterialApp rebuild the locale change itself triggers, and the mounted
/// instance installs the [dissolve] trigger. Capturing must happen BEFORE the
/// locale is dispatched, so [dissolve] snapshots synchronously and only then
/// runs (and awaits) [applyLocale].
class LanguageSwitchAnimator extends HookWidget {
  final Widget child;

  static final GlobalKey _instanceKey = GlobalKey();

  /// Installed by the mounted instance; null until it is in the tree.
  static Future<void> Function(Future<void> Function() applyLocale)? _run;

  static final ui.ImageFilter _blurFilter = ui.ImageFilter.blur(
    sigmaX: _blurSigma,
    sigmaY: _blurSigma,
    // Decal lets the blurred edges thin out instead of smearing; the slight
    // scale-up hides them.
    tileMode: TileMode.decal,
  );

  static const double _blurSigma = 10.0;
  static const double _maxScale = 1.05;

  LanguageSwitchAnimator({required this.child}) : super(key: _instanceKey);

  /// Freezes the current frame, runs [applyLocale] (awaiting the translation
  /// load so the re-typeset UI exists beneath the frozen frame), then
  /// dissolves the old frame away. Falls back to applying the locale instantly
  /// if the animator isn't mounted yet.
  static Future<void> dissolve({
    required Future<void> Function() applyLocale,
  }) {
    final run = _run;
    if (run == null) return applyLocale();
    return run(applyLocale);
  }

  @override
  Widget build(BuildContext context) {
    final boundaryKey = useMemoized(GlobalKey.new);
    final snapshot = useState<ui.Image?>(null);
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );
    final progress = useMemoized(
      // Ease-in-out: a gentle ramp on both ends so the frozen frame drifts
      // out of focus and settles instead of snapping away.
      () => CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic),
      [controller],
    );

    useEffect(() {
      Future<void> run(Future<void> Function() applyLocale) async {
        final boundary =
            boundaryKey.currentContext?.findRenderObject()
                as RenderRepaintBoundary?;
        // Already mid-dissolve, or nothing to snapshot: apply instantly so
        // the locale change is never lost, just without a (second) animation.
        if (controller.isAnimating || boundary == null || !context.mounted) {
          await applyLocale();
          return;
        }

        // Synchronous grab of the current (old-language) frame, at device
        // resolution so the frozen overlay stays crisp.
        final dpr = MediaQuery.devicePixelRatioOf(context);
        final image = boundary.toImageSync(pixelRatio: dpr);
        // A previous dissolve leaves the controller at 1.0, where both overlay
        // copies render fully transparent — the frames painted during the
        // awaits below would show the raw locale swap, then the old-language
        // frame would pop back once forward() rewinds. Reset BEFORE the
        // overlay first paints so the frozen frame starts opaque.
        controller.reset();
        snapshot.value = image;

        try {
          // Apply only AFTER the snapshot exists, then let the re-typeset
          // frame paint beneath the frozen overlay before it dissolves.
          await applyLocale();
          await WidgetsBinding.instance.endOfFrame;
          if (context.mounted) {
            await controller.forward();
          }
        } finally {
          snapshot.value = null;
          // Dispose only after the frame that removed the RawImages painted.
          WidgetsBinding.instance.addPostFrameCallback((_) => image.dispose());
        }
      }

      _run = run;
      return () {
        if (_run == run) _run = null;
      };
    }, const []);

    final snap = snapshot.value;

    return Stack(
      children: [
        RepaintBoundary(key: boundaryKey, child: child),
        if (snap != null)
          Positioned.fill(
            // Block input for the brief dissolve so a stray tap can't hit the
            // half-revealed new language mid-animation.
            child: AbsorbPointer(
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: _maxScale).animate(progress),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Blurred copy: constant sigma inside its own repaint
                    // boundary, so it rasterizes once and only fades.
                    FadeTransition(
                      opacity: ReverseAnimation(progress),
                      child: RepaintBoundary(
                        child: ImageFiltered(
                          imageFilter: _blurFilter,
                          child: RawImage(image: snap, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    // Sharp copy on top fades out over the first half,
                    // handing off to the blurred copy — perceived as a
                    // progressive defocus.
                    FadeTransition(
                      opacity: ReverseAnimation(
                        CurvedAnimation(
                          parent: progress,
                          curve: const Interval(0.0, 0.5),
                        ),
                      ),
                      child: RawImage(image: snap, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}