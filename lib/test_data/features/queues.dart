import 'package:faker/faker.dart';
import 'package:stage_queue/features/queues/models/queue_action.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/features/queues/models/trigger.dart';
import 'package:stage_queue/shared/notifiers/list_notifier.dart';
import 'package:stage_queue/test_data/faker_extensions.dart';

class Queues {
  const Queues();

  QueueItem queueItem() {
    return QueueItem(
      title: faker.lorem.word(),
      description: faker.nullOr(() => faker.lorem.sentence()),
      trigger: trigger(),
      actions: faker.randomGenerator.amount((i) => queueAction(), 5),
    );
  }

  Trigger trigger() {
    return const _FakeTrigger();
  }

  QueueAction queueAction() {
    return _FakeQueueAction(
      description: faker.lorem.word(),
    );
  }

  List<QueueItem> queueItemList() {
    return faker.randomGenerator.amount(
      (i) => queueItem(),
      50,
      min: 10,
    );
  }

  ListNotifier queueItems() {
    return ListNotifier()..value = queueItemList();
  }
}

class _FakeTrigger extends Trigger {
  const _FakeTrigger();

  @override
  List<Object?> get props => const [];
}

class _FakeQueueAction extends QueueAction {
  const _FakeQueueAction({
    required this.description,
  });

  @override
  final String? description;

  @override
  List<Object?> get props => [description];
}
