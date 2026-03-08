import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_cafe/data/drink_type.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/data/sharedpreferences.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/screens/home/home_actions.dart';

ThunkAction<AppState> homeOnReadyThunk(Repository repository) {
  return (Store<AppState> store) async {
    final preferredDrink = await AppSharedPreferences.preferredDrink;
    store.dispatch(homeSelectBottomNavThunk(
      repository,
      DrinkType.fromName(preferredDrink).index,
    ));
  };
}

ThunkAction<AppState> homeSelectBottomNavThunk(Repository repository, int index) {
  return (Store<AppState> store) async {
    final drinkType = DrinkType.fromIndex(index);
    store.dispatch(HomeSetBottomNavPageAction(drinkType));
    final drinks = await repository.getDrinks(drinkType);
    store.dispatch(HomeDrinksLoadedAction(drinks, drinkType));
  };
}
