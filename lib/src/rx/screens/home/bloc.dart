import 'package:rxdart/rxdart.dart';
import 'package:state_cafe/data/sharedpreferences.dart';
import 'package:state_cafe/base/bottom_nav_page.dart';

class HomeBloc {
  HomeBloc() {
    _initializeNavPage();
  }

  final _bottomNavPage = BehaviorSubject<HomeBottomNavPage>();

  Stream<HomeBottomNavPage> get bottomNavPage => _bottomNavPage.stream;

  void _initializeNavPage() async {
    final preferredDrink = await AppSharedPreferences.preferredDrink;
    _bottomNavPage.value = HomeBottomNavPage.fromName(preferredDrink);
  }

  void onBottomNavItemSelected(int index) {
    _bottomNavPage.value = HomeBottomNavPage.fromIndex(index);
  }
}