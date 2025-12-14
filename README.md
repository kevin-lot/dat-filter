


### Tree decision

| | synchronous | future | stream |
|---|---|---|---|
| __unmodifiable__ | Provider | FutureProvider | StreamProvider |
| __modifiable__ | NotifierProvider | AsyncNotifierProvider | StreamNotifierProvider |

### Tree decision

| use | situation | observations |
|---|---|---|
| Provider | simple sync value |
| FutureProvider | simple async fetch |
| StreamProvider | stream | something external emits events, and I want Riverpod to react to them |
| | | |
| NotifierProvider | complex sync state + methods to mute state |
| AsyncNotifierProvider | async complex state + methods to mute state |
| StreamNotifierProvider | async stream + methods to mute state | something external emits events, and I want Riverpod to react to them |