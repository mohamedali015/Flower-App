import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/logout/domain/entities/logout_response_entity.dart';
import 'package:flower_app/features/logout/domain/use_cases/logout_use_case.dart';
import 'package:flower_app/features/logout/presentation/manager/cubit/logout_cubit.dart';
import 'package:flower_app/features/logout/presentation/manager/cubit/logout_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_cubit_test.mocks.dart';

@GenerateMocks([LogoutUseCase, SecureCache])
void main() {
  late LogoutCubit logoutCubit;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockSecureCache mockSecureCache;
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
    mockSecureCache = MockSecureCache();
    logoutCubit = LogoutCubit(mockLogoutUseCase, mockSecureCache);
  });

  tearDown(() => logoutCubit.close());

  group('LogoutCubit Tests', () {
    test('should have LogoutInitial as initial state', () {
      expect(logoutCubit.state, isA<LogoutInitial>());
    });

    blocTest<LogoutCubit, LogoutState>(
      'should emit [Loading, Success] and clear cache when use case succeeds',
      build: () {
        when(
          mockLogoutUseCase.call(),
        ).thenAnswer((_) async => Success(data: logoutResponseEntity));
        when(
          mockSecureCache.removeData(key: anyNamed('key')),
        ).thenAnswer((_) async {});
        return logoutCubit;
      },
      act: (cubit) => cubit.doEvents(LogoutEvent()),
      expect: () => [isA<LogoutLoading>(), isA<LogoutSuccess>()],
      verify: (_) {
        verify(mockLogoutUseCase.call()).called(1);
        verify(mockSecureCache.removeData(key: CacheKeys.token)).called(1);
        verify(mockSecureCache.removeData(key: CacheKeys.rememberMe)).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutState>(
      'should emit [Loading, Failure] and NOT clear cache when use case fails',
      build: () {
        when(
          mockLogoutUseCase.call(),
        ).thenAnswer((_) async => Failure(errorMessage: 'Error'));
        return logoutCubit;
      },
      act: (cubit) => cubit.doEvents(LogoutEvent()),
      expect: () => [isA<LogoutLoading>(), isA<LogoutFailure>()],
      verify: (_) {
        verify(mockLogoutUseCase.call()).called(1);
        verifyNever(mockSecureCache.removeData(key: anyNamed('key')));
      },
    );
  });
}
