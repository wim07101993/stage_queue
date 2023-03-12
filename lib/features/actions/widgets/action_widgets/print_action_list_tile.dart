import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class PrintActionListTile extends StatelessWidget {
  const PrintActionListTile({
    super.key,
    required this.action,
  });

  final PrintAction action;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Print Action: ${action.description}',
      overflow: TextOverflow.ellipsis,
    );
  }
}
