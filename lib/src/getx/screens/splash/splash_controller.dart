import 'package:get/get.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

enum SplashNavigation { none, home, login }

class SplashController extends GetxController {
  final navigation = SplashNavigation.none.obs;

  @override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 4));
    final isLoggedIn = await AppSharedPreferences.isLoggedIn;
    navigation.value = isLoggedIn ? SplashNavigation.home : SplashNavigation.login;
  }
}
