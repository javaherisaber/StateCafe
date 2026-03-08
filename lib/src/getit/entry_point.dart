import 'package:flutter/material.dart';
import 'package:state_cafe/src/getit/app/app.dart';
import 'package:state_cafe/src/getit/service_locator.dart';
import 'package:state_cafe/themes/locale.dart';

Future<Widget> runGetItEntry() async {
  await AppLocale.initialize();
  setupServiceLocator();
  return const App();
}
