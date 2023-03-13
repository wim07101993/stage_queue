import 'package:faker/faker.dart';
import 'package:stage_queue/features/actions/console/console_action.dart';
import 'package:stage_queue/features/actions/console/console_action_data.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';
import 'package:stage_queue/features/actions/models/queue_action_data.dart';

class Actions {
  const Actions();

  ConsoleActionData consoleActionData() {
    return ConsoleActionData(
      description: faker.lorem.word(),
    );
  }

  List<QueueActionData> actionDataList() {
    return faker.randomGenerator
        .amount((i) => consoleActionData(), 50, min: 10);
  }

  ConsoleAction consoleAction() {
    return ConsoleAction(data: consoleActionData());
  }

  List<QueueAction<QueueActionData>> actionList() {
    return faker.randomGenerator.amount((i) => consoleAction(), 50, min: 10);
  }
}
