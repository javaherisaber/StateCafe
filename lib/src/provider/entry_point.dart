import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_cafe/src/provider/app/app.dart';
import 'package:state_cafe/src/provider/app/app_notifier.dart';
import 'package:state_cafe/themes/locale.dart';

Future<Widget> runProviderEntry() async {
  await AppLocale.initialize();
  return ChangeNotifierProvider(
    create: (_) => AppNotifier(),
    child: const App(),
  );
}
