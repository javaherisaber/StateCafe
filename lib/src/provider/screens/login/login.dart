import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/provider/routes.dart';
import 'package:state_cafe/src/provider/screens/login/login_notifier.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginNotifier(),
      child: const _LoginContent(),
    );
  }
}

class _LoginContent extends StatefulWidget {
  const _LoginContent();

  @override
  State<_LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContent> {
  bool _isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LoginNotifier>();
    if (notifier.shouldNavigateToHome) {
      notifier.consumeNavigation();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, ProviderRoutes.home);
      });
    }
    return Scaffold(
      appBar: AppBar(title: Text(tr.login)),
      body: Center(child: content()),
    );
  }

  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        username(),
        const Space(height: 16),
        password(),
        const Space(height: 36),
        confirm(),
      ],
    );
  }

  Widget username() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        initialValue: LoginNotifier.defaultUsername,
        onChanged: (value) => context.read<LoginNotifier>().onUsernameChanged(value),
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 5.0),
          ),
          labelText: tr.username,
        ),
      ),
    );
  }

  Widget password() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        obscureText: _isPasswordObscure,
        initialValue: LoginNotifier.defaultPassword,
        onChanged: (value) => context.read<LoginNotifier>().onPasswordChanged(value),
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 5.0),
          ),
          labelText: tr.password,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordObscure = !_isPasswordObscure;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget confirm() {
    return ElevatedButton(
      style: const ButtonStyle(
        visualDensity: VisualDensity.standard,
      ),
      onPressed: () => context.read<LoginNotifier>().onLoginClick(),
      child: Text(tr.loginButton),
    );
  }
}
