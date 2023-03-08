import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:stage_queue/features/queues/models/queue_action.dart';
import 'package:stage_queue/features/queues/models/trigger.dart';
import 'package:stage_queue/shared/notifiers/list_notifier.dart';
import 'package:uuid/uuid.dart';

typedef QueueItemNotifier = ValueNotifier<QueueItem>;
typedef QueueItemsNotifier = ListNotifier<QueueItemNotifier>;

class QueueItem extends Equatable {
  QueueItem({
    this.title,
    this.description,
    this.trigger,
    this.actions = const [],
  }) : id = const Uuid().v4();

  final String id;
  final String? title;
  final String? description;
  final Trigger? trigger;
  final List<QueueAction> actions;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        trigger,
        ...actions,
      ];

  static Exception? validateTitle(String? title) {
    return null;
  }

  static Exception? validateDescription(String? description) {
    return null;
  }
}

class TitleCannotBeEmptyException implements Exception {
  const TitleCannotBeEmptyException();
}
