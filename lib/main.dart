import 'package:flutter/material.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/rx/app/app.dart';

void main() {
  LifecycleAwareState.logSuffixedClassesOnly = true;
  runApp(const App());
}