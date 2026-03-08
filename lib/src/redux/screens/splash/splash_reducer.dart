import 'package:state_cafe/src/redux/screens/splash/splash_actions.dart';
import 'package:state_cafe/src/redux/screens/splash/splash_state.dart';

SplashState splashReducer(SplashState state, dynamic action) {
  if (action is SplashNavigateAction) {
    return state.copyWith(navigation: action.navigation);
  }
  if (action is SplashConsumeNavigationAction) {
    return state.copyWith(navigation: SplashNavigation.none);
  }
  return state;
}
