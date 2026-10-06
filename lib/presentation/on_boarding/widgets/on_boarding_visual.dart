import 'dart:math' as math;
import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/theme/app_theme_ext.dart';

/// Pure-code animated hero for the onboarding slides (replaces static SVGs).
///
/// Slide 0 — "Safe & Secure": a breathing shield with expanding radar
/// ripples, orbiting particles and a checkmark that draws itself in.
/// Slide 1 — "Fast Transfers": a paper plane flying a dashed arc from a
/// sender node to a receiver node, with departure/arrival pulses and
/// bobbing coins.
///
/// Everything is painted with theme tokens so both themes render correctly;
/// the transfer scene flips horizontally under RTL locales.
class OnBoardingVisual extends HookWidget {
  const OnBoardingVisual({
    super.key,
    required this.pageIndex,
    required this.entrance,
    required this.height,
  });

  final int pageIndex;
  final AnimationController entrance;
  final double height;

  @override
  Widget build(BuildContext context) {
    final loop = useAnimationController(duration: const Duration(seconds: 6));
    useEffect(() {
      loop.repeat();
      return null;
    }, const []);

    final colorScheme = context.colorScheme;
    final appColors = context.appColors;

    final fadeIn = CurvedAnimation(
      parent: entrance,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    final scaleIn = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: entrance,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final painter = pageIndex == 0
        ? _SecureShieldPainter(
            animation: loop,
            accent: colorScheme.tertiary,
            ink: colorScheme.onSurface,
            glass: appColors.glass,
          )
        : _FastTransferPainter(
            animation: loop,
            accent: colorScheme.tertiary,
            ink: colorScheme.onSurface,
            glass: appColors.glass,
            surface: colorScheme.secondaryContainer,
            success: appColors.success,
          );

    return FadeTransition(
      opacity: fadeIn,
      child: ScaleTransition(
        scale: scaleIn,
        child: SizedBox(
          height: height,
          width: double.infinity,
          // The transfer scene reads left→right; mirror it for RTL locales.
          child: Transform.flip(
            flipX: isRtl && pageIndex == 1,
            child: CustomPaint(painter: painter),
          ),
        ),
      ),
    );
  }
}

// ── Slide 0: Safe & Secure ─────────────────────────────────────────────────

class _SecureShieldPainter extends CustomPainter {
  _SecureShieldPainter({
    required this.animation,
    required this.accent,
    required this.ink,
    required this.glass,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color accent;
  final Color ink;
  final Color glass;

  static const _rippleCount = 3;

  // Orbiting particles: [phase, speed (loops per cycle), size factor].
  static const _orbiters = <List<double>>[
    [0.00, 1.0, 1.0],
    [0.22, -1.0, 0.7],
    [0.41, 1.0, 0.55],
    [0.58, -1.0, 0.85],
    [0.76, 1.0, 0.6],
    [0.90, -1.0, 0.75],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final center = Offset(size.width / 2, size.height * 0.5);
    final base = math.min(size.width, size.height);

    _paintGlow(canvas, center, base, t);
    _paintRipples(canvas, center, base, t);
    _paintOrbiters(canvas, center, base, t);
    _paintShield(canvas, center, base, t);
  }

  void _paintGlow(Canvas canvas, Offset center, double base, double t) {
    final pulse = 0.10 + 0.05 * math.sin(t * 2 * math.pi);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          accent.withValues(alpha: pulse),
          accent.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: base * 0.46));
    canvas.drawCircle(center, base * 0.46, paint);
  }

  void _paintRipples(Canvas canvas, Offset center, double base, double t) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (var i = 0; i < _rippleCount; i++) {
      final phase = (t + i / _rippleCount) % 1.0;
      final radius = _lerp(base * 0.28, base * 0.50, phase);
      paint.color = accent.withValues(alpha: (1 - phase) * 0.28);
      canvas.drawCircle(center, radius, paint);
    }
  }

  void _paintOrbiters(Canvas canvas, Offset center, double base, double t) {
    final paint = Paint();
    final rx = base * 0.42;
    final ry = base * 0.30;
    for (final o in _orbiters) {
      final angle = 2 * math.pi * (o[0] + t * o[1]);
      final pos = center +
          Offset(math.cos(angle) * rx, math.sin(angle) * ry);
      final radius = base * 0.014 * o[2];
      paint.color = o[1] > 0
          ? accent.withValues(alpha: 0.55)
          : glass.withValues(alpha: 0.30);
      canvas.drawCircle(pos, radius, paint);
    }
  }

  void _paintShield(Canvas canvas, Offset center, double base, double t) {
    // Gentle breathing.
    final breath = 1 + 0.02 * math.sin(t * 2 * math.pi);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(breath);
    canvas.translate(-center.dx, -center.dy);

    final rect = Rect.fromCenter(
      center: center,
      width: base * 0.44,
      height: base * 0.52,
    );
    final shield = _shieldPath(rect);

    canvas.drawPath(
      shield,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            glass.withValues(alpha: 0.16),
            glass.withValues(alpha: 0.05),
          ],
        ).createShader(rect),
    );
    canvas.drawPath(
      shield,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..color = accent,
    );

    _paintCheck(canvas, rect, t);
    canvas.restore();
  }

  void _paintCheck(Canvas canvas, Rect rect, double t) {
    // Draws in early in the loop, holds, then fades just before replaying.
    final draw = Curves.easeInOut
        .transform(((t - 0.08) / 0.30).clamp(0.0, 1.0));
    final fade =
        1 - Curves.easeIn.transform(((t - 0.90) / 0.10).clamp(0.0, 1.0));
    if (draw == 0 || fade == 0) return;

    final check = Path()
      ..moveTo(rect.left + rect.width * 0.30, rect.top + rect.height * 0.48)
      ..lineTo(rect.left + rect.width * 0.45, rect.top + rect.height * 0.62)
      ..lineTo(rect.left + rect.width * 0.72, rect.top + rect.height * 0.32);

    final metric = check.computeMetrics().first;
    canvas.drawPath(
      metric.extractPath(0, metric.length * draw),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = rect.width * 0.075
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = accent.withValues(alpha: fade),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  static Path _shieldPath(Rect r) {
    final w = r.width;
    final h = r.height;
    return Path()
      ..moveTo(r.left + w * 0.5, r.top)
      ..lineTo(r.right, r.top + h * 0.16)
      ..lineTo(r.right, r.top + h * 0.52)
      ..quadraticBezierTo(
          r.right, r.top + h * 0.80, r.left + w * 0.5, r.bottom)
      ..quadraticBezierTo(r.left, r.top + h * 0.80, r.left, r.top + h * 0.52)
      ..lineTo(r.left, r.top + h * 0.16)
      ..close();
  }

  @override
  bool shouldRepaint(_SecureShieldPainter oldDelegate) =>
      oldDelegate.accent != accent ||
      oldDelegate.ink != ink ||
      oldDelegate.glass != glass;
}

// ── Slide 1: Fast Transfers ────────────────────────────────────────────────

class _FastTransferPainter extends CustomPainter {
  _FastTransferPainter({
    required this.animation,
    required this.accent,
    required this.ink,
    required this.glass,
    required this.surface,
    required this.success,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color accent;
  final Color ink;
  final Color glass;
  final Color surface;
  final Color success;

  static const _dash = 10.0;
  static const _gap = 8.0;
  static const _flight = Interval(0.10, 0.70, curve: Curves.easeInOutCubic);

  // Bobbing coins: [x fraction, y fraction, bob phase, size factor].
  static const _coins = <List<double>>[
    [0.30, 0.78, 0.0, 1.0],
    [0.52, 0.30, 0.4, 0.7],
    [0.72, 0.72, 0.7, 0.85],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final w = size.width;
    final h = size.height;
    final base = math.min(w, h);

    final sender = Offset(w * 0.17, h * 0.64);
    final receiver = Offset(w * 0.83, h * 0.40);
    final nodeR = base * 0.125;

    final route = Path()
      ..moveTo(sender.dx, sender.dy)
      ..cubicTo(w * 0.30, h * 0.16, w * 0.68, h * 0.06,
          receiver.dx, receiver.dy);
    final metric = route.computeMetrics().first;

    _paintCoins(canvas, size, base, t);
    _paintDashes(canvas, metric, t);
    _paintPlane(canvas, metric, base, t);
    _paintPulse(canvas, sender, nodeR, t, const Interval(0.06, 0.30));
    _paintPulse(canvas, receiver, nodeR, t, const Interval(0.66, 0.92));
    _paintNode(canvas, sender, nodeR, _NodeGlyph.person);
    _paintNode(canvas, receiver, nodeR, _NodeGlyph.check);
  }

  void _paintDashes(Canvas canvas, PathMetric metric, double t) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..color = glass.withValues(alpha: 0.30);
    const cycle = _dash + _gap;
    // Offset drifts forward so the dashes appear to flow toward the receiver.
    var d = (t * cycle * 2) % cycle - cycle;
    while (d < metric.length) {
      final start = math.max(0.0, d);
      final end = math.min(metric.length, d + _dash);
      if (end > start) {
        canvas.drawPath(metric.extractPath(start, end), paint);
      }
      d += cycle;
    }
  }

  void _paintPlane(Canvas canvas, PathMetric metric, double base, double t) {
    final p = _flight.transform(t);
    // Fade in on departure, out shortly after arrival.
    final alpha = Curves.easeOut.transform(((t - 0.04) / 0.08).clamp(0, 1)) *
        (1 - Curves.easeIn.transform(((t - 0.72) / 0.12).clamp(0, 1)));
    if (alpha == 0) return;

    final offset = (metric.length * p).clamp(0.001, metric.length - 0.001);
    final tangent = metric.getTangentForOffset(offset);
    if (tangent == null) return;

    // Comet trail behind the plane.
    final trailStart = metric.length * math.max(0.0, p - 0.16);
    if (offset > trailStart) {
      canvas.drawPath(
        metric.extractPath(trailStart, offset),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..strokeCap = StrokeCap.round
          ..color = accent.withValues(alpha: 0.30 * alpha),
      );
    }

    final s = base * 0.05;
    canvas.save();
    canvas.translate(tangent.position.dx, tangent.position.dy);
    canvas.rotate(-tangent.angle);
    final plane = Path()
      ..moveTo(1.4 * s, 0)
      ..lineTo(-1.0 * s, -0.9 * s)
      ..lineTo(-0.5 * s, 0)
      ..lineTo(-1.0 * s, 0.9 * s)
      ..close();
    canvas.drawPath(plane, Paint()..color = accent.withValues(alpha: alpha));
    canvas.restore();
  }

  void _paintPulse(
    Canvas canvas,
    Offset center,
    double nodeR,
    double t,
    Interval window,
  ) {
    final q = window.transform(t);
    if (q <= 0 || q >= 1) return;
    canvas.drawCircle(
      center,
      nodeR * (1 + q * 1.1),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..color = accent.withValues(alpha: (1 - q) * 0.5),
    );
  }

  void _paintNode(Canvas canvas, Offset c, double r, _NodeGlyph glyph) {
    // Soft halo so the node lifts off the background in both themes.
    canvas.drawCircle(
      c,
      r * 1.35,
      Paint()
        ..shader = RadialGradient(
          colors: [
            accent.withValues(alpha: 0.14),
            accent.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: c, radius: r * 1.35)),
    );
    canvas.drawCircle(c, r, Paint()..color = surface);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..color = accent,
    );

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.16
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    switch (glyph) {
      case _NodeGlyph.person:
        stroke.color = ink;
        canvas.drawCircle(c + Offset(0, -r * 0.24), r * 0.24, stroke);
        canvas.drawArc(
          Rect.fromCircle(center: c + Offset(0, r * 0.52), radius: r * 0.42),
          math.pi,
          math.pi,
          false,
          stroke,
        );
      case _NodeGlyph.check:
        stroke.color = success;
        final check = Path()
          ..moveTo(c.dx - r * 0.32, c.dy + r * 0.02)
          ..lineTo(c.dx - r * 0.08, c.dy + r * 0.26)
          ..lineTo(c.dx + r * 0.36, c.dy - r * 0.22);
        canvas.drawPath(check, stroke);
    }
  }

  void _paintCoins(Canvas canvas, Size size, double base, double t) {
    for (final coin in _coins) {
      final bob = math.sin(2 * math.pi * (t + coin[2])) * base * 0.02;
      final c = Offset(size.width * coin[0], size.height * coin[1] + bob);
      final r = base * 0.045 * coin[3];
      canvas.drawCircle(
        c,
        r,
        Paint()..color = accent.withValues(alpha: 0.12),
      );
      canvas.drawCircle(
        c,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4
          ..color = accent.withValues(alpha: 0.55),
      );
      canvas.drawCircle(
        c,
        r * 0.55,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = accent.withValues(alpha: 0.35),
      );
    }
  }

  @override
  bool shouldRepaint(_FastTransferPainter oldDelegate) =>
      oldDelegate.accent != accent ||
      oldDelegate.ink != ink ||
      oldDelegate.glass != glass ||
      oldDelegate.surface != surface ||
      oldDelegate.success != success;
}

enum _NodeGlyph { person, check }