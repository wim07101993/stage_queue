import 'package:flutter/foundation.dart';

class ListNotifier<T> extends ChangeNotifier
    implements ValueListenable<List<T>> {
  final List<ListChangeListener> _listChangedListeners = [];
  List<T> _items = [];

  @override
  List<T> get value => _items.toList();

  set value(Iterable<T> items) {
    _items = items.toList();
    _notifyListeners((listener) => listener.onResetList());
  }

  T operator [](int index) => _items[index];

  void operator []=(int index, T item) {
    _items[index] = item;
    _notifyListeners((listener) => listener.onItemReplaced(index));
  }

  int get length => _items.length;

  void insert(int index, T item) {
    _items.insert(index, item);
    _notifyListeners((listener) => listener.onItemInserted(index));
  }

  T removeAt(int index) {
    final item = _items.removeAt(index);
    _notifyListeners((listener) => listener.onItemRemoved(index));
    return item;
  }

  T move(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      // ignore: parameter_assignments
      newIndex -= 1;
    }
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);
    _notifyListeners((listener) => listener.onItemMoved(oldIndex, newIndex));
    return item;
  }

  void _notifyListeners(void Function(ListChangeListener item) callback) {
    notifyListeners();
    for (final listener in _listChangedListeners) {
      try {
        callback(listener);
      } catch (exception, stackTrace) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: exception,
            stack: stackTrace,
          ),
        );
      }
    }
  }

  void addChangeListener(ListChangeListener listener) {
    _listChangedListeners.add(listener);
  }

  void removeChangeListener(ListChangeListener listener) {
    _listChangedListeners.remove(listener);
  }
}

abstract class ListChangeListener {
  void onItemMoved(int oldIndex, int newIndex);
  void onItemInserted(int index);
  void onItemRemoved(int index);
  void onItemReplaced(int index);
  void onResetList();
}
