import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/routes.dart';
import 'package:state_cafe/src/redux/screens/splash/splash_actions.dart';
import 'package:state_cafe/src/redux/screens/splash/splash_middleware.dart';
import 'package:state_cafe/src/redux/screens/splash/splash_state.dart';
import 'package:state_cafe/widgets/view/splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashState>(
      onInit: (store) => store.dispatch(splashTimerThunk()),
      converter: (store) => store.state.splashState,
      onDidChange: (previous, current) {
        if (current.navigation == SplashNavigation.home) {
          StoreProvider.of<AppState>(context).dispatch(SplashConsumeNavigationAction());
          Navigator.pushReplacementNamed(context, ReduxRoutes.home);
        } else if (current.navigation == SplashNavigation.login) {
          StoreProvider.of<AppState>(context).dispatch(SplashConsumeNavigationAction());
          Navigator.pushReplacementNamed(context, ReduxRoutes.login);
        }
      },
      builder: (context, state) {
        return const SplashView();
      },
    );
  }
}
