import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/common/common_selectable_dto.dart';
import '../app_bar/app_app_bar.dart';
import '../scaffold/app_scaffold.dart';
import '../theme/app_theme_ext.dart';

/// Dedicated full-page payment-method picker.
///
/// Follows the AppSelectablePage approach — same contract ([title],
/// [commonSelectableDto], [initialSelectedItem], [onSelected]) and the same
/// selection behaviour (haptic tap, brief selected beat, then pop) — but a
/// designed page rather than a generic list: ambient drifting orbs, a
/// question-style header, captioned method cards whose leading badge is the
/// selection indicator (outline chip → solid fill + icon pop + one-shot
/// ripple), and a trust note pinned at the bottom.
///
/// Performance: one entrance controller shared by every reveal, one slow
/// ambient controller isolated behind a RepaintBoundary, and only implicit /
/// one-shot animations on interaction — nothing ticks once the page settles
/// except the background drift.
@RoutePage()
class AppPaymentMethodPage extends HookWidget {
  final String? title;
  final String? subtitle;
  final CommonSelectableDto? commonSelectableDto;
  final CommonSelectableItem? initialSelectedItem;
  final ValueChanged<CommonSelectableItem>? onSelected;

  const AppPaymentMethodPage({
    super.key,
    this.title,
    this.subtitle,
    this.commonSelectableDto,
    this.initialSelectedItem,
    this.onSelected,
  });

  // Matches AppSelectablePage's post-tap beat: long enough to read the
  // selected state, short enough to feel instant.
  static const _popDelay = Duration(milliseconds: 240);

  // Entrance choreography: each card starts this fraction after the previous
  // one on the shared controller.
  static const _staggerStep = 0.09;

  // Icon + caption per method family, resolved from the method's code/name.
  static (IconData, String) _methodVisual(CommonSelectableItem item) {
    final n = '${item.titleCode ?? ''} ${item.titleName ?? ''}'.toLowerCase();
    if (n.contains('card')) {
      return (
        Icons.credit_card_rounded,
        'core.paymentMethodPage.captions.card',
      );
    }
    if (n.contains('wallet')) {
      return (
        Icons.account_balance_wallet_rounded,
        'core.paymentMethodPage.captions.wallet',
      );
    }
    if (n.contains('cash')) {
      return (Icons.payments_rounded, 'core.paymentMethodPage.captions.cash');
    }
    if (n.contains('bank') || n.contains('account')) {
      return (
        Icons.account_balance_rounded,
        'core.paymentMethodPage.captions.bank',
      );
    }
    return (Icons.payment_rounded, 'core.paymentMethodPage.captions.other');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final items = commonSelectableDto?.data?.list ?? const [];
    final selected = useState<CommonSelectableItem?>(initialSelectedItem);
    // Blocks double-taps during the pop delay.
    final isClosing = useRef(false);

    // One controller drives the whole entrance: header, cards in stagger,
    // then the trust note — a single timeline instead of per-item tickers.
    final entranceCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1100),
    );

    useEffect(() {
      entranceCtrl.forward();
      return null;
    }, const []);

    void onItemTap(CommonSelectableItem item) {
      if (isClosing.value) return;
      isClosing.value = true;
      selected.value = item;
      HapticFeedback.lightImpact();
      Future.delayed(_popDelay, () {
        if (!context.mounted) return;
        onSelected?.call(item);
        context.router.pop();
      });
    }

    return AppScaffold(
      appBar: AppAppBar(title: title),
      body: Stack(
        children: [
          Positioned.fill(child: RepaintBoundary(child: _AmbientBackground())),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ─────────────────────────────────────────────────────
              _Reveal(
                parent: entranceCtrl,
                interval: const Interval(0.0, 0.40, curve: Curves.easeOutCubic),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            letterSpacing: -0.2,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      SizedBox(height: 6.h),
                      Text(
                        'core.paymentMethodPage.methodsAvailable'.tr(
                          namedArgs: {'count': '${items.length}'},
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 11.sp,
                          color: context.appColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // ── Method cards ───────────────────────────────────────────────
              Expanded(
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final (icon, captionKey) = _methodVisual(item);
                    final start = (0.18 + index * _staggerStep).clamp(0.0, 0.6);
                    return _Reveal(
                      parent: entranceCtrl,
                      interval: Interval(
                        start,
                        (start + 0.4).clamp(0.0, 1.0),
                        curve: Curves.easeOutCubic,
                      ),
                      child: _MethodCard(
                        item: item,
                        icon: icon,
                        caption: captionKey.tr(),
                        isSelected: item.titleCode == selected.value?.titleCode,
                        onTap: () => onItemTap(item),
                      ),
                    );
                  },
                ),
              ),

              // ── Trust note ─────────────────────────────────────────────────
              _Reveal(
                parent: entranceCtrl,
                interval: const Interval(0.55, 1.0, curve: Curves.easeOutCubic),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: colorScheme.tertiary.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          color: colorScheme.tertiary.withValues(alpha: 0.7),
                          size: 14.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'core.paymentMethodPage.secureNote'.tr(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 10.sp,
                              height: 1.5,
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Entrance reveal (fade + slide on the shared controller) ──────────────────

class _Reveal extends StatelessWidget {
  final AnimationController parent;
  final Interval interval;
  final Widget child;

  const _Reveal({
    required this.parent,
    required this.interval,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final drive = CurvedAnimation(parent: parent, curve: interval);
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.10),
      end: Offset.zero,
    ).animate(drive);

    return FadeTransition(
      opacity: drive,
      child: SlideTransition(position: slide, child: child),
    );
  }
}

// ─── Ambient background orbs (single slow controller, repaint-isolated) ───────

class _AmbientBackground extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.appColors;

    final ctrl = useAnimationController(duration: const Duration(seconds: 8));

    useEffect(() {
      ctrl.repeat(reverse: true);
      return null;
    }, const []);

    final anim = useMemoized(
      () => CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
      [ctrl],
    );

    return AnimatedBuilder(
      animation: anim,
      builder: (_, _) {
        final t = anim.value;
        return Stack(
          children: [
            Positioned(
              top: -50 + t * 24,
              right: -70 + t * 12,
              child: _Orb(
                size: 240.w,
                color: colorScheme.tertiary.withValues(alpha: 0.05),
              ),
            ),
            Positioned(
              bottom: 60 - t * 30,
              left: -80 + t * 14,
              child: _Orb(
                size: 220.w,
                color: appColors.info.withValues(alpha: 0.04),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;

  const _Orb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

// ─── Method card ──────────────────────────────────────────────────────────────

class _MethodCard extends HookWidget {
  final CommonSelectableItem item;
  final IconData icon;
  final String caption;
  final bool isSelected;
  final VoidCallback onTap;

  const _MethodCard({
    required this.item,
    required this.icon,
    required this.caption,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isPressed = useState(false);

    return AnimatedScale(
      scale: isPressed.value ? 0.97 : (isSelected ? 1.01 : 1.0),
      duration: Duration(milliseconds: isPressed.value ? 80 : 220),
      curve: isPressed.value ? Curves.easeIn : Curves.easeOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [
                    colorScheme.tertiary.withValues(alpha: 0.14),
                    colorScheme.tertiary.withValues(alpha: 0.05),
                  ]
                : [
                    context.appColors.glass.withValues(alpha: 0.08),
                    context.appColors.glass.withValues(alpha: 0.03),
                  ],
          ),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? colorScheme.tertiary.withValues(alpha: 0.75)
                : context.appColors.glassBorder.withValues(alpha: 0.18),
            width: isSelected ? 1.2.w : 0.8.w,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: colorScheme.tertiary.withValues(alpha: 0.18),
                blurRadius: 14.r,
                offset: const Offset(0, 3),
              )
            else
              BoxShadow(
                color: context.appColors.shadowInk.withValues(alpha: 0.10),
                blurRadius: 12.r,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: InkWell(
            onTap: onTap,
            onHighlightChanged: (highlighted) => isPressed.value = highlighted,
            borderRadius: BorderRadius.circular(14.r),
            splashColor: colorScheme.tertiary.withValues(alpha: 0.06),
            highlightColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Row(
                children: [
                  _MethodBadge(icon: icon, isSelected: isSelected),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeInOut,
                          style:
                              (theme.textTheme.bodyMedium ?? const TextStyle())
                                  .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? colorScheme.tertiary
                                        : colorScheme.onSurface,
                                  ),
                          child: Text(
                            item.titleName?.toUpperCase() ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 10.5.sp,
                            height: 1.35,
                            color: colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutBack,
                      ),
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check_circle,
                            key: const ValueKey(true),
                            size: 22.sp,
                            color: colorScheme.tertiary,
                          )
                        : Icon(
                            Icons.circle_outlined,
                            key: const ValueKey(false),
                            size: 22.sp,
                            color: context.appColors.glassBorder.withValues(
                              alpha: 0.30,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Leading badge — the selection indicator ──────────────────────────────────
//
// Unselected: tinted outline chip holding the method icon.
// Selected: flips to a solid tertiary fill, the icon pops with an easeOutBack
// scale, and a ripple ring fires once and fades — the badge announces the
// choice before the border/check finish animating.

class _MethodBadge extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const _MethodBadge({required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 50.w,
      height: 50.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // One-shot ripple ring. Keyed by isSelected so it replays exactly
          // once per state change and settles at full transparency.
          if (isSelected)
            TweenAnimationBuilder<double>(
              key: const ValueKey('ripple'),
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              builder: (_, t, _) => Container(
                width: 46.w + 16.w * t,
                height: 46.w + 16.w * t,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.tertiary.withValues(
                      alpha: (1 - t) * 0.45,
                    ),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          // Badge chip: outline → solid fill.
          AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.r),
              color: isSelected
                  ? context.appColors.brandFill
                  : colorScheme.tertiary.withValues(alpha: 0.10),
              border: Border.all(
                color: colorScheme.tertiary.withValues(
                  alpha: isSelected ? 0.0 : 0.20,
                ),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colorScheme.tertiary.withValues(alpha: 0.35),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : const [],
            ),
            // Icon pop on selection change: scale dips then overshoots back.
            child: TweenAnimationBuilder<double>(
              key: ValueKey(isSelected),
              tween: Tween(begin: 0.6, end: 1.0),
              duration: const Duration(milliseconds: 340),
              curve: Curves.easeOutBack,
              builder: (_, scale, child) => Transform.scale(
                scale: scale,
                child: child,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? context.appColors.onBrandFill
                    : colorScheme.tertiary,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
