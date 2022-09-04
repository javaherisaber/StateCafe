import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imager/imager.dart';
import 'package:state_cafe/data/drink_data.dart';
import 'package:state_cafe/widgets/sized_box/space.dart';

class DrinkView extends StatelessWidget {
  const DrinkView({super.key, required this.drinks});

  final List<DrinkData> drinks;

  @override
  Widget build(BuildContext context) {
    final widthCount = (MediaQuery.of(context).size.width ~/ 250).toInt();
    return GridView.builder(
      itemCount: drinks.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemBuilder: (BuildContext context, int index) {
        return item(drinks[index]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: min(widthCount, 4),
        mainAxisExtent: 180,
      ),
    );
  }

  Widget item(DrinkData drink) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
          child: Column(
            children: [
              Imager.fromLocal(
                drink.fileName,
                height: 100,
                fit: BoxFit.contain,
                backOffSizing: false,
              ),
              const Space(height: 16),
              Text(drink.name)
            ],
          ),
        ),
      ),
    );
  }
}
