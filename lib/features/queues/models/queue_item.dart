import 'package:equatable/equatable.dart';
import 'package:stage_queue/features/queues/models/queue_action.dart';
import 'package:stage_queue/features/queues/models/trigger.dart';
import 'package:uuid/uuid.dart';

class QueueItem extends Equatable {
  QueueItem({
    required this.title,
    this.description,
    this.trigger,
    this.actions = const [],
    String? id,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String title;
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
