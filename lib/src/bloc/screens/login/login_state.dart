part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState(this.username, this.password);

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];

  static const defaultUsername = 'admin';
  static const defaultPassword = 'admin';
}

class LoginInitial extends LoginState {
  const LoginInitial() : super(LoginState.defaultPassword, LoginState.defaultPassword);
}

class LoginChangeCredentials extends LoginState {
  const LoginChangeCredentials(super.username, super.password);
}

class LoginNavigateToHome extends LoginState {
  LoginNavigateToHome(LoginState s) : super(s.username, s.password);
}