import 'package:flutter/material.dart';

class ChangeLocaleAction {
  final Locale locale;
  const ChangeLocaleAction(this.locale);
}

class LocaleChangedAction {
  final Locale locale;
  const LocaleChangedAction(this.locale);
}

class ConsumeRestartAction {}
