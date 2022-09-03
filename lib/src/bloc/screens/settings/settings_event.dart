part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsPreferredDrinkChanged extends SettingsEvent {
  const SettingsPreferredDrinkChanged(this.newPreferredDrink);

  final String newPreferredDrink;

  @override
  List<Object> get props => [newPreferredDrink];
}

class SettingsLogoutClicked extends SettingsEvent {
  const SettingsLogoutClicked();
}

class SettingsLogoutConfirmed extends SettingsEvent {
  const SettingsLogoutConfirmed();
}
