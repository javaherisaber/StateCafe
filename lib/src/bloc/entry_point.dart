import 'package:flutter/material.dart';
import 'package:state_cafe/src/bloc/app/app.dart';
import 'package:state_cafe/src/bloc/app/app_bloc.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<Widget> runBlocEntry() async {
  final appBloc = AppBloc();
  final locale = await AppLocale.initialize();
  appBloc.add(AppLocaleRetrieved(locale));
  return BlocProvider(
    create: (_) => appBloc,
    child: const App(),
  );
}
