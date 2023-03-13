import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/console/console_action_data.dart';

class PrintActionDetail extends StatelessWidget {
  const PrintActionDetail({super.key, required this.data});

  final ConsoleActionData data;

  @override
  Widget build(BuildContext context) {
    return Text('This is a print action which prints: ${data.description}');
  }
}
