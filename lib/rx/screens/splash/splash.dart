import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/routes.dart';
import 'package:state_cafe/rx/screens/splash/bloc.dart';
import 'package:state_cafe/utils/image.dart';
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
      Navigator.pushReplacementNamed(context, Routes.home);
    });

    bloc.navigateToLogin.listen((_) {
      Navigator.pushReplacementNamed(context, Routes.login);
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
            ImageUtils.fromLocal('assets/app_icon.png', width: 164),
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
