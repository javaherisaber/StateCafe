import 'package:flutter/material.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

Locale appInitialLocale = AppLocale.defaultLocale; // initial locale before app loads

abstract class AppLocale {
  static const en = Locale('en');
  static const fa = Locale('fa');

  static const defaultLocale = en;
  static const supportedLocales = [
    fa,
    en,
  ];

  /// Current locale of app at runtime
  static Future<Locale> get currentLocale async => Locale(await AppSharedPreferences.localeCode);

  static Future<Locale> initialize() async {
    appInitialLocale = await currentLocale;
    return appInitialLocale;
  }

  static Future<void> setCurrentLocale(Locale locale) async {
    appInitialLocale = locale;
    await AppSharedPreferences.setLocaleCode(locale.languageCode);
  }
}
