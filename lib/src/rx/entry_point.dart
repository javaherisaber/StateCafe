import 'package:flutter/material.dart';
import 'package:state_cafe/src/rx/app/app.dart';
import 'package:state_cafe/themes/locale.dart';

Future<Widget> runRxEntry() async {
  await AppLocale.initialize();
  return const App();
}