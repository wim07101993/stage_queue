import 'package:faker/faker.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/shared/notifiers/list_notifier.dart';
import 'package:stage_queue/test_data/faker_extensions.dart';

class Queues {
  const Queues();

  QueueItem queueItem() {
    return QueueItem(
      title: faker.lorem.word(),
      description: faker.nullOr(() => faker.lorem.sentence()),
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
