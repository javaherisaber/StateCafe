import 'package:flutter/material.dart';

import 'rx/screens/home/home.dart';
import 'rx/screens/splash/splash.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
final RouteObserver<PageRoute> routeObserver = RouteObserver();

abstract class Routes {
  static const home = '/home';
  static const splash = '/splash';

  static const initialRoute = splash;

  static final all = <String, WidgetBuilder>{
    home: (context) => const HomePage(),
    splash: (context) => const SplashPage(),
  };
}