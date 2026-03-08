import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/riverpod/providers.dart';
import 'package:state_cafe/src/riverpod/routes.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (next.shouldNavigateToHome) {
        ref.read(loginProvider.notifier).consumeNavigation();
        Navigator.pushNamed(context, RiverpodRoutes.home);
      }
    });

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
        initialValue: LoginState.defaultUsername,
        onChanged: (value) => ref.read(loginProvider.notifier).onUsernameChanged(value),
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
        initialValue: LoginState.defaultPassword,
        onChanged: (value) => ref.read(loginProvider.notifier).onPasswordChanged(value),
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
      onPressed: () {
        final notifier = ref.read(loginProvider.notifier);
        notifier.onLoginClick();
        final state = ref.read(loginProvider);
        if (!state.shouldNavigateToHome) {
          Fluttertoast.showToast(msg: 'Wrong username or password');
        }
      },
      child: Text(tr.loginButton),
    );
  }
}
