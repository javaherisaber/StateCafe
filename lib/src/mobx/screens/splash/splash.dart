import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/src/mobx/routes.dart';
import 'package:state_cafe/src/mobx/screens/splash/splash_store.dart';
import 'package:state_cafe/widgets/view/splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ResourcefulState<SplashPage> {
  final _store = SplashStore();
  late final ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _disposer = reaction(
      (_) => _store.navigation,
      (SplashNavigation nav) {
        if (nav == SplashNavigation.home) {
          Navigator.pushReplacementNamed(context, MobXRoutes.home);
        } else if (nav == SplashNavigation.login) {
          Navigator.pushReplacementNamed(context, MobXRoutes.login);
        }
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    _store.onReady();
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SplashView();
  }
}
