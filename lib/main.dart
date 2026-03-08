import 'package:flutter/material.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';
import 'package:state_cafe/src/bloc/entry_point.dart';
import 'package:state_cafe/src/rx/entry_point.dart';
import 'package:state_cafe/src/provider/entry_point.dart';
import 'package:state_cafe/src/getit/entry_point.dart';
import 'package:state_cafe/src/getx/entry_point.dart';
import 'package:state_cafe/src/riverpod/entry_point.dart';
import 'package:state_cafe/src/redux/entry_point.dart';
import 'package:state_cafe/src/mobx/entry_point.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

enum StateApproach { bloc, rx, provider, riverpod, redux, getit, getx, mobx }

const _currentApproach = StateApproach.bloc;

void main() async {
  LifecycleAwareState.logSuffixedClassesOnly = true;
  final app = switch (_currentApproach) {
    StateApproach.bloc => await runBlocEntry(),
    StateApproach.rx => await runRxEntry(),
    StateApproach.provider => await runProviderEntry(),
    StateApproach.riverpod => await runRiverpodEntry(),
    StateApproach.redux => await runReduxEntry(),
    StateApproach.getit => await runGetItEntry(),
    StateApproach.getx => await runGetXEntry(),
    StateApproach.mobx => await runMobXEntry(),
  };
  runApp(app);
}
