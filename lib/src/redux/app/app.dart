import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/l10n/app_localizations.dart';
import 'package:state_cafe/main.dart';
import 'package:state_cafe/src/redux/app/app_actions.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/routes.dart';
import 'package:state_cafe/themes/locale.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onDidChange: (previous, current) {
        if (current.shouldRestart) {
          StoreProvider.of<AppState>(navigatorKey.currentContext!).dispatch(ConsumeRestartAction());
          Navigator.pushNamedAndRemoveUntil(
            navigatorKey.currentContext!,
            ReduxRoutes.splash,
            ModalRoute.withName(ReduxRoutes.splash),
          );
        }
      },
      builder: (context, appState) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocale.supportedLocales,
          locale: appState.locale,
          initialRoute: ReduxRoutes.initialRoute,
          navigatorObservers: [LifecycleAwareState.routeObserver],
          routes: ReduxRoutes.all,
        );
      },
    );
  }
}
