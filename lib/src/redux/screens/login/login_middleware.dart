import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_cafe/data/sharedpreferences.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/screens/login/login_actions.dart';
import 'package:state_cafe/src/redux/screens/login/login_state.dart';

ThunkAction<AppState> loginConfirmThunk() {
  return (Store<AppState> store) async {
    final loginState = store.state.loginState;
    if (loginState.username == LoginState.defaultUsername &&
        loginState.password == LoginState.defaultPassword) {
      await AppSharedPreferences.setIsLoggedIn(true);
      store.dispatch(LoginNavigateToHomeAction());
    } else {
      Fluttertoast.showToast(msg: 'Wrong username or password');
    }
  };
}
