import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../data_base/data_base_service.dart';

@LazySingleton(as: DatabaseService)
class FirebaseService implements DatabaseService {
  final FirebaseFirestore _firestore;

  FirebaseService(this._firestore);

  /// Helper for creating a typed [DocumentReference] intended for reading.
  /// The [toFirestore] is intentionally unimplemented as this ref is for reads.
  DocumentReference<T> _getReadDocRef<T>(
    String path,
    T Function(Map<String, dynamic> json) fromFirestore,
  ) {
    return _firestore
        .doc(path)
        .withConverter<T>(
          fromFirestore: (snapshot, _) => fromFirestore(snapshot.data() ?? {}),
          toFirestore: (_, _) =>
              throw UnimplementedError("Read-only reference"),
        );
  }

  /// Helper for creating a typed [CollectionReference] intended for reading.
  CollectionReference<T> _getReadCollectionRef<T>(
    String path,
    T Function(Map<String, dynamic> json) fromFirestore,
  ) {
    return _firestore
        .collection(path)
        .withConverter<T>(
          fromFirestore: (snapshot, _) => fromFirestore(snapshot.data() ?? {}),
          toFirestore: (_, _) =>
              throw UnimplementedError("Read-only reference"),
        );
  }

  @override
  Future<T?> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromFirestore,
  }) async {
    final docRef = _getReadDocRef<T>(path, fromFirestore);
    final snapshot = await docRef.get();
    return snapshot.data();
  }

  @override
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromFirestore,
    Map<String, dynamic>? queryParams,
    int? limit,
  }) async {
    Query<T> query = _getReadCollectionRef<T>(path, fromFirestore);

    if (queryParams != null) {
      queryParams.forEach((field, value) {
        query = query.where(field, isEqualTo: value);
      });
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<void> setData<T>({
    required String path,
    required T data,
    required Map<String, dynamic> Function(T value) toFirestore,
    bool merge = true,
  }) async {
    // For writing, we don't need withConverter's fromFirestore.
    // We manually map the data to a map and use the raw Firestore API.
    await _firestore.doc(path).set(toFirestore(data), SetOptions(merge: merge));
  }

  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.doc(path).update(data);
  }

  @override
  Future<String> addData<T>({
    required String collectionPath,
    required T data,
    required Map<String, dynamic> Function(T value) toFirestore,
  }) async {
    final docRef = await _firestore
        .collection(collectionPath)
        .add(toFirestore(data));
    return docRef.id;
  }

  @override
  Future<void> deleteData(String path) async {
    await _firestore.doc(path).delete();
  }

  @override
  Stream<T?> watchDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromFirestore,
  }) {
    return _getReadDocRef<T>(
      path,
      fromFirestore,
    ).snapshots().map((s) => s.data());
  }

  @override
  Stream<List<T>> watchCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromFirestore,
    Map<String, dynamic>? queryParams,
  }) {
    Query<T> query = _getReadCollectionRef<T>(path, fromFirestore);

    if (queryParams != null) {
      queryParams.forEach((field, value) {
        query = query.where(field, isEqualTo: value);
      });
    }

    return query.snapshots().map((s) => s.docs.map((d) => d.data()).toList());
  }
}
