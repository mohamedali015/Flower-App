// import 'package:dio/dio.dart';
// import 'package:flower_app/features/category/api/category_api_client.dart';
// import 'package:flower_app/features/category/api/data_source/category_remote_data_source_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flower_app/config/error_handling/result.dart';
// import 'package:flower_app/features/category/data/model/response/categories_response.dart';
//
// import '../../data/model/response/all_categories_response.dart';
// import 'category_remote_data_source_impl_test.mocks.dart';
//
// @GenerateMocks([CategoryApiClient])
// void main() {
//   late CategoryRemoteDataSourceImpl dataSource;
//   late MockCategoryApiClient mockApiClient;
//
//   setUp(() {
//     mockApiClient = MockCategoryApiClient();
//     dataSource = CategoryRemoteDataSourceImpl(mockApiClient);
//   });
//
//   group('Category Remote Data Source Impl - getAllCategories', () {
//
//     // ─── Success Cases ───────────────────────────────────────────────
//
//     test('returns Success with CategoriesResponse when API call succeeds', () async {
//       // Arrange
//       final mockResponse = CategoriesResponse(
//         categories: [
//
//           AllCategoriesResponse(id: '1', name: 'Category 1'),
//           AllCategoriesResponse(id: '2', name: 'Category 2'),
//           AllCategoriesResponse(id: '3', name: 'Category 3'),
//
//         ]
//       );
//       when(mockApiClient.getAllCategories())
//           .thenAnswer((_) async => mockResponse);
//
//       // Act
//       final result = await dataSource.getAllCategories();
//
//       // Assert
//       expect(result, isA<Success<CategoriesResponse>>());
//       expect((result as Success).data, equals(mockResponse));
//     });
//
//     test('calls apiClient.getAllCategories() exactly once', () async {
//       // Arrange
//       final mockResponse = CategoriesResponse();
//       when(mockApiClient.getAllCategories())
//           .thenAnswer((_) async => mockResponse);
//
//       // Act
//       await dataSource.getAllCategories();
//
//       // Assert
//       verify(mockApiClient.getAllCategories()).called(1);
//     });
//
//     test('returns Success with empty categories list when API returns empty response', () async {
//       // Arrange
//       final emptyResponse = CategoriesResponse(categories: []);
//       when(mockApiClient.getAllCategories())
//           .thenAnswer((_) async => emptyResponse);
//
//       // Act
//       final result = await dataSource.getAllCategories();
//
//       // Assert
//       expect(result, isA<Success<CategoriesResponse>>());
//       expect((result as Success<CategoriesResponse>).data.categories, isEmpty);
//     });
//
//     // test('returns Success with multiple categories when API returns populated list', () async {
//     //   // Arrange
//     //   final populatedResponse = CategoriesResponse(
//     //     categories: [
//     //       AllCategoriesResponse(
//     //           id: '1', name: 'Category 1'),
//     //       AllCategoriesResponse(id: '2', name: 'Category 2'),
//     //       AllCategoriesResponse(id: '3', name: 'Category 3'),
//     //     ],
//     //   );
//     //   when(mockApiClient.getAllCategories())
//     //       .thenAnswer((_) async => populatedResponse);
//     //
//     //   // Act
//     //   final result = await dataSource.getAllCategories();
//     //
//     //   // Assert
//     //   final success = result as Success<CategoriesResponse>;
//     //   expect(success.data.data?.length, 3);
//     // });
//
//     // ─── Failure Cases ───────────────────────────────────────────────
//
//     test('returns Failure when API throws a generic Exception', () async {
//       // Arrange
//       when(mockApiClient.getAllCategories())
//           .thenThrow(Exception('Something went wrong'));
//
//       // Act
//       final result = await dataSource.getAllCategories();
//
//       // Assert
//       expect(result, isA<Failure<CategoriesResponse>>());
//     });
//
//     test('returns Failure when API throws a network/socket exception', () async {
//       // Arrange
//       when(mockApiClient.getAllCategories())
//           .thenThrow(Exception('SocketException: No internet'));
//
//       // Act
//       final result = await dataSource.getAllCategories();
//
//       // Assert
//       expect(result, isA<Failure<CategoriesResponse>>());
//     });
//
//     test('returns Failure when API throws a DioException (e.g. 404)', () async {
//       // Arrange
//       when(mockApiClient.getAllCategories())
//           .thenThrow(DioException(
//         requestOptions: RequestOptions(path: '/categories'),
//         response: Response(
//           requestOptions: RequestOptions(path: '/categories'),
//           statusCode: 404,
//         ),
//       ));
//
//       // Act
//       final result = await dataSource.getAllCategories();
//
//       // Assert
//       expect(result, isA<Failure<CategoriesResponse>>());
//     });
//
//     test('returns Failure when API throws a DioException (e.g. 500)', () async {
//       // Arrange
//       when(mockApiClient.getAllCategories())
//           .thenThrow(DioException(
//         requestOptions: RequestOptions(path: '/categories'),
//         response: Response(
//           requestOptions: RequestOptions(path: '/categories'),
//           statusCode: 500,
//         ),
//       ));
//
//       // Act
//       final result = await dataSource.getAllCategories();
//
//       // Assert
//       expect(result, isA<Failure<CategoriesResponse>>());
//     });
//
//     test('returns Failure when API throws a timeout exception', () async {
//       // Arrange
//       when(mockApiClient.getAllCategories())
//           .thenThrow(DioException(
//         requestOptions: RequestOptions(path: '/categories'),
//         type: DioExceptionType.receiveTimeout,
//       ));
//
//       // Act
//       final result = await dataSource.getAllCategories();
//
//       // Assert
//       expect(result, isA<Failure<CategoriesResponse>>());
//     });
//
//     test('does not throw even when API throws — error is wrapped in Failure', () async {
//       // Arrange
//       when(mockApiClient.getAllCategories()).thenThrow(Exception('crash'));
//
//       // Act & Assert — no exception should propagate
//       expect(
//             () async => await dataSource.getAllCategories(),
//         returnsNormally,
//       );
//     });
//
//     // ─── Interaction / Side-effect Cases ─────────────────────────────
//
//     test('does not call apiClient more than once per invocation', () async {
//       // Arrange
//       when(mockApiClient.getAllCategories())
//           .thenAnswer((_) async => CategoriesResponse());
//
//       // Act
//       await dataSource.getAllCategories();
//
//       // Assert
//       verifyNever(mockApiClient.getAllCategories()); // after 1st call is verified
//       // or use:
//       verify(mockApiClient.getAllCategories()).called(1);
//     });
//
//     test('consecutive calls each invoke apiClient independently', () async {
//       // Arrange
//       when(mockApiClient.getAllCategories())
//           .thenAnswer((_) async => CategoriesResponse());
//
//       // Act
//       await dataSource.getAllCategories();
//       await dataSource.getAllCategories();
//
//       // Assert
//       verify(mockApiClient.getAllCategories()).called(2);
//     });
//
//     test('result type is always Result<CategoriesResponse> regardless of outcome', () async {
//       // Success path
//       when(mockApiClient.getAllCategories())
//           .thenAnswer((_) async => CategoriesResponse());
//       final successResult = await dataSource.getAllCategories();
//       expect(successResult, isA<Result<CategoriesResponse>>());
//
//       // Failure path
//       when(mockApiClient.getAllCategories()).thenThrow(Exception());
//       final failureResult = await dataSource.getAllCategories();
//       expect(failureResult, isA<Result<CategoriesResponse>>());
//     });
//   });
// }