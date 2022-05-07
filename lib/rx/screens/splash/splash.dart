import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/utils/image.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

import '../../../routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
