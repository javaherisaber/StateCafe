import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/l10n/app_localizations.dart';
import 'package:state_cafe/main.dart';
import 'package:state_cafe/src/getx/app/app_controller.dart';
import 'package:state_cafe/src/getx/routes.dart';
import 'package:state_cafe/themes/locale.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<AppController>();
    ever(_controller.shouldRestart, (shouldRestart) {
      if (shouldRestart) {
        _controller.consumeRestart();
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          GetXRoutes.splash,
          ModalRoute.withName(GetXRoutes.splash),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocale.supportedLocales,
        locale: _controller.locale.value,
        initialRoute: GetXRoutes.initialRoute,
        navigatorObservers: [LifecycleAwareState.routeObserver],
        routes: GetXRoutes.all,
      );
    });
  }
}
