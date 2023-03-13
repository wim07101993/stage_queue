import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';
import 'package:stage_queue/features/actions/models/queue_action_data.dart';
import 'package:stage_queue/features/actions/notifiers/actions_notifier.dart';
import 'package:stage_queue/features/actions/widgets/actions_list.dart';
import 'package:stage_queue/features/queues/widgets/queue_list.dart';
import 'package:stage_queue/features/queues/widgets/selected_queue_item.dart';
import 'package:stage_queue/shared/widgets/build_context_extensions.dart';
import 'package:stage_queue/shared/widgets/master_detail.dart';
import 'package:stage_queue/shared/widgets/multi_listenable_builder.dart';

enum ListTab {
  queueItems(0),
  actions(1);

  const ListTab(this.tabIndex);

  final int tabIndex;

  static ListTab fromTabIndex(int tabIndex) {
    return ListTab.values.firstWhere((value) => value.tabIndex == tabIndex);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(
    length: ListTab.values.length,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    final s = context.localizations;
    return Scaffold(
      bottomNavigationBar: MultiListenableBuilder(
        listenables: [tabController],
        builder: (context) => BottomNavigationBar(
          currentIndex: tabController.index,
          onTap: (index) => tabController.animateTo(index),
          items: [
            BottomNavigationBarItem(
              label: s.queueItemsTabLabel,
              icon: const Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: s.actionsTabLabel,
              icon: const Icon(Icons.play_circle),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          MasterDetail(
            masterBuilder: (context) => const QueueList(),
            detailBuilder: (context) => const SelectedQueueItem(),
          ),
          MasterDetail(
            masterBuilder: (context) => const ActionsList(),
            detailBuilder: (context) {
              return ValueListenableBuilder<QueueAction<QueueActionData>>(
                valueListenable:
                    context.getIt<EditingActionNotifier<QueueActionData>>(),
                builder: (context, action, _) {
                  return action.data.detailWidget(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
