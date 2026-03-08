import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/src/redux/routes.dart';
import 'package:state_cafe/src/redux/screens/login/login_actions.dart';
import 'package:state_cafe/src/redux/screens/login/login_middleware.dart';
import 'package:state_cafe/src/redux/screens/login/login_state.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginState>(
      converter: (store) => store.state.loginState,
      onDidChange: (previous, current) {
        if (current.shouldNavigateToHome) {
          StoreProvider.of<AppState>(context).dispatch(LoginConsumeNavigationAction());
          Navigator.pushNamed(context, ReduxRoutes.home);
        }
      },
      builder: (context, loginState) {
        return Scaffold(
          appBar: AppBar(title: Text(tr.login)),
          body: Center(child: content()),
        );
      },
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
        onChanged: (value) =>
            StoreProvider.of<AppState>(context).dispatch(LoginUsernameChangedAction(value)),
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
        onChanged: (value) =>
            StoreProvider.of<AppState>(context).dispatch(LoginPasswordChangedAction(value)),
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
      onPressed: () => StoreProvider.of<AppState>(context).dispatch(loginConfirmThunk()),
      child: Text(tr.loginButton),
    );
  }
}
