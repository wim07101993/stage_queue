import 'package:flutter/foundation.dart';

class ListNotifier<T> extends ChangeNotifier
    implements ValueListenable<List<T>> {
  List<T> _items = [];

  @override
  List<T> get value => _items.toList();

  set value(Iterable<T> items) {
    _items = items.toList();
    notifyListeners();
  }

  void insert(int index, T item) {
    _items.insert(index, item);
    notifyListeners();
  }

  T removeAt(int index) {
    final item = _items.removeAt(index);
    notifyListeners();
    return item;
  }

  T move(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      // ignore: parameter_assignments
      newIndex -= 1;
    }
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);
    notifyListeners();
    return item;
  }
}
