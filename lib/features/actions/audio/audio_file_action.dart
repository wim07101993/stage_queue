import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/audio/widgets/audio_file_action_detail.dart';
import 'package:stage_queue/features/actions/audio/widgets/audio_file_action_list_tile_content.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class AudioFileAction extends QueueAction {
  AudioFileAction({
    required this.audioPlayer,
    required String filePath,
    required super.description,
    super.id,
  }) : _filePath = filePath;

  final AudioPlayer audioPlayer;
  String _filePath;

  String get filePath => _filePath;
  set filePath(String value) {
    if (value == filePath) return;
    _filePath = value;
    reinitialize();
    notifyListeners();
  }

  @override
  Future<void> initializeInternal() async {
    await audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    await audioPlayer.setSource(DeviceFileSource(filePath));
    // await audioPlayer.seek(const Duration(minutes: 1));
  }

  @override
  Future<void> execute() {
    return audioPlayer.resume();
  }

  @override
  Widget detailWidget(BuildContext context) {
    return AudioFileActionDetail(action: this);
  }

  @override
  Widget icon(BuildContext context) {
    return const Icon(Icons.music_note);
  }

  @override
  Widget listTileContent(BuildContext context) {
    return AudioFileActionListTileContent(action: this);
  }
}
