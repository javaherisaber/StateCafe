import 'package:state_cafe/src/redux/app/app_actions.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/screens/home/home_reducer.dart';
import 'package:state_cafe/src/redux/screens/login/login_reducer.dart';
import 'package:state_cafe/src/redux/screens/settings/settings_reducer.dart';
import 'package:state_cafe/src/redux/screens/splash/splash_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is LocaleChangedAction) {
    return state.copyWith(locale: action.locale, shouldRestart: true);
  }
  if (action is ConsumeRestartAction) {
    return state.copyWith(shouldRestart: false);
  }

  return state.copyWith(
    splashState: splashReducer(state.splashState, action),
    loginState: loginReducer(state.loginState, action),
    homeState: homeReducer(state.homeState, action),
    settingsState: settingsReducer(state.settingsState, action),
  );
}
