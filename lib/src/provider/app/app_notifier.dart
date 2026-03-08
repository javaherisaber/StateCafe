import 'package:flutter/material.dart';
import 'package:state_cafe/themes/locale.dart';

class AppNotifier extends ChangeNotifier {
  Locale _locale = appInitialLocale;
  bool _shouldRestart = false;

  Locale get locale => _locale;
  bool get shouldRestart => _shouldRestart;

  void changeLocale(Locale locale) async {
    await AppLocale.setCurrentLocale(locale);
    _locale = locale;
    _shouldRestart = true;
    notifyListeners();
  }

  void consumeRestart() {
    _shouldRestart = false;
  }
}
