import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../domain/core/di/injection.dart';
import '../../../domain/core/prefs/app_prefs.dart';
import '../theme/app_theme_ext.dart';
import 'app_showcase.dart';

/// Drives a one-time, branded coach-mark tour.
///
/// Wrap each target with [AppShowcase] and pass the same [Globalkey]s — in the
/// order they should be visited — as [steps]. The tour:
///
/// * runs **once per device** (gated by [tourId] via [SharedPrefs]); pass
///   `once: false` to always run (e.g. a manual "replay tour" entry),
/// * starts only after [ready] turns true, so it never spotlights a shimmer
///   or an unmounted widget — drive it from your "content loaded" flag,
/// * scrolls off-screen targets into view and supplies Back / Next buttons
///   plus a persistent Skip, all themed and localised.
///
/// Designed to be copied verbatim across projects: it reads every colour and
/// text style from the shared theme extensions and every label from the
/// `showcase.actions.*` translation keys.
///
/// Only one tour may be active at a time (it uses the default showcase scope);
/// the controller is registered on mount and unregistered on dispose.
/// Returns a [ValueListenable] that is `true` while a tour is expected to run
/// this session (or is actively running) and flips to `false` once it
/// finishes/dismisses (or immediately when no tour will run). Callers can use
/// it to defer competing dialogs until the coach marks are done — see
/// `home_page.dart`, which holds back the advertisement carousel.
ValueListenable<bool> useShowcaseTour({
  required String tourId,
  required List<GlobalKey> steps,
  required bool ready,
  bool once = true,
  Duration startDelay = const Duration(milliseconds: 350),
}) {
  final started = useRef(false);
  // Holds the count of steps actually started, so the card's "n / m" indicator
  // stays correct even though the controller is registered (once, on mount)
  // before the final dynamic step list is known.
  final stepCount = useRef(0);

  final hostContext = useContext();
  // Never start while another route covers the host page: the showcase overlay
  // is inserted into the *root* overlay, so it would render on top of the
  // covering route as a stuck grey barrier spotlighting invisible widgets
  // (e.g. `ready` flipping true while the user is already on a pushed form).
  // ModalRoute.of registers a dependency on the route's status, so this widget
  // rebuilds — and the tour retries — when it becomes the top route again.
  final isTopRoute = ModalRoute.of(hostContext)?.isCurrent ?? true;

  // Whether a tour is pending/running. Seeded from the persisted "seen" flag so
  // it is already `true` on a first launch *before* the tour starts — letting
  // callers defer competing dialogs without racing the tour's delayed start —
  // and `false` on later launches when the tour won't run. Flipped to `false`
  // when the tour completes or is dismissed.
  final active = useMemoized<ValueNotifier<bool>>(
    () => ValueNotifier(
      once ? !getIt<SharedPrefs>().hasSeenShowcase(tourId) : true,
    ),
    const [],
  );
  useEffect(() => active.dispose, const []);

  // Register the controller once for the lifetime of the host widget. Back /
  // Next / progress are rendered by the custom tooltip card (AppShowcase); the
  // controller only needs to publish the active step and persist completion.
  useEffect(() {
    void clearProgress() => showcaseProgress.value = null;

    void markSeen() {
      clearProgress();
      active.value = false;
      getIt<SharedPrefs>().setShowcaseSeen(tourId);
    }

    // Each tour gets its own scope (the tourId). With the shared default
    // scope, a pushed page's register() overwrites this page's registration
    // and its unregister() (on pop) removes the scope entirely — leaving the
    // page underneath scope-less, so any newly built Showcase target throws
    // ("No ShowcaseView is registered") — a grey screen in release. Named
    // scopes are stacked/popped by the package, so nesting home →
    // beneficiary → summary tours is safe.
    final view = ShowcaseView.register(
      scope: tourId,
      enableAutoScroll: true,
      disableBarrierInteraction: true,
      skipIfTargetNotPresent: true,
      blurValue: 1,
      globalFloatingActionWidget: (context) {
        // Lift the Skip pill above the system gesture/navigation bar (incl. the
        // Android back button) so it is never hidden behind the bottom safe
        // area. Read the inset straight from the FlutterView so it is immune to
        // any MediaQuery overrides in the tree.
        final view = View.of(context);
        final bottomInset = view.viewPadding.bottom / view.devicePixelRatio;
        return FloatingActionWidget(
          bottom: 20.h + bottomInset,
          right: 16.w,
          child: _SkipButton(onTap: () => ShowcaseView.getNamed(tourId).dismiss()),
        );
      },
      onStart: (index, _) =>
          showcaseProgress.value = (index: index ?? 0, total: stepCount.value),
      onFinish: markSeen,
      onDismiss: (_) => markSeen(),
    );

    return () {
      clearProgress();
      view.unregister();
    };
  }, const []);

  // Kick the tour off the first time the screen is ready *and* visible.
  final canStart = ready && isTopRoute;
  useEffect(() {
    if (!canStart || started.value) return null;
    // Terminal "won't run" cases: release any deferred work waiting on us.
    if (steps.isEmpty ||
        (once && getIt<SharedPrefs>().hasSeenShowcase(tourId))) {
      active.value = false;
      return null;
    }

    started.value = true;
    active.value = true;
    stepCount.value = steps.length;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // Own the start delay (instead of passing it to startShowCase) so the
      // route can be re-checked *after* it elapses — the user may have
      // navigated away between the ready flip and now.
      await Future<void>.delayed(startDelay);
      if (!hostContext.mounted) return;
      if (!(ModalRoute.of(hostContext)?.isCurrent ?? true)) {
        // Covered mid-frame/mid-delay: allow a retry when the page is
        // rebuilt as the top route again.
        started.value = false;
        return;
      }
      ShowcaseView.getNamed(tourId).startShowCase(steps);
    });
    return null;
  }, [canStart]);

  return active;
}

/// Pill "Skip" button shown in the corner for the whole tour.
class _SkipButton extends StatelessWidget {
  const _SkipButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: context.appColors.containerBackground,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: context.appColors.glassBorder.withValues(alpha: 0.18),
              width: 0.8,
            ),
          ),
          child: Text(
            'showcase.actions.skip'.tr(),
            style: context.typography.secondaryMedium.copyWith(
              color: cs.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
