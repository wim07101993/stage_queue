import 'package:flutter/foundation.dart';
import 'package:stage_queue/features/actions/models/queue_action.dart';
import 'package:stage_queue/shared/notifiers/list_notifier.dart';

typedef ActionsNotifier<T> = ListNotifier<QueueAction<T>>;
typedef EditingActionNotifier<T> = ValueNotifier<QueueAction<T>>;
