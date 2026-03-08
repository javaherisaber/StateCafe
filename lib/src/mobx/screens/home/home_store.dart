import 'package:mobx/mobx.dart';
import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/data/drink_type.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore({required this.repository});

  final Repository repository;

  @observable
  DrinkType bottomNavPage = DrinkType.coffee;

  @observable
  ObservableList<DrinkData>? drinks;

  @action
  Future<void> onReady() async {
    final preferredDrink = await AppSharedPreferences.preferredDrink;
    await onBottomNavItemSelected(DrinkType.fromName(preferredDrink).index);
  }

  @action
  Future<void> onBottomNavItemSelected(int index) async {
    final drinkType = DrinkType.fromIndex(index);
    bottomNavPage = drinkType;
    drinks = null;
    final loaded = await repository.getDrinks(drinkType);
    drinks = ObservableList.of(loaded);
  }
}
