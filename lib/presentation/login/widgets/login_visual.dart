import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/theme/app_theme_ext.dart';

/// Pure-code animated hero for the login screen (replaces the static SVG).
///
/// **"Anywhere, anytime in the world."** A slowly spinning wireframe globe with
/// glowing location nodes, and brand-yellow value-comets that arc up off the
/// surface from the pulsing "home" node out to the world — money leaving Oman
/// for everywhere, all the time.
///
/// The globe's structure (meridians, parallels, silhouette) is drawn in the
/// `glass` token — dark ink on the light theme, white on dark — so it reads
/// with equal contrast over the login page's own ambient orbs. `accent` (brand
/// yellow) is reserved for the home beacon and the flying transfers: the only
/// brand pop. Back-facing lines dim and front-facing geometry brightens, and
/// anything behind the sphere is simply not drawn, so the globe reads as solid
/// without a heavy fill. A single faint atmosphere glow grounds it.
///
/// One loop == one full rotation, and every periodic term (node pulses, comet
/// flights, atmosphere breath) completes a whole number of periods per loop, so
/// the cycle replays seamlessly. Entrance animation is owned by the page
/// (`_FadeSlide`); this widget only runs the ambient loop.
class LoginVisual extends HookWidget {
  const LoginVisual({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final loop = useAnimationController(duration: const Duration(seconds: 16));
    useEffect(() {
      loop.repeat();
      return null;
    }, const []);

    final appColors = context.appColors;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _GlobePainter(
          animation: loop,
          accent: appColors.brandFill,
          glass: appColors.glass,
        ),
      ),
    );
  }
}

/// One surface point (radians) — a "location" on the globe.
class _LatLon {
  const _LatLon(this.lat, this.lon);
  final double lat;
  final double lon;
}

class _GlobePainter extends CustomPainter {
  _GlobePainter({
    required this.animation,
    required this.accent,
    required this.glass,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color accent;
  final Color glass;

  /// North pole leans toward the viewer so parallels read as ellipses and the
  /// globe looks dimensional rather than head-on.
  static const double _tilt = 0.38;
  static final double _ct = math.cos(_tilt);
  static final double _st = math.sin(_tilt);

  /// Integer flights per loop per comet -> the wrap is seamless.
  static const int _cometTrips = 3;

  /// Height a transfer lifts off the surface, as a fraction of the radius.
  static const double _arcLift = 0.17;

  static double _deg(double d) => d * math.pi / 180;

  /// Surface nodes. Index 0 is "home" (Oman) — the brand beacon every transfer
  /// launches from. The rest are spread around the sphere so some are always
  /// rotating into and out of view.
  static final List<_LatLon> _nodes = [
    _LatLon(_deg(22), _deg(0)), // home
    _LatLon(_deg(6), _deg(52)),
    _LatLon(_deg(34), _deg(116)),
    _LatLon(_deg(-18), _deg(158)),
    _LatLon(_deg(46), _deg(-58)),
    _LatLon(_deg(-26), _deg(-20)),
    _LatLon(_deg(2), _deg(-116)),
  ];

  /// Transfers fly from home (0) out to these node indices.
  static const List<int> _arcTargets = [1, 4, 3, 5];

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final base = math.min(size.width, size.height);
    final c = Offset(size.width / 2, size.height * 0.5);
    final r = base * 0.33;
    final phi = 2 * math.pi * t;
    final cphi = math.cos(phi);
    final sphi = math.sin(phi);

    _paintAtmosphere(canvas, c, r, t);
    _paintWireframe(canvas, c, r, cphi, sphi);
    _paintSilhouette(canvas, c, r);
    _paintNodes(canvas, c, r, cphi, sphi, t);
    _paintArcs(canvas, c, r, cphi, sphi, t);
  }

  /// Unit sphere vector for a surface point, before spin/tilt.
  static (double, double, double) _vec(double lat, double lon) {
    final cl = math.cos(lat);
    return (cl * math.sin(lon), math.sin(lat), cl * math.cos(lon));
  }

  /// Spin a point about the vertical axis, tilt it toward the viewer, and drop
  /// it to the screen. [alt] lifts the point off the surface (for arcs).
  /// Returns the screen offset and a signed depth (>0 == front-facing).
  ({Offset p, double depth}) _project(
    double vx,
    double vy,
    double vz,
    double alt,
    Offset c,
    double r,
    double cphi,
    double sphi,
  ) {
    // Spin around the vertical (y) axis.
    final rx = vx * cphi + vz * sphi;
    final rz = -vx * sphi + vz * cphi;
    // Tilt around the horizontal (x) axis; x is unchanged.
    final ty = vy * _ct - rz * _st;
    final tz = vy * _st + rz * _ct;
    final rad = r * (1 + alt);
    return (p: Offset(c.dx + rad * rx, c.dy - rad * ty), depth: tz);
  }

  /// Great-circle interpolation between two unit vectors (spherical lerp).
  (double, double, double) _slerp(
    (double, double, double) a,
    (double, double, double) b,
    double s,
    double omega,
    double sinO,
  ) {
    final w1 = math.sin((1 - s) * omega) / sinO;
    final w2 = math.sin(s * omega) / sinO;
    return (
      a.$1 * w1 + b.$1 * w2,
      a.$2 * w1 + b.$2 * w2,
      a.$3 * w1 + b.$3 * w2,
    );
  }

  /// Soft radial accent glow behind the sphere — the "atmosphere". Kept faint
  /// and slow so it never becomes a blob over the page's own orbs.
  void _paintAtmosphere(Canvas canvas, Offset c, double r, double t) {
    final breath = 0.05 + 0.02 * math.sin(2 * math.pi * t);
    canvas.drawCircle(
      c,
      r * 1.35,
      Paint()
        ..shader = RadialGradient(
          colors: [
            accent.withValues(alpha: breath),
            accent.withValues(alpha: 0.0),
          ],
          stops: const [0.55, 1.0],
        ).createShader(Rect.fromCircle(center: c, radius: r * 1.35)),
    );
  }

  /// Meridians + parallels. Each segment lands in the bright front path or the
  /// dim back path by its midpoint depth, so the far side of the globe recedes.
  void _paintWireframe(
    Canvas canvas,
    Offset c,
    double r,
    double cphi,
    double sphi,
  ) {
    final front = Path();
    final back = Path();

    // Meridians: 8 half great-circles pole to pole, every 45° of longitude.
    for (int m = 0; m < 8; m++) {
      final lon = math.pi * m / 4;
      Offset? prev;
      double prevDepth = 0;
      const n = 30;
      for (int i = 0; i <= n; i++) {
        final lat = -math.pi / 2 + math.pi * i / n;
        final cl = math.cos(lat);
        final pr = _project(
          cl * math.sin(lon),
          math.sin(lat),
          cl * math.cos(lon),
          0,
          c,
          r,
          cphi,
          sphi,
        );
        if (prev != null) {
          final sel = (prevDepth + pr.depth) >= 0 ? front : back;
          sel
            ..moveTo(prev.dx, prev.dy)
            ..lineTo(pr.p.dx, pr.p.dy);
        }
        prev = pr.p;
        prevDepth = pr.depth;
      }
    }

    // Parallels: latitude rings.
    const lats = [-60.0, -30.0, 0.0, 30.0, 60.0];
    for (final ld in lats) {
      final lat = _deg(ld);
      final cl = math.cos(lat);
      final sl = math.sin(lat);
      Offset? prev;
      double prevDepth = 0;
      const n = 64;
      for (int i = 0; i <= n; i++) {
        final lon = 2 * math.pi * i / n;
        final pr = _project(
          cl * math.sin(lon),
          sl,
          cl * math.cos(lon),
          0,
          c,
          r,
          cphi,
          sphi,
        );
        if (prev != null) {
          final sel = (prevDepth + pr.depth) >= 0 ? front : back;
          sel
            ..moveTo(prev.dx, prev.dy)
            ..lineTo(pr.p.dx, pr.p.dy);
        }
        prev = pr.p;
        prevDepth = pr.depth;
      }
    }

    canvas.drawPath(
      back,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeCap = StrokeCap.round
        ..color = glass.withValues(alpha: 0.06),
    );
    canvas.drawPath(
      front,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..strokeCap = StrokeCap.round
        ..color = glass.withValues(alpha: 0.22),
    );
  }

  /// The globe's rim (always a circle under orthographic projection) plus a
  /// whisper-thin accent halo hugging it.
  void _paintSilhouette(Canvas canvas, Offset c, double r) {
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3
        ..color = glass.withValues(alpha: 0.28),
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.6
        ..color = accent.withValues(alpha: 0.10),
    );
  }

  /// Glowing location nodes. Only front-facing ones are drawn (the globe
  /// occludes the rest), fading as they near the rim. The home node gets a
  /// brand-yellow expanding beacon ring; the others are quiet glass dots.
  void _paintNodes(
    Canvas canvas,
    Offset c,
    double r,
    double cphi,
    double sphi,
    double t,
  ) {
    for (int i = 0; i < _nodes.length; i++) {
      final n = _nodes[i];
      final v = _vec(n.lat, n.lon);
      final pr = _project(v.$1, v.$2, v.$3, 0, c, r, cphi, sphi);
      if (pr.depth <= 0.02) continue; // behind the globe
      final edge = pr.depth.clamp(0.0, 1.0); // dim toward the rim
      final isHome = i == 0;
      final col = isHome ? accent : glass;
      final pulse =
          0.5 + 0.5 * math.sin(2 * math.pi * (t * 4 + i / _nodes.length));
      final dot = (isHome ? 3.0 : 2.0) + 0.8 * pulse;

      canvas.drawCircle(
        pr.p,
        dot * 2.6,
        Paint()..color = col.withValues(alpha: 0.10 * edge),
      );
      canvas.drawCircle(
        pr.p,
        dot,
        Paint()..color = col.withValues(alpha: (isHome ? 0.95 : 0.55) * edge),
      );

      if (isHome) {
        final ringR = dot + 4 + 7 * pulse;
        canvas.drawCircle(
          pr.p,
          ringR,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.2
            ..color = accent.withValues(alpha: 0.28 * (1 - pulse) * edge),
        );
      }
    }
  }

  /// The hero: brand-yellow value-comets arcing off the surface from home out
  /// to the world. Each route is drawn faintly; a bright comet with a fading
  /// trail flies along it, its brightness peaking mid-flight (so it "arrives"
  /// and fades — and the loop wraps without a pop). Segments behind the globe
  /// are dropped.
  void _paintArcs(
    Canvas canvas,
    Offset c,
    double r,
    double cphi,
    double sphi,
    double t,
  ) {
    final home = _nodes[0];
    final a = _vec(home.lat, home.lon);

    for (int k = 0; k < _arcTargets.length; k++) {
      final tgt = _nodes[_arcTargets[k]];
      final b = _vec(tgt.lat, tgt.lon);
      final dot = (a.$1 * b.$1 + a.$2 * b.$2 + a.$3 * b.$3).clamp(-1.0, 1.0);
      final omega = math.acos(dot);
      if (omega < 1e-3) continue;
      final sinO = math.sin(omega);

      // Route line.
      final route = Path();
      Offset? prev;
      double prevDepth = 0;
      const seg = 48;
      for (int i = 0; i <= seg; i++) {
        final s = i / seg;
        final pt = _slerp(a, b, s, omega, sinO);
        final alt = _arcLift * math.sin(math.pi * s);
        final pr = _project(pt.$1, pt.$2, pt.$3, alt, c, r, cphi, sphi);
        if (prev != null && (prevDepth > -0.05 || pr.depth > -0.05)) {
          route
            ..moveTo(prev.dx, prev.dy)
            ..lineTo(pr.p.dx, pr.p.dy);
        }
        prev = pr.p;
        prevDepth = pr.depth;
      }
      canvas.drawPath(
        route,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = accent.withValues(alpha: 0.14),
      );

      // Comet: head position + fading trail. `fade` zeroes at both ends of each
      // flight so the wrap is invisible.
      final head = (t * _cometTrips + k / _arcTargets.length) % 1.0;
      final fade = math.sin(math.pi * head);
      const trail = 7;
      for (int j = trail; j >= 0; j--) {
        final s = head - j * 0.035;
        if (s < 0 || s > 1) continue;
        final pt = _slerp(a, b, s, omega, sinO);
        final alt = _arcLift * math.sin(math.pi * s);
        final pr = _project(pt.$1, pt.$2, pt.$3, alt, c, r, cphi, sphi);
        if (pr.depth <= 0) continue; // behind the globe
        final lead = 1 - j / trail; // 1 at the head
        canvas.drawCircle(
          pr.p,
          0.8 + 2.2 * lead,
          Paint()..color = accent.withValues(alpha: 0.9 * lead * fade),
        );
      }

      // Soft glow around the head.
      final pt = _slerp(a, b, head, omega, sinO);
      final alt = _arcLift * math.sin(math.pi * head);
      final pr = _project(pt.$1, pt.$2, pt.$3, alt, c, r, cphi, sphi);
      if (pr.depth > 0) {
        canvas.drawCircle(
          pr.p,
          6,
          Paint()..color = accent.withValues(alpha: 0.28 * fade),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_GlobePainter oldDelegate) =>
      oldDelegate.accent != accent || oldDelegate.glass != glass;
}
