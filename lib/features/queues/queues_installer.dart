import 'package:faker/faker.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/shared/installer/installer.dart';
import 'package:stage_queue/test_data/faker_extensions.dart';

class QueuesInstaller extends Installer {
  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerLazySingleton(
      () => QueueItemsNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );
  }

  @override
  Future<void> installInternal(GetIt getIt) {
    getIt<QueueItemsNotifier>().value = faker.stageQueue.queues
        .queueItemList()
        .map((item) => QueueItemNotifier(item))
        .toList();

    return Future.value();
  }
}
