import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('executeApi Tests', () {
    test('returns Success for generic types', () async {
      final stringResult = await executeApi<String>(
        () async => "data from api",
      );
      final intResult = await executeApi<int>(() async => 10);
      final boolResult = await executeApi<bool>(() async => true);
      final listResult = await executeApi<List<int>>(() async => [1, 2, 3]);

      expect(stringResult, isA<Success<String>>());
      expect((stringResult as Success<String>).data, "data from api");

      expect(intResult, isA<Success<int>>());
      expect((intResult as Success<int>).data, 10);

      expect(boolResult, isA<Success<bool>>());
      expect((boolResult as Success<bool>).data, true);

      expect(listResult, isA<Success<List<int>>>());
      expect((listResult as Success<List<int>>).data.length, 3);
    });

    test('returns Failure when API throws exception', () async {
      final result = await executeApi<String>(() async {
        throw Exception('error occurred');
      });

      expect(result, isA<Failure<String>>());
      expect((result as Failure<String>).errorMessage, isNotEmpty);
      expect((result).errorMessage, isNotEmpty);
    });

    test('returns Success for empty string', () async {
      final result = await executeApi<String>(() async => "");

      expect(result, isA<Success<String>>());
      expect((result as Success<String>).data, isEmpty);
    });

    test('executes async API correctly', () async {
      final result = await executeApi<int>(() async {
        await Future.delayed(const Duration(milliseconds: 10));
        return 5;
      });

      expect(result, isA<Success<int>>());
      expect((result as Success<int>).data, 5);
    });
  });
}
