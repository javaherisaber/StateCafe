import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/mobx/app/app_provider.dart';
import 'package:state_cafe/src/mobx/app/app_store.dart';
import 'package:state_cafe/src/mobx/routes.dart';
import 'package:state_cafe/src/mobx/screens/settings/settings_store.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _store = SettingsStore();
  late final ReactionDisposer _disposer;
  late AppStore _appStore;

  @override
  void initState() {
    super.initState();
    _disposer = reaction(
      (_) => _store.navigation,
      (SettingsNavigation nav) {
        if (nav == SettingsNavigation.showLogoutAlert) {
          _store.consumeNavigation();
          _showLogoutDialog();
        } else if (nav == SettingsNavigation.navigateToLogin) {
          _store.consumeNavigation();
          Navigator.pushNamedAndRemoveUntil(
            context,
            MobXRoutes.login,
            ModalRoute.withName(MobXRoutes.splash),
          );
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appStore = MobXAppProvider.of(context);
  }

  @override
  void dispose() {
    _disposer();
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
                _store.onLogoutConfirmed();
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
    return Observer(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${tr.iPrefer}:    "),
            DropdownButton(
              value: _store.preferredDrink,
              items: [
                DropdownMenuItem(value: 'coffee', child: Text(tr.coffee)),
                DropdownMenuItem(value: 'tea', child: Text(tr.tea)),
                DropdownMenuItem(value: 'juice', child: Text(tr.juice)),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  _store.onPreferredDrinkChanged(value);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget language() {
    return Observer(
      builder: (_) {
        final languageCode = _appStore.locale.languageCode;
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
                onPressed: () => _appStore.changeLocale(AppLocale.fa),
                child: Text(tr.persian),
              ),
            if (languageCode == AppLocale.fa.languageCode)
              TextButton(
                onPressed: () => _appStore.changeLocale(AppLocale.en),
                child: Text(tr.english),
              ),
          ],
        );
      },
    );
  }

  Widget logout() {
    return OutlinedButton(
      onPressed: () => _store.onLogoutClick(),
      child: Text(tr.logout),
    );
  }
}
