import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/category/data/mapper/categories_response_mapper.dart';
import 'package:flower_app/features/category/data/model/response/all_categories_response.dart';

void main() {

  late AllCategoriesResponse emptyResponse;
  late AllCategoriesResponse fullResponse;
  late AllCategoriesResponse nullResponse;
  late AllCategoriesResponse partialResponse;

  setUp(() {
    emptyResponse = AllCategoriesResponse(
      id: '',
      name: '',
      image: '',
    );

    fullResponse = AllCategoriesResponse(
      id: '1',
      name: 'Flowers',
      image: 'flower.png',
      isSuperAdmin: true,
      productsCount: 10,
    );

    nullResponse = AllCategoriesResponse();

    partialResponse = AllCategoriesResponse(
      id: '2',
      name: 'Roses',
    );

  });

  group('CategoriesResponseMapper', () {

    test('should map full data correctly', () {
      final result = fullResponse.toGetAllCategoryEntity();

      expect(result.id, '1');
      expect(result.name, 'Flowers');
      expect(result.image, 'flower.png');
      expect(result.isSuperAdmin, true);
      expect(result.productsCount, 10);
    });

    test('should handle null values correctly', () {
      final result = nullResponse.toGetAllCategoryEntity();

      expect(result.id, null);
      expect(result.name, null);
      expect(result.image, null);
      expect(result.isSuperAdmin, null);
      expect(result.productsCount, null);
    });

    test('should map partial data correctly', () {
      final result = partialResponse.toGetAllCategoryEntity();

      expect(result.id, '2');
      expect(result.name, 'Roses');
      expect(result.image, null);
      expect(result.isSuperAdmin, null);
      expect(result.productsCount, null);
    });

    test('should handle empty string values correctly', () {
      final result = emptyResponse.toGetAllCategoryEntity();

      expect(result.id, '');
      expect(result.name, '');
      expect(result.image, '');
    });
  });
}