import 'package:flower_app/config/data_base/data_base_service.dart';
import 'package:flower_app/config/firebase/firestore_collection.dart';
import 'package:flower_app/features/notifications/data/data_source/remote/firestore_remote_data_source.dart';
import 'package:flower_app/features/notifications/data/model/firestore_notifications_model.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: FirestoreRemoteDataSource)
class FirestoreRemoteDataSourceImpl implements FirestoreRemoteDataSource {
  final DatabaseService _databaseService;

  FirestoreRemoteDataSourceImpl(this._databaseService);

  @override
  Stream<List<FirestoreNotificationsModel>> watchUserNotifications(
    String userId,
  ) {
    final path =
        "${FireStoreCollection.usersCollectionPath}/$userId/${FireStoreCollection.notificationsCollectionPath}";

    return _databaseService.watchCollection<FirestoreNotificationsModel>(
      path: path,
      fromFirestore: (json) => FirestoreNotificationsModel.fromJson(json),
    );
  }
}
