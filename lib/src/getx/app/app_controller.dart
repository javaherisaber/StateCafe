import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_cafe/themes/locale.dart';

class AppController extends GetxController {
  final locale = appInitialLocale.obs;
  final shouldRestart = false.obs;

  void changeLocale(Locale newLocale) async {
    await AppLocale.setCurrentLocale(newLocale);
    locale.value = newLocale;
    shouldRestart.value = true;
  }

  void consumeRestart() {
    shouldRestart.value = false;
  }
}
