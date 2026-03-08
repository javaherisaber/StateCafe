import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  static const defaultUsername = 'admin';
  static const defaultPassword = 'admin';

  @observable
  String username = defaultUsername;

  @observable
  String password = defaultPassword;

  @observable
  bool shouldNavigateToHome = false;

  @action
  void onUsernameChanged(String value) {
    username = value;
  }

  @action
  void onPasswordChanged(String value) {
    password = value;
  }

  @action
  Future<void> onLoginClick() async {
    if (username == defaultUsername && password == defaultPassword) {
      await AppSharedPreferences.setIsLoggedIn(true);
      shouldNavigateToHome = true;
    } else {
      Fluttertoast.showToast(msg: 'Wrong username or password');
    }
  }
}
