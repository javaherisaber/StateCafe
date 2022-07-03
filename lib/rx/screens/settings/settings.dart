import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Space(height: 48),
              avatar(),
              const Space(height: 16),
              username(),
              const Space(height: 24),
              preferredDrink(),
              const Space(height: 24),
              language(),
              const Space(height: 48),
              logout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget avatar() {
    return CircleAvatar(
      radius: 36,
      child: Container(
        color: Colors.blue,
        child: Text('M'),
      ),
    );
  }

  Widget username() {
    return Text(
      'mjavaheri',
      style: tp.titleLarge,
    );
  }

  Widget preferredDrink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("I prefer: "),
        DropdownButton(
          items: [
            DropdownMenuItem(child: Text('Coffee'), value: 0),
            DropdownMenuItem(child: Text('Tea'), value: 1),
            DropdownMenuItem(child: Text('Juice'), value: 2),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget language() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {}, child: Text('English')),
        Space(width: 8),
        TextButton(onPressed: () {}, child: Text('فارسی')),
      ],
    );
  }

  Widget logout() {
    return OutlinedButton(onPressed: () {}, child: Text('Logout'));
  }
}
