import 'package:state_cafe/base/first_class_functions.dart';

extension ObjectExtensions<T> on T {
  /// Kotlin let equivalent
  R let<R>(R Function(T it) op) => op(this);

  /// Kotlin also equivalent
  T also(void Function(T it) block) {
    block(this);
    return this;
  }
}

extension ObjectNullableExtensions<T> on T? {
  /// Return value if not null or default otherwise
  String valueOrDefault<E>(E Function(T value) selector, {String defaultData = '-'}) {
    return this != null ? selector(this!).toString() : defaultData;
  }

  /// Throw an error if subject is null
  T errorIfNull([var message]) {
    if (this == null) error(message ?? 'Exception');
    return this!;
  }
}
