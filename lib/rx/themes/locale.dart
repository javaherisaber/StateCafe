import 'package:flutter/material.dart';

Locale appInitialLocale = AppLocale.defaultLocale; // initial locale before app loads

abstract class AppLocale {
  static const en = Locale('en');
  static const fa = Locale('fa');

  static const defaultLocale = en;
  static const supportedLocales = [
    fa,
    en,
  ];
}
