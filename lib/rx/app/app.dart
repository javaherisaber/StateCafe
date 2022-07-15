import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/themes/locale.dart';

import '../../routes.dart';
import 'provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State createState() => _AppState();
}

class _AppState extends State<App> {
  late AppBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AppBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.themeLocale,
        builder: (context, AsyncSnapshot<Locale> snapshot) {
          final locale = snapshot.data ?? appInitialLocale;
          return app(locale);
        }
    );
  }

  Widget app(Locale locale) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocale.supportedLocales,
      locale: locale,
      initialRoute: Routes.initialRoute,
      navigatorObservers: [LifecycleAwareState.routeObserver],
      routes: Routes.all,
    );
  }
}
