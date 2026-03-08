import 'package:state_cafe/src/redux/screens/login/login_actions.dart';
import 'package:state_cafe/src/redux/screens/login/login_state.dart';

LoginState loginReducer(LoginState state, dynamic action) {
  if (action is LoginUsernameChangedAction) {
    return state.copyWith(username: action.username);
  }
  if (action is LoginPasswordChangedAction) {
    return state.copyWith(password: action.password);
  }
  if (action is LoginNavigateToHomeAction) {
    return state.copyWith(shouldNavigateToHome: true);
  }
  if (action is LoginConsumeNavigationAction) {
    return state.copyWith(shouldNavigateToHome: false);
  }
  return state;
}
