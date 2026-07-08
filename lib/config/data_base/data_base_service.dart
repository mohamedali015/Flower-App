abstract class DatabaseService {
  /// Fetches a single document and converts it to [T] using [fromFirestore].
  /// Throws an exception if the document does not exist.
  Future<T?> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromFirestore,
  });

  /// Fetches a collection of documents and converts them to a list of [T].
  /// Optionally filters by [queryParams] and [limit].
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromFirestore,
    Map<String, dynamic>? queryParams,
    int? limit,
  });

  /// Sets data to a document at [path].
  /// Use [merge] = true (default) to perform a merge-set (partial overwrite),
  /// or [merge] = false to completely overwrite the document.
  Future<void> setData<T>({
    required String path,
    required T data,
    required Map<String, dynamic> Function(T value) toFirestore,
    bool merge = true,
  });

  /// Performs a partial update on a document at [path] using the provided [data] map.
  ///
  /// This is the preferred way to update specific fields without needing
  /// the full model or risking overwriting other fields.
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  });

  /// Adds a new document to the collection at [collectionPath] with an auto-generated ID.
  /// Returns the ID of the newly created document.
  Future<String> addData<T>({
    required String collectionPath,
    required T data,
    required Map<String, dynamic> Function(T value) toFirestore,
  });

  /// Deletes the document at [path].
  Future<void> deleteData(String path);

  /// Listens to real-time updates for a document at [path].
  Stream<T?> watchDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromFirestore,
  });

  /// Listens to real-time updates for a collection at [path].
  Stream<List<T>> watchCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromFirestore,
    Map<String, dynamic>? queryParams,
  });
}
