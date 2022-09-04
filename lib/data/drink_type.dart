import 'package:state_cafe/base/first_class_functions.dart';

enum DrinkType {
  coffee,
  tea,
  juice;

  @override
  String toString() {
    switch (this) {
      case coffee:
        return 'coffee';
      case tea:
        return 'tea';
      case juice:
        return 'juice';
    }
  }

  static DrinkType fromIndex(int index) {
    const values = DrinkType.values;
    if (index < 0 || index >= values.length) {
      return error('No page found for index $index');
    }
    return values[index];
  }

  static DrinkType fromName(String name) {
    const values = DrinkType.values;
    for (var element in values) {
      if (element.toString() == name) {
        return element;
      }
    }
    return error('No page found for name $name');
  }
}
