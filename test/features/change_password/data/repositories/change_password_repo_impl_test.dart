import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/change_password/data/data_source/change_password_data_source.dart';
import 'package:flower_app/features/change_password/data/models/change_password_response.dart';
import 'package:flower_app/features/change_password/data/repositories/change_password_repo_impl.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_repo_impl_test.mocks.dart';

@GenerateMocks([ChangePasswordDataSource, SecureCache])
void main() {
  late ChangePasswordRepoImpl repo;
  late MockChangePasswordDataSource mockDataSource;
  late MockSecureCache mockSecureCache;

  late ChangePasswordResponse changePasswordResponse;
  late ChangePasswordRequestEntity requestEntity;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    provideDummy<Result<ChangePasswordResponse>>(
      Success<ChangePasswordResponse>(data: ChangePasswordResponse()),
    );

    provideDummy<Result<ChangePasswordResponse>>(
      Failure<ChangePasswordResponse>(errorMessage: ''),
    );

    changePasswordResponse = ChangePasswordResponse(
      message: 'ok',
      token: 'token_123',
    );
  });

  setUp(() {
    mockDataSource = MockChangePasswordDataSource();
    mockSecureCache = MockSecureCache();

    repo = ChangePasswordRepoImpl(mockSecureCache, mockDataSource);

    requestEntity = const ChangePasswordRequestEntity(
      password: 'old',
      newPassword: 'new',
    );
  });

  group('ChangePasswordRepoImpl', () {
    test(
      'saves token and returns Success when data source returns Success',
      () async {
        when(
          mockDataSource.changePassword(
            changePasswordRequest: anyNamed('changePasswordRequest'),
          ),
        ).thenAnswer(
          (_) async =>
              Success<ChangePasswordResponse>(data: changePasswordResponse),
        );

        when(
          mockSecureCache.saveData(
            key: anyNamed('key'),
            value: anyNamed('value'),
          ),
        ).thenAnswer((_) async {});

        final result = await repo.changePassword(
          changePasswordRequestEntity: requestEntity,
        );

        expect(result, isA<Success<ChangePasswordResponseEntity>>());

        final success = result as Success<ChangePasswordResponseEntity>;

        expect(success.data.token, changePasswordResponse.token);

        verify(
          mockDataSource.changePassword(
            changePasswordRequest: anyNamed('changePasswordRequest'),
          ),
        ).called(1);

        verify(
          mockSecureCache.saveData(
            key: CacheKeys.token,
            value: changePasswordResponse.token,
          ),
        ).called(1);
      },
    );

    test('returns Failure when data source returns Failure', () async {
      when(
        mockDataSource.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenAnswer(
        (_) async => Failure<ChangePasswordResponse>(errorMessage: 'error'),
      );

      final result = await repo.changePassword(
        changePasswordRequestEntity: requestEntity,
      );

      expect(result, isA<Failure<ChangePasswordResponseEntity>>());

      final failure = result as Failure<ChangePasswordResponseEntity>;

      expect(failure.errorMessage, 'error');

      verify(
        mockDataSource.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).called(1);
    });
  });
}
