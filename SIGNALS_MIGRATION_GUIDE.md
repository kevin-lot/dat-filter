# Migration Guide: From watch_it to Signals

This guide explains how to migrate from `watch_it` dependency injection and state management to `signals`.

## Overview

The migration involves:
1. Replacing `watch_it`'s DI container with a simple service locator
2. Converting `ChangeNotifier`-based notifiers to signal-based notifiers
3. Replacing `WatchingWidget`/`WatchingStatefulWidget` with signal-aware widgets
4. Replacing `watchPropertyValue` with direct signal access

## Step 1: Service Locator

The new service locator (`service_locator_signals.dart`) is a simple Map-based container that replaces `watch_it`'s `di`:

```dart
// Old (watch_it)
di.registerSingleton<MyService>(MyService());
final service = di<MyService>();

// New (signals)
serviceLocator.registerSingleton<MyService>(MyService());
final service = serviceLocator.get<MyService>();
```

## Step 2: Converting Notifiers

### Old Pattern (ChangeNotifier)
```dart
class MyNotifier extends ChangeNotifier implements MyNotifierInterface {
  @override
  String value = 'initial';
  
  void update(String newValue) {
    value = newValue;
    notifyListeners();
  }
}
```

### New Pattern (Signals)
```dart
class MyNotifierSignal implements MyNotifierInterface {
  final Signal<String> _signal = signal('initial');
  
  @override
  String get value => _signal.value;
  
  void update(String newValue) {
    _signal.value = newValue;
  }
  
  // Expose signal for widgets
  ReadonlySignal<String> get signal => _signal.readonly();
}
```

## Step 3: Updating Widgets

### Old Pattern (watch_it)
```dart
class MyWidget extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final value = watchPropertyValue((MyNotifierInterface n) => n.value);
    return Text(value);
  }
}
```

### New Pattern (signals)
```dart
class MyWidget extends SignalWidget {
  @override
  Widget buildWithSignals(BuildContext context) {
    final notifier = serviceLocator.get<MyNotifierInterface>();
    final value = notifier.signal.value; // Direct access
    return Text(value);
  }
}
```

Or using the `Watch` widget directly:
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = serviceLocator.get<MyNotifierInterface>();
    return Watch((context) => Text(notifier.signal.value));
  }
}
```

## Step 4: Migration Checklist

1. **Update service_locator.dart**
   - Replace `di` with `serviceLocator`
   - Remove `registerSingletonAsync` and `registerSingletonWithDependencies`
   - Use simple `registerSingleton` calls
   - Handle async initialization manually

2. **Convert Notifiers**
   - Replace `ChangeNotifier` with `Signal`
   - Remove `notifyListeners()` calls
   - Expose `ReadonlySignal` via a getter
   - Update interfaces to remove `ChangeNotifier` dependency (optional)

3. **Update Widgets**
   - Replace `WatchingWidget` with `SignalWidget`
   - Replace `WatchingStatefulWidget` with `SignalStatefulWidget`
   - Replace `watchPropertyValue` with direct signal access
   - Use `Watch` widget for fine-grained reactivity

4. **Update main.dart**
   - Replace `serviceLocator()` with `serviceLocatorSignals()`
   - Update `Main` widget to use `SignalWidget`

5. **Remove watch_it dependency**
   - Remove `watch_it` from `pubspec.yaml`
   - Remove all `watch_it` imports

## Example: Complete Migration

### Before (watch_it)
```dart
// service_locator.dart
di.registerSingleton<MyNotifier>(MyNotifier());

// notifier.dart
class MyNotifier extends ChangeNotifier {
  String _value = '';
  String get value => _value;
  void setValue(String v) {
    _value = v;
    notifyListeners();
  }
}

// widget.dart
class MyWidget extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final value = watchPropertyValue((MyNotifier n) => n.value);
    return Text(value);
  }
}
```

### After (signals)
```dart
// service_locator_signals.dart
serviceLocator.registerSingleton<MyNotifier>(MyNotifier());

// notifier.dart
class MyNotifier {
  final Signal<String> _signal = signal('');
  String get value => _signal.value;
  ReadonlySignal<String> get signal => _signal.readonly();
  void setValue(String v) => _signal.value = v;
}

// widget.dart
class MyWidget extends SignalWidget {
  @override
  Widget buildWithSignals(BuildContext context) {
    final notifier = serviceLocator.get<MyNotifier>();
    return Watch((context) => Text(notifier.signal.value));
  }
}
```

## Benefits

1. **Simpler**: No complex DI container, just a Map
2. **Better Performance**: Signals are more efficient than ChangeNotifier
3. **Type Safety**: Direct signal access is more type-safe
4. **Less Boilerplate**: No need for `notifyListeners()`
5. **Modern**: Signals are the modern approach to reactive state management

## Notes

- The `signals` package is already in your `pubspec.yaml`
- You can migrate gradually, one notifier/widget at a time
- Consider updating interfaces to remove `ChangeNotifier` dependency for cleaner code
- Use `Watch` widget for automatic rebuilds when signals change

