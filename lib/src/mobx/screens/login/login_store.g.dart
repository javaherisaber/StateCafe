// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  late final _$usernameAtom = Atom(
    name: '_LoginStore.username',
    context: context,
  );

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$passwordAtom = Atom(
    name: '_LoginStore.password',
    context: context,
  );

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$shouldNavigateToHomeAtom = Atom(
    name: '_LoginStore.shouldNavigateToHome',
    context: context,
  );

  @override
  bool get shouldNavigateToHome {
    _$shouldNavigateToHomeAtom.reportRead();
    return super.shouldNavigateToHome;
  }

  @override
  set shouldNavigateToHome(bool value) {
    _$shouldNavigateToHomeAtom.reportWrite(
      value,
      super.shouldNavigateToHome,
      () {
        super.shouldNavigateToHome = value;
      },
    );
  }

  late final _$onLoginClickAsyncAction = AsyncAction(
    '_LoginStore.onLoginClick',
    context: context,
  );

  @override
  Future<void> onLoginClick() {
    return _$onLoginClickAsyncAction.run(() => super.onLoginClick());
  }

  late final _$_LoginStoreActionController = ActionController(
    name: '_LoginStore',
    context: context,
  );

  @override
  void onUsernameChanged(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
      name: '_LoginStore.onUsernameChanged',
    );
    try {
      return super.onUsernameChanged(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPasswordChanged(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
      name: '_LoginStore.onPasswordChanged',
    );
    try {
      return super.onPasswordChanged(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username},
password: ${password},
shouldNavigateToHome: ${shouldNavigateToHome}
    ''';
  }
}
