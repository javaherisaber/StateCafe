import 'dart:async';

import 'package:flutter/material.dart';
import 'package:live_event/live_event.dart';

class SettingsBloc {
  final _showLogoutAlert = LiveEvent();
  final _navigateToLoginPage = LiveEvent();
  final _restartApp = LiveEvent();
  final _updateThemeLocale = StreamController<Locale>();

  Stream get showLogoutAlert => _showLogoutAlert.stream;
  Stream get navigateToLoginPage => _navigateToLoginPage.stream;
  Stream get restartApp => _restartApp.stream;
  Stream<Locale> get updateThemeLocale => _updateThemeLocale.stream;

  void onLogoutClick() {
    _showLogoutAlert.fire();
  }

  void onLogoutAlertPositiveClick() {
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