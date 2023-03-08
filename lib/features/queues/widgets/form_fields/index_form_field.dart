import 'package:flutter/material.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';

class IndexFormField extends StatelessWidget {
  const IndexFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final s = context.localizations;
    return Autocomplete(
      initialValue: controller.value,
      optionsBuilder: (input) {
        final inputText = input.text.toLowerCase();
        return [
          s.startIndexSuggestion,
          s.endIndexSuggestion,
        ].where((item) => item.toLowerCase().startsWith(inputText));
      },
    );
  }
}
