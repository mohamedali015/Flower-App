import 'dart:io';

import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:flower_app/features/edit_profile/domain/use_case/upload_image_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'upload_image_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late UploadPhotoUseCase uploadPhotoUseCase;

  late MockEditProfileRepo mockEditProfileRepo;

  late File image;

  late String errorMessage;

  setUpAll(() {
    image = File("test/image.png");

    errorMessage = "Something went wrong";

    provideDummy<Result<bool>>(Success<bool>(data: true));
  });

  setUp(() {
    mockEditProfileRepo = MockEditProfileRepo();

    uploadPhotoUseCase = UploadPhotoUseCase(mockEditProfileRepo);
  });

  group("Upload Photo UseCase Test Group", () {
    test("should return success true", () async {
      when(
        mockEditProfileRepo.uploadPhoto(image: anyNamed('image')),
      ).thenAnswer((_) async => Success<bool>(data: true));

      final result = await uploadPhotoUseCase(image: image);

      expect(result, isA<Success<bool>>());

      verify(
        mockEditProfileRepo.uploadPhoto(image: anyNamed('image')),
      ).called(1);
    });

    test("should return failure", () async {
      when(
        mockEditProfileRepo.uploadPhoto(image: anyNamed('image')),
      ).thenAnswer((_) async => Failure<bool>(errorMessage: errorMessage));

      final result = await uploadPhotoUseCase(image: image);

      expect(result, isA<Failure<bool>>());

      verify(
        mockEditProfileRepo.uploadPhoto(image: anyNamed('image')),
      ).called(1);
    });
  });
}
