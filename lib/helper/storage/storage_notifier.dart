import 'package:property_change_notifier/property_change_notifier.dart';

class StorageNotifier extends PropertyChangeNotifier<String> {
  notify(String listener) {
    notifyListeners(listener);
  }

  notifyAll(List<String> listeners) {
    for (String listener in listeners) {
      notify(listener);
    }
  }
}
