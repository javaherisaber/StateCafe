import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/main.dart';
import 'package:state_cafe/src/bloc/app/app_bloc.dart';
import 'package:state_cafe/src/bloc/routes.dart';
import 'package:state_cafe/themes/locale.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppRestart) {
          Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, BlocRoutes.splash, ModalRoute.withName(BlocRoutes.splash));
        }
      },
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocale.supportedLocales,
          locale: state.locale,
          initialRoute: BlocRoutes.initialRoute,
          navigatorObservers: [LifecycleAwareState.routeObserver],
          routes: BlocRoutes.all,
        );
      },
    );
  }
}
