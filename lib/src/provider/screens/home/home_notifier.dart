import 'package:flutter/foundation.dart';
import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/data/drink_type.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class HomeNotifier extends ChangeNotifier {
  HomeNotifier({required this.repository});

  final Repository repository;

  DrinkType _bottomNavPage = DrinkType.coffee;
  List<DrinkData>? _drinks;

  DrinkType get bottomNavPage => _bottomNavPage;
  List<DrinkData>? get drinks => _drinks;

  void onReady() async {
    final preferredDrink = await AppSharedPreferences.preferredDrink;
    onBottomNavItemSelected(DrinkType.fromName(preferredDrink).index);
  }

  void onBottomNavItemSelected(int index) async {
    final drinkType = DrinkType.fromIndex(index);
    _bottomNavPage = drinkType;
    _drinks = null;
    notifyListeners();
    final drinks = await repository.getDrinks(drinkType);
    _drinks = drinks;
    notifyListeners();
  }
}
