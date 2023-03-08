import 'package:equatable/equatable.dart';

abstract class QueueAction extends Equatable {
  const QueueAction();

  String? get description;
}
