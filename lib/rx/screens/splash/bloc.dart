import 'package:live_event/live_event.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class SplashBloc {
  final _navigateToHome = LiveEvent();
  final _navigateToLogin = LiveEvent();

  Stream get navigateToHome => _navigateToHome.stream;
  Stream get navigateToLogin => _navigateToLogin.stream;

  void onReady() async {
    await Future.delayed(const Duration(seconds: 4));
    final isLoggedIn = await AppSharedPreferences.isLoggedIn;
    if (isLoggedIn) {
      _navigateToHome.fire();
    } else {
      _navigateToLogin.fire();
    }
  }

  void dispose() {
    _navigateToHome.close();
  }
}