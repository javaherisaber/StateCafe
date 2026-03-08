import 'package:state_cafe/src/redux/screens/home/home_actions.dart';
import 'package:state_cafe/src/redux/screens/home/home_state.dart';

HomeState homeReducer(HomeState state, dynamic action) {
  if (action is HomeSetBottomNavPageAction) {
    return HomeState(bottomNavPage: action.drinkType);
  }
  if (action is HomeDrinksLoadedAction) {
    return state.copyWith(drinks: action.drinks);
  }
  if (action is HomeClearDrinksAction) {
    return state.copyWith(clearDrinks: true);
  }
  return state;
}
