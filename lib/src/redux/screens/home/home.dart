import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/routes.dart';
import 'package:state_cafe/src/redux/screens/home/home_middleware.dart';
import 'package:state_cafe/src/redux/screens/home/home_state.dart';
import 'package:state_cafe/themes/icons.dart';
import 'package:state_cafe/widgets/view/drink.dart';
import 'package:touch_mouse_behavior/touch_mouse_behavior.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final _repository = RepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeState>(
      onInit: (store) => store.dispatch(homeOnReadyThunk(_repository)),
      converter: (store) => store.state.homeState,
      builder: (context, homeState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr.appName),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, ReduxRoutes.settings);
              },
            ),
          ),
          body: TouchMouseScrollable(child: content(homeState)),
          bottomNavigationBar: bottomNav(context, homeState),
        );
      },
    );
  }

  Widget content(HomeState homeState) {
    final drinks = homeState.drinks;
    if (drinks == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return DrinkView(drinks: drinks);
  }

  Widget bottomNav(BuildContext context, HomeState homeState) {
    return BottomNavigationBar(
      selectedLabelStyle: tp.bodyMedium,
      unselectedLabelStyle: tp.bodyLarge,
      currentIndex: homeState.bottomNavPage.index,
      onTap: (int index) {
        StoreProvider.of<AppState>(context).dispatch(
          homeSelectBottomNavThunk(_repository, index),
        );
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
