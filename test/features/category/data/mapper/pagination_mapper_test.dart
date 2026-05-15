import 'package:flower_app/features/category/data/mapper/pagination_mapper.dart';
import 'package:flower_app/features/category/data/model/response/pagination.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Pagination zeroPagination;
  late Pagination fullPagination;
  late Pagination nullPagination;
  late Pagination partialPagination;

  setUp(() {
    zeroPagination = Pagination(
      currentPage: 0,
      limit: 0,
      totalPages: 0,
      totalItems: 0,
    );

    fullPagination = Pagination(
      currentPage: 1,
      limit: 10,
      totalPages: 5,
      totalItems: 50,
    );

    nullPagination = Pagination();

    partialPagination = Pagination(currentPage: 2, totalPages: 3);
  });

  group('Pagination Mapper Tests', () {
    // Full
    test('should map full pagination correctly', () {
      final result = fullPagination.toEntity();

      expect(result.currentPage, 1);
      expect(result.limit, 10);
      expect(result.totalPages, 5);
      expect(result.totalItems, 50);
    });

    // Null
    test('should handle null pagination correctly', () {
      final result = nullPagination.toEntity();

      expect(result.currentPage, null);
      expect(result.limit, null);
      expect(result.totalPages, null);
      expect(result.totalItems, null);
    });

    test('should map partial pagination correctly', () {
      final result = partialPagination.toEntity();

      expect(result.currentPage, 2);
      expect(result.totalPages, 3);
      expect(result.limit, null);
      expect(result.totalItems, null);
    });

    ///? Zero
    test('should handle zero values correctly', () {
      final result = zeroPagination..toEntity();

      expect(result.currentPage, 0);
      expect(result.limit, 0);
      expect(result.totalPages, 0);
      expect(result.totalItems, 0);
    });
  });
}
