import 'package:flutter/material.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/src/rx/app/app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() {
  LifecycleAwareState.logSuffixedClassesOnly = true;
  runApp(const App());
}