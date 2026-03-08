import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/getit/app/app_notifier.dart';
import 'package:state_cafe/src/getit/routes.dart';
import 'package:state_cafe/src/getit/screens/settings/settings_notifier.dart';
import 'package:state_cafe/src/getit/service_locator.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsNotifier _notifier;
  late final AppNotifier _appNotifier;

  @override
  void initState() {
    super.initState();
    _notifier = SettingsNotifier();
    _appNotifier = getIt<AppNotifier>();
    _notifier.addListener(_onStateChanged);
    _appNotifier.addListener(_onAppStateChanged);
  }

  @override
  void dispose() {
    _notifier.removeListener(_onStateChanged);
    _appNotifier.removeListener(_onAppStateChanged);
    _notifier.dispose();
    super.dispose();
  }

  void _onAppStateChanged() {
    setState(() {});
  }

  void _onStateChanged() {
    if (_notifier.shouldShowLogoutAlert) {
      _notifier.consumeLogoutAlert();
      _showLogoutDialog();
    } else if (_notifier.shouldNavigateToLogin) {
      _notifier.consumeNavigation();
      Navigator.pushNamedAndRemoveUntil(
        context,
        GetItRoutes.login,
        ModalRoute.withName(GetItRoutes.splash),
      );
    } else {
      setState(() {});
    }
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
                _notifier.onLogoutConfirmed();
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${tr.iPrefer}:    "),
        DropdownButton(
          value: _notifier.preferredDrink,
          items: [
            DropdownMenuItem(value: 'coffee', child: Text(tr.coffee)),
            DropdownMenuItem(value: 'tea', child: Text(tr.tea)),
            DropdownMenuItem(value: 'juice', child: Text(tr.juice)),
          ],
          onChanged: (String? value) {
            if (value != null) {
              _notifier.onPreferredDrinkChanged(value);
            }
          },
        ),
      ],
    );
  }

  Widget language() {
    final languageCode = _appNotifier.locale.languageCode;
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
            onPressed: () => _appNotifier.changeLocale(AppLocale.fa),
            child: Text(tr.persian),
          ),
        if (languageCode == AppLocale.fa.languageCode)
          TextButton(
            onPressed: () => _appNotifier.changeLocale(AppLocale.en),
            child: Text(tr.english),
          ),
      ],
    );
  }

  Widget logout() {
    return OutlinedButton(
      onPressed: () => _notifier.onLogoutClick(),
      child: Text(tr.logout),
    );
  }
}
