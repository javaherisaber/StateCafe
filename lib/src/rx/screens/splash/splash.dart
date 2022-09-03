import 'package:flutter/material.dart';
import 'package:imager/imager.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/src/rx/routes.dart';
import 'package:state_cafe/src/rx/screens/splash/bloc.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Imager.fromLocal('assets/app_icon.png', width: 164),
            const Space(height: 16),
            Text(tr.appName, style: tp.headline4),
            const Space(height: 56),
            Text('${tr.author}: ${tr.myName}', style: tp.bodyText2),
          ],
        ),
      ),
    );
  }
}
