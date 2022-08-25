import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc {
  final _themeLocale = BehaviorSubject<Locale>();

  Stream<Locale> get themeLocale => _themeLocale.stream;

  Function(Locale) get changeThemeLocale => _themeLocale.sink.add;

  void dispose() {
    _themeLocale.close();
  }
}