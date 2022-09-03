part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent(this.locale);

  final Locale locale;

  @override
  List<Object> get props => [locale];
}

class AppLocaleRetrieved extends AppEvent {
  const AppLocaleRetrieved(super.locale);
}

class AppLocaleChanged extends AppEvent {
  const AppLocaleChanged(super.locale);
}