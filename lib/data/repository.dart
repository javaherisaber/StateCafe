import 'dart:convert';

import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/data/drink_type.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract class Repository {
  Future<List<DrinkData>> getDrinks(DrinkType type);
}

class RepositoryImpl extends Repository {
  final Map<DrinkType, List<DrinkData>> allDrinks = {};

  @override
  Future<List<DrinkData>> getDrinks(DrinkType type) async {
    final cachedData = allDrinks[type];
    if (cachedData != null) {
      return cachedData;
    }
    await Future.delayed(const Duration(seconds: 1)); // simulated delay
    var assetPath = 'assets/${type.toString()}.json';
    List<dynamic> data = await rootBundle.loadString(assetPath).then((value) => jsonDecode(value));
    List<DrinkData> drinks = [];
    for (var item in data) {
      drinks.add(DrinkData.fromJson(item));
    }
    allDrinks[type] = drinks;
    return drinks;
  }
}
