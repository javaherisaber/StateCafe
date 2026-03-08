import 'package:mobx/mobx.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

part 'splash_store.g.dart';

enum SplashNavigation { loading, home, login }

class SplashStore = _SplashStore with _$SplashStore;

abstract class _SplashStore with Store {
  @observable
  SplashNavigation navigation = SplashNavigation.loading;

  @action
  Future<void> onReady() async {
    await Future.delayed(const Duration(seconds: 4));
    final isLoggedIn = await AppSharedPreferences.isLoggedIn;
    navigation = isLoggedIn ? SplashNavigation.home : SplashNavigation.login;
  }
}
