import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class TriggerButton extends StatelessWidget {
  const TriggerButton({
    super.key,
    required this.action,
  });

  final QueueAction action;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: action.loadingFuture,
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? IconButton(
                onPressed: action.execute,
                icon: const Icon(Icons.play_arrow, color: Colors.green),
              )
            : const IconButton(
                onPressed: null,
                icon: Icon(Icons.play_arrow),
              );
      },
    );
  }
}
