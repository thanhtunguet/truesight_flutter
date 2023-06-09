part of 'truesight_flutter.dart';

typedef OpenStoreFunction = Future<Store> Function({
  String? directory,
  int? maxDBSizeInKB,
  int? fileMode,
  int? maxReaders,
  bool queriesCaseSensitiveDefault,
  String? macosApplicationGroup,
});

class Database {
  /// The Store of this app.
  late final Store store;

  late final Admin admin;

  Box<T> box<T>() {
    return store.box<T>();
  }

  Database._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    if (Admin.isAvailable()) {
      // Keep a reference until no longer needed or manually closed.
      admin = Admin(store);
    }
    _instance = this;
  }

  static Database? _instance;

  static Database get instance {
    return _instance!;
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<Database> create({
    required OpenStoreFunction openStore,
    String databaseName = "objectbox",
    String? macosApplicationGroup,
  }) async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: join(docsDir.path, databaseName));
    return Database._create(store);
  }

  void close() {
    store.close();
    if (Admin.isAvailable()) {
      // (Optional) Close at some later point.
      admin.close();
    }
  }
}
