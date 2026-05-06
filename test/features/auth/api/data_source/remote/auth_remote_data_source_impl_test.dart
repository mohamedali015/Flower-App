import 'package:flower_app/features/auth/api/auth_api_client.dart';
import 'package:flower_app/features/auth/api/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthApiClient mockAuthApiClient;
  setUpAll(() {
    mockAuthApiClient = MockAuthApiClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockAuthApiClient);
  });

  group("Register Function Test Group", () {
    group("Success Test Cases", () {});
  });
}
