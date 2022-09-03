import 'package:flutter/material.dart';
import 'package:imager/imager.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
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
