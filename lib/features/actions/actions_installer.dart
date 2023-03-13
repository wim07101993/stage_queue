import 'package:faker/faker.dart';
import 'package:stage_queue/features/actions/notifiers/actions_notifier.dart';
import 'package:stage_queue/shared/installer/installer.dart';
import 'package:stage_queue/test_data/faker_extensions.dart';

class ActionsInstaller extends Installer {
  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerLazySingleton(
      () => ActionsNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );
    getIt.registerLazySingleton(
      () => EditingActionNotifier(getIt<ActionsNotifier>().first),
      dispose: (notifier) => notifier.dispose(),
    );
  }

  @override
  Future<void> installInternal(GetIt getIt) {
    final actions = faker.stageQueue.actions.actionList();
    getIt<ActionsNotifier>().value = actions;

    return Future.value();
  }
}
