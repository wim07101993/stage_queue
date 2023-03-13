import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/audio/audio_file_action_data.dart';

class AudioFileActionListTileContent extends StatelessWidget {
  const AudioFileActionListTileContent({
    super.key,
    required this.data,
  });

  final AudioFileActionData data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        data.filePath,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
