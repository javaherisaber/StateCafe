part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {
  const SettingsState(this.preferredDrink);

  final String preferredDrink;
}

class SettingsInitial extends SettingsState {
  const SettingsInitial() : super('coffee');
}

class SettingsPreferredDrinkReady extends SettingsState {
  const SettingsPreferredDrinkReady(super.preferredDrink);
}

class SettingsLogoutAlertShown extends SettingsState {
  const SettingsLogoutAlertShown(super.preferredDrink);
}

class SettingNavigateToLogin extends SettingsState {
  const SettingNavigateToLogin(super.preferredDrink);
}
