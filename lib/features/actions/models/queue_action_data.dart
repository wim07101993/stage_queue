import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class QueueActionData {
  QueueActionData({
    required this.description,
    String? id,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String description;

  Widget icon(BuildContext context);
  Widget listTileContent(BuildContext context);
  Widget detailWidget(BuildContext context);
}
