/// Adapter pattern to bridge existing ChangeNotifier-based notifiers with signals
/// This allows gradual migration without breaking existing code
///
/// Usage: Wrap your existing notifier to expose a signal interface

import 'package:flutter/foundation.dart';
import 'package:signals/signals.dart';

/// Adapter that wraps a ChangeNotifier and exposes it as a signal
/// This allows you to use signals in widgets while keeping existing notifiers
class NotifierToSignalAdapter<T> {
  NotifierToSignalAdapter(this._notifier, T Function() getValue) {
    _signal = signal(getValue());

    // Listen to changes in the notifier and update the signal
    _notifier.addListener(() {
      _signal.value = getValue();
    });
  }

  final ChangeNotifier _notifier;
  late final Signal<T> _signal;

  T get value => _signal.value;
  ReadonlySignal<T> get signal => _signal.readonly();

  void dispose() {
    _notifier.removeListener(() {});
  }
}

/// Helper function to create a signal from a notifier
///
/// Example:
/// ```dart
/// final notifier = serviceLocator.get<LocaleNotifierInterface>();
/// final localeSignal = notifierToSignal(notifier, (n) => n.value);
/// ```
ReadonlySignal<T> notifierToSignal<T>(
  ChangeNotifier notifier,
  T Function() getValue,
) {
  final adapter = NotifierToSignalAdapter(notifier, getValue);
  return adapter.signal;
}

/// Extension to add signal support to any ChangeNotifier-based interface
extension NotifierSignalExtension<T> on ChangeNotifier {
  /// Convert this notifier's value to a signal
  ///
  /// Note: This requires the notifier to have a `value` getter
  /// For custom access, use `notifierToSignal` instead
  ReadonlySignal<T> toSignal<T>(T Function() getValue) {
    return notifierToSignal(this, getValue);
  }
}

