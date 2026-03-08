import 'package:flutter/foundation.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class SettingsNotifier extends ChangeNotifier {
  SettingsNotifier() {
    _initializePreferredDrink();
  }

  String _preferredDrink = 'coffee';
  bool _shouldShowLogoutAlert = false;
  bool _shouldNavigateToLogin = false;

  String get preferredDrink => _preferredDrink;
  bool get shouldShowLogoutAlert => _shouldShowLogoutAlert;
  bool get shouldNavigateToLogin => _shouldNavigateToLogin;

  void _initializePreferredDrink() async {
    _preferredDrink = await AppSharedPreferences.preferredDrink;
    notifyListeners();
  }

  void onPreferredDrinkChanged(String newValue) {
    AppSharedPreferences.setPreferredDrink(newValue);
    _preferredDrink = newValue;
    notifyListeners();
  }

  void onLogoutClick() {
    _shouldShowLogoutAlert = true;
    notifyListeners();
  }

  void consumeLogoutAlert() {
    _shouldShowLogoutAlert = false;
  }

  void onLogoutConfirmed() {
    AppSharedPreferences.setIsLoggedIn(false);
    _shouldNavigateToLogin = true;
    notifyListeners();
  }

  void consumeNavigation() {
    _shouldNavigateToLogin = false;
  }
}
