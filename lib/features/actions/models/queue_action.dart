import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stage_queue/features/actions/widgets/action_widgets/print_action_list_tile.dart';
import 'package:uuid/uuid.dart';

import '../widgets/action_widgets/print_action_detail.dart';

abstract class QueueAction extends Equatable {
  QueueAction({
    required this.description,
    String? id,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String description;

  @override
  List<Object?> get props => [id, description];

  Future<void> call();

  Widget icon(BuildContext context);
  Widget listTileContent(BuildContext context);
  Widget detailWidget(BuildContext context);
}

class PrintAction extends QueueAction {
  PrintAction({
    required super.description,
    super.id,
  });

  @override
  Future<void> call() {
    print(description);
    return Future.value();
  }

  @override
  Widget icon(BuildContext context) => const Icon(Icons.developer_mode);

  @override
  Widget listTileContent(BuildContext context) {
    return PrintActionListTile(action: this);
  }

  @override
  Widget detailWidget(BuildContext context) {
    return PrintActionDetail(action: this);
  }
}
