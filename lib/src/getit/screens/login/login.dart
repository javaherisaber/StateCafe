import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/getit/routes.dart';
import 'package:state_cafe/src/getit/screens/login/login_notifier.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginNotifier _notifier;
  bool _isPasswordObscure = true;

  @override
  void initState() {
    super.initState();
    _notifier = LoginNotifier();
    _notifier.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _notifier.removeListener(_onStateChanged);
    _notifier.dispose();
    super.dispose();
  }

  void _onStateChanged() {
    if (_notifier.shouldNavigateToHome) {
      _notifier.consumeNavigation();
      Navigator.pushNamed(context, GetItRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        onChanged: (value) => _notifier.onUsernameChanged(value),
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
        onChanged: (value) => _notifier.onPasswordChanged(value),
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
      onPressed: () => _notifier.onLoginClick(),
      child: Text(tr.loginButton),
    );
  }
}
