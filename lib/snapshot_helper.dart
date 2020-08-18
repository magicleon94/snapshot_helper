import 'package:flutter/widgets.dart';

typedef SnapshotBuilder<T> = Widget Function(AsyncSnapshot<T>);
typedef SnapshotPredicate<T> = bool Function(AsyncSnapshot<T>);

/// AsyncSnapshot wrapper
class SnapshotHelper<T> {
  /// [snapshot] is the original snapshot to process
  final AsyncSnapshot<T> snapshot;
  final SnapshotPredicate<T> _loadingPredicate;
  final SnapshotPredicate<T> _dataPredicate;
  final SnapshotPredicate<T> _errorPredicate;

  SnapshotHelper(
    this.snapshot, {

    /// [loadingPredicate] is the optional predicate to determine the loading status
    SnapshotPredicate<T> loadingPredicate,

    /// [dataPredicate] is the optional predicate to determine the onData status
    SnapshotPredicate<T> dataPredicate,

    /// [errorPredicate] is the optional predicate to determine the onError status
    SnapshotPredicate<T> errorPredicate,
    Widget defaultWidget,
  })  : _loadingPredicate = loadingPredicate,
        _dataPredicate = dataPredicate,
        _errorPredicate = errorPredicate;

  /// [defaultLoadingPredicate] is the default predicate to determine the loading status
  @protected
  bool defaultLoadingPredicate(AsyncSnapshot<T> snapshot) =>
      (snapshot.connectionState == ConnectionState.waiting) ||
      (snapshot.connectionState == ConnectionState.active && !snapshot.hasData);

  /// [defaultDataPredicate] is the default predicate to determine the onData status
  @protected
  bool defaultDataPredicate(AsyncSnapshot<T> snapshot) =>
      snapshot.hasData && !snapshot.hasError;

  /// [defaultErrorPredicate] is the default predicate to determine the onError status
  @protected
  bool defaultErrorPredicate(AsyncSnapshot<T> snapshot) => snapshot.hasError;

  ///Creates an instance of the helper for the given [snapshot].
  ///Supply additional predicates in case of needing more complex rules.
  factory SnapshotHelper.of(
    AsyncSnapshot<T> snapshot, {
    SnapshotPredicate<T> loadingPredicate,
    SnapshotPredicate<T> dataPredicate,
    SnapshotPredicate<T> errorPredicate,
  }) =>
      SnapshotHelper<T>(
        snapshot,
        loadingPredicate: loadingPredicate,
        dataPredicate: dataPredicate,
        errorPredicate: errorPredicate,
      );

  ///Call this to build the widget in the cases of [onData], [onError] or [onLoading]
  ///Supply a [defaultWidget] in case any state is matched
  Widget getWidget({
    SnapshotBuilder<T> onData,
    SnapshotBuilder<T> onError,
    SnapshotBuilder<T> onLoading,
    Widget defaultWidget,
  }) {
    if (_errorPredicate?.call(snapshot) ?? defaultErrorPredicate(snapshot)) {
      return onError(snapshot);
    }

    if (_loadingPredicate?.call(snapshot) ??
        defaultLoadingPredicate(snapshot)) {
      return onLoading(snapshot);
    }

    if (_dataPredicate?.call(snapshot) ?? defaultDataPredicate(snapshot)) {
      return onData(snapshot);
    }

    return defaultWidget;
  }
}
