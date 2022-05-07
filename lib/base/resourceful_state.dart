import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import '/routes.dart';

export '/extensions/build_context.dart';

/// Convenient base class for StatefulWidget's State to provide access to resources
/// like typography, intl, ...
abstract class ResourcefulState<T extends StatefulWidget> extends ResumableState<T> with RouteAware {
  final bool _printLifecycleEvents = true;
  final bool _printPageEventsOnly = true;

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    _printEvent('building widget...');

    return const Text('Not implemented body');
  }

  String get _widgetName => widget.toStringShort();

  void _printEvent(String message) {
    if (_printPageEventsOnly && !_widgetName.endsWith('Page')) {
      return;
    }
    if (_printLifecycleEvents) {
      debugPrint('ResourcefulState => $_widgetName: $message');
    }
  }

  @override
  void dispose() {
    _printEvent('dispose()');
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    _printEvent('initState()');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _printEvent('didChangeDependencies()');
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    _printEvent('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  @mustCallSuper
  void onResume() {
    _printEvent('onResume()');
  }

  @override
  @mustCallSuper
  void onPause() {
    _printEvent('onPause()');
  }

  @override
  @mustCallSuper
  void onReady() {
    _printEvent('onReady()');
  }

  @override
  @mustCallSuper
  void didPush() {
    _printEvent('didPush()');
  }

  @override
  @mustCallSuper
  void didPushNext() {
    _printEvent('didPushNext()');
  }

  @override
  @mustCallSuper
  void didPop() {
    _printEvent('didPop()');
  }

  @override
  @mustCallSuper
  void didPopNext() {
    _printEvent('didPopNext()');
  }
}
