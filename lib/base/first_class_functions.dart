import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:state_cafe/extensions/build_context.dart';
import 'package:state_cafe/main.dart';

/// When there is no functionality for a given action eg. noOp
void doNothing([dynamic]) {}

/// Use this when you just want to track which places to implement later
@Deprecated('Implement your own code here')
void notImplemented({String? message}) {
  debugPrint(message ?? 'Not implemented functionality');
}

/// Uses this when you want to inform yourself about important functionality to be implemented
@Deprecated('Implement your own code here')
void shouldImplement({String? message}) {
  error('This should be implemented');
}

/// Run your operation with Kotlin run equivalent
T run<T>(T Function() operation) => operation();

/// Runtime exception when an error occurs
dynamic error([message]) {
  throw (message ?? 'Exception with no message');
}

/// Get string from translation files
AppLocalizations get tr {
  BuildContext? context = navigatorKey.currentContext;
  if (context == null) {
    throw 'Cannot access to build context';
  } else {
    return context.intl;
  }
}

/// Typography for textStyle used in [Text] widget
TextTheme get tp {
  BuildContext? context = navigatorKey.currentContext;
  if (context == null) {
    throw 'Cannot access to build context';
  } else {
    return Theme.of(context).textTheme;
  }
}
