import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/audio/widgets/audio_file_action_detail.dart';
import 'package:stage_queue/features/actions/audio/widgets/audio_file_action_list_tile_content.dart';
import 'package:stage_queue/features/actions/models/queue_action_data.dart';

class AudioFileActionData extends QueueActionData {
  AudioFileActionData({
    required this.filePath,
    required super.description,
    super.id,
  });

  final String filePath;

  late AudioPlayer audioPlayer;

  @override
  Widget detailWidget(BuildContext context) {
    return AudioFileActionDetail(data: this);
  }

  @override
  Widget icon(BuildContext context) {
    return const Icon(Icons.music_note);
  }

  @override
  Widget listTileContent(BuildContext context) {
    return AudioFileActionListTileContent(data: this);
  }
}
