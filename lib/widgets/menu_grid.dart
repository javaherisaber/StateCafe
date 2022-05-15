import 'package:flutter/material.dart';

import '../utils/image.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return item();
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 5,
          childAspectRatio: 2 / 1
      ),
    );
  }

  Widget item() {
    return Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
      child: Column(
        children: [
          ImageUtils.fromLocal('assets/app_icon.png', height: 80),
          Text(name),
        ],
      ),
    );
  }
}
