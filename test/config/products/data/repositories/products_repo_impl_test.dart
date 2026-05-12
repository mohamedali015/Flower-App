import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/data/data_source/remote/products_remote_data_source.dart';
import 'package:flower_app/config/products/data/model/response/product_model.dart';
import 'package:flower_app/config/products/data/model/response/products_response.dart';
import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flower_app/config/products/data/repositories/products_repo_impl.dart';
import 'package:flower_app/config/products/domain/entities/products_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_repo_impl_test.mocks.dart';

@GenerateMocks([ProductsRemoteDataSource])
void main() {
  late ProductsRepoImpl productsRepoImpl;

  late MockProductsRemoteDataSource mockProductsRemoteDataSource;

  late List<ProductModel> productsModels;

  late ProductsResponse productsResponse;

  late ProductQueryParams params;

  late String errorMessage;

  setUpAll(() {
    errorMessage = "Something went wrong. Please try again later.";

    params = ProductQueryParams(page: 1, limit: 10);

    productsModels = List.generate(
      5,
      (index) => ProductModel(
        id: index.toString(),
        title: "Product $index",
        price: index + 100,
        imgCover: "image$index.png",
      ),
    );

    productsResponse = ProductsResponse(products: productsModels);

    provideDummy<Result<ProductsResponse>>(
      Success<ProductsResponse>(data: ProductsResponse()),
    );

    mockProductsRemoteDataSource = MockProductsRemoteDataSource();

    productsRepoImpl = ProductsRepoImpl(mockProductsRemoteDataSource);
  });

  group("Get Products Function Test Group", () {
    group("Success Cases", () {
      test("Test Success Case with empty products list", () async {
        when(
          mockProductsRemoteDataSource.getProducts(params: anyNamed('params')),
        ).thenAnswer(
          (_) async =>
              Success<ProductsResponse>(data: ProductsResponse(products: [])),
        );

        final result = await productsRepoImpl.getProducts(params: params);

        expect(result, isA<Success<ProductsResponseEntity>>());

        expect(
          (result as Success<ProductsResponseEntity>).data.products,
          isEmpty,
        );

        verify(
          mockProductsRemoteDataSource.getProducts(params: anyNamed('params')),
        ).called(1);
      });

      test("Test Success Case with 5 Products", () async {
        when(
          mockProductsRemoteDataSource.getProducts(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => Success<ProductsResponse>(data: productsResponse),
        );

        final result = await productsRepoImpl.getProducts(params: params);

        expect(result, isA<Success<ProductsResponseEntity>>());

        expect(
          (result as Success<ProductsResponseEntity>).data.products.length,
          productsModels.length,
        );

        expect(result.data.products.first.title, productsModels.first.title);

        expect(result.data.products.first.id, productsModels.first.id);

        expect(result.data.products.first.price, productsModels.first.price);

        expect(
          result.data.products.first.imgCover,
          productsModels.first.imgCover,
        );

        expect(result.data.products.last.title, productsModels.last.title);

        expect(result.data.products.last.id, productsModels.last.id);

        expect(result.data.products.last.price, productsModels.last.price);

        expect(
          result.data.products.last.imgCover,
          productsModels.last.imgCover,
        );

        verify(
          mockProductsRemoteDataSource.getProducts(params: anyNamed('params')),
        ).called(1);
      });
    });

    group("Failure Cases", () {
      test("Test Failure Case with Error Message", () async {
        when(
          mockProductsRemoteDataSource.getProducts(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => Failure<ProductsResponse>(errorMessage: errorMessage),
        );

        final result = await productsRepoImpl.getProducts(params: params);

        expect(result, isA<Failure<ProductsResponseEntity>>());

        expect(
          (result as Failure<ProductsResponseEntity>).errorMessage,
          isNotNull,
        );

        expect(result.errorMessage, errorMessage);

        verify(
          mockProductsRemoteDataSource.getProducts(params: anyNamed('params')),
        ).called(1);
      });
    });
  });
}
