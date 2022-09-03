import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/main.dart';
import 'package:state_cafe/src/bloc/app/app_bloc.dart';
import 'package:state_cafe/src/bloc/routes.dart';
import 'package:state_cafe/src/bloc/screens/settings/settings_bloc.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:state_cafe/widgets/sized_box/empty_box.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(),
      child: buildView(),
    );
  }

  Widget buildView() {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (settingsContext, state) {
        if (state is SettingsLogoutAlertShown) {
          showDialog(
            context: settingsContext,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(tr.areYouSure),
                content: Text(tr.logoutMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(settingsContext).pop(),
                    child: Text(tr.cancel),
                  ),
                  TextButton(
                    onPressed: () => settingsContext.read<SettingsBloc>().add(const SettingsLogoutConfirmed()),
                    child: Text(tr.ok),
                  ),
                ],
              );
            },
          );
        } else if (state is SettingNavigateToLogin) {
          Navigator.pushNamedAndRemoveUntil(settingsContext, BlocRoutes.login, ModalRoute.withName(BlocRoutes.splash));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr.settings),
        ),
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
      ),
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
    return Text(
      'admin',
      style: tp.titleLarge,
    );
  }

  Widget preferredDrink() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${tr.iPrefer}:    "),
            DropdownButton(
              value: state.preferredDrink,
              items: [
                DropdownMenuItem(value: 'coffee', child: Text(tr.coffee)),
                DropdownMenuItem(value: 'tea', child: Text(tr.tea)),
                DropdownMenuItem(value: 'juice', child: Text(tr.juice)),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  context.read<SettingsBloc>().add(SettingsPreferredDrinkChanged(value));
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget language() {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final languageCode = state.locale.languageCode;
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
                onPressed: () => context.read<AppBloc>().add(const AppLocaleChanged(AppLocale.fa)),
                child: Text(tr.persian),
              ),
            if (languageCode == AppLocale.fa.languageCode)
              TextButton(
                onPressed: () => context.read<AppBloc>().add(const AppLocaleChanged(AppLocale.en)),
                child: Text(tr.english),
              ),
          ],
        );
      },
    );
  }

  Widget logout() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return OutlinedButton(
          onPressed: () => context.read<SettingsBloc>().add(const SettingsLogoutClicked()),
          child: Text(tr.logout),
        );
      },
    );
  }
}
