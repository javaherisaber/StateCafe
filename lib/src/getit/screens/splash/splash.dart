import 'package:flutter/material.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/src/getit/routes.dart';
import 'package:state_cafe/src/getit/screens/splash/splash_notifier.dart';
import 'package:state_cafe/widgets/view/splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ResourcefulState<SplashPage> {
  late final SplashNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = SplashNotifier();
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
    if (_notifier.shouldNavigateToHome) {
      _notifier.consumeNavigation();
      Navigator.pushReplacementNamed(context, GetItRoutes.home);
    } else if (_notifier.shouldNavigateToLogin) {
      _notifier.consumeNavigation();
      Navigator.pushReplacementNamed(context, GetItRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SplashView();
  }
}
