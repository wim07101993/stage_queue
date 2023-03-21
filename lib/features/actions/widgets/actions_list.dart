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

  int? _selectedItemIndex;

  int? get selectedItemIndex => _selectedItemIndex;
  set selectedItemIndex(int? value) {
    if (_selectedItemIndex == value) {
      return;
    }
    _selectedItemIndex = value;
    if (value == null) {
      editingAction.value = null;
    } else {
      editingAction.value = actions[value];
    }
  }

  void addAction() {
    // TODO
  }

  @override
  void initState() {
    super.initState();
    final selectedAction = editingAction.value;
    if (selectedAction != null) {
      _selectedItemIndex = actions.value.indexOf(selectedAction);
    }
  }

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
              action: actions[i],
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
