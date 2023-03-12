import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/features/queues/notifiers/queue_items_notifier.dart';
import 'package:stage_queue/features/queues/widgets/queue_item_detail.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';

class SelectedQueueItem extends StatelessWidget {
  const SelectedQueueItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<QueueItem?>(
      valueListenable: context.getIt<EditingQueueItemNotifier>(),
      builder: (context, queueItem, _) {
        return queueItem == null
            ? const SizedBox()
            : _build(context, queueItem);
      },
    );
  }

  Widget _build(BuildContext context, QueueItem queueItem) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.dividerColor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: const QueueItemDetail(),
      ),
    );
  }
}
