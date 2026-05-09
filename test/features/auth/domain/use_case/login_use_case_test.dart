import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  final dummyUser = UserEntity(
    id: "1",
    firstName: "Test",
    lastName: "User",
    email: "email",
    gender: "male",
    phone: '+201010700999',
    userPhoto: '',
    role: '',
    wishList: [],
    addresses: [],
    createdAt: DateTime(2023, 5, 4, 8, 56, 26, 842),
  );

  final dummyAuth = AuthEntity(message: 'Login successful', user: dummyUser);

  setUpAll(() {
    provideDummy<Result<AuthEntity>>(Success<AuthEntity>(data: dummyAuth));

    provideDummy<Result<AuthEntity>>(
      Failure<AuthEntity>(errorMessage: 'Login failed'),
    );
  });

  late MockAuthRepo mockAuthRepo;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    loginUseCase = LoginUseCase(mockAuthRepo);
  });

  group('LoginUseCase', () {
    group('call function', () {
      test('should return Success when login is successful', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';
        const rememberMe = true;

        when(
          mockAuthRepo.login(
            email: anyNamed('email'),
            password: anyNamed('password'),
            rememberMe: anyNamed('rememberMe'),
          ),
        ).thenAnswer((_) async => Success<AuthEntity>(data: dummyAuth));

        // Act
        final result = await loginUseCase.call(
          email: email,
          password: password,
          rememberMe: rememberMe,
        );

        // Assert
        expect(result, isA<Success<AuthEntity>>());

        verify(
          mockAuthRepo.login(
            email: email,
            password: password,
            rememberMe: rememberMe,
          ),
        ).called(1);
      });

      test('should return Failure when login fails', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';
        const rememberMe = false;

        when(
          mockAuthRepo.login(
            email: anyNamed('email'),
            password: anyNamed('password'),
            rememberMe: anyNamed('rememberMe'),
          ),
        ).thenAnswer(
          (_) async => Failure<AuthEntity>(errorMessage: 'Login failed'),
        );

        // Act
        final result = await loginUseCase.call(
          email: email,
          password: password,
          rememberMe: rememberMe,
        );

        // Assert
        expect(result, isA<Failure<AuthEntity>>());

        expect((result as Failure<AuthEntity>).errorMessage, 'Login failed');
      });
    });
  });
}
