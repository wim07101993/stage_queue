import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class QueueAction<T> {
  QueueAction({
    required this.data,
  }) : _loadingCompleter = Completer();

  final Completer _loadingCompleter;
  final T data;

  Future<void> get loadingFuture => _loadingCompleter.future;

  @mustCallSuper
  Future<void> initialize() async {
    await initializeInternal();
    _loadingCompleter.complete();
  }

  Future<void> initializeInternal() => Future.value();

  @mustCallSuper
  Future<void> call() => execute();

  @mustCallSuper
  Future<void> execute();
}
