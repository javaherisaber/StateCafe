import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:state_cafe/themes/locale.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  Locale locale = appInitialLocale;

  @observable
  bool shouldRestart = false;

  @action
  Future<void> changeLocale(Locale newLocale) async {
    await AppLocale.setCurrentLocale(newLocale);
    locale = newLocale;
    shouldRestart = true;
  }

  @action
  void consumeRestart() {
    shouldRestart = false;
  }
}
