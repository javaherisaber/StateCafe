import 'package:flutter/material.dart';
import 'package:state_cafe/base/first_class_functions.dart';
import 'package:state_cafe/base/resourceful_state.dart';

import '../../../widgets/menu_grid.dart';

class TeaPage extends StatefulWidget {
  const TeaPage({Key? key}) : super(key: key);

  @override
  State<TeaPage> createState() => _TeaPageState();
}

class _TeaPageState extends ResourcefulState<TeaPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MenuGrid(name: tr.tea);
  }
}
