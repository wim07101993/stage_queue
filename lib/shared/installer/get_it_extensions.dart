import 'package:collection/collection.dart';
import 'package:stage_queue/shared/installer/installer.dart';

extension InstallerGetItExtensions on GetIt {
  Iterable<MapEntry<int, List<Installer>>> get installersByPriority {
    return get<List<Installer>>()
        .groupListsBy((installer) => installer.priority)
        .entries
      ..sorted((a, b) => a.key.compareTo(b.key));
  }

  void registerDependencies() {
    for (final installer in installersByPriority.mapMany((e) => e.value)) {
      installer.registerDependencies(this);
    }
  }

  Future<void> installInstallers() async {
    for (final installers in installersByPriority) {
      await Future.wait(
        installers.value.map((installer) => installer.install(this)),
      );
    }
  }
}
