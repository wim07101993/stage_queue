import 'package:faker/faker.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:stage_queue/features/actions/console/console_action.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class Actions {
  const Actions();

  ConsoleAction consoleAction() {
    return ConsoleAction(
      description: faker.lorem.word(),
      logger: Logger('test'),
    );
  }

  List<QueueAction> actionList() {
    return faker.randomGenerator.amount((i) => consoleAction(), 50, min: 10);
  }
}
