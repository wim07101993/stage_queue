import 'package:faker/faker.dart';
import 'package:stage_queue/test_data/features/actions.dart';
import 'package:stage_queue/test_data/features/queues.dart';

class StageQueue {
  const StageQueue();

  Queues get queues => const Queues();
  Actions get actions => const Actions();
}

extension TestDataFakerExtensions on Faker {
  StageQueue get stageQueue => const StageQueue();

  T? nullOr<T>(T Function() generator) {
    return faker.randomGenerator.boolean() ? generator() : null;
  }
}
