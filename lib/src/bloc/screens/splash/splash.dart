import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cafe/src/bloc/routes.dart';
import 'package:state_cafe/src/bloc/screens/splash/splash_bloc.dart';
import 'package:state_cafe/widgets/view/splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(),
      child: buildView(),
    );
  }

  Widget buildView() {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToLogin) {
          Navigator.pushReplacementNamed(context, BlocRoutes.login);
        } else if (state is SplashNavigateToHome) {
          Navigator.pushReplacementNamed(context, BlocRoutes.home);
        }
      },
      child: const SplashView(),
    );
  }
}
