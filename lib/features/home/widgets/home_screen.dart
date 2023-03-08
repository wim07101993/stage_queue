import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/widgets/queue_list.dart';
import 'package:stage_queue/features/queues/widgets/selected_queue_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Expanded(child: QueueList(isInModifyMode: true)),
          SelectedQueueItem(),
        ],
      ),
    );
  }
}
