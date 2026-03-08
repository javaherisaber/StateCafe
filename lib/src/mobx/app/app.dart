import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:mobx/mobx.dart';
import 'package:state_cafe/l10n/app_localizations.dart';
import 'package:state_cafe/main.dart';
import 'package:state_cafe/src/mobx/app/app_provider.dart';
import 'package:state_cafe/src/mobx/app/app_store.dart';
import 'package:state_cafe/src/mobx/routes.dart';
import 'package:state_cafe/themes/locale.dart';

class App extends StatefulWidget {
  final AppStore store;

  const App({super.key, required this.store});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ReactionDisposer _restartDisposer;

  @override
  void initState() {
    super.initState();
    _restartDisposer = reaction(
      (_) => widget.store.shouldRestart,
      (bool shouldRestart) {
        if (shouldRestart) {
          widget.store.consumeRestart();
          Navigator.pushNamedAndRemoveUntil(
            navigatorKey.currentContext!,
            MobXRoutes.splash,
            ModalRoute.withName(MobXRoutes.splash),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _restartDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobXAppProvider(
      store: widget.store,
      child: Observer(
        builder: (_) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocale.supportedLocales,
            locale: widget.store.locale,
            initialRoute: MobXRoutes.initialRoute,
            navigatorObservers: [LifecycleAwareState.routeObserver],
            routes: MobXRoutes.all,
          );
        },
      ),
    );
  }
}
