import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/logout/api/data_source/logout_data_source_impl.dart';
import 'package:flower_app/features/logout/data/models/logout_response.dart';
import 'package:flower_app/features/logout/data/repositories/logout_repo_impl.dart';
import 'package:flower_app/features/logout/domain/entities/logout_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'logout_repo_impl_test.mocks.dart';

class FakeSecureCache implements SecureCache {
  final List<String> removedKeys = [];

  @override
  Future<void> clear() async {}

  @override
  Future<String?> getData({required String key}) async => null;

  @override
  Future<void> removeData({required String key}) async {
    removedKeys.add(key);
    return Future<void>.value();
  }

  @override
  Future<void> saveData({required String key, required String value}) async {}
}

@GenerateMocks([LogoutDataSourceImpl])
void main() {
  late LogoutRepoImpl logoutRepoImpl;
  late MockLogoutDataSourceImpl mockLogoutDataSourceImpl;
  late FakeSecureCache mockSecureCache;
  late LogoutResponse logoutResponse;
  late String errorMessage;

  setUpAll(() {
    errorMessage = 'Something went wrong. Please try again later.';

    provideDummy<Result<LogoutResponse>>(
      Success<LogoutResponse>(data: LogoutResponse()),
    );
  });

  setUp(() {
    mockLogoutDataSourceImpl = MockLogoutDataSourceImpl();
    mockSecureCache = FakeSecureCache();
    logoutRepoImpl = LogoutRepoImpl(mockLogoutDataSourceImpl, mockSecureCache);
    logoutResponse = LogoutResponse(message: 'Logout successful');
  });

  group('LogoutRepoImpl', () {
    group('logout', () {
      test(
        'should return Success<LogoutResponseEntity> when data source returns Success<LogoutResponse>',
        () async {
          when(mockLogoutDataSourceImpl.logout()).thenAnswer(
            (_) async => Success<LogoutResponse>(data: logoutResponse),
          );
          when(
            mockSecureCache.removeData(key: CacheKeys.token),
          ).thenAnswer((_) async {});
          when(
            mockSecureCache.removeData(key: CacheKeys.rememberMe),
          ).thenAnswer((_) async {});

          final result = await logoutRepoImpl.logout();

          expect(result, isA<Success<LogoutResponseEntity>>());
          final success = result as Success<LogoutResponseEntity>;
          expect(success.data.message, equals(logoutResponse.message));
          verify(() => mockLogoutDataSourceImpl.logout()).called(1);
          verify(
            () => mockSecureCache.removeData(key: CacheKeys.token),
          ).called(1);
          verify(
            () => mockSecureCache.removeData(key: CacheKeys.rememberMe),
          ).called(1);
        },
      );

      test(
        'should return Failure<LogoutResponseEntity> when data source returns Failure<LogoutResponse>',
        () async {
          when(mockLogoutDataSourceImpl.logout()).thenAnswer(
            (_) async => Failure<LogoutResponse>(errorMessage: errorMessage),
          );

          final result = await logoutRepoImpl.logout();

          expect(result, isA<Failure<LogoutResponseEntity>>());
          final failure = result as Failure<LogoutResponseEntity>;
          expect(failure.errorMessage, equals(errorMessage));
          verify(mockLogoutDataSourceImpl.logout()).called(1);
        },
      );
    });
  });
}
