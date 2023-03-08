import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_queue/app.dart';
import 'package:stage_queue/features/queues/queues_installer.dart';
import 'package:stage_queue/shared/installer/get_it_extensions.dart';
import 'package:stage_queue/shared/installer/installer.dart';
import 'package:stage_queue/shared/logging/logging_installer.dart';

Future<void> main() async {
  final getIt = GetIt.asNewInstance()..registerInstallers();
  return run(getIt);
}

Future<void> run(GetIt getIt) async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerDependencies();
  await getIt.installInstallers();
  runApp(
    Provider<GetIt>(
      create: (_) => getIt,
      builder: (context, child) => const App(),
    ),
  );
}

extension _MainGetItExtensions on GetIt {
  void registerInstallers() {
    registerSingleton(LoggingInstaller());
    registerSingleton(QueuesInstaller());
    registerLazySingleton<List<Installer>>(
      () => [
        get<LoggingInstaller>(),
        get<QueuesInstaller>(),
      ],
    );
  }
}
