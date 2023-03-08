import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';

class TriggerButton extends StatelessWidget {
  const TriggerButton({
    super.key,
    required this.itemToTrigger,
  });

  final QueueItem itemToTrigger;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        print('TODO trigger ${itemToTrigger.id}');
      },
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.green,
      ),
    );
  }
}
