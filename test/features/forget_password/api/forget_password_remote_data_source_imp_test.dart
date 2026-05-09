import 'package:dio/dio.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/core/values/app_response_error_messages.dart';
import 'package:flower_app/features/forget_password/api/client/forget_password_client.dart';
import 'package:flower_app/features/forget_password/api/forget_password_remote_data_source_imp.dart';
import 'package:flower_app/features/forget_password/data/data_sources/forget_password_remote_data_source_contract.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_remote_data_source_imp_test.mocks.dart';

@GenerateMocks([ForgetPasswordClient])
main() {
  late ForgetPasswordRemoteDataSourceContract dataSource;
  late MockForgetPasswordClient mockClient;
  String successEmail = "dygofile@fxzig.com";
  String errorEmail = "error@test.com";
  String resetCode = "754274";
  String newPassword = "123456";
  late String error_msg;

  setUpAll(() {
    mockClient = MockForgetPasswordClient();
    dataSource = ForgetPasswordRemoteDataSourceImp(mockClient);
  });

  group("Test forgetPassword API Group", () {
    test("test forgetPassword API Success and a reset Code returned", () async {
      //Arrange
      when(
        mockClient.forgetPassword(successEmail),
      ).thenAnswer((_) async => resetCode);
      //Act

      var result = await dataSource.forgetPassword(email: successEmail);
      //Assert

      expect(result, isA<Success<String?>>());
      expect(result, isNotNull);
      expect((result as Success<String?>).data, resetCode);
      expect(result.data, isNotEmpty);
      verify(mockClient.forgetPassword(successEmail)).called(1);
      verifyNever(mockClient.forgetPassword(errorEmail));
      verifyNever(mockClient.resetPassword(successEmail, newPassword));
      verifyNever(mockClient.verifyReset(resetCode));
    });

    setUp(() {
      error_msg = "Failed to send reset email";
    });
    test("test forgetPassword API Failed and throw DioException", () async {
      //Arrange
      when(mockClient.forgetPassword(errorEmail)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(),
            data: {'message': error_msg},
          ),
          requestOptions: RequestOptions(),
        ),
      );
      //Act

      var result = await dataSource.forgetPassword(email: errorEmail);
      //Assert
      expect(result, isA<Failure<String?>>());
      expect(result, isNotNull);
      expect((result as Failure<String?>).errorMessage, error_msg);
      expect(result.errorMessage, isNotEmpty);
      verify(mockClient.forgetPassword(errorEmail)).called(1);
      verifyNever(mockClient.forgetPassword(successEmail));
      verifyNever(mockClient.resetPassword(successEmail, newPassword));
      verifyNever(mockClient.verifyReset(resetCode));
    });

    setUp(() {
      error_msg = AppResponseErrorMessages.unexpectedErrorMessage;
    });
    test("test forgetPassword API Failed and throw Exception", () async {
      //Arrange
      when(mockClient.forgetPassword(errorEmail)).thenThrow(Exception());

      //Act
      var result = await dataSource.forgetPassword(email: errorEmail);
      //Assert
      expect(result, isA<Failure<String?>>());
      expect(result, isNotNull);
      expect((result as Failure<String?>).errorMessage, error_msg);
      expect(result.errorMessage, isNotEmpty);
      verify(mockClient.forgetPassword(errorEmail)).called(1);
      verifyNever(mockClient.forgetPassword(successEmail));
      verifyNever(mockClient.resetPassword(successEmail, newPassword));
      verifyNever(mockClient.verifyReset(resetCode));
    });
  });

  group("Test VerifyReset API Group", () {
    test("Test VerifyReset API Success and return true", () async {
      //Arrange
      when(mockClient.verifyReset(resetCode)).thenAnswer((_) async => true);
      //Act
      var result = await dataSource.verifyReset(resetCode: resetCode);
      //Assert
      expect(result, isA<Success<bool>>());
      expect((result as Success<bool>).data, true);
      expect(result, isNotNull);
      expect(result, isNot(false));
      verify(mockClient.verifyReset(resetCode)).called(1);
      verifyNever(mockClient.forgetPassword(successEmail));
      verifyNever(mockClient.resetPassword(successEmail, newPassword));
    });
    test("Test VerifyReset API Failure and throw DioException", () async {
      //Arrange
      when(mockClient.verifyReset(resetCode)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(),
            data: {'message': false},
          ),
          requestOptions: RequestOptions(),
        ),
      );
      //Act
      var result = await dataSource.verifyReset(resetCode: resetCode);
      //Assert
      expect(result, isA<Failure<bool>>());
      expect((result as Failure<bool>).errorMessage, 'false');
      expect(result.errorMessage, isNotNull);
      expect(result.errorMessage, isNot(false));
      verify(mockClient.verifyReset(resetCode)).called(1);
      verifyNever(mockClient.forgetPassword(successEmail));
      verifyNever(mockClient.resetPassword(successEmail, newPassword));
    });

    setUp(() {
      error_msg = AppResponseErrorMessages.unexpectedErrorMessage;
    });
    test("Test VerifyReset API Failure and throw Exception", () async {
      //Arrange
      when(mockClient.verifyReset(resetCode)).thenThrow(Exception());
      //Act
      var result = await dataSource.verifyReset(resetCode: resetCode);
      //Assert
      expect(result, isA<Failure<bool>>());
      expect((result as Failure<bool>).errorMessage, error_msg);
      expect(result.errorMessage, isNotNull);
      expect(result.errorMessage, isNot(false));
      verify(mockClient.verifyReset(resetCode)).called(1);
      verifyNever(mockClient.forgetPassword(successEmail));
      verifyNever(mockClient.resetPassword(successEmail, newPassword));
    });
  });

  group("Test ResetPassword API Group", () {
    test(
      "Test ResetPassword APi Case return Success and return true",
      () async {
        // Arrange
        when(
          mockClient.resetPassword(successEmail, newPassword),
        ).thenAnswer((_) async => true);
        //Act

        var result = await dataSource.resetPassword(
          email: successEmail,
          newPassword: newPassword,
        );

        //Assert
        expect(result, isA<Success<bool>>());
        expect((result as Success<bool>).data, true);
        expect(result.data, isNot(false));
        expect(result.data, isNotNull);
        verify(mockClient.resetPassword(successEmail, newPassword)).called(1);
        verifyNever(mockClient.verifyReset(resetCode));
        verifyNever(mockClient.forgetPassword(successEmail));
      },
    );
    setUp(() {
      error_msg = 'password too weak';
    });
    test("Test ResetPassword APi Case throw DioException", () async {
      // Arrange
      when(mockClient.resetPassword(successEmail, newPassword)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(),
            data: {'message': error_msg},
          ),
          requestOptions: RequestOptions(),
        ),
      );
      //Act

      var result = await dataSource.resetPassword(
        email: successEmail,
        newPassword: newPassword,
      );

      //Assert
      expect(result, isA<Failure<bool>>());
      expect((result as Failure<bool>).errorMessage, error_msg);
      expect(result.errorMessage, isNotEmpty);
      expect(result.errorMessage, isNotNull);
      verify(mockClient.resetPassword(successEmail, newPassword)).called(1);
      verifyNever(mockClient.verifyReset(resetCode));
      verifyNever(mockClient.forgetPassword(successEmail));
    });

    setUp(() {
      error_msg = AppResponseErrorMessages.unexpectedErrorMessage;
    });
    test("Test ResetPassword APi Case throw Exception", () async {
      // Arrange
      when(
        mockClient.resetPassword(successEmail, newPassword),
      ).thenThrow(Exception());
      //Act

      var result = await dataSource.resetPassword(
        email: successEmail,
        newPassword: newPassword,
      );

      //Assert
      expect(result, isA<Failure<bool>>());
      expect((result as Failure<bool>).errorMessage, error_msg);
      expect(result.errorMessage, isNotEmpty);
      expect(result.errorMessage, isNotNull);
      verify(mockClient.resetPassword(successEmail, newPassword)).called(1);
      verifyNever(mockClient.verifyReset(resetCode));
      verifyNever(mockClient.forgetPassword(successEmail));
    });
  });
}
