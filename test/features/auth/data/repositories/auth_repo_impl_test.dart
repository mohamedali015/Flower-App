import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:flower_app/features/auth/data/model/response/auth_response.dart';
import 'package:flower_app/features/auth/data/model/response/user_response.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/auth/domain/params/register_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRepoImpl authRepoImpl;

  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  late AuthResponse authResponse;

  late String errorMessage;

  late RegisterParams params;

  setUpAll(() {
    provideDummy<Result<AuthResponse>>(
      Success<AuthResponse>(data: AuthResponse()),
    );
    errorMessage = "Something went wrong. Please try again later.";

    params = RegisterParams(
      firstName: "Mohamed",
      lastName: "Ali",
      email: "mohamed@gmail.com",
      password: "123456",
      confirmPassword: "123456",
      phone: "01020374526",
      gender: "male",
    );

    authResponse = AuthResponse(
      message: "Success",
      user: UserResponse(
        firstName: "Mohamed",
        lastName: "Ali",
        email: "mohamed@gmail.com",
      ),
    );
  });

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepoImpl = AuthRepoImpl(mockAuthRemoteDataSource);
  });

  group('Auth Repo Implementation test functions', () {
    group("Register Implement Function Test Group", () {
      group("Success Test Cases", () {
        test(
          "Register Test success case with auth entity returned successfully",
          () async {
            when(
              mockAuthRemoteDataSource.register(request: anyNamed('request')),
            ).thenAnswer(
              (_) async => Success<AuthResponse>(data: authResponse),
            );

            final result = await authRepoImpl.register(params: params);

            expect(result, isA<Success<AuthEntity>>());

            expect(
              (result as Success<AuthEntity>).data.message,
              authResponse.message,
            );

            expect(result.data.user.email, authResponse.user?.email);

            verify(
              mockAuthRemoteDataSource.register(request: anyNamed('request')),
            ).called(1);
          },
        );
      });

      group("Failure Test Cases", () {
        test("Register Test failure case with error message", () async {
          when(
            mockAuthRemoteDataSource.register(request: anyNamed('request')),
          ).thenAnswer(
            (_) async => Failure<AuthResponse>(errorMessage: errorMessage),
          );

          final result = await authRepoImpl.register(params: params);

          expect(result, isA<Failure<AuthEntity>>());

          expect((result as Failure<AuthEntity>).errorMessage, isNotNull);

          expect((result).errorMessage, errorMessage);

          verify(
            mockAuthRemoteDataSource.register(request: anyNamed('request')),
          ).called(1);
        });
      });
    });
  });
}
