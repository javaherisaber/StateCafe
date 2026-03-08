import 'package:flutter/material.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:provider/provider.dart';
import 'package:state_cafe/l10n/app_localizations.dart';
import 'package:state_cafe/main.dart';
import 'package:state_cafe/src/provider/app/app_notifier.dart';
import 'package:state_cafe/src/provider/routes.dart';
import 'package:state_cafe/themes/locale.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (context, appNotifier, _) {
        if (appNotifier.shouldRestart) {
          appNotifier.consumeRestart();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
              navigatorKey.currentContext!,
              ProviderRoutes.splash,
              ModalRoute.withName(ProviderRoutes.splash),
            );
          });
        }
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocale.supportedLocales,
          locale: appNotifier.locale,
          initialRoute: ProviderRoutes.initialRoute,
          navigatorObservers: [LifecycleAwareState.routeObserver],
          routes: ProviderRoutes.all,
        );
      },
    );
  }
}
