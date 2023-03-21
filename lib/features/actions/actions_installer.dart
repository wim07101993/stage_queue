import 'package:audioplayers/audioplayers.dart';
import 'package:stage_queue/features/actions/audio/audio_file_action.dart';
import 'package:stage_queue/features/actions/notifiers/actions_notifier.dart';
import 'package:stage_queue/shared/installer/installer.dart';
import 'package:stage_queue/shared/logging/get_it_extensions.dart';

class ActionsInstaller extends Installer {
  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerLazySingleton(
      () => ActionsNotifier(),
      dispose: (notifier) => notifier.dispose(),
    );
    getIt.registerLazySingleton(
      () => EditingActionNotifier(getIt<ActionsNotifier>().firstOrNull),
      dispose: (notifier) => notifier.dispose(),
    );
    getIt.registerFactory(() => AudioPlayer());
  }

  @override
  Future<void> installInternal(GetIt getIt) {
    final audioAction = AudioFileAction(
      audioPlayer: getIt(),
      logger: getIt.logger(loggerName: 'AudioAction james bond'),
      filePath: '/home/wim/Music/toneel2023/James bond 007 - Theme.mp3',
      description: 'james bond',
    );
    getIt<ActionsNotifier>().value = [audioAction];

    return Future.value();
  }
}
