import 'package:flutter/material.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/l10n/app_localizations.dart';
import 'package:state_cafe/main.dart';
import 'package:state_cafe/src/getit/app/app_notifier.dart';
import 'package:state_cafe/src/getit/routes.dart';
import 'package:state_cafe/src/getit/service_locator.dart';
import 'package:state_cafe/themes/locale.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppNotifier _appNotifier;

  @override
  void initState() {
    super.initState();
    _appNotifier = getIt<AppNotifier>();
    _appNotifier.addListener(_onAppStateChanged);
  }

  @override
  void dispose() {
    _appNotifier.removeListener(_onAppStateChanged);
    super.dispose();
  }

  void _onAppStateChanged() {
    setState(() {});
    if (_appNotifier.shouldRestart) {
      _appNotifier.consumeRestart();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          GetItRoutes.splash,
          ModalRoute.withName(GetItRoutes.splash),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocale.supportedLocales,
      locale: _appNotifier.locale,
      initialRoute: GetItRoutes.initialRoute,
      navigatorObservers: [LifecycleAwareState.routeObserver],
      routes: GetItRoutes.all,
    );
  }
}
