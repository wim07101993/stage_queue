import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/audio/audio_file_action.dart';
import 'package:stage_queue/features/actions/audio/widgets/audio_file_form_field.dart';
import 'package:stage_queue/features/actions/notifiers/actions_notifier.dart';
import 'package:stage_queue/features/actions/widgets/form_fields/description_form_field.dart';
import 'package:stage_queue/features/queues/widgets/save_button.dart';
import 'package:stage_queue/shared/logging/get_it_extensions.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';

class NewAudioFileActionForm extends StatefulWidget {
  const NewAudioFileActionForm({super.key});

  @override
  State<NewAudioFileActionForm> createState() => _NewAudioFileActionFormState();
}

class _NewAudioFileActionFormState extends State<NewAudioFileActionForm> {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final audioFilePathController = ValueNotifier<FilePickerResult?>(null);

  @override
  void initState() {
    super.initState();
    audioFilePathController.addListener(onAudioFileChanged);
  }

  @override
  void dispose() {
    audioFilePathController.removeListener(onAudioFileChanged);
    super.dispose();
  }

  void save() {
    if (formKey.currentState?.validate() != true) {
      return;
    }
    final filePath = audioFilePathController.value?.paths.first;
    assert(
      filePath != null,
      'Audio file-path should not be null because validator should have checked that.',
    );
    if (filePath == null) {
      return;
    }
    final getIt = context.getIt;
    getIt<ActionsNotifier>().add(
      AudioFileAction(
        audioPlayer: getIt(),
        logger: getIt.logger(
          loggerName: 'AudioAction ${descriptionController.text}',
        ),
        filePath: filePath,
        description: descriptionController.text,
      ),
    );
  }

  void onAudioFileChanged() {
    if (descriptionController.text.isNotEmpty) {
      return;
    }
    final filePath = audioFilePathController.value?.paths.first;
    if (filePath == null) {
      return;
    }
    final fileNameWithExtension = filePath.split(Platform.pathSeparator).last;
    final extensionIndex = fileNameWithExtension.lastIndexOf('.');
    if (extensionIndex > 0) {
      descriptionController.text =
          fileNameWithExtension.substring(0, extensionIndex);
    } else {
      descriptionController.text = fileNameWithExtension;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.localizations;
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(s.newAudioFileActionTitle, style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          AudioFileFormField(controller: audioFilePathController),
          const SizedBox(height: 16),
          DescriptionFormField(controller: descriptionController),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: SaveButton(onTap: save),
          ),
        ],
      ),
    );
  }
}
