# Quick Start: Using Signals in Flutter

## Files Created

3. **`examples/signal_notifiers_example.dart`** - Examples of signal-based notifiers
4. **`adapters/notifier_to_signal_adapter.dart`** - Bridge for gradual migration

## Basic Usage

### 1. Register Services

```dart
import 'package:app/service_locator_signals.dart';

// In your initialization code
serviceLocator.registerSingleton<MyService>(MyService());
```

### 2. Get Services

```dart
final service = serviceLocator.get<MyService>();
```

### 3. Create Signal-Based Notifier

```dart
import 'package:signals/signals.dart';

class MyNotifier {
  final Signal<String> _signal = signal('initial');
  
  String get value => _signal.value;
  ReadonlySignal<String> get signal => _signal.readonly();
  
  void update(String newValue) {
    _signal.value = newValue;
  }
}
```

### 4. Use in Widgets

```dart
import 'package:app/widgets/signal_widgets.dart';
import 'package:app/service_locator_signals.dart';
import 'package:signals/signals.dart';

class MyWidget extends SignalWidget {
  @override
  Widget buildWithSignals(BuildContext context) {
    final notifier = serviceLocator.get<MyNotifier>();
    return Watch((context) => Text(notifier.signal.value));
  }
}
```

## Migration Path

### Option 1: Gradual Migration (Recommended)

Use the adapter to bridge existing notifiers:

```dart
// Keep existing ChangeNotifier-based notifiers
// Use adapter to expose signals
final notifier = serviceLocator.get<LocaleNotifierInterface>();
final localeSignal = notifierToSignal(notifier, () => notifier.value);

// Use in widgets
Watch((context) => Text(localeSignal.value.languageCode));
```

### Option 2: Full Migration

Convert all notifiers to signals (see `examples/signal_notifiers_example.dart`)

## Key Differences from watch_it

| watch_it | Signals |
|----------|---------|
| `di.registerSingleton<T>()` | `serviceLocator.registerSingleton<T>()` |
| `di<T>()` | `serviceLocator.get<T>()` |
| `WatchingWidget` | `SignalWidget` |
| `WatchingStatefulWidget` | `SignalStatefulWidget` |
| `watchPropertyValue((n) => n.value)` | `notifier.signal.value` (inside `Watch`) |
| `notifyListeners()` | Automatic (signals handle it) |

## Next Steps

1. Review `SIGNALS_MIGRATION_GUIDE.md` for detailed migration steps
2. Check `examples/signal_notifiers_example.dart` for notifier patterns
3. See `main_signals_example.dart` for widget examples
4. Start migrating one notifier/widget at a time
