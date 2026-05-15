import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/user/data/models/responses/get_user_response/user_response.dart';
import 'package:flower_app/features/auth/api/auth_api_client.dart';
import 'package:flower_app/features/auth/api/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:flower_app/features/auth/data/mapper/register_params_mapper.dart';
import 'package:flower_app/features/auth/data/model/request/login_request.dart';
import 'package:flower_app/features/auth/data/model/response/auth_response.dart';
import 'package:flower_app/features/auth/domain/params/register_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late MockAuthApiClient mockAuthApiClient;
  late String errorMessage;
  late AuthResponse expectedResponse;
  late RegisterParams params;

  late AuthRemoteDataSourceImpl dataSource;

  setUpAll(() {
    provideDummy<Result<AuthResponse>>(Success(data: AuthResponse()));
  });

  setUp(() {
    mockAuthApiClient = MockAuthApiClient();
    dataSource = AuthRemoteDataSourceImpl(mockAuthApiClient);

    errorMessage = "Something went wrong. Please try again later.";

    expectedResponse = AuthResponse(message: "Success", token: "token_123");

    params = RegisterParams(
      firstName: "Mohamed",
      lastName: "Ali",
      email: "mohamed@gmail.com",
      password: "123456",
      confirmPassword: "123456",
      phone: "01020374526",
      gender: "male",
    );
  });

  group('AuthRemoteDataSourceImpl - login', () {
    const email = 'test@example.com';
    const password = 'password123';

    test(
      'should return Success<AuthResponse> when API call is successful',
      () async {
        // Arrange
        final mockResponse = AuthResponse(
          message: 'success',
          token:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjlmODVmM2E2YmJhZjE',
          user: UserResponse(
            id: "69f85f3a6bbaf1588bbdc447",
            firstName: "Elevate",
            lastName: "Techh",
            email: "ahmedmutti221@gmail.com",
            gender: "male",
            phone: "+201010700999",
          ),
        );

        when(
          mockAuthApiClient.login(any),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.login(email: email, password: password);

        // Assert
        expect(result, isA<Success<AuthResponse>>());

        final success = result as Success<AuthResponse>;

        expect(success.data, mockResponse);

        verify(
          mockAuthApiClient.login(
            argThat(
              isA<LoginRequest>()
                  .having((r) => r.email, 'email', email)
                  .having((r) => r.password, 'password', password),
            ),
          ),
        ).called(1);
      },
    );

    test(
      'should return Failure<AuthResponse> when API throws exception',
      () async {
        // Arrange
        when(mockAuthApiClient.login(any)).thenThrow(Exception('Login failed'));

        // Act
        final result = await dataSource.login(email: email, password: password);

        // Assert
        expect(result, isA<Failure<AuthResponse>>());

        final failure = result as Failure<AuthResponse>;

        expect(failure.errorMessage, isNotNull);

        verify(mockAuthApiClient.login(any)).called(1);
      },
    );
  });

  group('Remote data source Implementation test functions', () {
    group("Register Function Test Group", () {
      group("Success Test Cases", () {
        test("Test success test case with data return successfully", () async {
          // Arrange
          when(
            mockAuthApiClient.register(any),
          ).thenAnswer((_) async => expectedResponse);

          // Act
          final result = await dataSource.register(request: params.toRequest());

          // Assert
          expect(result, isA<Success<AuthResponse>>());

          expect((result as Success<AuthResponse>).data, expectedResponse);

          verify(mockAuthApiClient.register(any)).called(1);
        });
      });

      group('Failure Test Cases', () {
        test("Test Failure Test case with ErrorMessage", () async {
          // Arrange
          when(
            mockAuthApiClient.register(any),
          ).thenThrow(Exception(errorMessage));

          // Act
          final result = await dataSource.register(request: params.toRequest());

          // Assert
          expect(result, isA<Failure<AuthResponse>>());

          expect((result as Failure<AuthResponse>).errorMessage, isNotNull);

          verify(mockAuthApiClient.register(any)).called(1);
        });
      });
    });
  });
}
