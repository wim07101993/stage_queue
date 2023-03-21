import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:stage_queue/features/actions/audio/widgets/audio_file_action_detail.dart';
import 'package:stage_queue/features/actions/audio/widgets/audio_file_action_list_tile_content.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class AudioFileAction extends QueueAction {
  AudioFileAction({
    required this.audioPlayer,
    required String filePath,
    required super.description,
    required super.logger,
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
  Future<void> initializeInternal() {
    final initCompleter = Completer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await audioPlayer.setSource(DeviceFileSource(filePath));
      // since the api does indicate when the file is buffering, we let the
      // initialization completer run until the song can play.
      await audioPlayer.setVolume(0);
      logger.v('waiting for file to be loaded');
      await audioPlayer.resume();
      await audioPlayer.onPositionChanged.firstWhere(
        (time) => time >= const Duration(milliseconds: 1),
      );
      await audioPlayer.stop();
      await audioPlayer.setVolume(1);
      logger.v('done loading file');
      initCompleter.complete();
    });
    return initCompleter.future;
  }

  @override
  Future<void> executeInternal() async {
    await audioPlayer.resume();
    await audioPlayer.onPlayerComplete.first;
    await audioPlayer.seek(Duration.zero);
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

  static Exception? validateFilePath(String? filePath) {
    if (filePath == null || filePath.isEmpty) {
      return const AudioFilePathCannotBeEmptyException();
    }
    if (!File(filePath).existsSync()) {
      return const AudioFileNotFoundException();
    }
    return null;
  }
}

class AudioFilePathCannotBeEmptyException implements Exception {
  const AudioFilePathCannotBeEmptyException();
}

class AudioFileNotFoundException implements Exception {
  const AudioFileNotFoundException();
}
