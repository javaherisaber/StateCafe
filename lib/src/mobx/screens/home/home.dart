import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/src/mobx/routes.dart';
import 'package:state_cafe/src/mobx/screens/home/home_store.dart';
import 'package:state_cafe/themes/icons.dart';
import 'package:state_cafe/widgets/view/drink.dart';
import 'package:touch_mouse_behavior/touch_mouse_behavior.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResourcefulState<HomePage> {
  late final HomeStore _store;

  @override
  void initState() {
    super.initState();
    _store = HomeStore(repository: RepositoryImpl());
  }

  @override
  void onReady() {
    super.onReady();
    _store.onReady();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr.appName),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, MobXRoutes.settings);
              },
            ),
          ),
          body: TouchMouseScrollable(child: content()),
          bottomNavigationBar: bottomNav(),
        );
      },
    );
  }

  Widget content() {
    final drinks = _store.drinks;
    if (drinks == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return DrinkView(drinks: drinks.toList());
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      selectedLabelStyle: tp.bodyMedium,
      unselectedLabelStyle: tp.bodyLarge,
      currentIndex: _store.bottomNavPage.index,
      onTap: (int index) {
        _store.onBottomNavItemSelected(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(AppIcons.coffee),
          label: tr.coffee,
        ),
        BottomNavigationBarItem(
          icon: const Icon(AppIcons.tea),
          label: tr.tea,
        ),
        BottomNavigationBarItem(
          icon: const Icon(AppIcons.juice),
          label: tr.juice,
        ),
      ],
    );
  }
}
