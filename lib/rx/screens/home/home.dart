import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/rx/screens/coffee/coffee.dart';
import 'package:state_cafe/rx/screens/juice/juice.dart';
import 'package:state_cafe/rx/screens/tea/tea.dart';
import 'package:state_cafe/rx/themes/icons.dart';
import 'package:touch_mouse_behavior/touch_mouse_behavior.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appName),
        centerTitle: true,
      ),
      body: TouchMouseScrollable(child: content()),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget content() {
    switch (navigationIndex) {
      case 0:
        return const CoffeePage();
      case 1:
        return const TeaPage();
      case 2:
        return const JuicePage();
      default:
        return error('No page found for index $navigationIndex');
    }
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      selectedLabelStyle: tp.bodyText2,
      unselectedLabelStyle: tp.bodyText1,
      currentIndex: navigationIndex,
      onTap: (int index) {
        setState(() {
          navigationIndex = index;
        });
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
