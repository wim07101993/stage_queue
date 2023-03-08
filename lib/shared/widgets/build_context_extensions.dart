import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:stage_queue/shared/localization/localization.dart';

extension BuildContextExtensions on BuildContext {
  GetIt get getIt => read();
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
