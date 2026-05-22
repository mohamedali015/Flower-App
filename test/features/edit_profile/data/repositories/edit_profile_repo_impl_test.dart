import 'dart:io';

import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/user/data/models/responses/get_user_response/user_response.dart';
import 'package:flower_app/config/user/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/edit_profile/data/data_source/remote/edit_profile_remote_data_source.dart';
import 'package:flower_app/features/edit_profile/data/model/response/edit_profile_response.dart';
import 'package:flower_app/features/edit_profile/data/model/response/upload_image_response.dart';
import 'package:flower_app/features/edit_profile/data/repositories/edit_profile_repo_impl.dart';
import 'package:flower_app/features/edit_profile/domain/params/edit_profile_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_repo_impl_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSource])
void main() {
  late EditProfileRepoImpl editProfileRepoImpl;

  late MockEditProfileRemoteDataSource mockRemoteDataSource;

  late EditProfileParams params;

  late EditProfileResponse response;

  late UploadImageResponse uploadImageResponse;

  late File image;

  late String errorMessage;

  setUpAll(() {
    errorMessage = "Something went wrong";

    image = File("test/image.png");

    params = const EditProfileParams(
      firstName: "Mohamed",
      lastName: "Ali",
      email: "mohamed@gmail.com",
      phone: "01020374526",
    );

    response = EditProfileResponse(
      message: "Success",
      user: UserResponse(
        firstName: "Mohamed",
        lastName: "Ali",
        email: "mohamed@gmail.com",
        phone: "01020374526",
      ),
    );

    uploadImageResponse = UploadImageResponse(message: "Uploaded");

    provideDummy<Result<EditProfileResponse>>(
      Success<EditProfileResponse>(data: response),
    );

    provideDummy<Result<UploadImageResponse>>(
      Success<UploadImageResponse>(data: uploadImageResponse),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockEditProfileRemoteDataSource();

    editProfileRepoImpl = EditProfileRepoImpl(mockRemoteDataSource);
  });

  group("Edit Profile Repo Test Group", () {
    group("Edit Profile Tests", () {
      test(
        "should return mapped auth entity when edit profile succeeds",
        () async {
          when(
            mockRemoteDataSource.editProfile(request: anyNamed('request')),
          ).thenAnswer(
            (_) async => Success<EditProfileResponse>(data: response),
          );

          final result = await editProfileRepoImpl.editProfile(params: params);

          expect(result, isA<Success<AuthEntity>>());

          expect(
            (result as Success<AuthEntity>).data.message,
            response.message,
          );

          expect(result.data.user.firstName, response.user?.firstName);

          expect(result.data.user.lastName, response.user?.lastName);

          expect(result.data.user.email, response.user?.email);

          expect(result.data.user.phone, response.user?.phone);

          verify(
            mockRemoteDataSource.editProfile(request: anyNamed('request')),
          ).called(1);

          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );

      test("should return failure when edit profile fails", () async {
        when(
          mockRemoteDataSource.editProfile(request: anyNamed('request')),
        ).thenAnswer(
          (_) async => Failure<EditProfileResponse>(errorMessage: errorMessage),
        );

        final result = await editProfileRepoImpl.editProfile(params: params);

        expect(result, isA<Failure<AuthEntity>>());

        expect((result as Failure<AuthEntity>).errorMessage, errorMessage);

        verify(
          mockRemoteDataSource.editProfile(request: anyNamed('request')),
        ).called(1);

        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });

    group("Upload Photo Tests", () {
      test("should return success true when upload image succeeds", () async {
        when(
          mockRemoteDataSource.uploadPhoto(image: anyNamed('image')),
        ).thenAnswer(
          (_) async => Success<UploadImageResponse>(data: uploadImageResponse),
        );

        final result = await editProfileRepoImpl.uploadPhoto(image: image);

        expect(result, isA<Success<bool>>());

        expect((result as Success<bool>).data, true);

        verify(
          mockRemoteDataSource.uploadPhoto(image: anyNamed('image')),
        ).called(1);

        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test("should return failure when upload image fails", () async {
        when(
          mockRemoteDataSource.uploadPhoto(image: anyNamed('image')),
        ).thenAnswer(
          (_) async => Failure<UploadImageResponse>(errorMessage: errorMessage),
        );

        final result = await editProfileRepoImpl.uploadPhoto(image: image);

        expect(result, isA<Failure<bool>>());

        expect((result as Failure<bool>).errorMessage, errorMessage);

        verify(
          mockRemoteDataSource.uploadPhoto(image: anyNamed('image')),
        ).called(1);

        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });
  });
}
