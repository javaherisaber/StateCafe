import 'package:flutter/material.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/src/rx/routes.dart';
import 'package:state_cafe/src/rx/screens/splash/bloc.dart';
import 'package:state_cafe/widgets/view/splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ResourcefulState<SplashPage> {
  late SplashBloc bloc;

  @override
  void initState() {
    bloc = SplashBloc();
    listenBlocStreams();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    bloc.onReady();
  }

  void listenBlocStreams() {
    bloc.navigateToHome.listen((_) {
      Navigator.pushReplacementNamed(context, RxRoutes.home);
    });

    bloc.navigateToLogin.listen((_) {
      Navigator.pushReplacementNamed(context, RxRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SplashView();
  }
}
