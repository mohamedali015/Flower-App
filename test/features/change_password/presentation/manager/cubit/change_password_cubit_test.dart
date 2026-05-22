import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flower_app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:flower_app/features/change_password/presentation/manager/cubit/change_password_cubit.dart';
import 'package:flower_app/features/change_password/presentation/manager/cubit/change_password_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_cubit_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase])
void main() {
  late MockChangePasswordUseCase mockUseCase;
  late ChangePasswordCubit cubit;

  late ChangePasswordRequestEntity requestEntity;
  late ChangePasswordResponseEntity responseEntity;

  setUpAll(() {
    provideDummy<Result<ChangePasswordResponseEntity>>(
      Success<ChangePasswordResponseEntity>(
        data: const ChangePasswordResponseEntity(
          message: 'ok',
          token: 'token_123',
        ),
      ),
    );

    provideDummy<Result<ChangePasswordResponseEntity>>(
      Failure<ChangePasswordResponseEntity>(errorMessage: ''),
    );
  });

  setUp(() {
    mockUseCase = MockChangePasswordUseCase();
    cubit = ChangePasswordCubit(changePasswordUseCase: mockUseCase);

    requestEntity = const ChangePasswordRequestEntity(
      password: 'old',
      newPassword: 'new',
    );
    responseEntity = const ChangePasswordResponseEntity(
      message: 'ok',
      token: 'token_123',
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  group('ChangePasswordCubit doEvents', () {
    test('emits loading and success when use case returns Success', () async {
      when(
        mockUseCase.changePassword(
          changePasswordRequestEntity: anyNamed('changePasswordRequestEntity'),
        ),
      ).thenAnswer(
        (_) async =>
            Success<ChangePasswordResponseEntity>(data: responseEntity),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<ChangePasswordLoading>(),
          isA<ChangePasswordSuccess>(),
        ]),
      );

      cubit.doEvents(
        SubmitChangePasswordEvent(changePasswordRequestEntity: requestEntity),
      );

      verify(
        mockUseCase.changePassword(
          changePasswordRequestEntity: anyNamed('changePasswordRequestEntity'),
        ),
      ).called(1);
    });

    test('emits loading and error when use case returns Failure', () async {
      when(
        mockUseCase.changePassword(
          changePasswordRequestEntity: anyNamed('changePasswordRequestEntity'),
        ),
      ).thenAnswer(
        (_) async =>
            Failure<ChangePasswordResponseEntity>(errorMessage: 'failed'),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<ChangePasswordLoading>(),
          const ChangePasswordError(errorMessage: 'failed'),
        ]),
      );

      cubit.doEvents(
        SubmitChangePasswordEvent(changePasswordRequestEntity: requestEntity),
      );

      verify(
        mockUseCase.changePassword(
          changePasswordRequestEntity: anyNamed('changePasswordRequestEntity'),
        ),
      ).called(1);
    });
  });
}
