class LoginUsernameChangedAction {
  final String username;
  const LoginUsernameChangedAction(this.username);
}

class LoginPasswordChangedAction {
  final String password;
  const LoginPasswordChangedAction(this.password);
}

class LoginConfirmAction {}

class LoginNavigateToHomeAction {}

class LoginConsumeNavigationAction {}
