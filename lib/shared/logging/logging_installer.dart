import 'package:stage_queue/shared/installer/installer.dart';

class LoggingInstaller extends Installer {
  @override
  void registerDependenciesInternal(GetIt getIt) {
    getIt.registerLazySingleton(() => LogsController());
    getIt.registerLazySingleton<LogSink>(
      () => MultiLogSink(
        [
          PrintSink(
            LevelDependentFormatter(
              defaultFormatter: SimpleFormatter(),
              severe: PrettyFormatter(),
              shout: PrettyFormatter(),
            ),
          ),
          LogsControllerLogSink(controller: getIt()),
        ],
      ),
      dispose: (sink) => sink.dispose(),
    );

    getIt.registerFactoryParam<Logger, String, dynamic>(
      (loggerName, _) => createLogger(getIt, loggerName),
    );
  }

  Logger createLogger(GetIt getIt, String loggerName) {
    final loggerInstanceName = '$loggerName-logger';
    if (getIt.isRegistered<Logger>(instanceName: loggerInstanceName)) {
      return getIt(instanceName: loggerInstanceName);
    }
    final logger = Logger(loggerName);
    getIt<LogSink>().listenTo(logger.onRecord);
    getIt.registerSingleton(logger, instanceName: loggerInstanceName);
    return logger;
  }
}
