import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';

export 'package:file_picker/file_picker.dart' show FilePickerResult, FileType;

typedef FileFieldController = ValueNotifier<FilePickerResult?>;

class FileFormField extends FormField<FilePickerResult?> {
  FileFormField({
    super.key,
    super.onSaved,
    super.autovalidateMode,
    super.enabled,
    super.initialValue,
    super.validator,
    this.controller,
    this.dialogTitle,
    this.initialDirectory,
    this.type = FileType.any,
    this.allowedExtensions,
    this.onFileLoading,
    this.allowCompression = true,
    this.allowMultiple = false,
    this.withData = false,
    this.lockParentWindow = false,
    this.withReadStream = false,
  }) : super(
          builder: (FormFieldState<FilePickerResult?> field) =>
              build(field as _AudioFileSelectorState),
        );

  final FileFieldController? controller;
  final String? dialogTitle;
  final String? initialDirectory;
  final FileType type;
  final List<String>? allowedExtensions;
  final Function(FilePickerStatus)? onFileLoading;
  final bool allowCompression;
  final bool allowMultiple;
  final bool withData;
  final bool withReadStream;
  final bool lockParentWindow;

  @override
  FormFieldState<FilePickerResult?> createState() => _AudioFileSelectorState();

  static Widget build(_AudioFileSelectorState state) {
    final theme = Theme.of(state.context);
    final s = state.context.localizations;

    final errorText = state.errorText;
    final filePaths = state.value?.paths.join(', ');
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (filePaths != null)
                Text(filePaths, overflow: TextOverflow.clip),
              if (errorText != null)
                Text(
                  errorText,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        TextButton(
          onPressed: state.pickFile,
          child: Text(s.selectAudioFileButtonLabel),
        ),
      ],
    );
  }
}

class _AudioFileSelectorState extends FormFieldState<FilePickerResult?> {
  FileFieldController? _controller;

  FileFormField get formField => super.widget as FileFormField;

  FileFieldController get controller => (formField.controller ?? _controller)!;

  @override
  void initState() {
    super.initState();
    final widgetController = formField.controller;
    if (widgetController == null) {
      _controller = ValueNotifier(value);
    } else {
      widgetController.addListener(handleControllerValueChanged);
    }
  }

  @override
  void didUpdateWidget(FileFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldWidgetController = oldWidget.controller;
    final newWidgetController = formField.controller;
    if (oldWidgetController != newWidgetController) {
      oldWidgetController?.removeListener(handleControllerValueChanged);
      newWidgetController?.addListener(handleControllerValueChanged);

      if (oldWidgetController != null && newWidgetController == null) {
        _controller = ValueNotifier(value);
      }

      if (newWidgetController != null) {
        setValue(newWidgetController.value);
        _controller?.dispose();
        _controller = null;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    formField.controller?.removeListener(handleControllerValueChanged);
    _controller?.dispose();
  }

  @override
  void didChange(FilePickerResult? value) {
    super.didChange(value);
    if (controller.value != value) {
      controller.value = value;
    }
  }

  @override
  void reset() {
    controller.value = widget.initialValue;
    super.reset();
  }

  void handleControllerValueChanged() {
    if (controller.value != value) {
      didChange(controller.value);
    }
  }

  Future<void> pickFile() {
    return FilePicker.platform
        .pickFiles(
          allowCompression: formField.allowCompression,
          allowedExtensions: formField.allowedExtensions,
          allowMultiple: formField.allowMultiple,
          dialogTitle: formField.dialogTitle,
          initialDirectory: formField.initialDirectory,
          lockParentWindow: formField.lockParentWindow,
          onFileLoading: formField.onFileLoading,
          type: formField.type,
          withData: formField.withData,
          withReadStream: formField.withReadStream,
        )
        .then((result) => controller.value = result);
  }
}
