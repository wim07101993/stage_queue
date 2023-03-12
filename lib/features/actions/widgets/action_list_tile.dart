import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';
import 'package:stage_queue/features/actions/widgets/delete_button.dart';
import 'package:stage_queue/features/actions/widgets/trigger_button.dart';

class ActionListTile extends StatelessWidget {
  const ActionListTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
  });

  final QueueAction item;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              Expanded(child: _contents(context)),
              const SizedBox(width: 8),
              TriggerButton(itemToTrigger: item),
              DeleteButton(onPressed: onDelete),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item.icon(context),
            const SizedBox(width: 12),
            item.listTileContent(context),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
