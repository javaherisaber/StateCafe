part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState(this.bottomNavPage);

  final DrinkType bottomNavPage;

  @override
  List<Object> get props => [bottomNavPage];
}

class HomeInitial extends HomeState {
  const HomeInitial(): super(DrinkType.coffee);
}

class HomeBottomNavReady extends HomeState {
  const HomeBottomNavReady(super.bottomNavPage);
}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.drinks, super.bottomNavPage);

  final List<DrinkData> drinks;

  @override
  List<Object> get props => [bottomNavPage, drinks];
}
