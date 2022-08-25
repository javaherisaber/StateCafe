import 'package:flutter/material.dart';
import 'bloc.dart';

export 'bloc.dart';

class AppProvider extends InheritedWidget {
  final AppBloc bloc;

  const AppProvider(this.bloc, {super.key, required super.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>()!.bloc;
  }
}