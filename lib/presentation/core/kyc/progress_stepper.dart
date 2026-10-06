import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme_ext.dart';

typedef KycStepData = ({String label, IconData icon, bool complete});

class KycProgressStepper extends StatelessWidget {
  final List<KycStepData> steps;
  const KycProgressStepper({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Expanded(
            flex: 2,
            child: _StepNode(
              step: steps[i],
              isActive: !steps[i].complete &&
                  (i == 0 || steps[i - 1].complete),
              theme: theme,
            ),
          ),
          if (i < steps.length - 1)
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(top: 22.w),
                child: _ConnectorLine(
                  leftDone: steps[i].complete,
                ),
              ),
            ),
        ],
      ],
    );
  }
}

// ── Step node ─────────────────────────────────────────────────────────────────

class _StepNode extends StatefulWidget {
  final KycStepData step;
  final bool isActive;
  final ThemeData theme;

  const _StepNode({
    required this.step,
    required this.isActive,
    required this.theme,
  });

  @override
  State<_StepNode> createState() => _StepNodeState();
}

class _StepNodeState extends State<_StepNode>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _checkScale;
  late final Animation<double> _rippleScale;
  late final Animation<double> _rippleOpacity;
  bool _wasComplete = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _checkScale = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: const Interval(0.0, 0.75),
          ),
        );
    _rippleScale = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.0, 0.7)),
    );
    _rippleOpacity = Tween<double>(begin: 0.45, end: 0.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.1, 0.8, curve: Curves.easeOut),
      ),
    );
    _wasComplete = widget.step.complete;
    if (_wasComplete) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(_StepNode old) {
    super.didUpdateWidget(old);
    if (!_wasComplete && widget.step.complete) {
      _wasComplete = true;
      _ctrl.forward(from: 0.0);
    } else if (_wasComplete && !widget.step.complete) {
      _wasComplete = false;
      _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final cs = theme.colorScheme;
    final step = widget.step;

    return Column(
      children: [
        SizedBox(
          width: 44.w,
          height: 44.w,
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  if (step.complete && _ctrl.value < 1.0)
                    Transform.scale(
                      scale: _rippleScale.value,
                      child: Opacity(
                        opacity: _rippleOpacity.value,
                        child: Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.appColors.success,
                              width: 2.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: step.complete
                          ? context.appColors.success
                          : widget.isActive
                              ? cs.tertiary.withValues(alpha: 0.12)
                              : context.appColors.glass.withValues(alpha: 0.06),
                      border: Border.all(
                        color: step.complete
                            ? context.appColors.success
                            : widget.isActive
                                ? cs.tertiary
                                : context.appColors.glassBorder.withValues(alpha: 0.18),
                        width: 1.w,
                      ),
                    ),
                  ),
                  if (step.complete)
                    ScaleTransition(
                      scale: _checkScale,
                      child: Icon(
                        Icons.check_rounded,
                        color: context.appColors.onSuccess,
                        size: 20.sp,
                      ),
                    )
                  else
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: 1.0,
                      child: Icon(
                        step.icon,
                        color: widget.isActive
                            ? cs.tertiary
                            : cs.onSurface.withValues(alpha: 0.4),
                        size: 20.sp,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 6.h),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: theme.textTheme.labelSmall!.copyWith(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: step.complete
                ? context.appColors.success
                : cs.onSurface.withValues(alpha: 0.6),
          ),
          child: Text(step.label, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

// ── Connector line ─────────────────────────────────────────────────────────────

class _ConnectorLine extends StatefulWidget {
  final bool leftDone;
  const _ConnectorLine({required this.leftDone});

  @override
  State<_ConnectorLine> createState() => _ConnectorLineState();
}

class _ConnectorLineState extends State<_ConnectorLine>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fill;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fill = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    if (widget.leftDone) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(_ConnectorLine old) {
    super.didUpdateWidget(old);
    if (!old.leftDone && widget.leftDone) {
      _ctrl.forward(from: 0.0);
    } else if (old.leftDone && !widget.leftDone) {
      _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inactive = context.appColors.glassBorder.withValues(alpha: 0.18);

    return AnimatedBuilder(
      animation: _fill,
      builder: (_, __) {
        final t = _fill.value;
        return Container(
          height: 1.5.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(inactive, context.appColors.success, t)!,
                Color.lerp(inactive, context.appColors.success, (t - 0.3).clamp(0.0, 1.0) / 0.7)!,
              ],
            ),
          ),
        );
      },
    );
  }
}