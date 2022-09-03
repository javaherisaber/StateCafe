part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState(this.bottomNavPage);

  final HomeBottomNavPage bottomNavPage;

  @override
  List<Object> get props => [bottomNavPage];
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(HomeBottomNavPage.coffee);
}

class HomeBottomNavReady extends HomeState {
  const HomeBottomNavReady(super.bottomNavPage);
}
