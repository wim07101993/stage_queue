import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class QueueItem extends Equatable {
  QueueItem({
    required this.title,
    this.description,
    String? id,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final String? description;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
      ];

  Future<void> call() {
    // TODO
    print('Not yet implemented');
    return Future.value();
  }

  static Exception? validateTitle(String? title) {
    return null;
  }

  static Exception? validateDescription(String? description) {
    return null;
  }
}

class TitleCannotBeEmptyException implements Exception {
  const TitleCannotBeEmptyException();
}
