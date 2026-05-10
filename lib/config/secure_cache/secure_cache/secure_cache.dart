abstract interface class SecureCache {
  Future<void> saveData({required String key, required String value});

  Future<String?> getData({required String key});

  Future<void> removeData({required String key});

  Future<void> clear();
}
