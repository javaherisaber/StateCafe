import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/mobx/routes.dart';
import 'package:state_cafe/src/mobx/screens/login/login_store.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _store = LoginStore();
  late final ReactionDisposer _disposer;
  bool _isPasswordObscure = true;

  @override
  void initState() {
    super.initState();
    _disposer = reaction(
      (_) => _store.shouldNavigateToHome,
      (bool shouldNavigate) {
        if (shouldNavigate) {
          Navigator.pushNamed(context, MobXRoutes.home);
        }
      },
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
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
        initialValue: 'admin',
        onChanged: (value) => _store.onUsernameChanged(value),
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
        initialValue: 'admin',
        onChanged: (value) => _store.onPasswordChanged(value),
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
      onPressed: () => _store.onLoginClick(),
      child: Text(tr.loginButton),
    );
  }
}
