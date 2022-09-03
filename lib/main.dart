import 'package:flutter/material.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/src/bloc/entry_point.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  LifecycleAwareState.logSuffixedClassesOnly = true;
  runApp(await runBlocEntry());
}