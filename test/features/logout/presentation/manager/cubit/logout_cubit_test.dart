import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/logout/domain/entities/logout_response_entity.dart';
import 'package:flower_app/features/logout/domain/use_cases/logout_use_case.dart';
import 'package:flower_app/features/logout/presentation/manager/cubit/logout_cubit.dart';
import 'package:flower_app/features/logout/presentation/manager/cubit/logout_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_cubit_test.mocks.dart';

@GenerateMocks([LogoutUseCase])
void main() {
  late LogoutCubit logoutCubit;
  late MockLogoutUseCase mockLogoutUseCase;

  const logoutResponseEntity = LogoutResponseEntity(
    message: 'Logout successful',
  );

  setUpAll(() {
    provideDummy<Result<LogoutResponseEntity>>(
      Success(data: logoutResponseEntity),
    );
  });

  setUp(() {
    mockLogoutUseCase = MockLogoutUseCase();
    logoutCubit = LogoutCubit(mockLogoutUseCase);
  });

  tearDown(() => logoutCubit.close());

  group('LogoutCubit Tests', () {

    blocTest<LogoutCubit, LogoutState>(
      'success case',
      build: () {
        when(mockLogoutUseCase.call()).thenAnswer(
              (_) async => Success(data: logoutResponseEntity),
        );
        return logoutCubit;
      },
      act: (cubit) => cubit.doEvents(LogoutEvent()),
      expect: () => [isA<LogoutLoading>(), isA<LogoutSuccess>()],
      verify: (_) {
        verify(mockLogoutUseCase.call()).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutState>(
      'failure case',
      build: () {
        when(mockLogoutUseCase.call()).thenAnswer(
              (_) async => Failure(errorMessage: 'Error'),
        );
        return logoutCubit;
      },
      act: (cubit) => cubit.doEvents(LogoutEvent()),
      expect: () => [isA<LogoutLoading>(), isA<LogoutFailure>()],
      verify: (_) {
        verify(mockLogoutUseCase.call()).called(1);
      },
    );
  });
}
