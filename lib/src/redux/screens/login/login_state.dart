class LoginState {
  final String username;
  final String password;
  final bool shouldNavigateToHome;

  static const defaultUsername = 'admin';
  static const defaultPassword = 'admin';

  const LoginState({
    this.username = defaultUsername,
    this.password = defaultPassword,
    this.shouldNavigateToHome = false,
  });

  LoginState copyWith({String? username, String? password, bool? shouldNavigateToHome}) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      shouldNavigateToHome: shouldNavigateToHome ?? this.shouldNavigateToHome,
    );
  }
}
