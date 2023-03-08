import 'package:faker/faker.dart';
import 'package:stage_queue/features/queues/notifiers/queue_items_notifier.dart';
import 'package:stage_queue/shared/installer/installer.dart';
import 'package:stage_queue/test_data/faker_extensions.dart';

class QueuesInstaller extends Installer {
  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerLazySingleton(
      () => QueueItemsNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );
    getIt.registerLazySingleton(
      () => EditingQueueItemNotifier(null),
      dispose: (notifier) => notifier.dispose(),
    );
  }

  @override
  Future<void> installInternal(GetIt getIt) {
    getIt<QueueItemsNotifier>().value = faker.stageQueue.queues.queueItemList();

    return Future.value();
  }
}
