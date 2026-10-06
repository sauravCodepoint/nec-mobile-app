import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Decorative Oman-themed backdrop for the rate calculator. Fills the empty
/// space above and below the compact converter card with subtle, hand-drawn
/// silhouettes — a coastal scene (rising sun, dhows sailing, gulls, water) up
/// top and the Sultan Qaboos Grand Mosque skyline (dome, minarets, palms)
/// anchored to the bottom.
///
/// Pure vector art (no image assets), tinted from the active theme so it reads
/// softly on both the light and dark brand gradients. Non-interactive.
class RateCalculatorBackdrop extends StatelessWidget {
  const RateCalculatorBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // Silhouette ink: the on-surface colour at a whisper of alpha so the art
    // never competes with the card or the scaffold's diamond pattern.
    final ink = cs.onSurface;
    final accent = cs.tertiary;

    return IgnorePointer(
      child: Stack(
        children: [
          // ── Coastal sea scene spanning the upper region ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(double.infinity, 470.h),
              painter: _SeaScenePainter(ink: ink, accent: accent),
            ),
          ),
          // ── Muscat / Grand Mosque skyline along the bottom ──
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              size: Size(double.infinity, 210.h),
              painter: _SkylinePainter(ink: ink, accent: accent),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared: a traditional dhow with a lateen sail ────────────────────────────

void _drawDhow(
  Canvas c,
  double cx,
  double waterY,
  double s,
  Color ink,
  Color accent,
) {
  final fill = Paint()
    ..style = PaintingStyle.fill
    ..color = ink.withValues(alpha: 0.06);
  final line = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.2 * s
    ..strokeCap = StrokeCap.round
    ..color = ink.withValues(alpha: 0.07);

  final hullW = 130 * s;
  final left = cx - hullW / 2;
  final right = cx + hullW / 2;

  // Hull — a shallow crescent tapering up to a raised bow on the right.
  final hull = Path()
    ..moveTo(left, waterY)
    ..quadraticBezierTo(cx, waterY + 22 * s, right - 6 * s, waterY)
    ..quadraticBezierTo(right + 10 * s, waterY - 12 * s, right + 2 * s,
        waterY - 3 * s)
    ..quadraticBezierTo(cx, waterY + 6 * s, left, waterY)
    ..close();
  c.drawPath(hull, fill);

  // Mast.
  final mastX = cx - 4 * s;
  final mastTopY = waterY - 80 * s;
  c.drawLine(Offset(mastX, waterY - 4 * s), Offset(mastX, mastTopY), line);

  // Lateen (triangular) sail with a wind-curved foot.
  final sail = Path()
    ..moveTo(mastX, mastTopY + 6 * s)
    ..lineTo(mastX + 54 * s, waterY - 6 * s)
    ..quadraticBezierTo(mastX + 18 * s, waterY - 30 * s, mastX, waterY - 12 * s)
    ..close();
  c.drawPath(sail, fill);

  // Masthead pennant in the brand accent.
  final flag = Path()
    ..moveTo(mastX, mastTopY)
    ..lineTo(mastX + 14 * s, mastTopY + 5 * s)
    ..lineTo(mastX, mastTopY + 10 * s)
    ..close();
  c.drawPath(
    flag,
    Paint()
      ..style = PaintingStyle.fill
      ..color = accent.withValues(alpha: 0.14),
  );
}

// ── Coastal sea scene (sun, gulls, two dhows, water) ─────────────────────────

class _SeaScenePainter extends CustomPainter {
  final Color ink;
  final Color accent;

  _SeaScenePainter({required this.ink, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Rising sun with a soft halo ring, upper-right.
    final sun = Offset(w * 0.80, h * 0.20);
    canvas.drawCircle(
      sun,
      h * 0.085,
      Paint()..color = accent.withValues(alpha: 0.10),
    );
    canvas.drawCircle(
      sun,
      h * 0.12,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = accent.withValues(alpha: 0.06),
    );

    // A small flock of gulls.
    _gull(canvas, w * 0.18, h * 0.15, 11);
    _gull(canvas, w * 0.27, h * 0.115, 9);
    _gull(canvas, w * 0.235, h * 0.19, 8);

    // Two dhows — a nearer one to the left, a smaller, farther one to the right.
    final waterY = h * 0.46;
    _drawDhow(canvas, w * 0.33, waterY, 1.0, ink, accent);
    _drawDhow(canvas, w * 0.73, waterY - h * 0.04, 0.62, ink, accent);

    // Full-width water flowing down toward (and behind) the card.
    for (var i = 0; i < 7; i++) {
      final y = waterY + h * 0.055 + i * h * 0.05;
      _ripple(canvas, w, y, (7 - i) * 1.2, 0.06 - i * 0.007);
    }
  }

  void _gull(Canvas c, double x, double y, double s) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..color = ink.withValues(alpha: 0.10);
    final path = Path()
      ..moveTo(x - s, y)
      ..quadraticBezierTo(x - s * 0.4, y - s * 0.55, x, y)
      ..quadraticBezierTo(x + s * 0.4, y - s * 0.55, x + s, y);
    c.drawPath(path, paint);
  }

  void _ripple(Canvas c, double w, double y, double amp, double alpha) {
    final path = Path()..moveTo(0, y);
    const segments = 6;
    final seg = w / segments;
    for (var i = 0; i < segments; i++) {
      final cxp = seg * i + seg / 2;
      final ex = seg * (i + 1);
      final dir = i.isEven ? 1 : -1;
      path.quadraticBezierTo(cxp, y + amp * dir, ex, y);
    }
    c.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round
        ..color = ink.withValues(alpha: alpha.clamp(0.0, 1.0)),
    );
  }

  @override
  bool shouldRepaint(covariant _SeaScenePainter old) =>
      old.ink != ink || old.accent != accent;
}

// ── Grand Mosque skyline (dome, minarets, palms, low buildings) ──────────────

class _SkylinePainter extends CustomPainter {
  final Color ink;
  final Color accent;

  _SkylinePainter({required this.ink, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final base = size.height;

    final soft = Paint()
      ..style = PaintingStyle.fill
      ..color = ink.withValues(alpha: 0.05);
    final hero = Paint()
      ..style = PaintingStyle.fill
      ..color = ink.withValues(alpha: 0.08);

    // ── Low building clusters flanking the mosque ──
    _building(canvas, soft, w * 0.09, base, w * 0.07, base * 0.30);
    _building(canvas, soft, w * 0.17, base, w * 0.06, base * 0.42);
    _building(canvas, soft, w * 0.235, base, w * 0.05, base * 0.26);
    _building(canvas, soft, w * 0.74, base, w * 0.06, base * 0.38);
    _building(canvas, soft, w * 0.81, base, w * 0.07, base * 0.28);
    _building(canvas, soft, w * 0.885, base, w * 0.05, base * 0.44);

    // ── Palms at the far edges ──
    _palm(canvas, soft, w * 0.045, base, base * 0.52);
    _palm(canvas, soft, w * 0.955, base, base * 0.50);

    // ── Corner minarets ──
    _minaret(canvas, hero, w * 0.335, base, base * 0.86);
    _minaret(canvas, hero, w * 0.665, base, base * 0.86);

    // ── Central grand dome on its drum ──
    final domeCx = w * 0.5;
    final drumW = w * 0.24;
    final drumH = base * 0.20;
    final drum = RRect.fromRectAndCorners(
      Rect.fromLTWH(domeCx - drumW / 2, base - drumH, drumW, drumH),
      topLeft: Radius.circular(6.r),
      topRight: Radius.circular(6.r),
    );
    canvas.drawRRect(drum, hero);
    final dome = _onionDome(domeCx, base - drumH, drumW * 0.92, base * 0.36);
    canvas.drawPath(dome, hero);
    // Finial spike + crescent accent.
    final finialBaseY = base - drumH - base * 0.36;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(domeCx, finialBaseY - base * 0.03),
        width: 2.5.w,
        height: base * 0.06,
      ),
      hero,
    );
    canvas.drawCircle(
      Offset(domeCx, finialBaseY - base * 0.07),
      3.5.r,
      Paint()
        ..style = PaintingStyle.fill
        ..color = accent.withValues(alpha: 0.16),
    );

    // Ground line to seat the whole skyline.
    canvas.drawRect(
      Rect.fromLTWH(0, base - 1.2.h, w, 1.2.h),
      Paint()..color = ink.withValues(alpha: 0.06),
    );
  }

  void _building(
    Canvas c,
    Paint p,
    double x,
    double baseY,
    double bw,
    double bh,
  ) {
    c.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(x, baseY - bh, bw, bh),
        topLeft: Radius.circular(2.r),
        topRight: Radius.circular(2.r),
      ),
      p,
    );
  }

  /// A pointed onion/ogee dome centred on [cx], resting on [baseY].
  Path _onionDome(double cx, double baseY, double dw, double dh) {
    final left = cx - dw / 2;
    final right = cx + dw / 2;
    return Path()
      ..moveTo(left, baseY)
      ..cubicTo(
        left,
        baseY - dh * 0.52,
        cx - dw * 0.20,
        baseY - dh * 0.88,
        cx,
        baseY - dh,
      )
      ..cubicTo(
        cx + dw * 0.20,
        baseY - dh * 0.88,
        right,
        baseY - dh * 0.52,
        right,
        baseY,
      )
      ..close();
  }

  void _minaret(Canvas c, Paint p, double cx, double baseY, double mh) {
    final shaftW = mh * 0.085;
    final shaftH = mh * 0.74;
    c.drawRect(
      Rect.fromLTWH(cx - shaftW / 2, baseY - shaftH, shaftW, shaftH),
      p,
    );
    final balW = shaftW * 1.9;
    final balY = baseY - shaftH;
    c.drawRect(
      Rect.fromLTWH(cx - balW / 2, balY - mh * 0.035, balW, mh * 0.035),
      p,
    );
    final capBaseY = balY - mh * 0.035;
    c.drawRect(
      Rect.fromLTWH(
          cx - shaftW * 0.35, capBaseY - mh * 0.10, shaftW * 0.7, mh * 0.10),
      p,
    );
    final cap = _onionDome(cx, capBaseY - mh * 0.10, shaftW * 1.5, mh * 0.16);
    c.drawPath(cap, p);
    c.drawRect(
      Rect.fromCenter(
        center: Offset(cx, capBaseY - mh * 0.10 - mh * 0.16 - mh * 0.02),
        width: 2.w,
        height: mh * 0.05,
      ),
      p,
    );
  }

  void _palm(Canvas c, Paint p, double x, double baseY, double ph) {
    final trunkTopY = baseY - ph * 0.66;
    final trunk = Path()
      ..moveTo(x - ph * 0.018, baseY)
      ..quadraticBezierTo(x + ph * 0.03, baseY - ph * 0.4, x, trunkTopY)
      ..quadraticBezierTo(x - ph * 0.03, baseY - ph * 0.4, x + ph * 0.018, baseY)
      ..close();
    c.drawPath(trunk, p);

    const angles = [-1.25, -0.75, -0.28, 0.28, 0.75, 1.25];
    final frondLen = ph * 0.34;
    for (final a in angles) {
      final tipX = x + frondLen * math.sin(a);
      final tipY = trunkTopY - frondLen * math.cos(a).abs();
      final midX = x + frondLen * 0.5 * math.sin(a);
      final midY = trunkTopY - frondLen * 0.62;
      final frond = Path()
        ..moveTo(x, trunkTopY)
        ..quadraticBezierTo(midX, midY, tipX, tipY);
      c.drawPath(
        frond,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2
          ..strokeCap = StrokeCap.round
          ..color = p.color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SkylinePainter old) =>
      old.ink != ink || old.accent != accent;
}