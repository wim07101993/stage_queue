import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/notifiers/actions_notifier.dart';
import 'package:stage_queue/features/actions/widgets/action_list_tile.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';
import 'package:stage_queue/shared/widgets/multi_listenable_builder.dart';

class ActionsList extends StatefulWidget {
  const ActionsList({super.key});

  @override
  State<ActionsList> createState() => _ActionsListState();
}

class _ActionsListState extends State<ActionsList> {
  late final ActionsNotifier actions = context.getIt();
  late final EditingActionNotifier editingAction = context.getIt();

  late int _selectedItemIndex = actions.value.indexOf(editingAction.value);

  int get selectedItemIndex => _selectedItemIndex;
  set selectedItemIndex(int value) {
    if (_selectedItemIndex == value) {
      return;
    }
    _selectedItemIndex = value;
    editingAction.value = actions[value];
  }

  void addAction() {}

  @override
  Widget build(BuildContext context) {
    final s = context.localizations;
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addAction,
        icon: const Icon(Icons.add),
        label: Text(s.addActionButtonLabel),
      ),
      body: MultiListenableBuilder(
        listenables: [actions, editingAction],
        builder: (context) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: actions.length,
          itemBuilder: (context, i) => Padding(
            padding: EdgeInsets.only(
              top: i > 0 ? 4 : 0,
              bottom: i < actions.length ? 4 : 0,
            ),
            child: ActionListTile(
              item: actions[i],
              isSelected: selectedItemIndex == i,
              onTap: () => selectedItemIndex = i,
              onDelete: () => actions.removeAt(i),
            ),
          ),
        ),
      ),
    );
  }
}
