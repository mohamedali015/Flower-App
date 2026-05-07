import 'package:dio/dio.dart';
import 'package:flower_app/config/error_handling/result.dart';
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
    test("test forgetPassword API Failed and an error msg returned", () async {
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
  });
}
