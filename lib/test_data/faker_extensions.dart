import 'package:faker/faker.dart';

import 'features/queues.dart';

class StageQueue {
  const StageQueue();

  Queues get queues => const Queues();
}

extension TestDataFakerExtensions on Faker {
  StageQueue get stageQueue => const StageQueue();

  T? nullOr<T>(T Function() generator) {
    return faker.randomGenerator.boolean() ? generator() : null;
  }
}
