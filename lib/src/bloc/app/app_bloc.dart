import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:bloc/bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppInitial()) {
    on<AppLocaleRetrieved>(_onLocaleRetrieved);
    on<AppLocaleChanged>(_onLocaleChanged);
  }

  void _onLocaleRetrieved(AppLocaleRetrieved event, Emitter<AppState> emit) {
    emit(AppLocaleReady(event.locale));
  }

  void _onLocaleChanged(AppLocaleChanged event, Emitter<AppState> emit) async {
    await AppLocale.setCurrentLocale(event.locale);
    emit(AppLocaleReady(event.locale));
    emit(AppRestart(state.locale));
  }
}