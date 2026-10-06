import 'package:nec_mobile_app/presentation/routes/app_navigation_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Covers the half of the guard that does not need a router: a screen kept
/// mounted behind another tab is not active, which is the case the reported
/// bug hit — tapping "Send Again" on home, switching tab while the check was
/// in flight, and landing on the summary from the tab the user moved to.
void main() {
  late bool? active;

  /// A screen that records whether it may navigate, the way a BLoC listener
  /// would ask at the moment a response lands.
  Widget screen() => Builder(
    builder: (context) {
      active = context.isScreenActive;
      return const SizedBox();
    },
  );

  setUp(() => active = null);

  testWidgets('a screen with no visibility marker is active', (tester) async {
    await tester.pumpWidget(MaterialApp(home: screen()));
    expect(active, isTrue);
  });

  testWidgets('the showing tab is active, the hidden ones are not', (
    tester,
  ) async {
    final selectedIndex = ValueNotifier<int>(0);
    addTearDown(selectedIndex.dispose);

    Widget tab(int index) => AppScreenVisibility(
      activeIndex: selectedIndex,
      index: index,
      child: screen(),
    );

    await tester.pumpWidget(MaterialApp(home: tab(0)));
    expect(active, isTrue);

    await tester.pumpWidget(MaterialApp(home: tab(1)));
    expect(active, isFalse);
  });

  testWidgets('switching tab deactivates the tab left behind', (tester) async {
    final selectedIndex = ValueNotifier<int>(0);
    addTearDown(selectedIndex.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: AppScreenVisibility(
          activeIndex: selectedIndex,
          index: 0,
          child: screen(),
        ),
      ),
    );
    expect(active, isTrue);

    // The tab page stays mounted — only the host's selection moves — so the
    // answer has to be read live rather than captured when the page was built.
    selectedIndex.value = 1;
    final element = tester.element(find.byType(SizedBox));
    expect(element.isScreenActive, isFalse);
  });
}
