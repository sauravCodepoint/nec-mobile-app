import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../application/home/home_bloc.dart';
import '../../domain/core/crash_reporting/app_crash_reporting.dart';
import '../../domain/core/push_notification/app_push_notification.dart';
import '../beneficiary/beneficiary_page.dart';
import '../core/notification_permission/notification_permission_primer.dart';
import '../core/notify/app_notify.dart';
import '../core/shimmer/app_shimmer.dart';
import '../core/theme/app_theme_ext.dart';
import '../home/home_page.dart';
import '../routes/app_navigation_guard.dart';
import '../routes/app_routes.gr.dart';
import '../settings/settings_page.dart';
import '../support/support_page.dart';

@RoutePage()
class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Selection lives in a raw ValueNotifier (NOT useState) so tapping a tab
    // does NOT rebuild MainPage — only the IndexedStack index and the affected
    // nav tabs (each wrapped in its own ValueListenableBuilder) repaint. This
    // keeps the frequent interaction (tab switching) off the expensive path:
    // the HomeBloc.select, PopScope, and lifecycle effects below never re-run.
    final selectedIndex = useMemoized(() => ValueNotifier<int>(0));
    useEffect(() => selectedIndex.dispose, [selectedIndex]);

    // Lock the bottom nav (shimmer placeholders, no taps) until the home
    // page's FIRST load has fully settled — switching tabs mid-load breaks
    // widgets that assume home stays visible (notably the coach-mark tour,
    // which would spotlight offstage IndexedStack targets). A critical load
    // failure also unlocks, so the full-screen retry state can never trap the
    // user on the home tab. Once settled, the lock never re-engages: refreshes
    // and rate recalculations keep the nav usable.
    final hasHomeSettledOnce = useRef(false);
    final homeSettledNow = context.select<HomeBloc, bool>(
      (bloc) =>
          !bloc.state.isInitialSectionsLoading || bloc.state.criticalLoadFailed,
    );
    if (homeSettledNow) hasHomeSettledOnce.value = true;
    final isNavLocked = !hasHomeSettledOnce.value;

    // Every login path (MPIN, biometric, OTP, set-MPIN) lands on MainPage,
    // so post-login one-shots live here. The permission itself is asked at
    // app start by SplashPage; these calls self-guard when it was denied.
    useEffect(() {
      // Offer the notification-permission primer here for the cold-start →
      // MPIN path: splash deliberately skips it on the lock screen so it can't
      // collide with the iOS biometric auto-prompt (see SplashPage). The
      // primer self-guards via _shownThisSession, so destinations that already
      // prompted at app start make this a no-op.
      NotificationPermissionPrimer.runAtAppStart();
      // One-time welcome notification (no-op until permission is granted).
      AppPushNotification.showWelcomeNotification();
      // Tag crash reports with the freshly logged-in member code.
      AppCrashReporting.syncUser();
      return null;
    }, const []);

    // Device-token registration is a network call, so it deliberately does NOT
    // run in the mount effect above: on this frame HomeBloc is starting its own
    // sequence of requests, and adding a concurrent authenticated POST is what
    // makes the backend contend server-side and answer 500 (see HomeBloc's
    // single-lane API gate). It waits for home's first load to settle instead.
    // Fire-and-forget and self-deduping, so landing a moment later costs
    // nothing — and the resume handler below still retries a failed sync.
    final isHomeSettled = hasHomeSettledOnce.value;
    useEffect(() {
      if (!isHomeSettled) return null;
      AppPushNotification.syncDeviceToken();
      return null;
    }, [isHomeSettled]);

    // Retry a failed token registration when the app returns to the
    // foreground (self-deduping — a successful sync makes this a no-op).
    useOnAppLifecycleStateChange((_, state) {
      if (state == AppLifecycleState.resumed) {
        AppPushNotification.syncDeviceToken();
      }
    });

    final pages = const [
      HomePage(),
      BeneficiaryPage(),
      SettingsPage(),
      SupportPage(),
    ];

    void onTap(int index) {
      if (selectedIndex.value == index) return;
      selectedIndex.value = index;
      HapticFeedback.lightImpact();
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // Back from any other tab first returns to home; only a second back
        // press (now on home) asks for exit confirmation.
        if (selectedIndex.value != 0) {
          selectedIndex.value = 0;
          return;
        }

        final confirmed = await AppNotify.confirm(
          title: 'main.dialog.exit.title'.tr(),
          message: 'main.dialog.exit.message'.tr(),
          confirmText: 'main.dialog.exit.button'.tr(),
          cancelText: 'buttons.cancel'.tr(),
        );
        if (confirmed) SystemNavigator.pop();
      },
      child: Stack(
        children: [
          Scaffold(
            // Fades + slides the incoming page in on every tab switch while
            // keeping IndexedStack's state preservation. See _NavPages.
            body: _NavPages(selectedIndex: selectedIndex, pages: pages),
            bottomNavigationBar: _PremiumBottomNav(
              selectedIndex: selectedIndex,
              onTap: onTap,
              colorScheme: colorScheme,
              theme: theme,
              isLoading: isNavLocked,
            ),
          ),
          // Floating centre action overlaid above the bar. It deliberately
          // lives OUTSIDE the Scaffold's bottomNavigationBar slot: the bar
          // itself stays 60.h so it doesn't inflate the nav height, while this
          // overlay's taller box lets the raised disc rise above the bar AND
          // stay fully tappable (its own hit box covers the disc). The disc
          // sits over the middle nav slot; taps either side pass through.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _CenterNavOverlay(
              isLoading: isNavLocked,
              colorScheme: colorScheme,
              theme: theme,
              onTap: () {
                HapticFeedback.lightImpact();
                context.router.push(const RateCalculatorRoute());
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Hosts the four tab pages in an [IndexedStack] (so their state — scroll
/// offsets, form input, in-flight BLoC work — survives tab switches) and plays
/// a full bottom-to-top linear slide on the page that comes into view.
///
/// Transform-only, no opacity fade: the incoming page is fully opaque and
/// slides straight up from the bottom edge, so the motion reads identically on
/// both the light and dark themes.
///
/// High-performance by construction:
/// - The [IndexedStack] is passed as the [SlideTransition]'s `child`, so it is
///   built exactly once per switch; the animation only *repaints* the already
///   laid-out page, never rebuilding any tab's widget tree.
/// - [SlideTransition] applies a paint-time transform only (no compositing
///   layer), and at rest (offset 0) it short-circuits to nothing, so the steady
///   state costs nothing extra.
/// - A [RepaintBoundary] keeps the animating page off the nav bar's layer.
class _NavPages extends HookWidget {
  final ValueNotifier<int> selectedIndex;
  final List<Widget> pages;

  const _NavPages({required this.selectedIndex, required this.pages});

  @override
  Widget build(BuildContext context) {
    // initialValue: 1 → the first tab is already fully settled on mount, so
    // there's no entrance animation on cold start.
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 120),
      initialValue: 1,
    );

    // Local mirror of the selected index. Advancing it here (rather than
    // reading the notifier in an inline builder) lets us fire the entrance
    // animation exactly on change.
    final currentIndex = useState(selectedIndex.value);

    // Every tab the user has opened so far — the set of pages that may be
    // built. Seeded with the initial tab and only ever added to, so a tab stays
    // alive (and keeps its state) once shown. A ref, not state: it is updated
    // during the build that `currentIndex` already triggered.
    final visitedTabs = useRef(<int>{selectedIndex.value});
    visitedTabs.value.add(currentIndex.value);

    useEffect(() {
      void onChange() {
        final next = selectedIndex.value;
        if (next == currentIndex.value) return;
        currentIndex.value = next;
        controller.forward(from: 0);
      }

      selectedIndex.addListener(onChange);
      return () => selectedIndex.removeListener(onChange);
    }, [selectedIndex]);

    return RepaintBoundary(
      child: SlideTransition(
        // Full bottom-to-top slide: the incoming page starts one full screen
        // below (Offset dy 1.0) and rises straight up into place. Driven by the
        // controller directly (no curve) so the motion is perfectly linear —
        // constant speed from bottom to top.
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(controller),
        child: IndexedStack(
          index: currentIndex.value,
          // Only tabs the user has actually opened are built. IndexedStack
          // *builds* every child (it merely paints one), so passing all four
          // pages mounted BeneficiaryPage, SettingsPage and SupportPage in the
          // same frame as HomePage — each firing its own load API, four
          // concurrent authenticated requests on a fresh session, which the
          // backend answers with 500s and home renders as its full-screen
          // retry. A visited tab is never dropped from the set, so the
          // state-preservation IndexedStack is used for (scroll offsets, form
          // input, in-flight BLoC work) is unchanged once a tab has been shown;
          // an unvisited tab simply fetches on its first open instead of at
          // login. The list keeps its length and order so `index` still lines
          // up with the nav items.
          children: [
            for (var i = 0; i < pages.length; i++)
              if (visitedTabs.value.contains(i))
                // A hidden tab stays mounted, so its BLoC listeners keep
                // firing: a response that lands after the user has switched
                // tabs would otherwise push its destination on top of the tab
                // they moved to. This marker tells the navigation guard which
                // tab is actually on screen — see app_navigation_guard.dart.
                AppScreenVisibility(
                  activeIndex: selectedIndex,
                  index: i,
                  child: pages[i],
                )
              else
                const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _PremiumBottomNav extends StatelessWidget {
  final ValueNotifier<int> selectedIndex;
  final void Function(int) onTap;
  final ColorScheme colorScheme;
  final ThemeData theme;
  final bool isLoading;

  const _PremiumBottomNav({
    required this.selectedIndex,
    required this.onTap,
    required this.colorScheme,
    required this.theme,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    // Reading context.locale registers this StatelessWidget as a direct
    // dependent of EasyLocalizationProvider. When the locale changes,
    // Flutter calls markNeedsBuild() here, so build() fires and the
    // .tr() calls below return the correct translated tab labels.
    context.locale;
    final items = [
      _NavItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: 'main.tabs.home'.tr(),
      ),
      _NavItem(
        icon: Icons.account_balance_wallet_outlined,
        activeIcon: Icons.account_balance_wallet_rounded,
        label: 'main.tabs.beneficiaries'.tr(),
      ),
      _NavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label: 'main.tabs.settings'.tr(),
      ),
      _NavItem(
        icon: Icons.headset_mic_outlined,
        activeIcon: Icons.headset_mic_rounded,
        label: 'main.tabs.support'.tr(),
      ),
    ];

    // Bar-only: fixed 60.h + bottom safe area, so it reserves no more height
    // than a plain nav bar. The raised centre action is drawn by a separate
    // overlay (_CenterNavOverlay) stacked over the Scaffold, so its disc can
    // rise above this bar without inflating the nav's height. The centre slot
    // here is left empty for that overlay to sit over.
    return Container(
      // surfaceContainerHighest == brandSurface — a flat, borderless bar.
      decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60.h,
          // Two tabs, an empty slot under the centre action, then two tabs.
          child: Row(
            children: [
              Expanded(child: _buildTab(items, 0)),
              Expanded(child: _buildTab(items, 1)),
              const Expanded(child: SizedBox()),
              Expanded(child: _buildTab(items, 2)),
              Expanded(child: _buildTab(items, 3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(List<_NavItem> items, int i) {
    // While home is loading, each tab is a shimmer placeholder with no gesture
    // target, so switching tabs mid-load is impossible.
    if (isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppShimmer(
            width: 22,
            height: 22,
            borderRadius: BorderRadius.circular(11.r),
          ),
          SizedBox(height: 6.h),
          const AppShimmer(width: 38, height: 8),
        ],
      );
    }

    final item = items[i];

    // Each tab subscribes to the shared notifier directly, so a tap rebuilds
    // only these four lightweight tab subtrees — never MainPage, the bar
    // chrome, or the center action. The GestureDetector wraps the builder so
    // the hit target itself is set up once and survives selection changes.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(i),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, current, _) => _buildTabContent(item, current == i),
      ),
    );
  }

  Widget _buildTabContent(_NavItem item, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              isSelected ? item.activeIcon : item.icon,
              key: ValueKey(isSelected),
              size: 22.sp,
              color: isSelected
                  ? colorScheme.tertiary
                  : colorScheme.onSurface.withAlpha(100),
            ),
          ),
          SizedBox(height: 4.h),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: theme.textTheme.labelSmall!.copyWith(
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? colorScheme.tertiary
                  : colorScheme.onSurface.withAlpha(100),
            ),
            child: Text(
              item.label,
              maxLines: 1,
              style: theme.textTheme.labelSmall!.copyWith(
                fontSize: 10.sp,
                overflow: TextOverflow.ellipsis,
                color: isSelected
                    ? colorScheme.tertiary
                    : colorScheme.onSurface.withAlpha(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The raised centre action, overlaid over the bottom nav (not inside it) so
/// its disc can rise above the bar without adding to the nav's height.
///
/// It aligns to the middle of the five nav slots via Spacer/Expanded/Spacer
/// flexes and occupies a box taller than the bar (bar height + a lift region).
/// The disc is centred in that box so it straddles the bar's top edge — the
/// same raised look as before — but now its full extent is inside a real hit
/// target, so the whole disc (top included) is tappable. Taps to either side
/// of the centre fifth fall through to the bar's tabs.
class _CenterNavOverlay extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _CenterNavOverlay({
    required this.isLoading,
    required this.onTap,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    // Locale dependency so the label re-translates on a language switch.
    context.locale;

    // Bar height (matches _PremiumBottomNav) plus the lift region the disc
    // rises into. The box sits above the bottom safe-area inset, exactly like
    // the bar's content, so the disc lines up with the bar's top edge.
    final content = isLoading
        ? Center(
            child: AppShimmer(
              width: 44,
              height: 44,
              borderRadius: BorderRadius.circular(22.r),
            ),
          )
        : _CenterActionButton(
            onTap: onTap,
            label: 'main.tabs.rateCalculator'.tr(),
            colorScheme: colorScheme,
            theme: theme,
          );

    return SafeArea(
      top: false,
      child: SizedBox(
        height: 60.h + 24.h,
        child: Row(
          children: [
            const Spacer(flex: 2),
            Expanded(flex: 1, child: content),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

/// The raised rate-converter action anchored at the centre of the bottom nav.
/// A hook widget (not part of the stateless bar) so it can own its own
/// press-scale animation without rebuilding the whole nav on every tap-down.
class _CenterActionButton extends HookWidget {
  final VoidCallback onTap;
  final String label;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _CenterActionButton({
    required this.onTap,
    required this.label,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    // A raw ValueNotifier (not useState) so a press toggles ONLY the disc via
    // the ValueListenableBuilder below — the label and layout never rebuild.
    final isPressed = useMemoized(() => ValueNotifier(false));
    useEffect(() => isPressed.dispose, [isPressed]);

    final accent = context.appColors.brandFill;

    // The disc is built exactly once and handed to the ValueListenableBuilder
    // as its `child`, so the press animation only re-wraps it in AnimatedScale
    // — the gradient, shadows and icon are never re-laid-out on tap.
    final disc = _buildDisc(context, accent);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) => isPressed.value = false,
      onTapCancel: () => isPressed.value = false,
      onTap: onTap,
      // Fill the whole centre slot (the raised lift region + the bar) so every
      // part of the floating action — including the disc protruding above the
      // bar line — is inside the hit target. The disc + label are centred in
      // that box: the disc lands over the bar's top edge (reading as a raised
      // coin punching up through the bar) with the label sitting in the bar.
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // RepaintBoundary isolates the disc's press-scale + soft glow onto
            // its own layer, so the shadow blur never repaints the nav bar.
            RepaintBoundary(
              child: ValueListenableBuilder<bool>(
                valueListenable: isPressed,
                child: disc,
                builder: (context, pressed, child) => AnimatedScale(
                  scale: pressed ? 0.9 : 1.0,
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.easeOut,
                  child: child,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            // Scale-to-fit so a longer label ("Rate Calculator") stays on one
            // legible line within the narrow nav slot instead of ellipsizing.
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall!.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The lifted "coin". Built once per rebuild and reused across press frames.
  Widget _buildDisc(BuildContext context, Color accent) {
    // Halo ring in the bar colour separates the disc from whatever sits behind
    // it, so the lift reads as punching up through the bar (a floating notch).
    final barColor = colorScheme.surfaceContainerHighest;

    return Container(
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(shape: BoxShape.circle, color: barColor),
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Vertical gradient — a lighter top edge reads as a soft top-lit
          // highlight, giving the disc a raised, tactile feel.
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.lerp(accent, Colors.white, 0.12)!, accent],
          ),
          // Thin light rim for a premium "coin" edge.
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.22),
            width: 1,
          ),
        ),
        // Calculator mark — the action opens the standalone rate calculator,
        // so the glyph names the tool directly.
        child: _RateCalculatorIcon(
          color: context.appColors.onBrandFill,
          size: 34.sp,
        ),
      ),
    );
  }
}

/// Rate-calculator mark: a calculator glyph, centred on the gold/green disc.
/// Kept at the same optical size as the previous mark so the disc layout is
/// unchanged.
class _RateCalculatorIcon extends StatelessWidget {
  final Color color;
  final double size;

  const _RateCalculatorIcon({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Icon(
          Icons.calculate_rounded,
          size: size * 0.92,
          color: color,
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
