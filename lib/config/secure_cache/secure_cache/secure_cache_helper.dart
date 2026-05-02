import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getData({required String key}) async {
    return await _storage.read(key: key);
  }

  static Future<void> removeData({required String key}) async {
    await _storage.delete(key: key);
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}

/*
 how to use save data

  await SecureCacheHelper.saveData(
    key: CacheKeys.accessToken,
    value: token,
  );

===============================

  how to use get data

  String? token =
    await SecureCacheHelper.getData(key: CacheKeys.accessToken);

================================

  how to use delete data

  await SecureCacheHelper.removeData(
    key: CacheKeys.accessToken,
  );


 */
