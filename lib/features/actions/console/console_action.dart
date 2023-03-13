import 'package:faker/faker.dart';
import 'package:stage_queue/features/actions/console/console_action_data.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class ConsoleAction extends QueueAction<ConsoleActionData> {
  ConsoleAction({
    required super.data,
  });

  @override
  Future<void> initializeInternal() {
    return Future.delayed(
      Duration(milliseconds: faker.randomGenerator.integer(10000, min: 1000)),
    );
  }

  @override
  Future<void> execute() {
    print(data.description);
    return Future.value();
  }
}
