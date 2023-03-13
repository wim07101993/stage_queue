import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/audio/audio_file_action_data.dart';

class AudioFileActionDetail extends StatelessWidget {
  const AudioFileActionDetail({
    super.key,
    required this.data,
  });

  final AudioFileActionData data;

  @override
  Widget build(BuildContext context) {
    return Text(data.filePath);
  }
}
