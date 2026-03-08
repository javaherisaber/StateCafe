import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_cafe/data/sharedpreferences.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/screens/splash/splash_actions.dart';
import 'package:state_cafe/src/redux/screens/splash/splash_state.dart';

ThunkAction<AppState> splashTimerThunk() {
  return (Store<AppState> store) async {
    await Future.delayed(const Duration(seconds: 4));
    final isLoggedIn = await AppSharedPreferences.isLoggedIn;
    final nav = isLoggedIn ? SplashNavigation.home : SplashNavigation.login;
    store.dispatch(SplashNavigateAction(nav));
  };
}
