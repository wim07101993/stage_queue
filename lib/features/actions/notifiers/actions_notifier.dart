import 'package:flutter/cupertino.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';
import 'package:stage_queue/shared/notifiers/list_notifier.dart';

typedef ActionsNotifier = ListNotifier<QueueAction>;
typedef EditingActionNotifier = ValueNotifier<QueueAction?>;
