import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Result of [useListReveal]: the shared cascade [controller] and the ids that
/// are appearing for the first time (they pop in individually).
class ListReveal {
  final AnimationController controller;
  final Set<String> fresh;

  const ListReveal(this.controller, this.fresh);

  bool isFresh(String? id) => id != null && fresh.contains(id);
}

/// Drives a list's entrance animation: the first time the list is shown every
/// row cascades in (staggered); afterwards only newly-added ids pop in, so
/// edits, deletes, scrolling and searching never re-animate a settled row.
///
/// [revealedIds] must outlive the list widget — own it on the page/screen
/// (`useRef(<String>{}).value`) so it survives the list remounting.
ListReveal useListReveal(Set<String> revealedIds, Iterable<String> currentIds) {
  final ids = currentIds.toList(growable: false);
  // Empty only on the very first reveal; a later mount starts already at rest.
  final firstReveal = useMemoized(() => revealedIds.isEmpty, const []);
  final controller = useAnimationController(
    duration: const Duration(milliseconds: 850),
    initialValue: firstReveal ? 0 : 1,
  );
  useEffect(() {
    if (firstReveal) controller.forward();
    return null;
  }, const []);

  // Seed the initial rows once so they cascade together rather than each being
  // treated as "new"; afterwards any unseen id is a freshly added row.
  final seeded = useRef(false);
  if (!seeded.value) {
    seeded.value = true;
    if (firstReveal) revealedIds.addAll(ids);
  }
  final fresh = ids.where(revealedIds.add).toSet();
  return ListReveal(controller, fresh);
}

/// Reveals [child] with a fade + springy pop. A [pop] row plays its own
/// one-shot; other rows follow the shared [controller] — staggered on first
/// load, otherwise resting at 1 (rendered with no wrapper, so settled rows
/// cost nothing extra).
class RevealItem extends HookWidget {
  final AnimationController controller;
  final int index;
  final bool pop;
  final Widget child;

  const RevealItem({
    super.key,
    required this.controller,
    required this.index,
    required this.pop,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Latch at mount so a later rebuild can't reclassify the row mid-animation.
    final isPop = useMemoized(() => pop, const []);

    if (isPop) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 620),
        builder: (_, t, child) => _pose(t, child!),
        child: child,
      );
    }
    // Already at rest → skip the AnimatedBuilder entirely.
    if (controller.value == 1) return child;

    // Each row starts a beat after the one above; later rows share the tail so
    // long lists still finish within the single run.
    final start = (index * 0.09).clamp(0.0, 0.6);
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) =>
          _pose(((controller.value - start) / 0.42).clamp(0.0, 1.0), child!),
      child: child,
    );
  }

  /// Maps linear progress [raw] (0→1) to the reveal pose: fade in while
  /// overshooting the resting scale/offset, then settling.
  static Widget _pose(double raw, Widget child) {
    final spring = Curves.easeOutBack.transform(raw);
    return Opacity(
      opacity: Curves.easeOut.transform(raw),
      child: Transform.translate(
        offset: Offset(0, (1 - spring) * 26.h),
        child: Transform.scale(scale: 0.85 + 0.15 * spring, child: child),
      ),
    );
  }
}