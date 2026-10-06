import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/member_approval/member_approval_bloc.dart';
import '../core/button/app_button.dart';
import '../core/notify/app_notify.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/theme/app_theme_ext.dart';
import '../routes/app_routes.gr.dart';

/// Shown after a successful registration while the member's account is being
/// reviewed/approved by the back office. Waiting-state screen: the review
/// state is presented statically (Submitted → Under Review → Activated) while
/// [MemberApprovalBloc] polls the approval status in the background — only
/// while this screen is visible and the app foregrounded. On approval the
/// user is sent back to Login with a success toast; every poll failure is
/// silent ("still pending"), so the only manual action is "Back to Login".
@RoutePage()
class MemberApprovalPage extends HookWidget {
  const MemberApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Single entrance timeline drives every section's staggered fade + slide.
    final entrance = useAnimationController(
      duration: const Duration(milliseconds: 1400),
    );
    useEffect(() {
      entrance.forward();
      return null;
    }, const []);

    final bloc = context.read<MemberApprovalBloc>();
    // The bloc is app-scoped, so a previous visit's terminal state (e.g. a
    // rejection before "Register Again" → re-registration) would otherwise
    // survive into this mount, resurrect the old rejected screen and block
    // polling. Reset FIRST — declared before the lifecycle effect so the
    // reset event is processed before pollingStarted.
    useEffect(() {
      bloc.add(const MemberApprovalEvent.screenOpened());
      return null;
    }, const []);

    // Poll only while this screen can actually show the result: start on
    // mount and on every foreground resume, stop on background and dispose.
    final lifecycle = useAppLifecycleState();
    useEffect(() {
      if (lifecycle == null || lifecycle == AppLifecycleState.resumed) {
        bloc.add(const MemberApprovalEvent.pollingStarted());
      } else {
        bloc.add(const MemberApprovalEvent.pollingStopped());
      }
      return null;
    }, [lifecycle]);
    useEffect(
          () =>
          () => bloc.add(const MemberApprovalEvent.pollingStopped()),
      const [],
    );

    return BlocConsumer<MemberApprovalBloc, MemberApprovalState>(
      // Failures stay silent by design (they only mean "still pending");
      // approval is the single one-shot reaction. Rejection is rendered by
      // the builder (the screen morphs into its rejected variant).
      listenWhen: (p, c) => p.isApproved != c.isApproved,
      listener: (context, state) {
        if (state.isApproved) {
          // The repository has already installed the session (and cleared
          // the approval marker), so login would be redundant — continue
          // straight into MPIN setup, matching what a cold start would do.
          AppNotify.toast(
            'memberApproval.toast.approved'.tr(),
            type: AppToastType.success,
          );
          context.router.replaceAll([const SetMpinRoute()]);
        }
      },
      buildWhen: (p, c) =>
      p.isRejected != c.isRejected ||
          p.rejectionReason != c.rejectionReason,
      builder: (context, state) {
        final rejected = state.isRejected;
        return AppScaffold(
          body: SafeArea(
            child: Stack(
              children: [
                const Positioned.fill(
                  child: RepaintBoundary(child: _AmbientBackground()),
                ),
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 12.h),
                            _Reveal(
                              parent: entrance,
                              interval: const Interval(0.0, 0.5),
                              child: Center(
                                child: RepaintBoundary(
                                  child: _ApprovalMedallion(rejected: rejected),
                                ),
                              ),
                            ),
                            SizedBox(height: 28.h),
                            _Reveal(
                              parent: entrance,
                              interval: const Interval(0.12, 0.6),
                              child: _StatusPill(rejected: rejected),
                            ),
                            SizedBox(height: 18.h),
                            _Reveal(
                              parent: entrance,
                              interval: const Interval(0.2, 0.68),
                              child: _Headline(rejected: rejected),
                            ),
                            SizedBox(height: 28.h),
                            _Reveal(
                              parent: entrance,
                              interval: const Interval(0.3, 0.82),
                              child: _ReviewTimeline(rejected: rejected),
                            ),
                            SizedBox(height: 20.h),
                            _Reveal(
                              parent: entrance,
                              interval: const Interval(0.42, 0.94),
                              child: rejected
                                  ? _RejectionCard(
                                reason: state.rejectionReason,
                              )
                                  : const _NextStepsCard(),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ),
                    _Reveal(
                      parent: entrance,
                      interval: const Interval(0.55, 1.0),
                      slideBegin: const Offset(0, 0.14),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 16.h),
                        child: AppButton(
                          // Same destination either way — Login is where the
                          // re-registration flow starts — but the label must
                          // match the user's next step.
                          text: rejected
                              ? 'memberApproval.rejected.registerAgain'.tr()
                              : 'memberApproval.backToLogin'.tr(),
                          onTap: () =>
                              context.router.replaceAll([const LoginRoute()]),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Staggered entrance reveal — fade + upward slide driven by a shared timeline.
// ─────────────────────────────────────────────────────────────────────────────

class _Reveal extends StatelessWidget {
  final AnimationController parent;
  final Interval interval;
  final Offset slideBegin;
  final Widget child;

  const _Reveal({
    required this.parent,
    required this.interval,
    this.slideBegin = const Offset(0, 0.08),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final drive = CurvedAnimation(
      parent: parent,
      curve: Interval(interval.begin, interval.end, curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: drive,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: slideBegin,
          end: Offset.zero,
        ).animate(drive),
        child: child,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Ambient background — slow-drifting radial orbs for depth.
// ─────────────────────────────────────────────────────────────────────────────

class _AmbientBackground extends HookWidget {
  const _AmbientBackground();

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final appColors = context.appColors;

    final ctrl = useAnimationController(duration: const Duration(seconds: 9))
      ..repeat(reverse: true);
    final t = useAnimation(
      CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
    );

    return Stack(
      children: [
        Positioned(
          top: -60 + t * 34,
          right: -80 + t * 12,
          child: _Orb(
            size: 240.w,
            color: appColors.statusPending.withValues(alpha: 0.08),
          ),
        ),
        Positioned(
          bottom: 40 - t * 46,
          left: -90 + t * 18,
          child: _Orb(size: 280.w, color: cs.tertiary.withValues(alpha: 0.05)),
        ),
        Positioned(
          top: 300.h + t * 24,
          left: 20.w + t * 10,
          child: _Orb(
            size: 90.w,
            color: appColors.success.withValues(alpha: 0.05),
          ),
        ),
      ],
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;

  const _Orb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Hero medallion — gently bobbing badge with radiating sonar rings, a rotating
// comet "processing" ring and an orbiting spark around a breathing centre icon.
// ─────────────────────────────────────────────────────────────────────────────

class _ApprovalMedallion extends HookWidget {
  final bool rejected;

  const _ApprovalMedallion({this.rejected = false});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final cs = context.colorScheme;
    // Orange "awaiting action" while pending; error tint once rejected.
    final tint = rejected ? appColors.error : appColors.statusPending;

    final sonar = useAnimationController(
      duration: const Duration(milliseconds: 2600),
    )..repeat();
    final spin = useAnimationController(
      duration: const Duration(milliseconds: 3400),
    )..repeat();
    final pulse = useAnimationController(
      duration: const Duration(milliseconds: 1700),
    )..repeat(reverse: true);
    final bob = useAnimationController(
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);

    const dim = 168.0;

    return SizedBox(
      width: dim.w,
      height: dim.w,
      child: AnimatedBuilder(
        animation: Listenable.merge([sonar, spin, pulse, bob]),
        builder: (context, _) {
          final bobT = Curves.easeInOut.transform(bob.value);
          final pulseT = Curves.easeInOut.transform(pulse.value);

          return Transform.translate(
            offset: Offset(0, -5 + bobT * 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // The motion vocabulary says "in progress", so everything
                // that radiates or orbits disappears once rejected — only
                // the breathing centre stays, in the error tint.
                if (!rejected) ...[
                  // Radiating sonar rings (staggered).
                  for (final phase in const [0.0, 0.5])
                    _sonarRing((sonar.value + phase) % 1.0, dim.w, tint),

                  // Rotating comet "processing" ring.
                  Transform.rotate(
                    angle: spin.value * 2 * math.pi,
                    child: CustomPaint(
                      size: Size(126.w, 126.w),
                      painter: _CometRingPainter(
                        color: tint,
                        strokeWidth: 3.2.w,
                      ),
                    ),
                  ),

                  // Orbiting spark, trailing the comet head.
                  Transform.rotate(
                    angle: spin.value * 2 * math.pi,
                    child: SizedBox(
                      width: 126.w,
                      height: 126.w,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: _Spark(color: tint, size: 8.w),
                      ),
                    ),
                  ),
                ],

                // Breathing centre medallion.
                Transform.scale(
                  scale: 0.94 + pulseT * 0.06,
                  child: Container(
                    width: 92.w,
                    height: 92.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          appColors.containerBackground,
                          Color.alphaBlend(
                            tint.withValues(alpha: 0.10),
                            appColors.containerBackground,
                          ),
                        ],
                      ),
                      border: Border.all(
                        color: tint.withValues(alpha: 0.35),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: tint.withValues(alpha: 0.12 + pulseT * 0.22),
                          blurRadius: 26,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Icon(
                      rejected
                          ? Icons.gpp_bad_rounded
                          : Icons.verified_user_rounded,
                      size: 40.sp,
                      color: Color.lerp(tint, cs.onSurface, 0.12),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sonarRing(double t, double maxSize, Color color) {
    final scale = 0.56 + t * 0.44;
    final opacity = (1.0 - t).clamp(0.0, 1.0) * 0.5;
    return Container(
      width: maxSize * scale,
      height: maxSize * scale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: opacity), width: 1.2),
      ),
    );
  }
}

class _Spark extends StatelessWidget {
  final Color color;
  final double size;

  const _Spark({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.7),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

/// Strokes an arc with a fading sweep gradient so it reads as a rotating comet.
class _CometRingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CometRingPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..shader = SweepGradient(
        colors: [color.withValues(alpha: 0), color],
        stops: const [0.0, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: rect.center, radius: radius),
      -math.pi / 2,
      math.pi * 1.55,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CometRingPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}

// ─────────────────────────────────────────────────────────────────────────────
// Status pill — "Awaiting Approval" with a breathing dot and shimmer sweep.
// ─────────────────────────────────────────────────────────────────────────────

class _StatusPill extends HookWidget {
  final bool rejected;

  const _StatusPill({this.rejected = false});

  @override
  Widget build(BuildContext context) {
    final tint = rejected
        ? context.appColors.error
        : context.appColors.statusPending;

    final ctrl = useAnimationController(
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    final t = useAnimation(
      CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
    );

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: tint.withValues(alpha: 0.30), width: 0.8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tint,
                boxShadow: [
                  BoxShadow(
                    color: tint.withValues(alpha: 0.3 + t * 0.5),
                    blurRadius: 6 + t * 4,
                    spreadRadius: t * 1.5,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              (rejected
                  ? 'memberApproval.rejected.statusPill'.tr()
                  : 'memberApproval.statusPill'.tr())
                  .toUpperCase(),
              style: context.textTheme.labelSmall?.copyWith(
                color: tint,
                fontWeight: FontWeight.w700,
                fontSize: 10.sp,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Headline + supporting copy.
// ─────────────────────────────────────────────────────────────────────────────

class _Headline extends StatelessWidget {
  final bool rejected;

  const _Headline({this.rejected = false});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return Column(
      children: [
        Text(
          rejected
              ? 'memberApproval.rejected.title'.tr()
              : 'memberApproval.title'.tr(),
          textAlign: TextAlign.center,
          style: context.textTheme.titleLarge?.copyWith(
            color: cs.onSurface,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            rejected
                ? 'memberApproval.rejected.subtitle'.tr()
                : 'memberApproval.subtitle'.tr(),
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.appColors.muted,
              height: 1.5,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Review timeline — Submitted (done) → Under Review (active) → Activated.
// ─────────────────────────────────────────────────────────────────────────────

enum _StepState { done, active, pending, rejected }

class _ReviewTimeline extends StatelessWidget {
  final bool rejected;

  const _ReviewTimeline({this.rejected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      decoration: context.glassPanel(borderRadius: BorderRadius.circular(18.r)),
      child: Column(
        children: [
          _TimelineStep(
            state: _StepState.done,
            title: 'memberApproval.timeline.submitted'.tr(),
            hint: 'memberApproval.timeline.submittedHint'.tr(),
            showConnector: true,
          ),
          _TimelineStep(
            // Once rejected the review itself is over — the step completes
            // and the terminal step below carries the outcome.
            state: rejected ? _StepState.done : _StepState.active,
            title: 'memberApproval.timeline.review'.tr(),
            hint: 'memberApproval.timeline.reviewHint'.tr(),
            showConnector: true,
          ),
          if (rejected)
            _TimelineStep(
              state: _StepState.rejected,
              title: 'memberApproval.rejected.timeline.step'.tr(),
              hint: 'memberApproval.rejected.timeline.stepHint'.tr(),
              showConnector: false,
            )
          else
            _TimelineStep(
              state: _StepState.pending,
              title: 'memberApproval.timeline.approved'.tr(),
              hint: 'memberApproval.timeline.approvedHint'.tr(),
              showConnector: false,
            ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final _StepState state;
  final String title;
  final String hint;
  final bool showConnector;

  const _TimelineStep({
    required this.state,
    required this.title,
    required this.hint,
    required this.showConnector,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final appColors = context.appColors;

    final Color accent = switch (state) {
      _StepState.done => appColors.success,
      _StepState.active => appColors.statusPending,
      _StepState.pending => appColors.muted,
      _StepState.rejected => appColors.error,
    };
    final bool isPending = state == _StepState.pending;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _TimelineNode(state: state, accent: accent),
              if (showConnector)
                Expanded(
                  child: Container(
                    width: 2.w,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          accent.withValues(alpha: 0.5),
                          appColors.glassBorder.withValues(alpha: 0.15),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: showConnector ? 18.h : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: isPending
                          ? cs.onSurface.withValues(alpha: 0.55)
                          : cs.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    hint,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: appColors.muted,
                      fontSize: 11.sp,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (state == _StepState.active)
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: _ActiveBadge(color: accent),
            ),
        ],
      ),
    );
  }
}

class _TimelineNode extends HookWidget {
  final _StepState state;
  final Color accent;

  const _TimelineNode({required this.state, required this.accent});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    // Only the active node breathes; done/pending/rejected are static
    // (cheaper).
    if (state != _StepState.active) {
      final bool done = state == _StepState.done;
      final bool rejected = state == _StepState.rejected;
      final bool filled = done || rejected;
      return Container(
        width: 26.w,
        height: 26.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled
              ? accent.withValues(alpha: 0.15)
              : appColors.glass.withValues(alpha: 0.05),
          border: Border.all(
            color: filled
                ? accent.withValues(alpha: 0.6)
                : appColors.glassBorder.withValues(alpha: 0.35),
            width: 1.4,
          ),
        ),
        child: filled
            ? Icon(
          done ? Icons.check_rounded : Icons.close_rounded,
          size: 15.sp,
          color: accent,
        )
            : null,
      );
    }

    final ctrl = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    final t = useAnimation(
      CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
    );

    return Container(
      width: 26.w,
      height: 26.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accent.withValues(alpha: 0.14),
        border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.6),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.15 + t * 0.3),
            blurRadius: 8 + t * 6,
            spreadRadius: t * 1.5,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 9.w,
          height: 9.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: accent),
        ),
      ),
    );
  }
}

class _ActiveBadge extends StatelessWidget {
  final Color color;
  const _ActiveBadge({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        'memberApproval.timeline.nowBadge'.tr(),
        style: context.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 8.5.sp,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rejection card — the backend's reason plus what to do about it.
// ─────────────────────────────────────────────────────────────────────────────

class _RejectionCard extends StatelessWidget {
  /// Backend-authored reason; null/empty falls back to the translated copy.
  final String? reason;

  const _RejectionCard({this.reason});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: context.glassPanel(
        borderRadius: BorderRadius.circular(16.r),
        fillTop: 0.06,
        fillBottom: 0.02,
        hairline: 0.14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 16.sp,
                color: appColors.error,
              ),
              SizedBox(width: 8.w),
              Text(
                'memberApproval.rejected.reason.title'.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            (reason ?? '').isNotEmpty
                ? reason!
                : 'memberApproval.rejected.reason.fallback'.tr(),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.85),
              height: 1.5,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'memberApproval.rejected.reason.hint'.tr(),
            style: context.textTheme.bodySmall?.copyWith(
              color: appColors.muted,
              height: 1.45,
              fontSize: 11.5.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// "What happens next" card.
// ─────────────────────────────────────────────────────────────────────────────

class _NextStepsCard extends StatelessWidget {
  const _NextStepsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: context.glassPanel(
        borderRadius: BorderRadius.circular(16.r),
        fillTop: 0.06,
        fillBottom: 0.02,
        hairline: 0.14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                size: 16.sp,
                color: context.colorScheme.tertiary,
              ),
              SizedBox(width: 8.w),
              Text(
                'memberApproval.next.title'.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _InfoRow(
            icon: Icons.notifications_active_rounded,
            text: 'memberApproval.next.notify'.tr(),
          ),
          SizedBox(height: 10.h),
          _InfoRow(
            icon: Icons.dialpad_rounded,
            text: 'memberApproval.next.mpin'.tr(),
          ),
          SizedBox(height: 10.h),
          _InfoRow(
            icon: Icons.fingerprint_rounded,
            text: 'memberApproval.next.biometric'.tr(),
          ),
          SizedBox(height: 10.h),
          _InfoRow(
            icon: Icons.send_rounded,
            text: 'memberApproval.next.send'.tr(),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26.w,
          height: 26.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: appColors.success.withValues(alpha: 0.10),
          ),
          child: Icon(icon, size: 14.sp, color: appColors.success),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(
                color: appColors.muted,
                height: 1.45,
                fontSize: 11.5.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
