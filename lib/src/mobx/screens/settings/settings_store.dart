import 'package:mobx/mobx.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

part 'settings_store.g.dart';

enum SettingsNavigation { none, showLogoutAlert, navigateToLogin }

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  _SettingsStore() {
    _initializePreferredDrink();
  }

  @observable
  String preferredDrink = 'coffee';

  @observable
  SettingsNavigation navigation = SettingsNavigation.none;

  void _initializePreferredDrink() async {
    final value = await AppSharedPreferences.preferredDrink;
    runInAction(() => preferredDrink = value);
  }

  @action
  void onPreferredDrinkChanged(String newValue) {
    AppSharedPreferences.setPreferredDrink(newValue);
    preferredDrink = newValue;
  }

  @action
  void onLogoutClick() {
    navigation = SettingsNavigation.showLogoutAlert;
  }

  @action
  void consumeNavigation() {
    navigation = SettingsNavigation.none;
  }

  @action
  void onLogoutConfirmed() {
    AppSharedPreferences.setIsLoggedIn(false);
    navigation = SettingsNavigation.navigateToLogin;
  }
}
