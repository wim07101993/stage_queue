import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/features/queues/widgets/create_queue_item_dialog.dart';
import 'package:stage_queue/features/queues/widgets/queue_list_tile.dart';
import 'package:stage_queue/shared/notifiers/list_notifier.dart';

class QueueList extends StatefulWidget {
  const QueueList({
    super.key,
    required this.queueItems,
    required this.isInModifyMode,
  });

  final ListNotifier<QueueItemNotifier> queueItems;
  final bool isInModifyMode;

  @override
  State<QueueList> createState() => _QueueListState();
}

class _QueueListState extends State<QueueList> {
  Future<void> _addQueueItem() async {
    final result = await showDialog<CreateQueueItemDialogResponse>(
      context: context,
      builder: (context) => const CreateQueueItemDialog(),
    );
    if (result == null || !mounted) {
      return;
    }
    widget.queueItems.insert(
      result.insertIndex,
      ValueNotifier(result.queueItem),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      // ignore: parameter_assignments
      newIndex -= 1;
    }

    if (oldIndex.isOdd) {
      //separator - should never happen
      return;
    } else if ((oldIndex - newIndex).abs() == 1) {
      //moved behind the top/bottom separator
      return;
    }

    widget.queueItems.move(
      oldIndex ~/ 2,
      oldIndex > newIndex && newIndex.isOdd
          ? (newIndex + 1) ~/ 2
          : newIndex ~/ 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: widget.queueItems,
          builder: (context, notifier, _) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ReorderableListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: max(0, widget.queueItems.value.length * 2 - 1),
                onReorder: _onReorder,
                buildDefaultDragHandles: false,
                itemBuilder: _buildItem,
                proxyDecorator: _buildProxyDecorator,
              ),
            ),
          ),
        ),
        if (widget.isInModifyMode)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: FloatingActionButton(
                onPressed: _addQueueItem,
                child: const Icon(Icons.add),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index.isOdd) {
      return KeyedSubtree(
        key: ValueKey('ReorderableSeparator${index}Key'),
        child: const IgnorePointer(child: SizedBox(height: 8)),
      );
    }
    final itemIndex = index ~/ 2;
    final item = widget.queueItems.value[itemIndex].value;
    return KeyedSubtree(
      key: ValueKey(item.id),
      child: Row(
        children: [
          Text((itemIndex + 1).toString()),
          const SizedBox(width: 16),
          Expanded(
            child: QueueListTile(
              item: item,
              index: index,
              isInModifyMode: widget.isInModifyMode,
              onDelete: () => widget.queueItems.removeAt(itemIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProxyDecorator(
    Widget child,
    int index,
    Animation<double> animation,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final animValue = Curves.easeInOut.transform(animation.value);
        final scale = lerpDouble(1, 1.05, animValue)!;
        final elevation = lerpDouble(0, 6, animValue)!;
        return Transform.scale(
          scale: scale,
          child: Material(
            elevation: elevation,
            borderRadius: BorderRadius.circular(4),
            color: Colors.transparent,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
