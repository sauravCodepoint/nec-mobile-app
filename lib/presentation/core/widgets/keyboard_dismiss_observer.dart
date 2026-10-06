import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Dismisses the software keyboard on route push, pop, remove and replace.
///
/// - [didPush]/[didReplace] unfocus synchronously so the new route never
///   inherits the previous route's IME state.
/// - [didPop]/[didRemove] schedule the unfocus on the next frame because
///   Flutter's FocusScopeNode restores focus to the previous route's
///   last-focused descendant during pop completion — running before that
///   restoration is a no-op and the keyboard would re-open.
/// - The next-frame sweep is not always enough: on some devices the focus
///   restoration lands only when the route's exit transition fully completes
///   (several frames later). In popAndPush/replace flows the restored node
///   then belongs to a route *buried* in the stack, so no
///   `FocusScope.of(context).unfocus()` on the visible page can ever clear it
///   and the keyboard is stuck. [_sweepAfterTransition] runs once more after
///   the route is disposed and clears focus that landed on a non-current
///   route (focus the user legitimately acquired on the current route in the
///   meantime is left alone).
class KeyboardDismissObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _safeUnfocus();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _safeUnfocus();
    _sweepAfterTransition(oldRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _safeUnfocus());
    _sweepAfterTransition(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _safeUnfocus());
    _sweepAfterTransition(route);
  }

  static void _sweepAfterTransition(Route<dynamic>? route) {
    if (route is! TransitionRoute) return;
    // `completed` resolves when the route is disposed after its exit
    // transition — i.e. after any late focus restoration has happened.
    route.completed.then((_) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _dismissNonCurrentFocus(),
      );
    });
  }

  /// Clears focus only when it is held by a node on a route that is no
  /// longer current — the stolen-focus case that makes the keyboard
  /// undismissable from the visible page.
  static void _dismissNonCurrentFocus() {
    final focus = FocusManager.instance.primaryFocus;
    if (focus == null) return;
    final context = focus.context;
    if (context == null) {
      // Node already deactivated but its IME connection may still be alive.
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      return;
    }
    final route = ModalRoute.of(context);
    if (route != null && !route.isCurrent) focus.unfocus();
  }

  static void _safeUnfocus() {
    final focus = FocusManager.instance.primaryFocus;
    if (focus == null) return;
    // A FocusNode whose owning Element has been deactivated keeps
    // `context: null`; calling `unfocus()` on it throws on low-end Android
    // during fast back-stack pops. Force-hide the IME instead — the node
    // can't reclaim it once disposed.
    if (focus.context == null) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      return;
    }
    focus.unfocus();
  }
}