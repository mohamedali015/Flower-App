import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/auth/api/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:flower_app/features/auth/data/model/response/auth_response.dart';
import 'package:flower_app/features/auth/data/model/response/user_response.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceImpl, SecureCache])
void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    provideDummy<Result<AuthResponse>>(Success(data: AuthResponse()));
  });

  late AuthRepoImpl authRepo;
  late MockAuthRemoteDataSourceImpl mockDataSource;

  late MockSecureCache mockSecureCache;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSourceImpl();
    mockSecureCache = MockSecureCache();

    authRepo = AuthRepoImpl(mockDataSource, mockSecureCache);
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
        ).thenAnswer((_) async => Success(data: mockResponse));

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

        expect(result, isA<Success<AuthEntity>>());

        final success = result as Success<AuthEntity>;

        expect(success.data.message, mockResponse.message);
        expect(success.data.user?.email, mockResponse.user?.email);
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
}
