import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/getx/app/app_controller.dart';
import 'package:state_cafe/src/getx/routes.dart';
import 'package:state_cafe/src/getx/screens/settings/settings_controller.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsController _controller;
  late final AppController _appController;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(SettingsController());
    _appController = Get.find<AppController>();
    ever(_controller.navigation, (nav) {
      if (nav == SettingsNavigation.showLogoutAlert) {
        _controller.consumeNavigation();
        _showLogoutDialog();
      } else if (nav == SettingsNavigation.navigateToLogin) {
        _controller.consumeNavigation();
        Navigator.pushNamedAndRemoveUntil(
          context,
          GetXRoutes.login,
          ModalRoute.withName(GetXRoutes.splash),
        );
      }
    });
  }

  @override
  void dispose() {
    Get.delete<SettingsController>();
    super.dispose();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(tr.areYouSure),
          content: Text(tr.logoutMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(tr.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _controller.onLogoutConfirmed();
              },
              child: Text(tr.ok),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr.settings)),
      body: SizedBox(
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
      child: Container(color: Colors.blue, child: Text('A')),
    );
  }

  Widget username() {
    return Text('admin', style: tp.titleLarge);
  }

  Widget preferredDrink() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${tr.iPrefer}:    "),
          DropdownButton(
            value: _controller.preferredDrink.value,
            items: [
              DropdownMenuItem(value: 'coffee', child: Text(tr.coffee)),
              DropdownMenuItem(value: 'tea', child: Text(tr.tea)),
              DropdownMenuItem(value: 'juice', child: Text(tr.juice)),
            ],
            onChanged: (String? value) {
              if (value != null) {
                _controller.onPreferredDrinkChanged(value);
              }
            },
          ),
        ],
      );
    });
  }

  Widget language() {
    return Obx(() {
      final languageCode = _appController.locale.value.languageCode;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (languageCode == AppLocale.en.languageCode)
            ElevatedButton(onPressed: doNothing, child: Text(tr.english)),
          if (languageCode == AppLocale.fa.languageCode)
            ElevatedButton(onPressed: doNothing, child: Text(tr.persian)),
          const Space(width: 8),
          if (languageCode == AppLocale.en.languageCode)
            TextButton(
              onPressed: () => _appController.changeLocale(AppLocale.fa),
              child: Text(tr.persian),
            ),
          if (languageCode == AppLocale.fa.languageCode)
            TextButton(
              onPressed: () => _appController.changeLocale(AppLocale.en),
              child: Text(tr.english),
            ),
        ],
      );
    });
  }

  Widget logout() {
    return OutlinedButton(
      onPressed: () => _controller.onLogoutClick(),
      child: Text(tr.logout),
    );
  }
}
