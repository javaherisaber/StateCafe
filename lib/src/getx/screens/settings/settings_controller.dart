import 'package:get/get.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

enum SettingsNavigation { none, showLogoutAlert, navigateToLogin }

class SettingsController extends GetxController {
  final preferredDrink = 'coffee'.obs;
  final navigation = SettingsNavigation.none.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePreferredDrink();
  }

  void _initializePreferredDrink() async {
    preferredDrink.value = await AppSharedPreferences.preferredDrink;
  }

  void onPreferredDrinkChanged(String newValue) {
    AppSharedPreferences.setPreferredDrink(newValue);
    preferredDrink.value = newValue;
  }

  void onLogoutClick() {
    navigation.value = SettingsNavigation.showLogoutAlert;
  }

  void onLogoutConfirmed() {
    AppSharedPreferences.setIsLoggedIn(false);
    navigation.value = SettingsNavigation.navigateToLogin;
  }

  void consumeNavigation() {
    navigation.value = SettingsNavigation.none;
  }
}
