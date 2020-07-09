# snapshot_helper

A simple helper to manage widget output from the AsyncSnapshot of a stream.

# Basic usage
Instantiate the helper from an `AsyncSnapshot<T>` and the call `getWidget` specifying the builders for different situations:

```dart
StreamBuilder(
    stream: streamController.stream,
    builder: (context, snapshot) =>
        SnapshotHelper.of(snapshot).getWidget(
    onData: (snapshot) => DataWidget(),
    onLoading: (snapshot) => LoadingWidget(),
    onError: (snapshot) => ErrorWidget(),
    ),
)
```

## Constructor parameters
- `loadingPredicate`: predicate to determine when the loading widget has to be returned
- `dataPredicate`: predicate to determine when the data widget has to be returned
- `errorPredicate`: predicate to determine when the error widget has to be returned

The predicates are optional and should be supplied only when in need of more custom scenarios.

## getWidget parameters
- `onLoading`: loading widget builder
- `onData`: data widget builder
- `onError`: error widget builder
- `defaultWidget`: placeholder widget in case no state is matched by the predicates

## Subclassing
You can `extend` the `SnapshotHelper` class in order to have you own custom rules too.