import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cafe/base/bottom_nav_page.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    _initializeNavPage();
    on<HomeBottomNavItemSelected>(_onBottomNavItemSelected);
  }

  void _initializeNavPage() async {
    final preferredDrink = await AppSharedPreferences.preferredDrink;
    add(HomeBottomNavItemSelected(HomeBottomNavPage.fromName(preferredDrink).indexOfNav()));
  }

  void _onBottomNavItemSelected(HomeBottomNavItemSelected event, Emitter<HomeState> emit) {
    emit(HomeBottomNavReady(HomeBottomNavPage.fromIndex(event.index)));
  }
}