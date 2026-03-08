import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/riverpod/providers.dart';
import 'package:state_cafe/src/riverpod/routes.dart';
import 'package:state_cafe/themes/icons.dart';
import 'package:state_cafe/widgets/view/drink.dart';
import 'package:touch_mouse_behavior/touch_mouse_behavior.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      ref.read(homeProvider.notifier).onReady();
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appName),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, RiverpodRoutes.settings);
          },
        ),
      ),
      body: TouchMouseScrollable(child: content(homeState)),
      bottomNavigationBar: bottomNav(homeState),
    );
  }

  Widget content(HomeState homeState) {
    final drinks = homeState.drinks;
    if (drinks == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return DrinkView(drinks: drinks);
  }

  Widget bottomNav(HomeState homeState) {
    return BottomNavigationBar(
      selectedLabelStyle: tp.bodyMedium,
      unselectedLabelStyle: tp.bodyLarge,
      currentIndex: homeState.bottomNavPage.index,
      onTap: (int index) {
        ref.read(homeProvider.notifier).onBottomNavItemSelected(index);
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
