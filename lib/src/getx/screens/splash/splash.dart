import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/src/getx/routes.dart';
import 'package:state_cafe/src/getx/screens/splash/splash_controller.dart';
import 'package:state_cafe/widgets/view/splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ResourcefulState<SplashPage> {
  late final SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(SplashController());
    once(_controller.navigation, (nav) {
      if (nav == SplashNavigation.home) {
        Navigator.pushReplacementNamed(context, GetXRoutes.home);
      } else if (nav == SplashNavigation.login) {
        Navigator.pushReplacementNamed(context, GetXRoutes.login);
      }
    }, condition: () => _controller.navigation.value != SplashNavigation.none);
  }

  @override
  void onReady() {
    super.onReady();
    _controller.onReady();
  }

  @override
  void dispose() {
    Get.delete<SplashController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SplashView();
  }
}
