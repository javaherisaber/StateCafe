import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/data/drink_type.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/data/sharedpreferences.dart';
import 'package:state_cafe/themes/locale.dart';

// --- App-level state ---

class AppState {
  const AppState({required this.locale, this.shouldRestart = false});
  final Locale locale;
  final bool shouldRestart;

  AppState copyWith({Locale? locale, bool? shouldRestart}) {
    return AppState(
      locale: locale ?? this.locale,
      shouldRestart: shouldRestart ?? this.shouldRestart,
    );
  }
}

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier() : super(AppState(locale: appInitialLocale));

  void changeLocale(Locale locale) async {
    await AppLocale.setCurrentLocale(locale);
    state = AppState(locale: locale, shouldRestart: true);
  }

  void consumeRestart() {
    state = state.copyWith(shouldRestart: false);
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(),
);

// --- Splash ---

enum SplashNavigation { loading, home, login }

final splashProvider = FutureProvider.autoDispose<SplashNavigation>((ref) async {
  await Future.delayed(const Duration(seconds: 4));
  final isLoggedIn = await AppSharedPreferences.isLoggedIn;
  return isLoggedIn ? SplashNavigation.home : SplashNavigation.login;
});

// --- Login ---

class LoginState {
  const LoginState({
    this.username = defaultUsername,
    this.password = defaultPassword,
    this.shouldNavigateToHome = false,
  });

  final String username;
  final String password;
  final bool shouldNavigateToHome;

  static const defaultUsername = 'admin';
  static const defaultPassword = 'admin';

  LoginState copyWith({String? username, String? password, bool? shouldNavigateToHome}) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      shouldNavigateToHome: shouldNavigateToHome ?? this.shouldNavigateToHome,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(const LoginState());

  void onUsernameChanged(String value) {
    state = state.copyWith(username: value);
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(password: value);
  }

  void onLoginClick() async {
    if (state.username == LoginState.defaultUsername &&
        state.password == LoginState.defaultPassword) {
      await AppSharedPreferences.setIsLoggedIn(true);
      state = state.copyWith(shouldNavigateToHome: true);
    } else {
      // Toast is handled in the UI
    }
  }

  void consumeNavigation() {
    state = state.copyWith(shouldNavigateToHome: false);
  }
}

final loginProvider = StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);

// --- Home ---

class HomeState {
  const HomeState({
    this.bottomNavPage = DrinkType.coffee,
    this.drinks,
  });

  final DrinkType bottomNavPage;
  final List<DrinkData>? drinks;

  HomeState copyWith({DrinkType? bottomNavPage, List<DrinkData>? drinks, bool clearDrinks = false}) {
    return HomeState(
      bottomNavPage: bottomNavPage ?? this.bottomNavPage,
      drinks: clearDrinks ? null : (drinks ?? this.drinks),
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier({required this.repository}) : super(const HomeState());

  final Repository repository;

  void onReady() async {
    final preferredDrink = await AppSharedPreferences.preferredDrink;
    onBottomNavItemSelected(DrinkType.fromName(preferredDrink).index);
  }

  void onBottomNavItemSelected(int index) async {
    final drinkType = DrinkType.fromIndex(index);
    state = HomeState(bottomNavPage: drinkType);
    final drinks = await repository.getDrinks(drinkType);
    state = state.copyWith(drinks: drinks);
  }
}

final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(repository: RepositoryImpl()),
);

// --- Settings ---

class SettingsState {
  const SettingsState({
    this.preferredDrink = 'coffee',
    this.shouldShowLogoutAlert = false,
    this.shouldNavigateToLogin = false,
  });

  final String preferredDrink;
  final bool shouldShowLogoutAlert;
  final bool shouldNavigateToLogin;

  SettingsState copyWith({
    String? preferredDrink,
    bool? shouldShowLogoutAlert,
    bool? shouldNavigateToLogin,
  }) {
    return SettingsState(
      preferredDrink: preferredDrink ?? this.preferredDrink,
      shouldShowLogoutAlert: shouldShowLogoutAlert ?? this.shouldShowLogoutAlert,
      shouldNavigateToLogin: shouldNavigateToLogin ?? this.shouldNavigateToLogin,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState()) {
    _initializePreferredDrink();
  }

  void _initializePreferredDrink() async {
    final preferred = await AppSharedPreferences.preferredDrink;
    state = state.copyWith(preferredDrink: preferred);
  }

  void onPreferredDrinkChanged(String newValue) {
    AppSharedPreferences.setPreferredDrink(newValue);
    state = state.copyWith(preferredDrink: newValue);
  }

  void onLogoutClick() {
    state = state.copyWith(shouldShowLogoutAlert: true);
  }

  void consumeLogoutAlert() {
    state = state.copyWith(shouldShowLogoutAlert: false);
  }

  void onLogoutConfirmed() {
    AppSharedPreferences.setIsLoggedIn(false);
    state = state.copyWith(shouldNavigateToLogin: true);
  }

  void consumeNavigation() {
    state = state.copyWith(shouldNavigateToLogin: false);
  }
}

final settingsProvider = StateNotifierProvider.autoDispose<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);
