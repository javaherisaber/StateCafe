import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/l10n/app_localizations.dart';
import 'package:state_cafe/main.dart';
import 'package:state_cafe/src/riverpod/providers.dart';
import 'package:state_cafe/src/riverpod/routes.dart';
import 'package:state_cafe/themes/locale.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);

    ref.listen<AppState>(appProvider, (previous, next) {
      if (next.shouldRestart) {
        ref.read(appProvider.notifier).consumeRestart();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(
            navigatorKey.currentContext!,
            RiverpodRoutes.splash,
            ModalRoute.withName(RiverpodRoutes.splash),
          );
        });
      }
    });

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocale.supportedLocales,
      locale: appState.locale,
      initialRoute: RiverpodRoutes.initialRoute,
      navigatorObservers: [LifecycleAwareState.routeObserver],
      routes: RiverpodRoutes.all,
    );
  }
}
