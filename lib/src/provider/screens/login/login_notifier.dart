import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class LoginNotifier extends ChangeNotifier {
  static const defaultUsername = 'admin';
  static const defaultPassword = 'admin';

  String _username = defaultUsername;
  String _password = defaultPassword;
  bool _shouldNavigateToHome = false;

  bool get shouldNavigateToHome => _shouldNavigateToHome;

  void onUsernameChanged(String value) {
    _username = value;
  }

  void onPasswordChanged(String value) {
    _password = value;
  }

  void onLoginClick() async {
    if (_username == defaultUsername && _password == defaultPassword) {
      await AppSharedPreferences.setIsLoggedIn(true);
      _shouldNavigateToHome = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Wrong username or password');
    }
  }

  void consumeNavigation() {
    _shouldNavigateToHome = false;
  }
}
