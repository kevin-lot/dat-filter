// A basic logger, which logs any state changes.
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class LoggerProvider extends ProviderObserver {
  @override
  void didUpdateProvider(
    final ProviderObserverContext context,
    final Object? previousValue,
    final Object? newValue,
  ) {
    print('''
{
  "provider": "${context.provider}",
  "previousValue": "$previousValue",
  "newValue": "$newValue",
  "mutation": "${context.mutation}"
}''');
  }
}
