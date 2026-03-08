import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/provider/app/app_notifier.dart';
import 'package:state_cafe/src/provider/routes.dart';
import 'package:state_cafe/src/provider/screens/settings/settings_notifier.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsNotifier(),
      child: const _SettingsContent(),
    );
  }
}

class _SettingsContent extends StatefulWidget {
  const _SettingsContent();

  @override
  State<_SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<_SettingsContent> {
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SettingsNotifier>();

    if (notifier.shouldShowLogoutAlert) {
      notifier.consumeLogoutAlert();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLogoutDialog(context, notifier);
      });
    }

    if (notifier.shouldNavigateToLogin) {
      notifier.consumeNavigation();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          ProviderRoutes.login,
          ModalRoute.withName(ProviderRoutes.splash),
        );
      });
    }

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
              preferredDrink(notifier),
              const Space(height: 24),
              language(),
              const Space(height: 48),
              logout(notifier),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, SettingsNotifier notifier) {
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
                notifier.onLogoutConfirmed();
              },
              child: Text(tr.ok),
            ),
          ],
        );
      },
    );
  }

  Widget avatar() {
    return CircleAvatar(
      radius: 36,
      child: Container(
        color: Colors.blue,
        child: Text('A'),
      ),
    );
  }

  Widget username() {
    return Text('admin', style: tp.titleLarge);
  }

  Widget preferredDrink(SettingsNotifier notifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${tr.iPrefer}:    "),
        DropdownButton(
          value: notifier.preferredDrink,
          items: [
            DropdownMenuItem(value: 'coffee', child: Text(tr.coffee)),
            DropdownMenuItem(value: 'tea', child: Text(tr.tea)),
            DropdownMenuItem(value: 'juice', child: Text(tr.juice)),
          ],
          onChanged: (String? value) {
            if (value != null) {
              notifier.onPreferredDrinkChanged(value);
            }
          },
        ),
      ],
    );
  }

  Widget language() {
    final appNotifier = context.watch<AppNotifier>();
    final languageCode = appNotifier.locale.languageCode;
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
            onPressed: () => appNotifier.changeLocale(AppLocale.fa),
            child: Text(tr.persian),
          ),
        if (languageCode == AppLocale.fa.languageCode)
          TextButton(
            onPressed: () => appNotifier.changeLocale(AppLocale.en),
            child: Text(tr.english),
          ),
      ],
    );
  }

  Widget logout(SettingsNotifier notifier) {
    return OutlinedButton(
      onPressed: () => notifier.onLogoutClick(),
      child: Text(tr.logout),
    );
  }
}
