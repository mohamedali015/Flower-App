import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/logout/domain/entities/logout_response_entity.dart';
import 'package:flower_app/features/logout/domain/repositories/logout_repo.dart';
import 'package:flower_app/features/logout/domain/use_cases/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateMocks([LogoutRepo])
void main() {
  late LogoutUseCase logoutUseCase;
  late MockLogoutRepo mockLogoutRepo;
  late LogoutResponseEntity logoutResponseEntity;
  late String errorMessage;

  setUpAll(() {
    mockLogoutRepo = MockLogoutRepo();
    logoutUseCase = LogoutUseCase(mockLogoutRepo);
    errorMessage = 'Something went wrong. Please try again later.';

    logoutResponseEntity = const LogoutResponseEntity(
      message: 'Logout successful',
    );

    provideDummy<Result<LogoutResponseEntity>>(
      Success<LogoutResponseEntity>(data: logoutResponseEntity),
    );
  });

  group('LogoutUseCase', () {
    group('call', () {
      test(
        'should return Success<LogoutResponseEntity> when repository returns Success',
        () async {
          when(mockLogoutRepo.logout()).thenAnswer(
            (_) async =>
                Success<LogoutResponseEntity>(data: logoutResponseEntity),
          );

          final result = await logoutUseCase();

          expect(result, isA<Success<LogoutResponseEntity>>());
          expect(
            (result as Success<LogoutResponseEntity>).data.message,
            equals('Logout successful'),
          );
          verify(mockLogoutRepo.logout()).called(1);
        },
      );

      test(
        'should return Failure<LogoutResponseEntity> when repository returns Failure',
        () async {
          when(mockLogoutRepo.logout()).thenAnswer(
            (_) async =>
                Failure<LogoutResponseEntity>(errorMessage: errorMessage),
          );

          final result = await logoutUseCase();

          expect(result, isA<Failure<LogoutResponseEntity>>());
          expect(
            (result as Failure<LogoutResponseEntity>).errorMessage,
            equals(errorMessage),
          );
          verify(mockLogoutRepo.logout()).called(1);
        },
      );
    });
  });
}
