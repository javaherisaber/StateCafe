import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/data/drink_type.dart';

class HomeState {
  final DrinkType bottomNavPage;
  final List<DrinkData>? drinks;

  const HomeState({
    this.bottomNavPage = DrinkType.coffee,
    this.drinks,
  });

  HomeState copyWith({DrinkType? bottomNavPage, List<DrinkData>? drinks, bool clearDrinks = false}) {
    return HomeState(
      bottomNavPage: bottomNavPage ?? this.bottomNavPage,
      drinks: clearDrinks ? null : (drinks ?? this.drinks),
    );
  }
}
