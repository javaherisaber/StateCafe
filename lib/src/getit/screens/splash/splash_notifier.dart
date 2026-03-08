import 'package:flutter/foundation.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class SplashNotifier extends ChangeNotifier {
  bool _shouldNavigateToHome = false;
  bool _shouldNavigateToLogin = false;

  bool get shouldNavigateToHome => _shouldNavigateToHome;
  bool get shouldNavigateToLogin => _shouldNavigateToLogin;

  void onReady() async {
    await Future.delayed(const Duration(seconds: 4));
    final isLoggedIn = await AppSharedPreferences.isLoggedIn;
    if (isLoggedIn) {
      _shouldNavigateToHome = true;
    } else {
      _shouldNavigateToLogin = true;
    }
    notifyListeners();
  }

  void consumeNavigation() {
    _shouldNavigateToHome = false;
    _shouldNavigateToLogin = false;
  }
}
