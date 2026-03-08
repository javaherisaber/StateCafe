import 'package:flutter/material.dart';
import 'package:state_cafe/src/redux/screens/home/home_state.dart';
import 'package:state_cafe/src/redux/screens/login/login_state.dart';
import 'package:state_cafe/src/redux/screens/settings/settings_state.dart';
import 'package:state_cafe/src/redux/screens/splash/splash_state.dart';
import 'package:state_cafe/themes/locale.dart';

class AppState {
  final Locale locale;
  final bool shouldRestart;
  final SplashState splashState;
  final LoginState loginState;
  final HomeState homeState;
  final SettingsState settingsState;

  const AppState({
    required this.locale,
    this.shouldRestart = false,
    this.splashState = const SplashState(),
    this.loginState = const LoginState(),
    this.homeState = const HomeState(),
    this.settingsState = const SettingsState(),
  });

  factory AppState.initial() {
    return AppState(locale: appInitialLocale);
  }

  AppState copyWith({
    Locale? locale,
    bool? shouldRestart,
    SplashState? splashState,
    LoginState? loginState,
    HomeState? homeState,
    SettingsState? settingsState,
  }) {
    return AppState(
      locale: locale ?? this.locale,
      shouldRestart: shouldRestart ?? this.shouldRestart,
      splashState: splashState ?? this.splashState,
      loginState: loginState ?? this.loginState,
      homeState: homeState ?? this.homeState,
      settingsState: settingsState ?? this.settingsState,
    );
  }
}
