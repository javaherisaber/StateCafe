import 'package:flutter/material.dart';
import 'package:state_cafe/src/riverpod/screens/home/home.dart';
import 'package:state_cafe/src/riverpod/screens/login/login.dart';
import 'package:state_cafe/src/riverpod/screens/settings/settings.dart';
import 'package:state_cafe/src/riverpod/screens/splash/splash.dart';

abstract class RiverpodRoutes {
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
