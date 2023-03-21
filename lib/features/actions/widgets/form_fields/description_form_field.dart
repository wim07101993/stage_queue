import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';
import 'package:stage_queue/shared/localization/localization.dart';

class DescriptionFormField extends StatelessWidget {
  const DescriptionFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      validator: QueueAction.validateDescription.localize(s),
      decoration: InputDecoration(
        label: Text(s.queueActionDescriptionFieldLabel),
      ),
    );
  }
}
