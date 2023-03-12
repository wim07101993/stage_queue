import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class TriggerButton extends StatelessWidget {
  const TriggerButton({
    super.key,
    required this.itemToTrigger,
  });

  final QueueAction itemToTrigger;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: itemToTrigger,
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.green,
      ),
    );
  }
}
