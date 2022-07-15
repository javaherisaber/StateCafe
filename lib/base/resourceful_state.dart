import 'package:flutter/material.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';

export '/extensions/build_context.dart';

/// Convenient base class for StatefulWidget's State to provide access to resources
abstract class ResourcefulState<T extends StatefulWidget> extends LifecycleAwareState<T> {
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    return const Text('Not implemented body');
  }
}
