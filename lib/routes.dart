import 'package:flutter/material.dart';
import 'package:state_cafe/rx/screens/login/login.dart';
import 'package:state_cafe/rx/screens/settings/settings.dart';

import 'rx/screens/home/home.dart';
import 'rx/screens/splash/splash.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
final RouteObserver<PageRoute> routeObserver = RouteObserver();

abstract class Routes {
  static const home = '/home';
  static const splash = '/splash';
  static const settings = '/settings';
  static const login = '/login';

  static const initialRoute = splash;

  static final all = <String, WidgetBuilder>{
    home: (context) => const HomePage(),
    splash: (context) => const SplashPage(),
    settings: (context) => const SettingsPage(),
    login: (context) => const LoginPage(),
  };
}