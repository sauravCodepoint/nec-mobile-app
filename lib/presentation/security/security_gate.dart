import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/core/config/app_config.dart';
import '../../domain/core/di/injection.dart';
import '../../domain/security/security_threat.dart';
import '../../infrastructure/security/security_service.dart';
import 'security_blocked_screen.dart';

class SecurityGate extends HookWidget {
  final Widget child;

  const SecurityGate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Security scanning is a build-time toggle; when off the gate is inert and
    // simply renders the app. The flag never flips at runtime, so the hooks
    // below still run in a stable order every build.
    final enabled = AppConfig.securityGateEnabled;
    final threats = useState<Set<SecurityThreat>>(const {});

    final service = useMemoized(
      () => enabled ? getIt<SecurityService>() : null,
    );

    // Subscribe to the threat stream and start monitoring for the gate's life.
    useEffect(() {
      if (service == null) return null;
      final sub = service.threatStream.listen((t) => threats.value = t);
      service.startMonitoring();
      return sub.cancel;
    }, [service]);

    // Re-scan whenever the app returns to the foreground. Callback-based so it
    // never rebuilds this subtree (which wraps the whole app) on lifecycle
    // changes — only the threat stream drives rebuilds.
    useOnAppLifecycleStateChange((_, state) {
      if (state == AppLifecycleState.resumed) service?.runChecks();
    });

    if (enabled && threats.value.isNotEmpty) {
      // This screen renders ABOVE MaterialApp, so it sits outside the
      // Localizations scope MaterialApp installs — and that scope is what runs
      // easy_localization's delegate, populating the global singleton the
      // context-free `.tr()` reads. On a cold first launch the blocked screen
      // can replace MaterialApp before those translations ever load, leaving
      // `.tr()` to echo raw keys. Install a Localizations scope here (using the
      // delegates the EasyLocalization ancestor already exposes) so the strings
      // load regardless of MaterialApp.
      return Localizations(
        locale: context.locale,
        delegates: context.localizationDelegates,
        child: SecurityBlockedScreen(threats: threats.value),
      );
    }
    return child;
  }
}
