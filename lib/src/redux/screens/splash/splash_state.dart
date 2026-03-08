enum SplashNavigation { none, home, login }

class SplashState {
  final SplashNavigation navigation;

  const SplashState({this.navigation = SplashNavigation.none});

  SplashState copyWith({SplashNavigation? navigation}) {
    return SplashState(navigation: navigation ?? this.navigation);
  }
}
