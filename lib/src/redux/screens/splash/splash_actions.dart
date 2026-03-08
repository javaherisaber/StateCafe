import 'package:state_cafe/src/redux/screens/splash/splash_state.dart';

class SplashTimerStartAction {}

class SplashNavigateAction {
  final SplashNavigation navigation;
  const SplashNavigateAction(this.navigation);
}

class SplashConsumeNavigationAction {}
