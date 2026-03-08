import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/src/getx/routes.dart';
import 'package:state_cafe/src/getx/screens/home/home_controller.dart';
import 'package:state_cafe/themes/icons.dart';
import 'package:state_cafe/widgets/view/drink.dart';
import 'package:touch_mouse_behavior/touch_mouse_behavior.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResourcefulState<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(HomeController(repository: RepositoryImpl()));
  }

  @override
  void onReady() {
    super.onReady();
    _controller.onReady();
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(tr.appName),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, GetXRoutes.settings);
            },
          ),
        ),
        body: TouchMouseScrollable(child: content()),
        bottomNavigationBar: bottomNav(),
      );
    });
  }

  Widget content() {
    final drinks = _controller.drinks.value;
    if (drinks == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return DrinkView(drinks: drinks);
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      selectedLabelStyle: tp.bodyMedium,
      unselectedLabelStyle: tp.bodyLarge,
      currentIndex: _controller.bottomNavPage.value.index,
      onTap: (int index) {
        _controller.onBottomNavItemSelected(index);
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
