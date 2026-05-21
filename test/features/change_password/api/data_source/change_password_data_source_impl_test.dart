import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/change_password/api/change_password_api_client.dart';
import 'package:flower_app/features/change_password/api/data_source/change_password_data_source_impl.dart';
import 'package:flower_app/features/change_password/data/models/change_password_request.dart';
import 'package:flower_app/features/change_password/data/models/change_password_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_data_source_impl_test.mocks.dart';

@GenerateMocks([ChangePasswordApiClient])
void main() {
  late ChangePasswordDataSourceImpl dataSource;
  late MockChangePasswordApiClient mockApiClient;

  late ChangePasswordRequest request;
  late ChangePasswordResponse response;

  setUpAll(() {
    request = ChangePasswordRequest(password: 'old', newPassword: 'new');

    response = ChangePasswordResponse(message: 'ok', token: 'token_123');
  });

  setUp(() {
    mockApiClient = MockChangePasswordApiClient();
    dataSource = ChangePasswordDataSourceImpl(mockApiClient);
  });

  group('ChangePasswordDataSourceImpl', () {
    test('returns Success when api client succeeds', () async {
      when(mockApiClient.changePassword(any)).thenAnswer((_) async => response);

      final result = await dataSource.changePassword(
        changePasswordRequest: request,
      );

      expect(result, isA<Success<ChangePasswordResponse>>());

      final success = result as Success<ChangePasswordResponse>;

      expect(success.data.message, response.message);
      expect(success.data.token, response.token);

      verify(mockApiClient.changePassword(any)).called(1);
    });

    test('returns Failure when api client throws', () async {
      when(mockApiClient.changePassword(any)).thenThrow(Exception());

      final result = await dataSource.changePassword(
        changePasswordRequest: request,
      );

      expect(result, isA<Failure<ChangePasswordResponse>>());

      final failure = result as Failure<ChangePasswordResponse>;

      expect(failure.errorMessage, isNotNull);

      verify(mockApiClient.changePassword(any)).called(1);
    });
  });
}
