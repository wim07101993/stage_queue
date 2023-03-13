import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class QueueAction extends ChangeNotifier {
  QueueAction({
    required String description,
    String? id,
  })  : _description = description,
        id = id ?? const Uuid().v4(),
        _loadingCompleter = Completer() {
    _initialize();
  }

  final String id;
  String _description;
  Completer _loadingCompleter;

  String get description => _description;
  set description(String value) {
    if (value == _description) return;
    _description = value;
    notifyListeners();
  }

  Future<void> get loadingFuture => _loadingCompleter.future;

  Future<void> reinitialize() {
    _loadingCompleter = Completer();
    return _initialize();
  }

  @mustCallSuper
  Future<void> _initialize() async {
    await initializeInternal();
    _loadingCompleter.complete();
  }

  Future<void> initializeInternal() => Future.value();

  @mustCallSuper
  Future<void> call() => execute();

  @mustCallSuper
  Future<void> execute();

  Widget icon(BuildContext context);
  Widget listTileContent(BuildContext context);
  Widget detailWidget(BuildContext context);
}
