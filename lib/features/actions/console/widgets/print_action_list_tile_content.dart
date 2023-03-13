import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/console/console_action.dart';

class PrintActionListTileContent extends StatelessWidget {
  const PrintActionListTileContent({
    super.key,
    required this.data,
  });

  final ConsoleAction data;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Print Action: ${data.description}',
      overflow: TextOverflow.ellipsis,
    );
  }
}
