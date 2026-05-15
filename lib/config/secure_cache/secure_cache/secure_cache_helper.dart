import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'secure_cache.dart';

@LazySingleton(as: SecureCache)
class SecureCacheImpl implements SecureCache {
  final FlutterSecureStorage storage;

  SecureCacheImpl(this.storage);

  @override
  Future<void> saveData({required String key, required String value}) {
    return storage.write(key: key, value: value);
  }

  @override
  Future<String?> getData({required String key}) {
    return storage.read(key: key);
  }

  @override
  Future<void> removeData({required String key}) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await storage.deleteAll();
  }
}
