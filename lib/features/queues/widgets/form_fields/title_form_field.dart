import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/shared/localization/localization.dart';

class TitleFormField extends StatelessWidget {
  const TitleFormField({
    super.key,
    required this.controller,
    this.style,
  });

  final TextEditingController controller;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      validator: QueueItem.validateTitle.localize(s),
      style: style,
      decoration: InputDecoration(
        label: Text(s.titleFieldLabel),
      ),
    );
  }
}
