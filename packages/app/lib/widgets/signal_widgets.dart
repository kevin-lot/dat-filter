import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

/// A widget that watches a signal and rebuilds when it changes
class WatchSignal<T> extends StatelessWidget {
  const WatchSignal({
    required this.signal,
    required this.builder,
    super.key,
  });

  final ReadonlySignal<T> signal;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext BuildContext context) {
    return Watch((context) => builder(context, signal.value));
  }
}

/// A widget that watches multiple signals
class WatchSignals extends StatelessWidget {
  const WatchSignals({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext BuildContext context) {
    return Watch((context) => builder(context));
  }
}

/// Base class for widgets that watch signals
/// Similar to WatchingWidget from watch_it
abstract class SignalWidget extends StatelessWidget {
  const SignalWidget({super.key});

  @override
  Widget build(BuildContext BuildContext context) {
    return Watch((context) => buildWithSignals(context));
  }

  Widget buildWithSignals(BuildContext context);
}

/// Base class for stateful widgets that watch signals
/// Similar to WatchingStatefulWidget from watch_it
abstract class SignalStatefulWidget extends StatefulWidget {
  const SignalStatefulWidget({super.key});
}

abstract class SignalState<T extends SignalStatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext BuildContext context) {
    return Watch((context) => buildWithSignals(context));
  }

  Widget buildWithSignals(BuildContext context);
}

/// Helper function to watch a signal value
/// Similar to watchPropertyValue from watch_it
T watchSignalValue<T>(ReadonlySignal<T> signal) {
  return signal.value;
}

