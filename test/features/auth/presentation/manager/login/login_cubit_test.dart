import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_event.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_state.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  setUpAll(() {
    provideDummy<Result<AuthEntity>>(
      Success<AuthEntity>(data: const AuthEntity(message: '')),
    );

    provideDummy<Result<AuthEntity>>(Failure<AuthEntity>(errorMessage: ''));
  });

  late MockLoginUseCase mockLoginUseCase;
  late LoginCubit loginCubit;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginCubit = LoginCubit(mockLoginUseCase);
  });

  tearDown(() {
    loginCubit.close();
  });

  group('test LoginCubit.doEvents', () {
    test(
      'emits loading and success when login use case returns Success',
      () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';
        const rememberMe = true;
        final authEntity = const AuthEntity(message: 'ok');

        when(
          mockLoginUseCase.call(
            email: email,
            password: password,
            rememberMe: rememberMe,
          ),
        ).thenAnswer((_) async => Success(data: authEntity));

        // Assert
        expectLater(
          loginCubit.stream,
          emitsInOrder([
            const LoginLoading(rememberMe: true),
            LoginSuccess(authEntity: authEntity, rememberMe: true),
          ]),
        );

        // Act
        loginCubit.doEvents(
          LoginSubmitEvent(
            email: email,
            password: password,
            rememberMe: rememberMe,
          ),
        );
      },
    );

    test(
      'emits loading and failure when login use case returns Failure',
      () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';
        const rememberMe = false;

        when(
          mockLoginUseCase.call(
            email: email,
            password: password,
            rememberMe: rememberMe,
          ),
        ).thenAnswer((_) async => Failure(errorMessage: 'Login failed'));

        // Assert
        expectLater(
          loginCubit.stream,
          emitsInOrder([
            const LoginLoading(rememberMe: false),
            const LoginFailure(errorMessage: 'Login failed', rememberMe: false),
          ]),
        );

        // Act
        loginCubit.doEvents(
          LoginSubmitEvent(
            email: email,
            password: password,
            rememberMe: rememberMe,
          ),
        );
      },
    );
  });
}
