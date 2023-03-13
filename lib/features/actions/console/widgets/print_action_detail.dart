import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/console/console_action.dart';

class PrintActionDetail extends StatelessWidget {
  const PrintActionDetail({
    super.key,
    required this.action,
  });

  final ConsoleAction action;

  @override
  Widget build(BuildContext context) {
    return Text('This is a print action which prints: ${action.description}');
  }
}
