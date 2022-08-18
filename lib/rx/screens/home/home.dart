import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/rx/screens/coffee/coffee.dart';
import 'package:state_cafe/rx/screens/home/bloc.dart';
import 'package:state_cafe/rx/screens/home/bottom_nav_page.dart';
import 'package:state_cafe/rx/screens/juice/juice.dart';
import 'package:state_cafe/rx/screens/tea/tea.dart';
import 'package:state_cafe/themes/icons.dart';
import 'package:state_cafe/widgets/sized_box/empty_box.dart';
import 'package:touch_mouse_behavior/touch_mouse_behavior.dart';

import '../../../routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;

  @override
  void initState() {
    bloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appName),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, Routes.settings);
          },
        ),
      ),
      body: TouchMouseScrollable(child: content()),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget content() {
    return StreamBuilder<HomeBottomNavPage>(
      stream: bloc.bottomNavPage,
      builder: (context, snapshot) {
        final navPage = snapshot.data;
        if (navPage == null) {
          return const EmptyBox();
        }
        switch (navPage) {
          case HomeBottomNavPage.coffee:
            return const CoffeePage();
          case HomeBottomNavPage.tea:
            return const TeaPage();
          case HomeBottomNavPage.juice:
            return const JuicePage();
          default:
            return error('No page found for index ${navPage.name}');
        }
      },
    );
  }

  Widget bottomNav() {
    return StreamBuilder<HomeBottomNavPage>(
      stream: bloc.bottomNavPage,
      builder: (context, snapshot) {
        final navPage = snapshot.data;
        if (navPage == null) {
          return const EmptyBox();
        }
        return BottomNavigationBar(
          selectedLabelStyle: tp.bodyText2,
          unselectedLabelStyle: tp.bodyText1,
          currentIndex: navPage.indexOfNav(),
          onTap: (int index) {
            bloc.onBottomNavItemSelected(index);
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
      },
    );
  }
}
