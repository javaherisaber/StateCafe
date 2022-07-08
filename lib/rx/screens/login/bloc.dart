import 'package:fluttertoast/fluttertoast.dart';
import 'package:live_event/live_event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class LoginBloc {
  LoginBloc() {
    _username.value = usernameDefault;
    _password.value = passwordDefault;
  }

  final _navigateToHome = LiveEvent();
  final _username = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream get navigateToHome => _navigateToHome.stream;

  Function(String) get onUsernameChanged => _username.sink.add;
  Function(String) get onPasswordChanged => _password.sink.add;

  void onLoginClick() async {
    final username = _username.valueOrNull;
    final password = _password.valueOrNull;
    if (username == usernameDefault && password == passwordDefault) {
      AppSharedPreferences.setIsLoggedIn(true);
      _navigateToHome.fire();
    } else {
      Fluttertoast.showToast(msg: 'Wrong username or password');
    }
  }

  void dispose() {
    _navigateToHome.close();
    _username.close();
    _password.close();
  }

  static const usernameDefault = 'admin';
  static const passwordDefault = 'admin';
}