import 'dart:io';

import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/edit_profile/api/data_source/remote/edit_profile_remote_data_source_impl.dart';
import 'package:flower_app/features/edit_profile/api/edit_profile_api_client.dart';
import 'package:flower_app/features/edit_profile/data/model/request/edit_profile_request.dart';
import 'package:flower_app/features/edit_profile/data/model/response/edit_profile_response.dart';
import 'package:flower_app/features/edit_profile/data/model/response/upload_image_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([EditProfileApiClient])
void main() {
  late EditProfileRemoteDataSourceImpl remoteDataSourceImpl;

  late MockEditProfileApiClient mockEditProfileApiClient;

  late EditProfileResponse editProfileResponse;

  late UploadImageResponse uploadImageResponse;

  late EditProfileRequest request;

  late File image;

  late Directory tempDir;

  setUpAll(() async {
    request = EditProfileRequest(
      firstName: "Mohamed",
      lastName: "Ali",
      email: "mohamed@gmail.com",
      phone: "01020374526",
    );

    tempDir = await Directory.systemTemp.createTemp();

    image = File('${tempDir.path}/image.png');

    await image.writeAsBytes([1, 2, 3]);

    editProfileResponse = EditProfileResponse();

    uploadImageResponse = UploadImageResponse(message: "success");
  });

  setUp(() {
    mockEditProfileApiClient = MockEditProfileApiClient();

    remoteDataSourceImpl = EditProfileRemoteDataSourceImpl(
      mockEditProfileApiClient,
    );
  });

  group("Edit Profile Remote Data Source Test Group", () {
    group("Edit Profile Tests", () {
      test("should return success when edit profile succeeds", () async {
        when(
          mockEditProfileApiClient.editProfile(any),
        ).thenAnswer((_) async => editProfileResponse);

        final result = await remoteDataSourceImpl.editProfile(request: request);

        expect(result, isA<Success<EditProfileResponse>>());

        verify(mockEditProfileApiClient.editProfile(any)).called(1);

        verifyNoMoreInteractions(mockEditProfileApiClient);
      });

      test("should return failure when edit profile fails", () async {
        when(mockEditProfileApiClient.editProfile(any)).thenThrow(Exception());

        final result = await remoteDataSourceImpl.editProfile(request: request);

        expect(result, isA<Failure<EditProfileResponse>>());

        verify(mockEditProfileApiClient.editProfile(any)).called(1);

        verifyNoMoreInteractions(mockEditProfileApiClient);
      });
    });

    group("Upload Photo Tests", () {
      test("should return success when upload image succeeds", () async {
        when(
          mockEditProfileApiClient.uploadPhoto(any),
        ).thenAnswer((_) async => uploadImageResponse);

        final result = await remoteDataSourceImpl.uploadPhoto(image: image);

        expect(result, isA<Success<UploadImageResponse>>());

        verify(mockEditProfileApiClient.uploadPhoto(any)).called(1);

        verifyNoMoreInteractions(mockEditProfileApiClient);
      });

      test("should return failure when upload image fails", () async {
        when(mockEditProfileApiClient.uploadPhoto(any)).thenThrow(Exception());

        final result = await remoteDataSourceImpl.uploadPhoto(image: image);

        expect(result, isA<Failure<UploadImageResponse>>());

        verify(mockEditProfileApiClient.uploadPhoto(any)).called(1);

        verifyNoMoreInteractions(mockEditProfileApiClient);
      });
    });
  });
}
