import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_cafe/src/riverpod/app/app.dart';
import 'package:state_cafe/themes/locale.dart';

Future<Widget> runRiverpodEntry() async {
  await AppLocale.initialize();
  return const ProviderScope(child: App());
}
