import 'package:state_cafe/base/first_class_functions.dart';

enum HomeBottomNavPage {
  coffee,
  tea,
  juice;

  int indexOfNav() {
    return index;
  }

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

  static HomeBottomNavPage fromIndex(int index) {
    const values = HomeBottomNavPage.values;
    if (index < 0 || index >= values.length) {
      return error('No page found for index $index');
    }
    return values[index];
  }

  static HomeBottomNavPage fromName(String name) {
    const values = HomeBottomNavPage.values;
    for (var element in values) {
      if (element.toString() == name) {
        return element;
      }
    }
    return error('No page found for name $name');
  }
}
