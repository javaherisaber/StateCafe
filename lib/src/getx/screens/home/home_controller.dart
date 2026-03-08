import 'package:get/get.dart';
import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/data/drink_type.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class HomeController extends GetxController {
  HomeController({required this.repository});

  final Repository repository;

  final bottomNavPage = DrinkType.coffee.obs;
  final drinks = Rxn<List<DrinkData>>();

  @override
  void onReady() async {
    final preferredDrink = await AppSharedPreferences.preferredDrink;
    onBottomNavItemSelected(DrinkType.fromName(preferredDrink).index);
  }

  void onBottomNavItemSelected(int index) async {
    final drinkType = DrinkType.fromIndex(index);
    bottomNavPage.value = drinkType;
    drinks.value = null;
    final loaded = await repository.getDrinks(drinkType);
    drinks.value = loaded;
  }
}
