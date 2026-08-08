import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/api/data_source/remote/products_remote_data_source_impl.dart';
import 'package:flower_app/config/products/api/products_api_client.dart';
import 'package:flower_app/config/products/data/model/response/product_model.dart';
import 'package:flower_app/config/products/data/model/response/products_response.dart';
import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProductsApiClient])
void main() {
  late ProductsRemoteDataSourceImpl productsRemoteDataSourceImpl;

  late MockProductsApiClient mockProductsApiClient;

  late ProductsResponse productsResponse;

  late ProductQueryParams params;

  late List<ProductModel> productsModels;

  setUpAll(() {
    params = const ProductQueryParams(page: 1, limit: 10);

    productsModels = List.generate(
      5,
      (index) => ProductModel(
        id: index.toString(),
        title: "Product $index",
        price: index + 100,
      ),
    );

    productsResponse = ProductsResponse(products: productsModels);
  });

  setUp(() {
    mockProductsApiClient = MockProductsApiClient();

    productsRemoteDataSourceImpl = ProductsRemoteDataSourceImpl(
      mockProductsApiClient,
    );
  });

  group("Get Products Function Test Group", () {
    group("Success Cases", () {
      test("Test Success Case with empty products list", () async {
        when(
          mockProductsApiClient.getProducts(any),
        ).thenAnswer((_) async => ProductsResponse(products: []));

        final result = await productsRemoteDataSourceImpl.getProducts(
          params: params,
        );

        expect(result, isA<Success<ProductsResponse>>());

        expect((result as Success<ProductsResponse>).data.products, isEmpty);

        verify(mockProductsApiClient.getProducts(any)).called(1);
      });

      test("Test Success Case with 5 products", () async {
        when(
          mockProductsApiClient.getProducts(any),
        ).thenAnswer((_) async => productsResponse);

        final result = await productsRemoteDataSourceImpl.getProducts(
          params: params,
        );

        expect(result, isA<Success<ProductsResponse>>());

        expect(
          (result as Success<ProductsResponse>).data.products?.length,
          productsModels.length,
        );

        verify(mockProductsApiClient.getProducts(any)).called(1);
      });
    });

    group("Failure Cases", () {
      test("Test Failure Case with Error Message", () async {
        when(mockProductsApiClient.getProducts(any)).thenThrow(Exception());

        final result = await productsRemoteDataSourceImpl.getProducts(
          params: params,
        );

        expect(result, isA<Failure<ProductsResponse>>());

        expect((result as Failure<ProductsResponse>).errorMessage, isNotNull);

        verify(mockProductsApiClient.getProducts(any)).called(1);
      });
    });
  });
}
