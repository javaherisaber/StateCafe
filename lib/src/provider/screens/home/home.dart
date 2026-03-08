import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/src/provider/routes.dart';
import 'package:state_cafe/src/provider/screens/home/home_notifier.dart';
import 'package:state_cafe/themes/icons.dart';
import 'package:state_cafe/widgets/view/drink.dart';
import 'package:touch_mouse_behavior/touch_mouse_behavior.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(repository: RepositoryImpl()),
      child: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ResourcefulState<_HomeContent> {
  @override
  void onReady() {
    super.onReady();
    context.read<HomeNotifier>().onReady();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HomeNotifier>(
      builder: (context, notifier, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr.appName),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, ProviderRoutes.settings);
              },
            ),
          ),
          body: TouchMouseScrollable(child: content(notifier)),
          bottomNavigationBar: bottomNav(notifier),
        );
      },
    );
  }

  Widget content(HomeNotifier notifier) {
    final drinks = notifier.drinks;
    if (drinks == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return DrinkView(drinks: drinks);
  }

  Widget bottomNav(HomeNotifier notifier) {
    return BottomNavigationBar(
      selectedLabelStyle: tp.bodyMedium,
      unselectedLabelStyle: tp.bodyLarge,
      currentIndex: notifier.bottomNavPage.index,
      onTap: (int index) {
        notifier.onBottomNavItemSelected(index);
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
