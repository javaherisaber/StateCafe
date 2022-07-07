import 'package:flutter/material.dart';
import 'package:state_cafe/routes.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(child: content(context)),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        input('Username'),
        const Space(height: 16),
        input('Password'),
        const Space(height: 36),
        confirm(context),
      ],
    );
  }

  Widget input(String hint) {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 5.0),
          ),
          hintText: hint,
        ),
      ),
    );
  }

  Widget confirm(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        visualDensity: VisualDensity.standard,
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, Routes.home);
      },
      child: const Text('Login'),
    );
  }
}
