import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/widgets/menu_grid.dart';

class JuicePage extends StatefulWidget {
  const JuicePage({super.key});

  @override
  State<JuicePage> createState() => _JuicePageState();
}

class _JuicePageState extends ResourcefulState<JuicePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MenuGrid(name: tr.juice);
  }
}
