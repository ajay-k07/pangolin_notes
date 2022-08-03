import 'package:pangolin_notes/model/objectbox.g.dart';

class ObjectBoxInterface {
  /// The Store of this app.
  late final Store store;

  ObjectBoxInterface._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxInterface> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBoxInterface._create(store);
  }
}
