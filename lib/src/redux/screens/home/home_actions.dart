import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/data/drink_type.dart';

class HomeOnReadyAction {}

class HomeBottomNavSelectedAction {
  final int index;
  const HomeBottomNavSelectedAction(this.index);
}

class HomeSetBottomNavPageAction {
  final DrinkType drinkType;
  const HomeSetBottomNavPageAction(this.drinkType);
}

class HomeDrinksLoadedAction {
  final List<DrinkData> drinks;
  final DrinkType drinkType;
  const HomeDrinksLoadedAction(this.drinks, this.drinkType);
}

class HomeClearDrinksAction {}
