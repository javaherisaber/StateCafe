import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/main.dart';
import 'package:state_cafe/src/bloc/routes.dart';
import 'package:state_cafe/themes/locale.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return app(AppLocale.defaultLocale);
  }

  Widget app(Locale locale) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocale.supportedLocales,
      locale: locale,
      initialRoute: BlocRoutes.initialRoute,
      navigatorObservers: [LifecycleAwareState.routeObserver],
      routes: BlocRoutes.all,
    );
  }
}
