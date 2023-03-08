import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/features/queues/widgets/form_fields/index_form_field.dart';
import 'package:stage_queue/features/queues/widgets/form_fields/title_form_field.dart';
import 'package:stage_queue/shared/localization/localization.dart';

class CreateQueueItemDialog extends StatefulWidget {
  const CreateQueueItemDialog({super.key});

  @override
  State<CreateQueueItemDialog> createState() => _CreateQueueItemDialogState();
}

class _CreateQueueItemDialogState extends State<CreateQueueItemDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final insertIndexController = TextEditingController();

  void _create() {
    print('here');
    final insertIndex = int.parse(insertIndexController.text) - 1;
    Navigator.of(context).pop(
      CreateQueueItemDialogResponse(
        insertIndex: max(insertIndex, 0),
        queueItem: QueueItem(title: titleController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: formKey,
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  s.createQueueItemDialogTitle,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TitleFormField(controller: titleController),
                const SizedBox(height: 16),
                IndexFormField(controller: insertIndexController),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _create,
                      child: Text(s.createQueueItemCreateButtonLabel),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(s.createQueueItemCancelButtonLabel),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateQueueItemDialogResponse {
  const CreateQueueItemDialogResponse({
    required this.queueItem,
    required this.insertIndex,
  });

  final QueueItem queueItem;
  final int insertIndex;
}
