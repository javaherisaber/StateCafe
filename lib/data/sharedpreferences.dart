import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_cafe/themes/locale.dart';

class AppSharedPreferences {
  static SharedPreferences? __instance;

  static Future<SharedPreferences> get _preference async {
    __instance ??= await SharedPreferences.getInstance();
    return __instance!;
  }

  static Future<bool> get isLoggedIn async {
    return (await _preference).getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> setIsLoggedIn(bool value) async {
    (await _preference).setBool(_keyIsLoggedIn, value);
  }

  static Future<String> get preferredDrink async {
    return (await _preference).getString(_keyPreferredDrink) ?? 'coffee';
  }

  static Future<void> setPreferredDrink(String value) async {
    (await _preference).setString(_keyPreferredDrink, value);
  }

  /// Warning: do not use this method to get locale, use [AppLocale.currentLocale] instead
  static Future<String> get localeCode async {
    return (await _preference).getString(_keyLocaleCode) ??
        AppLocale.defaultLocale.languageCode;
  }

  /// Warning: do not use this method to change locale, use [AppLocale.setCurrentLocale] instead
  static Future<void> setLocaleCode(String value) async {
    (await _preference).setString(_keyLocaleCode, value);
  }

  static const _keyIsLoggedIn = 'isLoggedIn';
  static const _keyPreferredDrink = 'preferredDrink';
  static const _keyLocaleCode = 'localeCode';
}