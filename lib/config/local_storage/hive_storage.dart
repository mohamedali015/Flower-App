import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'local_storage.dart';

@LazySingleton(as: LocalStorage)
class HiveStorage implements LocalStorage {
  @override
  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box<T>> _openBox<T>(String box) async {
    if (Hive.isBoxOpen(box)) {
      return Hive.box<T>(box);
    } else {
      return await Hive.openBox<T>(box);
    }
  }

  @override
  Future<void> put<T>({
    required String box,
    required dynamic key,
    required T value,
  }) async {
    final b = await _openBox<T>(box);
    await b.put(key, value);
  }

  @override
  Future<void> add<T>({required String box, required T value}) async {
    final b = await _openBox<T>(box);
    await b.add(value);
  }

  @override
  Future<T?> get<T>({required String box, required dynamic key}) async {
    final b = await _openBox<T>(box);
    return b.get(key);
  }

  @override
  Future<List<T>> getAll<T>(String box) async {
    final b = await _openBox<T>(box);
    return b.values.toList();
  }

  @override
  Future<void> delete({required String box, required dynamic key}) async {
    final b = await _openBox(box);
    await b.delete(key);
  }

  @override
  Future<void> clear(String box) async {
    final b = await _openBox(box);
    await b.clear();
  }
}
