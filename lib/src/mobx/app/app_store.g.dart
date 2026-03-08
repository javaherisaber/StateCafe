// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$localeAtom = Atom(name: '_AppStore.locale', context: context);

  @override
  Locale get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(Locale value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  late final _$shouldRestartAtom = Atom(
    name: '_AppStore.shouldRestart',
    context: context,
  );

  @override
  bool get shouldRestart {
    _$shouldRestartAtom.reportRead();
    return super.shouldRestart;
  }

  @override
  set shouldRestart(bool value) {
    _$shouldRestartAtom.reportWrite(value, super.shouldRestart, () {
      super.shouldRestart = value;
    });
  }

  late final _$changeLocaleAsyncAction = AsyncAction(
    '_AppStore.changeLocale',
    context: context,
  );

  @override
  Future<void> changeLocale(Locale newLocale) {
    return _$changeLocaleAsyncAction.run(() => super.changeLocale(newLocale));
  }

  late final _$_AppStoreActionController = ActionController(
    name: '_AppStore',
    context: context,
  );

  @override
  void consumeRestart() {
    final _$actionInfo = _$_AppStoreActionController.startAction(
      name: '_AppStore.consumeRestart',
    );
    try {
      return super.consumeRestart();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale},
shouldRestart: ${shouldRestart}
    ''';
  }
}
