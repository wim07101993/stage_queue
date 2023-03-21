import 'package:flutter/foundation.dart';
import 'package:stage_queue/features/queues/models/queue_item.dart';
import 'package:stage_queue/shared/notifiers/list_notifier.dart';

typedef QueueItemsNotifier = ListNotifier<QueueItem>;
typedef EditingQueueItemNotifier = ValueNotifier<QueueItem?>;
