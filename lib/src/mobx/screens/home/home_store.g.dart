// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$bottomNavPageAtom = Atom(
    name: '_HomeStore.bottomNavPage',
    context: context,
  );

  @override
  DrinkType get bottomNavPage {
    _$bottomNavPageAtom.reportRead();
    return super.bottomNavPage;
  }

  @override
  set bottomNavPage(DrinkType value) {
    _$bottomNavPageAtom.reportWrite(value, super.bottomNavPage, () {
      super.bottomNavPage = value;
    });
  }

  late final _$drinksAtom = Atom(name: '_HomeStore.drinks', context: context);

  @override
  ObservableList<DrinkData>? get drinks {
    _$drinksAtom.reportRead();
    return super.drinks;
  }

  @override
  set drinks(ObservableList<DrinkData>? value) {
    _$drinksAtom.reportWrite(value, super.drinks, () {
      super.drinks = value;
    });
  }

  late final _$onReadyAsyncAction = AsyncAction(
    '_HomeStore.onReady',
    context: context,
  );

  @override
  Future<void> onReady() {
    return _$onReadyAsyncAction.run(() => super.onReady());
  }

  late final _$onBottomNavItemSelectedAsyncAction = AsyncAction(
    '_HomeStore.onBottomNavItemSelected',
    context: context,
  );

  @override
  Future<void> onBottomNavItemSelected(int index) {
    return _$onBottomNavItemSelectedAsyncAction.run(
      () => super.onBottomNavItemSelected(index),
    );
  }

  @override
  String toString() {
    return '''
bottomNavPage: ${bottomNavPage},
drinks: ${drinks}
    ''';
  }
}
