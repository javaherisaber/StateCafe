class SettingsState {
  final String preferredDrink;
  final bool shouldShowLogoutAlert;
  final bool shouldNavigateToLogin;

  const SettingsState({
    this.preferredDrink = 'coffee',
    this.shouldShowLogoutAlert = false,
    this.shouldNavigateToLogin = false,
  });

  SettingsState copyWith({
    String? preferredDrink,
    bool? shouldShowLogoutAlert,
    bool? shouldNavigateToLogin,
  }) {
    return SettingsState(
      preferredDrink: preferredDrink ?? this.preferredDrink,
      shouldShowLogoutAlert: shouldShowLogoutAlert ?? this.shouldShowLogoutAlert,
      shouldNavigateToLogin: shouldNavigateToLogin ?? this.shouldNavigateToLogin,
    );
  }
}
