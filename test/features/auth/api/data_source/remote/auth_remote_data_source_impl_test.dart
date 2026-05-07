import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/api/auth_api_client.dart';
import 'package:flower_app/features/auth/api/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:flower_app/features/auth/data/model/response/auth_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthApiClient mockAuthApiClient;
  setUpAll(() {
    mockAuthApiClient = MockAuthApiClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockAuthApiClient);
  });

  group('Remote data source Implementation test functions', () {
    group("Register Function Test Group", () {
      group("Success Test Case", () {
        test("Test success test case with data return successfully", () async {
          final expectedResponse = AuthResponse(
            message: "Success",
            token: "token_123",
          );

          when(
            mockAuthApiClient.register(any),
          ).thenAnswer((_) async => expectedResponse);

          final result = await authRemoteDataSourceImpl.register(
            firstName: "Mohamed",
            lastName: "Ali",
            email: "mohamed@gmail.com",
            password: "123456",
            confirmPassword: "123456",
            phone: "01020374526",
            gender: "male",
          );

          expect(result, isA<Success<AuthResponse>>());
          expect((result as Success<AuthResponse>).data, expectedResponse);
          verify(mockAuthApiClient.register(any)).called(1);
        });
      });

      group('Failure Test Cases', () {
        test("Test Failure Test case with ErrorMessage", () async {
          final errorMessage = "Something went wrong. Please try again later.";

          when(
            mockAuthApiClient.register(any),
          ).thenThrow(Exception(errorMessage));

          final result = await authRemoteDataSourceImpl.register(
            firstName: "Mohamed",
            lastName: "Ali",
            email: "mohamed@gmail.com",
            password: "123456",
            confirmPassword: "123456",
            phone: "01020374526",
            gender: "male",
          );

          expect(result, isA<Failure<AuthResponse>>());

          verify(mockAuthApiClient.register(any)).called(1);
        });
      });
    });
  });
}
