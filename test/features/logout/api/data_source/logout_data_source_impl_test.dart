import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/logout/api/data_source/logout_data_source_impl.dart';
import 'package:flower_app/features/logout/api/logout_api_client.dart';
import 'package:flower_app/features/logout/data/models/logout_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'logout_data_source_impl_test.mocks.dart';

@GenerateMocks([LogoutApiClient])
void main() {
  late LogoutDataSourceImpl logoutDataSourceImpl;
  late MockLogoutApiClient mockLogoutApiClient;
  late LogoutResponse logoutResponse;

  setUpAll(() {
    mockLogoutApiClient = MockLogoutApiClient();
    logoutDataSourceImpl = LogoutDataSourceImpl(mockLogoutApiClient);

    logoutResponse = LogoutResponse(message: 'Logout successful');
  });

  group('LogoutDataSourceImpl', () {
    group('logout', () {
      test(
        'should return Success<LogoutResponse> when API client returns valid response',
        () async {
          when(
            mockLogoutApiClient.logout(),
          ).thenAnswer((_) async => logoutResponse);

          final result = await logoutDataSourceImpl.logout();

          expect(result, isA<Success<LogoutResponse>>());
          expect(
            (result as Success<LogoutResponse>).data.message,
            equals(logoutResponse.message),
          );
          verify(mockLogoutApiClient.logout()).called(1);
        },
      );

      test(
        'should return Failure<LogoutResponse> when API client throws generic exception',
        () async {
          const networkError = 'network error';
          when(mockLogoutApiClient.logout()).thenThrow(Exception(networkError));

          final result = await logoutDataSourceImpl.logout();

          expect(result, isA<Failure<LogoutResponse>>());
          expect((result as Failure<LogoutResponse>).errorMessage, isNotEmpty);
          verify(mockLogoutApiClient.logout()).called(1);
        },
      );

      test(
        'should return Failure<LogoutResponse> when API client throws SocketException',
        () async {
          when(
            mockLogoutApiClient.logout(),
          ).thenThrow(Exception('Connection timeout'));

          final result = await logoutDataSourceImpl.logout();

          expect(result, isA<Failure<LogoutResponse>>());
          verify(mockLogoutApiClient.logout()).called(1);
        },
      );

      test(
        'should return Failure when API client throws null response',
        () async {
          when(
            mockLogoutApiClient.logout(),
          ).thenThrow(Exception('Empty response'));

          final result = await logoutDataSourceImpl.logout();

          expect(result, isA<Failure<LogoutResponse>>());
          verify(mockLogoutApiClient.logout()).called(1);
        },
      );
    });
  });
}
