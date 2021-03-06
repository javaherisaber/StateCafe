import 'package:shared_preferences/shared_preferences.dart';

abstract class AppSharedPreferences {
  static SharedPreferences? _instance;

  static Future<SharedPreferences> get _preference async {
    _instance ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  static Future<String?> _getNullableString(String key) async {
    final result = (await _preference).getString(key);
    return result == _nullString ? null : result;
  }

  static Future<bool> get isLoggedIn async {
    return (await _preference).getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> setIsLoggedIn(bool value) async {
    (await _preference).setBool(_keyIsLoggedIn, value);
  }

  static const _keyIsLoggedIn = 'isLoggedIn';

  /// We must use non-nullable string in shared preferences, so we use 'null' to indicate as such
  static const _nullString = 'null';
}