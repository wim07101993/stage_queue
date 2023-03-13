import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/console/widgets/print_action_detail.dart';
import 'package:stage_queue/features/actions/console/widgets/print_action_list_tile_content.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';

class ConsoleAction extends QueueAction {
  ConsoleAction({
    required super.description,
    super.id,
  });

  @override
  Future<void> initializeInternal() {
    return Future.delayed(
      Duration(milliseconds: faker.randomGenerator.integer(10000, min: 1000)),
    );
  }

  @override
  Future<void> execute() {
    print(description);
    return Future.value();
  }

  @override
  Widget icon(BuildContext context) => const Icon(Icons.developer_mode);

  @override
  Widget listTileContent(BuildContext context) {
    return PrintActionListTileContent(data: this);
  }

  @override
  Widget detailWidget(BuildContext context) {
    return PrintActionDetail(action: this);
  }
}
