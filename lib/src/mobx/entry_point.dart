import 'package:flutter/material.dart';
import 'package:state_cafe/src/mobx/app/app.dart';
import 'package:state_cafe/src/mobx/app/app_store.dart';
import 'package:state_cafe/themes/locale.dart';

Future<Widget> runMobXEntry() async {
  await AppLocale.initialize();
  final appStore = AppStore();
  return App(store: appStore);
}
