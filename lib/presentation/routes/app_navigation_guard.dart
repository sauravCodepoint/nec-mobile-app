import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Stale-navigation guard.
///
/// Almost every navigation in this app is driven by an asynchronous result —
/// a one-shot BLoC reaction that fires whenever the backend answers, which can
/// be long after the tap that started it. Nothing stops the user from moving on
/// while that request is in flight: the screen's loading overlay covers its own
/// body, but never the app bar, the drawer or the bottom nav, so a tap on
/// "Send Again" can be followed by a tab switch or a pushed screen — and when
/// the answer lands, the listener pushes its destination on top of whatever the
/// user is looking at now.
///
/// The rule this file enforces is that **a screen may only navigate while it is
/// the screen the user is looking at**. Call sites ask with [isScreenActive], or
/// navigate through the `*IfActive` helpers, which drop the navigation when the
/// user has moved on. The tap is discarded — deliberately: the user abandoned
/// that flow, and re-tapping is cheap next to being thrown onto a screen they
/// did not ask for.
///
/// "Active" is judged permissively, so only a real screen change blocks:
///
/// * The screen is active when its page is the top-most page of the router's
///   stack. Dialogs, bottom sheets and toasts are pageless routes, so they
///   never make the screen underneath inactive — a dialog button that pops
///   itself and then navigates keeps working.
/// * A page on its way out has already handed the screen back, so it must not
///   count as covering: a response landing right after, say, an
///   [AppSelectableRoute] picker closes still belongs to the screen underneath.
///   auto_route drops a page from its stack the moment its pop is invoked, so
///   the check above already sees through a popping page; [ModalRoute.isCurrentOf]
///   — the framework's own answer, which flips at that same moment — is kept as
///   a second opinion so this guard can never start silently swallowing
///   navigations if that stack timing changes.
/// * A tab page stays mounted (and its route stays top-most) when the user
///   switches tabs, so tab hosts publish which tab is showing through
///   [AppScreenVisibility]; a hidden tab is never active.
///
/// Navigation that resets the whole stack (`replaceAll`, logout) is deliberately
/// NOT guarded: its destination is absolute, so it is correct from anywhere.

/// Publishes, to everything below it, whether this subtree is the visible one
/// among sibling screens that are all kept mounted — i.e. the tab pages
/// `MainPage` holds alive in its `IndexedStack`.
///
/// Wraps each tab with the host's selection notifier and that tab's index, so
/// the answer is read live at navigation time rather than captured at build
/// time. Nothing depends on this widget (it is read without registering a
/// dependency), so switching tabs rebuilds no subtree because of it.
class AppScreenVisibility extends InheritedWidget {
  /// The host's currently-selected index.
  final ValueListenable<int> activeIndex;

  /// The index this subtree is mounted at.
  final int index;

  const AppScreenVisibility({
    super.key,
    required this.activeIndex,
    required this.index,
    required super.child,
  });

  /// Whether this subtree is the one currently showing.
  bool get isVisible => activeIndex.value == index;

  /// Reads the nearest marker without registering a dependency — this is called
  /// from tap handlers and BLoC listeners, which must not turn into rebuilds of
  /// the page every time the selection changes.
  ///
  /// A screen with no marker above it is not a kept-alive sibling, so it counts
  /// as visible.
  static bool isVisibleIn(BuildContext context) =>
      context.getInheritedWidgetOfExactType<AppScreenVisibility>()?.isVisible ??
      true;

  @override
  bool updateShouldNotify(AppScreenVisibility oldWidget) =>
      oldWidget.activeIndex != activeIndex || oldWidget.index != index;
}

/// Navigation that only happens while the calling screen is still the one the
/// user is looking at. See the file header for the rule and why it exists.
extension AppNavigationGuardX on BuildContext {
  /// Whether the screen this context belongs to is the one on screen: its page
  /// is top-most (dialogs and sheets don't count as covering it) and, if it is
  /// a kept-alive tab, its tab is the selected one.
  bool get isScreenActive {
    if (!mounted) return false;
    if (!AppScreenVisibility.isVisibleIn(this)) return false;

    // Both scopes are read without registering a dependency.
    final routeData =
        findAncestorWidgetOfExactType<RouteDataScope>()?.routeData;
    final controller = findAncestorWidgetOfExactType<RouterScope>()?.controller;
    // Outside a router (a dialog built from the navigator key, a test harness):
    // there is no "other screen" to land on, so don't block.
    if (routeData == null || controller == null) return true;

    if (identical(controller.topRoute, routeData)) return true;

    // A page sits above this one in the router's stack. It is only a real
    // screen change while that page is still being presented — see the file
    // header on pages that are on their way out.
    return ModalRoute.isCurrentOf(this) ?? false;
  }

  /// [StackRouter.push], dropped when the user has moved on.
  @optionalTypeArgs
  Future<T?> pushIfActive<T extends Object?>(PageRouteInfo route) {
    if (!isScreenActive) return Future<T?>.value();
    return router.push<T>(route);
  }

  /// [StackRouter.replace], dropped when the user has moved on — which is what
  /// makes it safe: a stale replace would swap out the screen the user moved
  /// to, not the one that asked.
  @optionalTypeArgs
  Future<T?> replaceIfActive<T extends Object?>(PageRouteInfo route) {
    if (!isScreenActive) return Future<T?>.value();
    return router.replace<T>(route);
  }

  /// [StackRouter.popAndPush], dropped when the user has moved on — a stale one
  /// would pop whatever screen they opened in the meantime.
  @optionalTypeArgs
  Future<T?> popAndPushIfActive<T extends Object?>(PageRouteInfo route) {
    if (!isScreenActive) return Future<T?>.value();
    return router.popAndPush<T, Object?>(route);
  }

  /// Runs [action] only while this screen is the one on screen. For whole
  /// one-shot reactions — an error dialog whose button navigates, a picker
  /// opened from a listener — where reacting at all is wrong once the user has
  /// moved on.
  void runIfActive(VoidCallback action) {
    if (isScreenActive) action();
  }
}
