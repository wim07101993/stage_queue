import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stage_queue/features/queues/notifiers/queue_items_notifier.dart';
import 'package:stage_queue/features/queues/widgets/create_queue_item_dialog.dart';
import 'package:stage_queue/features/queues/widgets/queue_list_tile.dart';
import 'package:stage_queue/shared/notifiers/list_notifier.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';
import 'package:stage_queue/shared/widgets/multi_listenable_builder.dart';

class QueueList extends StatefulWidget {
  const QueueList({super.key});

  @override
  State<QueueList> createState() => _QueueListState();
}

class _QueueListState extends State<QueueList> implements ListChangeListener {
  late final QueueItemsNotifier queueItems = context.getIt();
  late final EditingQueueItemNotifier editingQueueItem = context.getIt();

  late int _selectedItemIndex =
      queueItems.value.indexOf(editingQueueItem.value);

  int get selectedItemIndex => _selectedItemIndex;
  set selectedItemIndex(int value) {
    if (_selectedItemIndex == value) {
      return;
    }
    _selectedItemIndex = value;
    editingQueueItem.value = queueItems[value];
  }

  @override
  void initState() {
    super.initState();
    queueItems.addChangeListener(this);
    editingQueueItem.addListener(onEditingQueueItemChanged);
  }

  @override
  void dispose() {
    super.dispose();
    queueItems.removeChangeListener(this);
    editingQueueItem.removeListener(onEditingQueueItemChanged);
  }

  Future<void> addQueueItem() async {
    final result = await showDialog<CreateQueueItemDialogResponse>(
      context: context,
      builder: (context) => const CreateQueueItemDialog(),
    );
    if (result == null || !mounted) {
      return;
    }
    queueItems.insert(
      result.insertIndex,
      result.queueItem,
    );
  }

  void reorder(int oldIndex, int newIndex) {
    final oldItemIndex = (oldIndex / 2).floor();
    // the magic separator number is 1 or -1, it is necessary to keep move the
    // items to the new index.
    final magicSeparatorNumber = oldIndex < newIndex ? -1 : 1;
    final newItemIndex = ((newIndex + magicSeparatorNumber) / 2).floor();
    if (oldItemIndex != newItemIndex) {
      queueItems.move(oldItemIndex, newItemIndex);
    }
  }

  @override
  void onItemInserted(int index) {
    if (index < selectedItemIndex) {
      selectedItemIndex++;
    }
    setState(() {});
  }

  @override
  void onItemMoved(int oldIndex, int newIndex) {
    if (oldIndex < selectedItemIndex && newIndex >= selectedItemIndex) {
      selectedItemIndex = selectedItemIndex - 1;
    } else if (oldIndex > selectedItemIndex && newIndex <= selectedItemIndex) {
      selectedItemIndex = selectedItemIndex + 1;
    } else if (oldIndex == selectedItemIndex) {
      selectedItemIndex = newIndex;
    }
    setState(() {});
  }

  @override
  void onItemRemoved(int index) {
    if (index < selectedItemIndex) {
      selectedItemIndex--;
    }
    setState(() {});
  }

  @override
  void onItemReplaced(int index) => setState(() {});

  @override
  void onResetList() {
    selectedItemIndex = 0;
    setState(() {});
  }

  void onEditingQueueItemChanged() {
    final queueItem = editingQueueItem.value;
    queueItems[selectedItemIndex] = queueItem;
  }

  @override
  Widget build(BuildContext context) {
    final s = context.localizations;
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addQueueItem,
        icon: const Icon(Icons.add),
        label: Text(s.addQueueItemButtonLabel),
      ),
      body: MultiListenableBuilder(
        listenables: [
          queueItems,
          context.getIt<EditingQueueItemNotifier>(),
        ],
        builder: (context) => ReorderableListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: max(0, queueItems.value.length * 2 - 1),
          onReorder: reorder,
          buildDefaultDragHandles: false,
          itemBuilder: _buildItem,
          proxyDecorator: _buildProxyDecorator,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index.isOdd) {
      return KeyedSubtree(
        key: ValueKey('QueueListItem${index}Key'),
        child: const IgnorePointer(child: SizedBox(height: 8)),
      );
    }
    final itemIndex = index ~/ 2;
    return KeyedSubtree(
      key: ValueKey('QueueListItem${index}Key'),
      child: Row(
        children: [
          Text((itemIndex + 1).toString()),
          const SizedBox(width: 16),
          Expanded(
            child: QueueListTile(
              item: queueItems[itemIndex],
              index: index,
              isSelected: selectedItemIndex == itemIndex,
              onDelete: () => queueItems.removeAt(itemIndex),
              onTap: () => selectedItemIndex = itemIndex,
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
