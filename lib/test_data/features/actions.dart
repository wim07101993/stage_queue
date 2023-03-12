import 'package:faker/faker.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class Actions {
  const Actions();

  QueueAction queueAction() {
    return PrintAction(
      description: faker.lorem.word(),
    );
  }

  List<QueueAction> queueActionList() {
    return faker.randomGenerator.amount((i) => queueAction(), 50, min: 10);
  }
}
