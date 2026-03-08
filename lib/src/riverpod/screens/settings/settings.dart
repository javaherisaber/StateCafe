import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/riverpod/providers.dart';
import 'package:state_cafe/src/riverpod/routes.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final appState = ref.watch(appProvider);

    ref.listen<SettingsState>(settingsProvider, (previous, next) {
      if (next.shouldShowLogoutAlert) {
        ref.read(settingsProvider.notifier).consumeLogoutAlert();
        _showLogoutDialog();
      } else if (next.shouldNavigateToLogin) {
        ref.read(settingsProvider.notifier).consumeNavigation();
        Navigator.pushNamedAndRemoveUntil(
          context,
          RiverpodRoutes.login,
          ModalRoute.withName(RiverpodRoutes.splash),
        );
      }
    });

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
              preferredDrink(settingsState),
              const Space(height: 24),
              language(appState),
              const Space(height: 48),
              logout(),
            ],
          ),
        ),
      ),
    );
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
                ref.read(settingsProvider.notifier).onLogoutConfirmed();
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
      child: Container(color: Colors.blue, child: Text('A')),
    );
  }

  Widget username() {
    return Text('admin', style: tp.titleLarge);
  }

  Widget preferredDrink(SettingsState settingsState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${tr.iPrefer}:    "),
        DropdownButton(
          value: settingsState.preferredDrink,
          items: [
            DropdownMenuItem(value: 'coffee', child: Text(tr.coffee)),
            DropdownMenuItem(value: 'tea', child: Text(tr.tea)),
            DropdownMenuItem(value: 'juice', child: Text(tr.juice)),
          ],
          onChanged: (String? value) {
            if (value != null) {
              ref.read(settingsProvider.notifier).onPreferredDrinkChanged(value);
            }
          },
        ),
      ],
    );
  }

  Widget language(AppState appState) {
    final languageCode = appState.locale.languageCode;
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
            onPressed: () => ref.read(appProvider.notifier).changeLocale(AppLocale.fa),
            child: Text(tr.persian),
          ),
        if (languageCode == AppLocale.fa.languageCode)
          TextButton(
            onPressed: () => ref.read(appProvider.notifier).changeLocale(AppLocale.en),
            child: Text(tr.english),
          ),
      ],
    );
  }

  Widget logout() {
    return OutlinedButton(
      onPressed: () => ref.read(settingsProvider.notifier).onLogoutClick(),
      child: Text(tr.logout),
    );
  }
}
