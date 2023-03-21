import 'package:stage_queue/features/queues/notifiers/queue_items_notifier.dart';
import 'package:stage_queue/shared/installer/installer.dart';

class QueuesInstaller extends Installer {
  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerLazySingleton(
      () => QueueItemsNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );
    getIt.registerLazySingleton(
      () => EditingQueueItemNotifier(getIt<QueueItemsNotifier>().firstOrNull),
      dispose: (notifier) => notifier.dispose(),
    );
  }
}
