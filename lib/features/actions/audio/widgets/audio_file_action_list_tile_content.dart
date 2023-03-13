import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/audio/audio_file_action.dart';

class AudioFileActionListTileContent extends StatelessWidget {
  const AudioFileActionListTileContent({
    super.key,
    required this.action,
  });

  final AudioFileAction action;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        action.filePath,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
