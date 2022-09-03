import 'dart:async';

import 'package:flutter/material.dart';
import 'package:live_event/live_event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class SettingsBloc {
  SettingsBloc() {
    _initializePreferredDrink();
  }

  final _showLogoutAlert = LiveEvent();
  final _navigateToLoginPage = LiveEvent();
  final _restartApp = LiveEvent();
  final _updateThemeLocale = StreamController<Locale>();
  final _preferredDrink = BehaviorSubject<String>();

  Stream get showLogoutAlert => _showLogoutAlert.stream;
  Stream get navigateToLoginPage => _navigateToLoginPage.stream;
  Stream get restartApp => _restartApp.stream;
  Stream<Locale> get updateThemeLocale => _updateThemeLocale.stream;
  Stream<String> get preferredDrink => _preferredDrink.stream;

  void _initializePreferredDrink() async {
    _preferredDrink.value = await AppSharedPreferences.preferredDrink;
  }

  void onPreferredDrinkChanged(String newValue) async {
    AppSharedPreferences.setPreferredDrink(newValue);
    _preferredDrink.value = newValue;
  }

  void onLogoutClick() {
    _showLogoutAlert.fire();
  }

  void onLogoutAlertPositiveClick() {
    AppSharedPreferences.setIsLoggedIn(false);
    _navigateToLoginPage.fire();
  }

  void onLanguageClick(Locale locale) {
    _updateThemeLocale.sink.add(locale);
    _restartApp.fire();
  }

  void dispose() {
    _showLogoutAlert.close();
    _navigateToLoginPage.close();
    _restartApp.close();
    _updateThemeLocale.close();
  }
}