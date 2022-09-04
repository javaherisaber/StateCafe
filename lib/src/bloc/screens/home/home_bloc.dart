import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/data/drink_type.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.repository}) : super(const HomeInitial()) {
    on<HomeOnReady>(_onReady);
    on<HomeBottomNavItemSelected>(_onBottomNavItemSelected);
  }

  final Repository repository;

  void _onReady(HomeOnReady event, Emitter<HomeState> emit) async {
    final preferredDrink = await AppSharedPreferences.preferredDrink;
    add(HomeBottomNavItemSelected(DrinkType.fromName(preferredDrink).index));
  }

  void _onBottomNavItemSelected(HomeBottomNavItemSelected event, Emitter<HomeState> emit) async {
    final drinkType = DrinkType.fromIndex(event.index);
    emit(HomeBottomNavReady(drinkType));
    final drinks = await repository.getDrinks(drinkType);
    emit(HomeLoaded(drinks, drinkType));
  }
}