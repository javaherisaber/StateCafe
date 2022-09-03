import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsInitial()) {
    _initializePreferredDrink();
    on<SettingsPreferredDrinkChanged>(_onPreferredDrinkChanged);
    on<SettingsLogoutClicked>(_onLogoutClicked);
    on<SettingsLogoutConfirmed>(_onLogoutConfirmed);
  }

  void _initializePreferredDrink() async {
    add(SettingsPreferredDrinkChanged(await AppSharedPreferences.preferredDrink));
  }

  void _onPreferredDrinkChanged(SettingsPreferredDrinkChanged event, Emitter<SettingsState> emit) {
    AppSharedPreferences.setPreferredDrink(event.newPreferredDrink);
    emit(SettingsPreferredDrinkReady(event.newPreferredDrink));
  }

  void _onLogoutClicked(SettingsLogoutClicked event, Emitter<SettingsState> emit) {
    emit(SettingsLogoutAlertShown(state.preferredDrink));
  }

  void _onLogoutConfirmed(SettingsLogoutConfirmed event, Emitter<SettingsState> emit) {
    AppSharedPreferences.setIsLoggedIn(false);
    emit(SettingNavigateToLogin(state.preferredDrink));
  }
}