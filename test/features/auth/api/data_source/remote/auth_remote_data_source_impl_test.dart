import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/api/auth_api_client.dart';
import 'package:flower_app/features/auth/api/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:flower_app/features/auth/data/model/request/login_request.dart';
import 'package:flower_app/features/auth/data/model/response/auth_response.dart';
import 'package:flower_app/features/auth/data/model/response/user_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late MockAuthApiClient mockAuthApiClient;
  late AuthRemoteDataSourceImpl dataSource;

  setUpAll(() {
    provideDummy<Result<AuthResponse>>(Success(data: AuthResponse()));
  });

  setUp(() {
    mockAuthApiClient = MockAuthApiClient();
    dataSource = AuthRemoteDataSourceImpl(mockAuthApiClient);
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

  group("Register Function Test Group", () {
    group("Success Test Cases", () {});

    group("Failure Test Cases", () {});
  });
}
