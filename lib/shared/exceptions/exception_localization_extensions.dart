import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/shared/localization/localization.dart';

void showException(BuildContext context, Exception exception) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(exception.getTranslatedErrorMessage(context))),
  );
}

extension ExceptionLocalizationExtensions on Exception {
  String getTranslatedErrorMessage(BuildContext context) {
    return getLocalizedErrorMessage(AppLocalizations.of(context)!);
  }

  String getLocalizedErrorMessage(AppLocalizations s) {
    switch (runtimeType) {
      case TitleCannotBeEmptyException:
        return s.titleCannotBeEmptyErrorMessage;
    }
    return s.genericErrorMessage;
  }
}

extension ValidationFunctionExtensions on Exception? Function(String?) {
  String? Function(String?) translate(BuildContext context) {
    return (String? value) {
      return this(value)?.getTranslatedErrorMessage(context);
    };
  }

  String? Function(String?) localize(AppLocalizations s) {
    return (String? value) {
      return this(value)?.getLocalizedErrorMessage(s);
    };
  }
}
