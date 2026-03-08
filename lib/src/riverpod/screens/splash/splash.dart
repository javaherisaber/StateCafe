import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_cafe/src/riverpod/providers.dart';
import 'package:state_cafe/src/riverpod/routes.dart';
import 'package:state_cafe/widgets/view/splash.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<SplashNavigation>>(splashProvider, (previous, next) {
      next.whenData((nav) {
        if (nav == SplashNavigation.home) {
          Navigator.pushReplacementNamed(context, RiverpodRoutes.home);
        } else if (nav == SplashNavigation.login) {
          Navigator.pushReplacementNamed(context, RiverpodRoutes.login);
        }
      });
    });

    return const SplashView();
  }
}
