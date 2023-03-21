import 'package:flutter/foundation.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:get_it/get_it.dart';
import 'package:stage_queue/shared/installer/get_it_extensions.dart';
import 'package:stage_queue/shared/logging/get_it_extensions.dart';
import 'package:stage_queue/shared/logging/logging_installer.dart';

export 'package:flutter_fox_logging/flutter_fox_logging.dart';
export 'package:get_it/get_it.dart';

class Installer {
  bool _hasRegisteredDependencies = false;
  bool _hasInstalled = false;
  Logger? _logger;

  /// Indicates the priority of the installer. Number 1 is the highest priority.
  ///
  /// The higher the number, the lower the priority. Defaults to 100.
  final int priority = 100;

  bool get hasRegisteredDependencies => _hasRegisteredDependencies;
  bool get hasInstalled => _hasInstalled;

  Logger? logger(GetIt getIt) {
    if (_logger != null) {
      return _logger;
    }
    if (getIt.tryGet<LoggingInstaller>()?.hasInstalled != true ||
        !getIt.isRegistered<Logger>()) {
      return null;
    }
    return _logger = getIt.logger(
      // ignore: no_runtimetype_tostring
      loggerName: runtimeType.toString(),
    );
  }

  void registerDependencies(GetIt getIt) {
    if (hasRegisteredDependencies) {
      return;
    }
    logger(getIt)?.d('registering dependencies');
    registerDependenciesInternal(getIt);
    _hasRegisteredDependencies = true;
    logger(getIt)?.d('done registering dependencies');
  }

  @protected
  void registerDependenciesInternal(GetIt getIt) {}

  Future<void> install(GetIt getIt) async {
    registerDependencies(getIt);
    if (hasInstalled) {
      return;
    }
    logger(getIt)?.d('installing');
    await installInternal(getIt);
    _hasInstalled = true;
    logger(getIt)?.d('done installing');
  }

  @protected
  Future<void> installInternal(GetIt getIt) => Future.value();
}
