part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeOnReady extends HomeEvent {
  const HomeOnReady();
}

class HomeBottomNavItemSelected extends HomeEvent {
  const HomeBottomNavItemSelected(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}
