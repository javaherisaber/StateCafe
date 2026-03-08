import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_cafe/src/redux/app/app.dart';
import 'package:state_cafe/src/redux/app/app_reducer.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/themes/locale.dart';

Future<Widget> runReduxEntry() async {
  await AppLocale.initialize();

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  );

  return StoreProvider<AppState>(
    store: store,
    child: const App(),
  );
}
