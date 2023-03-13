import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/console/widgets/print_action_detail.dart';
import 'package:stage_queue/features/actions/console/widgets/print_action_list_tile_content.dart';
import 'package:stage_queue/features/actions/models/queue_action_data.dart';

class ConsoleActionData extends QueueActionData {
  ConsoleActionData({
    required super.description,
    super.id,
  });

  @override
  Widget icon(BuildContext context) => const Icon(Icons.developer_mode);

  @override
  Widget listTileContent(BuildContext context) {
    return PrintActionListTileContent(data: this);
  }

  @override
  Widget detailWidget(BuildContext context) {
    return PrintActionDetail(data: this);
  }
}
