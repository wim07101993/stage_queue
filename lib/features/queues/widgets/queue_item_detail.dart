import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/notifiers/queue_items_notifier.dart';
import 'package:stage_queue/features/queues/widgets/form_fields/description_form_field.dart';
import 'package:stage_queue/features/queues/widgets/form_fields/title_form_field.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';

class QueueItemDetail extends StatefulWidget {
  const QueueItemDetail({super.key});

  @override
  State<QueueItemDetail> createState() => _QueueItemDetailState();
}

class _QueueItemDetailState extends State<QueueItemDetail> {
  final formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final description = TextEditingController();

  late final queueItemNotifier = context.getIt<EditingQueueItemNotifier>();

  @override
  void initState() {
    super.initState();
    queueItemNotifier.addListener(onItemChanged);
    onItemChanged();
  }

  @override
  void dispose() {
    super.dispose();
    queueItemNotifier.removeListener(onItemChanged);
  }

  void onItemChanged() {
    title.text = queueItemNotifier.value?.title ?? '';
    description.text = queueItemNotifier.value?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleFormField(
            controller: title,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          DescriptionFormField(controller: description),
        ],
      ),
    );
  }
}
