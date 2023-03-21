import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stage_queue/shared/installer/installer.dart';
import 'package:uuid/uuid.dart';

abstract class QueueAction extends ChangeNotifier {
  QueueAction({
    required String description,
    required this.logger,
    String? id,
  })  : _description = description,
        id = id ?? const Uuid().v4(),
        _loadingCompleter = Completer() {
    _initialize();
  }

  final String id;
  final Logger logger;
  String _description;
  Completer _loadingCompleter;

  String get description => _description;
  set description(String value) {
    if (value == _description) return;
    _description = value;
    notifyListeners();
  }

  Future<void> get loadingFuture => _loadingCompleter.future;

  Future<void> reinitialize() async {
    logger.v('reinitializing');
    _loadingCompleter = Completer();
    await _initialize();
    logger.v('reinitialized');
  }

  @mustCallSuper
  Future<void> _initialize() async {
    logger.v('initializing');
    await initializeInternal();
    _loadingCompleter.complete();
    logger.v('initialized');
  }

  Future<void> initializeInternal() => Future.value();

  @mustCallSuper
  Future<void> call() => execute();

  Future<void> execute() async {
    logger.v('executing');
    await executeInternal();
    logger.v('executed');
  }

  @protected
  Future<void> executeInternal();

  Widget icon(BuildContext context);
  Widget listTileContent(BuildContext context);
  Widget detailWidget(BuildContext context);

  static Exception? validateDescription(String? description) {
    if (description == null || description.isEmpty) {
      return const ActionDescriptionShouldNotBeEmptyException();
    }
    return null;
  }
}

class ActionDescriptionShouldNotBeEmptyException implements Exception {
  const ActionDescriptionShouldNotBeEmptyException();
}
