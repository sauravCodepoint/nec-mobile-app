import 'package:auto_route/auto_route.dart';
import 'app_routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.cupertino();

  /// How long after a push the same destination is treated as a repeat of the
  /// same tap rather than a fresh intent. Long enough to swallow a double-tap
  /// (and the second of two listeners reacting to one result), short enough
  /// that deliberately re-opening the same kind of screen still works.
  static const Duration _duplicatePushWindow = Duration(milliseconds: 700);

  DateTime? _lastPushedAt;
  String? _lastPushedName;

  /// Drops a push that would stack a second copy of the page already on top,
  /// moments after the first one.
  ///
  /// Nothing in the app blocks input during the frames a route takes to come
  /// in, so an impatient double-tap — or two screens reacting to the same
  /// one-shot BLoC result — pushes the destination twice and leaves the user
  /// backing out through a duplicate. This is the stack-level companion to
  /// [AppNavigationGuardX.isScreenActive] (`app_navigation_guard.dart`), which
  /// stops the other half of the problem: a screen navigating after the user
  /// has already moved on.
  ///
  /// Only `push` is filtered. `replace`, `popAndPush`, `navigate` and
  /// `replaceAll` each define the resulting stack outright, so repeating one
  /// cannot pile up pages.
  @override
  Future<T?> push<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) {
    final now = DateTime.now();
    final lastPushedAt = _lastPushedAt;
    final isRepeatOfTopPage =
        route.routeName == _lastPushedName &&
        lastPushedAt != null &&
        now.difference(lastPushedAt) < _duplicatePushWindow &&
        topRoute.name == route.routeName;
    if (isRepeatOfTopPage) return Future<T?>.value();

    _lastPushedName = route.routeName;
    _lastPushedAt = now;
    return super.push<T>(route, onFailure: onFailure);
  }

  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, page: SplashRoute.page),

    AutoRoute(page: OnBoardingRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: LoginContactUsView.page),
    AutoRoute(page: OtpRoute.page),

    AutoRoute(page: UpdateKycRoute.page),

    AutoRoute(page: MemberApprovalRoute.page),
    AutoRoute(page: CompleteProfileRoute.page),

    AutoRoute(page: SetMpinRoute.page),
    AutoRoute(page: SetVerifyMpinView.page),

    AutoRoute(page: BioMetricRoute.page),

    AutoRoute(page: HomeBeneficiaryView.page),

    AutoRoute(page: MainRoute.page),
    AutoRoute(page: RateCalculatorRoute.page),

    AutoRoute(page: ForgotMpinRoute.page),
    AutoRoute(page: ForgotOtpView.page),

    AutoRoute(page: HomeEmailView.page),
    AutoRoute(page: HomeEmailOtpView.page),

    AutoRoute(page: SupportRoute.page),

    AutoRoute(page: SummaryRoute.page),

    AutoRoute(page: TransactionHistoryRoute.page),
    AutoRoute(page: BranchesRoute.page),

    AutoRoute(page: BeneficiaryRoute.page),
    AutoRoute(page: BeneficiaryAddForm.page),
    AutoRoute(page: BeneficiaryEditForm.page),
    AutoRoute(page: BeneficiaryOtpView.page),

    AutoRoute(page: MpinRoute.page),

    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: ProfileEmailView.page),
    AutoRoute(page: ProfileEmailOtpView.page),

    AutoRoute(page: NotificationRoute.page),
    AutoRoute(page: NotificationDetailView.page),

    AutoRoute(page: ChangeCurrentMpinRoute.page),
    AutoRoute(page: ChangeNewMpinView.page),
    AutoRoute(page: ChangeVerifyMpinView.page),

    AutoRoute(page: CompanyInfoRoute.page),

    AutoRoute(page: AppSelectableRoute.page, fullscreenDialog: true),
    AutoRoute(page: AppPaymentMethodRoute.page, fullscreenDialog: true),
    AutoRoute(page: AppPaymentResultRoute.page, fullscreenDialog: true),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
