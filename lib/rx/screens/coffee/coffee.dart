import 'package:flutter/material.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/widgets/menu_grid.dart';

import '../../../base/first_class_functions.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({super.key});

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends ResourcefulState<CoffeePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MenuGrid(name: tr.coffee);
  }
}
