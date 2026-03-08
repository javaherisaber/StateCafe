import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class LoginController extends GetxController {
  static const defaultUsername = 'admin';
  static const defaultPassword = 'admin';

  final username = defaultUsername.obs;
  final password = defaultPassword.obs;
  final shouldNavigateToHome = false.obs;

  void onUsernameChanged(String value) {
    username.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  void onLoginClick() async {
    if (username.value == defaultUsername && password.value == defaultPassword) {
      await AppSharedPreferences.setIsLoggedIn(true);
      shouldNavigateToHome.value = true;
    } else {
      Fluttertoast.showToast(msg: 'Wrong username or password');
    }
  }
}
