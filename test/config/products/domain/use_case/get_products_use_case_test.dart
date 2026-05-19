import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/config/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/config/products/domain/repositories/products_repo.dart';
import 'package:flower_app/config/products/domain/use_case/get_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_products_use_case_test.mocks.dart';

@GenerateMocks([ProductsRepo])
void main() {
  late GetProductsUseCase getProductsUseCase;

  late MockProductsRepo mockProductsRepo;

  late ProductsResponseEntity productsResponseEntity;

  late ProductQueryParams params;

  late List<ProductEntity> productsEntities;

  late String errorMessage;

  setUpAll(() {
    errorMessage = "Something went wrong. Please try again later.";

    params = const ProductQueryParams(page: 1, limit: 10);

    productsEntities = List.generate(
      5,
      (index) => ProductEntity(
        id: index.toString(),
        title: "Product $index",
        slug: "",
        description: "",
        imgCover: "",
        images: const [],
        price: index + 100,
        priceAfterDiscount: 0,
        discount: 0,
        rateAvg: 0,
        rateCount: 0,
        sold: 0,
        quantity: 0,
        category: "",
        occasion: "",
        isSuperAdmin: false,
        createdAt: DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
        v: 0,
        favoriteId: "",
        isInWishlist: false,
      ),
    );

    productsResponseEntity = ProductsResponseEntity(
      products: productsEntities,
      metadata: const MetadataEntity(
        currentPage: 1,
        totalPages: 1,
        limit: 10,
        totalItems: 5,
      ),
    );

    provideDummy<Result<ProductsResponseEntity>>(
      Success<ProductsResponseEntity>(data: productsResponseEntity),
    );
  });

  setUp(() {
    mockProductsRepo = MockProductsRepo();

    getProductsUseCase = GetProductsUseCase(mockProductsRepo);
  });

  group("Get Products UseCase Test Group", () {
    group("Success Cases", () {
      test("Test Success Case with products returned successfully", () async {
        when(
          mockProductsRepo.getProducts(params: anyNamed('params')),
        ).thenAnswer(
          (_) async =>
              Success<ProductsResponseEntity>(data: productsResponseEntity),
        );

        final result = await getProductsUseCase(params: params);

        expect(result, isA<Success<ProductsResponseEntity>>());

        expect(
          (result as Success<ProductsResponseEntity>).data.products.length,
          productsEntities.length,
        );

        verify(
          mockProductsRepo.getProducts(params: anyNamed('params')),
        ).called(1);
      });
    });

    group("Failure Cases", () {
      test("Test Failure Case with Error Message", () async {
        when(
          mockProductsRepo.getProducts(params: anyNamed('params')),
        ).thenAnswer(
          (_) async =>
              Failure<ProductsResponseEntity>(errorMessage: errorMessage),
        );

        final result = await getProductsUseCase(params: params);

        expect(result, isA<Failure<ProductsResponseEntity>>());

        expect(
          (result as Failure<ProductsResponseEntity>).errorMessage,
          errorMessage,
        );

        verify(
          mockProductsRepo.getProducts(params: anyNamed('params')),
        ).called(1);
      });
    });
  });
}
