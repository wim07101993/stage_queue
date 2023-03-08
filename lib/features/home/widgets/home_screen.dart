import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:stage_queue/features/queues/widgets/queue_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueueList(
        isInModifyMode: true,
        queueItems: context.read<GetIt>()(),
      ),
    );
  }
}
