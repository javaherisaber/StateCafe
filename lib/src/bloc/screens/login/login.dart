import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/src/bloc/routes.dart';
import 'package:state_cafe/src/bloc/screens/login/login_bloc.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const LoginPageContent(),
    );
  }
}

class LoginPageContent extends StatefulWidget {
  const LoginPageContent({super.key});

  @override
  State<LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {
  bool _isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginNavigateToHome) {
          Navigator.pushNamed(context, BlocRoutes.home);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(tr.login)),
        body: Center(child: content()),
      ),
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
        onChanged: (value) => context.read<LoginBloc>().add(LoginUsernameChanged(value)),
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
        onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
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
      onPressed: () => context.read<LoginBloc>().add(const LoginConfirmClicked()),
      child: Text(tr.loginButton),
    );
  }
}
