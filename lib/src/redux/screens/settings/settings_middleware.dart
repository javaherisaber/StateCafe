import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_cafe/data/sharedpreferences.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/screens/settings/settings_actions.dart';

ThunkAction<AppState> settingsInitThunk() {
  return (Store<AppState> store) async {
    final preferred = await AppSharedPreferences.preferredDrink;
    store.dispatch(SettingsPreferredDrinkLoadedAction(preferred));
  };
}

ThunkAction<AppState> settingsPreferredDrinkThunk(String newValue) {
  return (Store<AppState> store) async {
    await AppSharedPreferences.setPreferredDrink(newValue);
    store.dispatch(SettingsPreferredDrinkChangedAction(newValue));
  };
}

ThunkAction<AppState> settingsLogoutConfirmedThunk() {
  return (Store<AppState> store) async {
    await AppSharedPreferences.setIsLoggedIn(false);
    store.dispatch(SettingsNavigateToLoginAction());
  };
}
