import 'package:state_cafe/src/redux/screens/settings/settings_actions.dart';
import 'package:state_cafe/src/redux/screens/settings/settings_state.dart';

SettingsState settingsReducer(SettingsState state, dynamic action) {
  if (action is SettingsPreferredDrinkChangedAction) {
    return state.copyWith(preferredDrink: action.newPreferredDrink);
  }
  if (action is SettingsPreferredDrinkLoadedAction) {
    return state.copyWith(preferredDrink: action.preferredDrink);
  }
  if (action is SettingsLogoutClickAction) {
    return state.copyWith(shouldShowLogoutAlert: true);
  }
  if (action is SettingsConsumeLogoutAlertAction) {
    return state.copyWith(shouldShowLogoutAlert: false);
  }
  if (action is SettingsNavigateToLoginAction) {
    return state.copyWith(shouldNavigateToLogin: true);
  }
  if (action is SettingsConsumeNavigationAction) {
    return state.copyWith(shouldNavigateToLogin: false);
  }
  return state;
}
