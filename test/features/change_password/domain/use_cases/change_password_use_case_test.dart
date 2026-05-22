import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flower_app/features/change_password/domain/repositories/change_password_repo.dart';
import 'package:flower_app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_use_case_test.mocks.dart';

@GenerateMocks([ChangePasswordRepo])
void main() {
  late ChangePasswordUseCase useCase;
  late MockChangePasswordRepo mockRepo;

  late ChangePasswordRequestEntity requestEntity;
  late ChangePasswordResponseEntity responseEntity;

  setUpAll(() {
    requestEntity = const ChangePasswordRequestEntity(
      password: 'old',
      newPassword: 'new',
    );

    responseEntity = const ChangePasswordResponseEntity(
      message: 'ok',
      token: 'token_123',
    );

    provideDummy<Result<ChangePasswordResponseEntity>>(
      Success<ChangePasswordResponseEntity>(data: responseEntity),
    );
  });

  setUp(() {
    mockRepo = MockChangePasswordRepo();
    useCase = ChangePasswordUseCase(mockRepo);
  });

  group('ChangePasswordUseCase', () {
    test('returns Success when repo returns Success', () async {
      when(
        mockRepo.changePassword(
          changePasswordRequestEntity: anyNamed('changePasswordRequestEntity'),
        ),
      ).thenAnswer(
        (_) async =>
            Success<ChangePasswordResponseEntity>(data: responseEntity),
      );

      final result = await useCase.changePassword(
        changePasswordRequestEntity: requestEntity,
      );

      expect(result, isA<Success<ChangePasswordResponseEntity>>());

      verify(
        mockRepo.changePassword(
          changePasswordRequestEntity: anyNamed('changePasswordRequestEntity'),
        ),
      ).called(1);
    });

    test('returns Failure when repo returns Failure', () async {
      when(
        mockRepo.changePassword(
          changePasswordRequestEntity: anyNamed('changePasswordRequestEntity'),
        ),
      ).thenAnswer(
        (_) async =>
            Failure<ChangePasswordResponseEntity>(errorMessage: 'error'),
      );

      final result = await useCase.changePassword(
        changePasswordRequestEntity: requestEntity,
      );

      expect(result, isA<Failure<ChangePasswordResponseEntity>>());

      final failure = result as Failure<ChangePasswordResponseEntity>;

      expect(failure.errorMessage, 'error');

      verify(
        mockRepo.changePassword(
          changePasswordRequestEntity: anyNamed('changePasswordRequestEntity'),
        ),
      ).called(1);
    });
  });
}
