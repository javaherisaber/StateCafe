import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/src/getit/routes.dart';
import 'package:state_cafe/src/getit/screens/home/home_notifier.dart';
import 'package:state_cafe/src/getit/service_locator.dart';
import 'package:state_cafe/themes/icons.dart';
import 'package:state_cafe/widgets/view/drink.dart';
import 'package:touch_mouse_behavior/touch_mouse_behavior.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResourcefulState<HomePage> {
  late final HomeNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = HomeNotifier(repository: getIt());
    _notifier.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _notifier.removeListener(_onStateChanged);
    _notifier.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    _notifier.onReady();
  }

  void _onStateChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appName),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, GetItRoutes.settings);
          },
        ),
      ),
      body: TouchMouseScrollable(child: content()),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget content() {
    final drinks = _notifier.drinks;
    if (drinks == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return DrinkView(drinks: drinks);
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      selectedLabelStyle: tp.bodyMedium,
      unselectedLabelStyle: tp.bodyLarge,
      currentIndex: _notifier.bottomNavPage.index,
      onTap: (int index) {
        _notifier.onBottomNavItemSelected(index);
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
