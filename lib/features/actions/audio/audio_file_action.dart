import 'package:audioplayers/audioplayers.dart';
import 'package:stage_queue/features/actions/audio/audio_file_action_data.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class AudioFileAction extends QueueAction<AudioFileActionData> {
  AudioFileAction({
    required this.audioPlayer,
    required super.data,
  });

  final AudioPlayer audioPlayer;

  @override
  Future<void> initializeInternal() async {
    await audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    await audioPlayer.setSource(DeviceFileSource(data.filePath));
    // await audioPlayer.seek(const Duration(minutes: 1));
  }

  @override
  Future<void> execute() {
    return audioPlayer.resume();
  }
}
