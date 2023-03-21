import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/audio/audio_file_action.dart';
import 'package:stage_queue/shared/localization/localization.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';
import 'package:stage_queue/shared/widgets/file_form_field.dart';

class AudioFileFormField extends StatelessWidget {
  const AudioFileFormField({
    super.key,
    required this.controller,
  });

  final FileFieldController controller;

  @override
  Widget build(BuildContext context) {
    final s = context.localizations;
    return FileFormField(
      controller: controller,
      dialogTitle: s.audioFilePickerDialogTitle,
      type: FileType.audio,
      validator: (result) =>
          AudioFileAction.validateFilePath.localize(s)(result?.paths.first),
    );
  }
}
