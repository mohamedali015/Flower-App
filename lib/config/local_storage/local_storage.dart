abstract class LocalStorage {
  Future<void> init();

  Future<void> put<T>({
    required String box,
    required dynamic key,
    required T value,
  });

  Future<void> add<T>({required String box, required T value});

  Future<T?> get<T>({required String box, required dynamic key});

  Future<List<T>> getAll<T>(String box);

  Future<void> delete({required String box, required dynamic key});

  Future<void> clear(String box);
}
