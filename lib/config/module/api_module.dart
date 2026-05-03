import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../core/values/api_end_points.dart';
import '../../core/values/api_strings.dart';
import '../secure_cache/secure_cache/cache_keys.dart';
import '../secure_cache/secure_cache/secure_cache_helper.dart';

@module
abstract class ApiModule {
  @lazySingleton
  BaseOptions providerOption() {
    return BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
      connectTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    );
  }

  @lazySingleton
  PrettyDioLogger providerDioLogger() {
    return PrettyDioLogger(
      requestBody: true,
      request: true,
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: false,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
      filter: (options, args) {
        // don't print requests with uris containing '/posts'
        if (options.path.contains('/posts')) {
          return false;
        }
        // don't print responses with unit8 list data
        return !args.isResponse || !args.hasUint8ListData;
      },
    );
  }

  @lazySingleton
  Dio provideDio(BaseOptions option, PrettyDioLogger logger) {
    final dio = Dio(option);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final requiresAuth = options.extra[ApiStrings.requireAuth] ?? true;

          if (requiresAuth) {
            final token = await SecureCacheHelper.getData(key: CacheKeys.token);

            if (token != null && token.isNotEmpty) {
              options.headers[ApiStrings.token] = token;
            }
          }

          return handler.next(options);
        },

        onError: (error, handler) async {
          final requiresAuth =
              error.requestOptions.extra[ApiStrings.requireAuth] ?? true;

          final message = (error.response?.data?['message'] ?? "")
              .toString()
              .toLowerCase();

          final isTokenError =
              message.contains("invalid token") ||
              message.contains("user not found");

          if (requiresAuth && isTokenError) {
            await SecureCacheHelper.removeData(key: CacheKeys.token);
            // getIt<UserCubit>().doEvent(UnauthorizedUserEvent());
          }

          return handler.next(error);
        },
      ),
    );

    dio.interceptors.add(logger);

    return dio;
  }
}
