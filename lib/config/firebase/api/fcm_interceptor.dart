import 'package:dio/dio.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:injectable/injectable.dart';

import '../../../core/values/api_strings.dart';
import '../../../secret_keys.dart';

@injectable
class FcmInterceptor extends Interceptor {
  static const _scopes = [ApiStrings.fcmScope];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accountCredentials = ServiceAccountCredentials.fromJson(
      SecretKeys.serviceAccountJson,
    );
    final client = await clientViaServiceAccount(accountCredentials, _scopes);
    final accessToken = client.credentials.accessToken.data;
    client.close();

    options.headers[ApiStrings.token] = 'Bearer $accessToken';
    handler.next(options);
  }
}
