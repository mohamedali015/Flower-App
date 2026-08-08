import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/config/user/data/models/responses/get_user_response/user_response.dart';
import 'package:flower_app/features/auth/api/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:flower_app/features/auth/data/model/response/auth_response.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/auth/domain/params/register_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceImpl, SecureCache])
void main() {
  late AuthRepoImpl authRepo;

  late MockAuthRemoteDataSourceImpl mockDataSource;
  late MockSecureCache mockSecureCache;

  late AuthResponse authResponse;
  late String errorMessage;
  late RegisterParams params;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    provideDummy<Result<AuthResponse>>(
      Success<AuthResponse>(data: AuthResponse()),
    );
  });

  setUp(() {
    mockDataSource = MockAuthRemoteDataSourceImpl();
    mockSecureCache = MockSecureCache();

    authRepo = AuthRepoImpl(mockDataSource, mockSecureCache);

    errorMessage = "Something went wrong. Please try again later.";

    params = const RegisterParams(
      firstName: "Mohamed",
      lastName: "Ali",
      email: "mohamed@gmail.com",
      password: "123456",
      confirmPassword: "123456",
      phone: "01020374526",
      gender: "male",
    );

    authResponse = AuthResponse(
      message: "Success",
      token: "token_123",
      user: UserResponse(
        firstName: "Mohamed",
        lastName: "Ali",
        email: "mohamed@gmail.com",
      ),
    );
  });

  group("AuthRepoImpl - login", () {
    const email = 'test@example.com';
    const password = 'password123';

    test(
      'should return Success when login succeeds and rememberMe = true',
      () async {
        // Arrange
        final mockResponse = AuthResponse(
          message: 'success',
          token: 'fake_token',
          user: UserResponse(
            id: "1",
            firstName: "Test",
            lastName: "User",
            email: email,
            gender: "male",
            phone: "123456789",
          ),
        );

        when(
          mockDataSource.login(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer((_) async => Success<AuthResponse>(data: mockResponse));

        when(
          mockSecureCache.saveData(
            key: anyNamed('key'),
            value: anyNamed('value'),
          ),
        ).thenAnswer((_) async {});

        // Act
        final result = await authRepo.login(
          email: email,
          password: password,
          rememberMe: true,
        );

        // Assert
        expect(result, isA<Success<AuthEntity>>());

        final success = result as Success<AuthEntity>;

        expect(success.data.message, mockResponse.message);
        expect(success.data.user.email, mockResponse.user?.email);

        verify(
          mockDataSource.login(email: email, password: password),
        ).called(1);
      },
    );

    test('should return Failure when remote data source fails', () async {
      // Arrange
      when(
        mockDataSource.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer((_) async => Failure<AuthResponse>(errorMessage: 'error'));

      // Act
      final result = await authRepo.login(
        email: email,
        password: password,
        rememberMe: true,
      );

      // Assert
      expect(result, isA<Failure<AuthEntity>>());

      final failure = result as Failure<AuthEntity>;

      expect(failure.errorMessage, 'error');

      verify(mockDataSource.login(email: email, password: password)).called(1);
    });
  });

  group('Auth Repo Implementation test functions', () {
    group("Register Implement Function Test Group", () {
      group("Success Test Cases", () {
        test(
          "Register Test success case with auth entity returned successfully",
          () async {
            // Arrange
            when(
              mockDataSource.register(request: anyNamed('request')),
            ).thenAnswer(
              (_) async => Success<AuthResponse>(data: authResponse),
            );

            // Act
            final result = await authRepo.register(params: params);

            // Assert
            expect(result, isA<Success<AuthEntity>>());

            final success = result as Success<AuthEntity>;

            expect(success.data.message, authResponse.message);
            expect(success.data.user.email, authResponse.user?.email);

            verify(
              mockDataSource.register(request: anyNamed('request')),
            ).called(1);
          },
        );
      });

      group("Failure Test Cases", () {
        test("Register Test failure case with error message", () async {
          // Arrange
          when(
            mockDataSource.register(request: anyNamed('request')),
          ).thenAnswer(
            (_) async => Failure<AuthResponse>(errorMessage: errorMessage),
          );

          // Act
          final result = await authRepo.register(params: params);

          // Assert
          expect(result, isA<Failure<AuthEntity>>());

          final failure = result as Failure<AuthEntity>;

          expect(failure.errorMessage, errorMessage);

          verify(
            mockDataSource.register(request: anyNamed('request')),
          ).called(1);
        });
      });
    });
  });
}
