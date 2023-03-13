import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/audio/audio_file_action.dart';

class AudioFileActionDetail extends StatelessWidget {
  const AudioFileActionDetail({
    super.key,
    required this.action,
  });

  final AudioFileAction action;

  @override
  Widget build(BuildContext context) {
    return Text(action.filePath);
  }
}
