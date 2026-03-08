// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  late final _$preferredDrinkAtom = Atom(
    name: '_SettingsStore.preferredDrink',
    context: context,
  );

  @override
  String get preferredDrink {
    _$preferredDrinkAtom.reportRead();
    return super.preferredDrink;
  }

  @override
  set preferredDrink(String value) {
    _$preferredDrinkAtom.reportWrite(value, super.preferredDrink, () {
      super.preferredDrink = value;
    });
  }

  late final _$navigationAtom = Atom(
    name: '_SettingsStore.navigation',
    context: context,
  );

  @override
  SettingsNavigation get navigation {
    _$navigationAtom.reportRead();
    return super.navigation;
  }

  @override
  set navigation(SettingsNavigation value) {
    _$navigationAtom.reportWrite(value, super.navigation, () {
      super.navigation = value;
    });
  }

  late final _$_SettingsStoreActionController = ActionController(
    name: '_SettingsStore',
    context: context,
  );

  @override
  void onPreferredDrinkChanged(String newValue) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
      name: '_SettingsStore.onPreferredDrinkChanged',
    );
    try {
      return super.onPreferredDrinkChanged(newValue);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onLogoutClick() {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
      name: '_SettingsStore.onLogoutClick',
    );
    try {
      return super.onLogoutClick();
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void consumeNavigation() {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
      name: '_SettingsStore.consumeNavigation',
    );
    try {
      return super.consumeNavigation();
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onLogoutConfirmed() {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
      name: '_SettingsStore.onLogoutConfirmed',
    );
    try {
      return super.onLogoutConfirmed();
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
preferredDrink: ${preferredDrink},
navigation: ${navigation}
    ''';
  }
}
