import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cafe/base/bottom_nav_page.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/bloc/routes.dart';
import 'package:state_cafe/src/bloc/screens/home/home_bloc.dart';
import 'package:state_cafe/themes/icons.dart';
import 'package:state_cafe/widgets/view/drink.dart';
import 'package:touch_mouse_behavior/touch_mouse_behavior.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: scaffold(),
    );
  }

  Widget scaffold() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr.appName),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, BlocRoutes.settings);
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final navPage = state.bottomNavPage;
        switch (navPage) {
          case HomeBottomNavPage.coffee:
            return DrinkView(drinkName: tr.coffee);
          case HomeBottomNavPage.tea:
            return DrinkView(drinkName: tr.tea);
          case HomeBottomNavPage.juice:
            return DrinkView(drinkName: tr.juice);
          default:
            return error('No page found for index ${navPage.name}');
        }
      },
    );
  }

  Widget bottomNav() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      final navPage = state.bottomNavPage;
      return BottomNavigationBar(
        selectedLabelStyle: tp.bodyText2,
        unselectedLabelStyle: tp.bodyText1,
        currentIndex: navPage.indexOfNav(),
        onTap: (int index) {
          context.read<HomeBloc>().add(HomeBottomNavItemSelected(index));
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
    });
  }
}
