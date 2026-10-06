import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../application/company_info/company_info_bloc.dart';
import '../../domain/company_info/company_info_type.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/app_states/app_state_view.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/web_view/app_web_view.dart';
import 'widgets/company_info_shimmer_view.dart';

@RoutePage()
class CompanyInfoPage extends HookWidget {
  final CompanyInfoType companyInfoType;

  const CompanyInfoPage({super.key, required this.companyInfoType});

  // Convert a Flutter [Color] to a CSS `#rrggbb` string.
  static String _cssHex(Color color) =>
      '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

  @override
  Widget build(BuildContext context) {
    final webController = useMemoized(
      () => WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.transparent),
    );

    // The backend HTML paints its own dark card with light text; strip every
    // background so the AppScaffold gradient shows through, and force the theme's
    // primary text color so the copy stays readable in both light and dark themes
    // (otherwise the hard-coded light text is invisible on the light gradient).
    // Links (e.g. `mailto:` emails, phone numbers) sometimes appear in the
    // backend HTML — render them as plain, inert text: kill the tap target
    // (`pointer-events`) and strip the link styling so they read like copy.
    final injectedStyle =
        '<style>html, body, body * { background: transparent !important; '
        'color: ${_cssHex(Theme.of(context).colorScheme.onPrimary)} !important; }'
        'a { pointer-events: none !important; cursor: default !important; '
        'text-decoration: none !important; color: inherit !important; }</style>';

    useEffect(() {
      context.read<CompanyInfoBloc>().add(
        CompanyInfoEvent.getCompanyInfo(companyInfoType),
      );
      return null;
    }, const []);

    return BlocConsumer<CompanyInfoBloc, CompanyInfoState>(
      listenWhen: (_, current) =>
          current.companyInfoFailureOrSuccessOption.isSome(),
      listener: (_, state) => state.companyInfoFailureOrSuccessOption
          .flatMap((e) => e.toOption())
          .fold(() {}, (dto) {
            final html = dto.data ?? '';
            if (html.isNotEmpty) {
              webController.loadHtmlString('$html$injectedStyle');
            }
          }),
      buildWhen: (prev, current) =>
          prev.companyInfoFailureOrSuccessOption !=
          current.companyInfoFailureOrSuccessOption,
      builder: (context, state) => state.companyInfoFailureOrSuccessOption.fold(
        () => AppScaffold(
          appBar: AppAppBar(title: companyInfoType.titleKey.tr()),
          body: const CompanyInfoShimmerView(),
        ),
        (either) => either.fold(
          (_) => AppScaffold(
            appBar: AppAppBar(title: companyInfoType.titleKey.tr()),
            body: AppErrorView(
              title: 'companyInfo.loadError'.tr(),
              retryLabel: 'buttons.retry'.tr(),
              onRetry: () => context.read<CompanyInfoBloc>().add(
                CompanyInfoEvent.getCompanyInfo(companyInfoType),
              ),
            ),
          ),
          (_) => AppWebView(
            title: companyInfoType.titleKey.tr(),
            loading: false,
            controller: webController,
          ),
        ),
      ),
    );
  }
}
