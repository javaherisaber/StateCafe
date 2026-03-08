class SettingsPreferredDrinkChangedAction {
  final String newPreferredDrink;
  const SettingsPreferredDrinkChangedAction(this.newPreferredDrink);
}

class SettingsPreferredDrinkLoadedAction {
  final String preferredDrink;
  const SettingsPreferredDrinkLoadedAction(this.preferredDrink);
}

class SettingsLogoutClickAction {}

class SettingsConsumeLogoutAlertAction {}

class SettingsLogoutConfirmedAction {}

class SettingsNavigateToLoginAction {}

class SettingsConsumeNavigationAction {}
