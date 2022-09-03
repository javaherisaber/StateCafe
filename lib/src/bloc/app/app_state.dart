part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState(this.locale);

  final Locale locale;

  @override
  List<Object?> get props => [locale];
}

class AppInitial extends AppState {
  const AppInitial() : super(AppLocale.defaultLocale);
}

class AppLocaleReady extends AppState {
  const AppLocaleReady(super.locale);
}

class AppRestart extends AppState {
  const AppRestart(super.locale);
}