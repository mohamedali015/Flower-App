import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late RegisterUseCase registerUseCase;

  late MockAuthRepo mockAuthRepo;

  late AuthEntity authEntity;

  late String errorMessage;

  setUpAll(() {
    authEntity = AuthEntity(message: "success", user: UserEntity.empty());
    provideDummy<Result<AuthEntity>>(Success<AuthEntity>(data: authEntity));

    errorMessage = "Something went wrong. Please try again later.";

    mockAuthRepo = MockAuthRepo();

    registerUseCase = RegisterUseCase(mockAuthRepo);
  });

  group("Register UseCase Test Group", () {
    group("Success Test Cases", () {
      test(
        "Test success case with auth entity returned successfully",
        () async {
          when(
            mockAuthRepo.register(
              firstName: anyNamed('firstName'),
              lastName: anyNamed('lastName'),
              email: anyNamed('email'),
              password: anyNamed('password'),
              confirmPassword: anyNamed('confirmPassword'),
              phone: anyNamed('phone'),
              gender: anyNamed('gender'),
            ),
          ).thenAnswer((_) async => Success<AuthEntity>(data: authEntity));

          final result = await registerUseCase.call(
            firstName: "Mohamed",
            lastName: "Ali",
            email: "test@test.com",
            password: "123456",
            confirmPassword: "123456",
            phone: "01000000000",
            gender: "male",
          );

          expect(result, isA<Success<AuthEntity>>());

          expect(
            (result as Success<AuthEntity>).data.message,
            authEntity.message,
          );

          verify(
            mockAuthRepo.register(
              firstName: anyNamed('firstName'),
              lastName: anyNamed('lastName'),
              email: anyNamed('email'),
              password: anyNamed('password'),
              confirmPassword: anyNamed('confirmPassword'),
              phone: anyNamed('phone'),
              gender: anyNamed('gender'),
            ),
          ).called(1);
        },
      );
    });

    group("Failure Test Cases", () {
      test("Test failure case with error message", () async {
        when(
          mockAuthRepo.register(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            password: anyNamed('password'),
            confirmPassword: anyNamed('confirmPassword'),
            phone: anyNamed('phone'),
            gender: anyNamed('gender'),
          ),
        ).thenAnswer(
          (_) async => Failure<AuthEntity>(errorMessage: errorMessage),
        );

        final result = await registerUseCase.call(
          firstName: "Mohamed",
          lastName: "Ali",
          email: "test@test.com",
          password: "123456",
          confirmPassword: "123456",
          phone: "01000000000",
          gender: "male",
        );

        expect(result, isA<Failure<AuthEntity>>());

        expect((result as Failure<AuthEntity>).errorMessage, errorMessage);

        verify(
          mockAuthRepo.register(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            password: anyNamed('password'),
            confirmPassword: anyNamed('confirmPassword'),
            phone: anyNamed('phone'),
            gender: anyNamed('gender'),
          ),
        ).called(1);
      });
    });
  });
}
