import 'package:dio/dio.dart';
import 'package:flower_app/config/error_handling/handle_exception.dart';
import 'package:flower_app/core/values/app_response_error_messages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkException DioException Types', () {
    test('connectionTimeout returns connectionTimeoutMessage', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.connectionTimeoutMessage);
    });

    test('sendTimeout returns sendTimeoutMessage', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.sendTimeout,
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.sendTimeoutMessage);
    });

    test('receiveTimeout returns receiveTimeoutMessage', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.receiveTimeout,
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.receiveTimeoutMessage);
    });

    test('badCertificate returns badCertificateMessage', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badCertificate,
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.badCertificateMessage);
    });

    test('cancel returns requestCancelledMessage', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.cancel,
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.requestCancelledMessage);
    });

    test('connectionError returns connectionErrorMessage', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.connectionErrorMessage);
    });

    test('unknown returns unknownErrorMessage', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.unknown,
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.unknownErrorMessage);
    });

    test('NoDioException returns unexpectedErrorMessage', () {
      final exception = Exception('Something went wrong');

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.unexpectedErrorMessage);
    });
  });

  group('NetworkException badResponse with message/error in body', () {
    test('response body contains "message" key returns that message', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 422,
          data: {'message': 'Validation failed'},
        ),
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, 'Validation failed');
    });

    test('response body contains "error" key returns that error', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 422,
          data: {'error': 'Invalid input'},
        ),
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, 'Invalid input');
    });

    test('"message" key takes priority over "error" key', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 422,
          data: {'message': 'Primary message', 'error': 'Secondary error'},
        ),
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, 'Primary message');
    });
  });

  group('NetworkException badResponse with HTTP Status Codes', () {
    Response makeResponse(int statusCode) => Response(
      requestOptions: RequestOptions(path: '/test'),
      statusCode: statusCode,
      data: {},
    );

    DioException makeException(int statusCode) => DioException(
      requestOptions: RequestOptions(path: '/test'),
      type: DioExceptionType.badResponse,
      response: makeResponse(statusCode),
    );

    test('400 returns error400', () {
      expect(
        NetworkException.getMessageError(makeException(400)),
        AppResponseErrorMessages.error400,
      );
    });

    test('401 returns error401', () {
      expect(
        NetworkException.getMessageError(makeException(401)),
        AppResponseErrorMessages.error401,
      );
    });

    test('403 returns error403', () {
      expect(
        NetworkException.getMessageError(makeException(403)),
        AppResponseErrorMessages.error403,
      );
    });

    test('404 returns error404', () {
      expect(
        NetworkException.getMessageError(makeException(404)),
        AppResponseErrorMessages.error404,
      );
    });

    test('408 returns error408', () {
      expect(
        NetworkException.getMessageError(makeException(408)),
        AppResponseErrorMessages.error408,
      );
    });

    test('429 returns error429', () {
      expect(
        NetworkException.getMessageError(makeException(429)),
        AppResponseErrorMessages.error429,
      );
    });

    test('500 returns error500', () {
      expect(
        NetworkException.getMessageError(makeException(500)),
        AppResponseErrorMessages.error500,
      );
    });

    test('502 returns error502', () {
      expect(
        NetworkException.getMessageError(makeException(502)),
        AppResponseErrorMessages.error502,
      );
    });

    test('503 returns error503', () {
      expect(
        NetworkException.getMessageError(makeException(503)),
        AppResponseErrorMessages.error503,
      );
    });

    test('504 returns error504', () {
      expect(
        NetworkException.getMessageError(makeException(504)),
        AppResponseErrorMessages.error504,
      );
    });

    test('Unknown status code (e.g. 418) returns dynamic fallback message', () {
      expect(
        NetworkException.getMessageError(makeException(418)),
        'Server error (418). Please try again.',
      );
    });
  });

  group('NetworkException badResponse edge cases', () {
    test('response is null returns defaultError', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: null,
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.defaultError);
    });

    test('response data is not a Map falls through to status code switch', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
          data: 'plain string error',
        ),
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, AppResponseErrorMessages.error500);
    });

    test('status code is null returns fallback with "unknown"', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: null,
          data: {},
        ),
      );

      final result = NetworkException.getMessageError(exception);

      expect(result, 'Server error (unknown). Please try again.');
    });
  });
}
