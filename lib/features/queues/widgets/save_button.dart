import 'package:flutter/material.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = context.localizations;
    return ElevatedButton(
      onPressed: onTap,
      child: Text(s.saveButtonLabel),
    );
  }
}
