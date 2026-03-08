import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/redux/app/app_middleware.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/routes.dart';
import 'package:state_cafe/src/redux/screens/settings/settings_actions.dart';
import 'package:state_cafe/src/redux/screens/settings/settings_middleware.dart';
import 'package:state_cafe/src/redux/screens/settings/settings_state.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SettingsViewModel>(
      onInit: (store) => store.dispatch(settingsInitThunk()),
      converter: (store) => _SettingsViewModel(
        settingsState: store.state.settingsState,
        locale: store.state.locale,
      ),
      onDidChange: (previous, current) {
        if (current.settingsState.shouldShowLogoutAlert) {
          StoreProvider.of<AppState>(context).dispatch(SettingsConsumeLogoutAlertAction());
          _showLogoutDialog(context);
        } else if (current.settingsState.shouldNavigateToLogin) {
          StoreProvider.of<AppState>(context).dispatch(SettingsConsumeNavigationAction());
          Navigator.pushNamedAndRemoveUntil(
            context,
            ReduxRoutes.login,
            ModalRoute.withName(ReduxRoutes.splash),
          );
        }
      },
      builder: (context, vm) {
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
                  preferredDrink(context, vm.settingsState),
                  const Space(height: 24),
                  language(context, vm.locale),
                  const Space(height: 48),
                  logout(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
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
                StoreProvider.of<AppState>(context).dispatch(settingsLogoutConfirmedThunk());
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

  Widget preferredDrink(BuildContext context, SettingsState settingsState) {
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
              StoreProvider.of<AppState>(context).dispatch(settingsPreferredDrinkThunk(value));
            }
          },
        ),
      ],
    );
  }

  Widget language(BuildContext context, Locale locale) {
    final languageCode = locale.languageCode;
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
            onPressed: () => StoreProvider.of<AppState>(context).dispatch(
              changeLocaleThunk(AppLocale.fa),
            ),
            child: Text(tr.persian),
          ),
        if (languageCode == AppLocale.fa.languageCode)
          TextButton(
            onPressed: () => StoreProvider.of<AppState>(context).dispatch(
              changeLocaleThunk(AppLocale.en),
            ),
            child: Text(tr.english),
          ),
      ],
    );
  }

  Widget logout(BuildContext context) {
    return OutlinedButton(
      onPressed: () => StoreProvider.of<AppState>(context).dispatch(SettingsLogoutClickAction()),
      child: Text(tr.logout),
    );
  }
}

class _SettingsViewModel {
  final SettingsState settingsState;
  final Locale locale;

  const _SettingsViewModel({required this.settingsState, required this.locale});
}
