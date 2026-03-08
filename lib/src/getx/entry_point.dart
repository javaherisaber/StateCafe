import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_cafe/src/getx/app/app.dart';
import 'package:state_cafe/src/getx/app/app_controller.dart';
import 'package:state_cafe/themes/locale.dart';

Future<Widget> runGetXEntry() async {
  await AppLocale.initialize();
  Get.put(AppController());
  return const App();
}
