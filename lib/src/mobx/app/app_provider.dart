import 'package:flutter/material.dart';
import 'package:state_cafe/src/mobx/app/app_store.dart';

class MobXAppProvider extends InheritedWidget {
  final AppStore store;

  const MobXAppProvider({super.key, required this.store, required super.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppStore of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MobXAppProvider>()!.store;
  }
}
