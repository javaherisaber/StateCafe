import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:state_cafe/extensions/object.dart';

extension ContextExtensions on BuildContext {
  /// Localized strings of project
  AppLocalizations get intl => AppLocalizations.of(this).errorIfNull('l10n is not initialized');

  /// Typography for textStyle used in [Text] widget
  TextTheme get typography => Theme.of(this).textTheme;

  /// Required arguments received between two Navigation destination
  Object get requiredArguments => modalRoute.settings.arguments.errorIfNull('Argument required');

  /// Optional arguments received between two Navigation destination
  Object? get optionalArguments => modalRoute.settings.arguments;

  ModalRoute get modalRoute {
    return ModalRoute.of(this).errorIfNull('Given context is not associated with a modal route');
  }

  bool get keyboardIsOpened => MediaQuery.of(this).viewInsets.bottom != 0.0;

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Navigation route name
  String? get routeName => ModalRoute.of(this)?.settings.name;
}
