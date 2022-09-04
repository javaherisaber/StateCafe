import 'package:rxdart/rxdart.dart';
import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/data/drink_type.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/data/sharedpreferences.dart';

class HomeBloc {
  HomeBloc({required this.repository}) {
    _initializeNavPage();
  }

  final Repository repository;
  final _bottomNavPage = BehaviorSubject<DrinkType>();
  final _drinks = BehaviorSubject<List<DrinkData>>();

  Stream<DrinkType> get bottomNavPage => _bottomNavPage.stream;
  Stream<List<DrinkData>> get drinks => _drinks.stream;

  void _initializeNavPage() async {
    final preferredDrink = await AppSharedPreferences.preferredDrink;
    onBottomNavItemSelected(DrinkType.fromName(preferredDrink).index);
  }

  void onBottomNavItemSelected(int index) async {
    _drinks.value = [];
    final drinkType = DrinkType.fromIndex(index);
    _bottomNavPage.value = drinkType;
    final drinks = await repository.getDrinks(drinkType);
    _drinks.value = drinks;
  }
}
