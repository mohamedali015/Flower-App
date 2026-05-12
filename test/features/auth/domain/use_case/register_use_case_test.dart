import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/config/user/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/params/register_params.dart';
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

  late RegisterParams params;

  setUpAll(() {
    authEntity = AuthEntity(message: "success", user: UserEntity.empty());
    provideDummy<Result<AuthEntity>>(Success<AuthEntity>(data: authEntity));

    errorMessage = "Something went wrong. Please try again later.";

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

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    registerUseCase = RegisterUseCase(mockAuthRepo);
  });

  group("Success Test Cases", () {
    test("Test success case with auth entity returned successfully", () async {
      when(
        mockAuthRepo.register(params: params),
      ).thenAnswer((_) async => Success<AuthEntity>(data: authEntity));

      final result = await registerUseCase.call(params: params);

      expect(result, isA<Success<AuthEntity>>());

      expect((result as Success<AuthEntity>).data.message, authEntity.message);

      verify(mockAuthRepo.register(params: params)).called(1);
    });
  });

  group("Failure Test Cases", () {
    test("Test failure case with error message", () async {
      when(mockAuthRepo.register(params: params)).thenAnswer(
        (_) async => Failure<AuthEntity>(errorMessage: errorMessage),
      );

      final result = await registerUseCase.call(params: params);

      expect(result, isA<Failure<AuthEntity>>());

      expect((result as Failure<AuthEntity>).errorMessage, isNotNull);

      expect((result).errorMessage, errorMessage);

      verify(mockAuthRepo.register(params: params)).called(1);
    });
  });
}
