import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/rx/screens/settings/bloc.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

import '../../../routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsBloc _bloc;

  @override
  void initState() {
    _bloc = SettingsBloc();
    listenBlocStreams();
    super.initState();
  }

  void listenBlocStreams() {
    _bloc.showLogoutAlert.listen((event) {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('You are logging out of your account'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
            TextButton(onPressed: _bloc.onLogoutAlertPositiveClick, child: Text('Ok')),
          ],
        );
      });
    });

    _bloc.navigateToLoginPage.listen((event) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.login, ModalRoute.withName(Routes.splash));
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

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
              logout(context),
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

  Widget logout(BuildContext context) {
    return OutlinedButton(
      onPressed: _bloc.onLogoutClick,
      child: Text('Logout'),
    );
  }
}
