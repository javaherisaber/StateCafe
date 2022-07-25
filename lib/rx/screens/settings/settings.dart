import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/rx/app/provider.dart';
import 'package:state_cafe/rx/screens/settings/bloc.dart';
import 'package:state_cafe/themes/locale.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

import '../../../routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsBloc _bloc;
  late AppBloc _appBloc;

  @override
  void initState() {
    _bloc = SettingsBloc();
    listenBlocStreams();
    super.initState();
  }

  void listenBlocStreams() {
    _bloc.showLogoutAlert.listen((_) {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr.areYouSure),
          content: Text(tr.logoutMessage),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(tr.cancel)),
            TextButton(onPressed: _bloc.onLogoutAlertPositiveClick, child: Text(tr.ok)),
          ],
        );
      });
    });

    _bloc.navigateToLoginPage.listen((_) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.login, ModalRoute.withName(Routes.splash));
    });

    _bloc.updateThemeLocale.listen((locale) {
      _appBloc.changeThemeLocale(locale);
    });

    _bloc.restartApp.listen((_) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.splash, ModalRoute.withName(Routes.splash));
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _appBloc = AppProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${tr.iPrefer}: "),
        DropdownButton(
          items: [
            DropdownMenuItem(value: 0, child: Text(tr.coffee)),
            DropdownMenuItem(value: 1, child: Text(tr.tea)),
            DropdownMenuItem(value: 2, child: Text(tr.juice)),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget language() {
    return StreamBuilder<Locale>(
      stream: _appBloc.themeLocale,
      builder: (context, snapshot) {
        final languageCode = snapshot.data?.languageCode ?? appInitialLocale.languageCode;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (languageCode == AppLocale.en.languageCode)
              ElevatedButton(onPressed: doNothing, child: Text(tr.english)),
            if (languageCode == AppLocale.fa.languageCode)
              ElevatedButton(onPressed: doNothing, child: Text(tr.persian)),
            const Space(width: 8),
            if (languageCode == AppLocale.en.languageCode)
              TextButton(onPressed: () => _bloc.onLanguageClick(AppLocale.fa), child: Text(tr.persian)),
            if (languageCode == AppLocale.fa.languageCode)
              TextButton(onPressed: () => _bloc.onLanguageClick(AppLocale.en), child: Text(tr.english)),
          ],
        );
      },
    );
  }

  Widget logout(BuildContext context) {
    return OutlinedButton(
      onPressed: _bloc.onLogoutClick,
      child: Text(tr.logout),
    );
  }
}
