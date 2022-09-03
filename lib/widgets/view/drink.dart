import 'package:flutter/material.dart';
import 'package:state_cafe/widgets/menu_grid.dart';

class DrinkView extends StatelessWidget {
  const DrinkView({super.key, required this.drinkName});

  final String drinkName;

  @override
  Widget build(BuildContext context) {
    return MenuGrid(name: drinkName);
  }
}
