import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/features/queues/widgets/delete_button.dart';
import 'package:stage_queue/features/queues/widgets/trigger_button.dart';
import 'package:stage_queue/shared/localization/localization.dart';

class QueueListTile extends StatelessWidget {
  const QueueListTile({
    super.key,
    required this.index,
    required this.item,
    required this.isInModifyMode,
    required this.isSelected,
    required this.onDelete,
    required this.onTap,
  });

  final int index;
  final QueueItem item;
  final bool isInModifyMode;
  final bool isSelected;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: isSelected ? theme.primaryColor : theme.dividerColor,
      ),
      height: 64,
      child: InkWell(
        onTap: onTap,
        customBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(child: _contents(theme, s)),
              const SizedBox(width: 8),
              TriggerButton(itemToTrigger: item),
              if (isInModifyMode) ...[
                DeleteButton(onPressed: onDelete),
                const SizedBox(width: 4),
                ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_handle),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _contents(ThemeData theme, AppLocalizations s) {
    final description = item.description;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Text(item.title),
        if (description != null) ...[
          const SizedBox(height: 2),
          Text(
            description,
            style: theme.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}
