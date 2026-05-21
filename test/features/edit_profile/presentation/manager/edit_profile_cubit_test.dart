import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/user/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/edit_profile/domain/use_case/edit_profile_use_case.dart';
import 'package:flower_app/features/edit_profile/domain/use_case/upload_image_use_case.dart';
import 'package:flower_app/features/edit_profile/presentation/manager/edit_profile_cubit.dart';
import 'package:flower_app/features/edit_profile/presentation/manager/edit_profile_events.dart';
import 'package:flower_app/features/edit_profile/presentation/manager/edit_profile_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([EditProfileUseCase, UploadPhotoUseCase])
void main() {
  late EditProfileCubit editProfileCubit;

  late MockEditProfileUseCase mockEditProfileUseCase;

  late MockUploadPhotoUseCase mockUploadPhotoUseCase;

  late AuthEntity authEntity;

  late String errorMessage;

  late File image;

  late Directory tempDir;

  late UserEntity user;

  setUpAll(() async {
    errorMessage = "Something went wrong";

    tempDir = await Directory.systemTemp.createTemp();

    image = File('${tempDir.path}/image.png');

    await image.writeAsBytes([1, 2, 3]);

    user = UserEntity(
      firstName: "Mohamed",
      lastName: "Ali",
      email: "mohamed@gmail.com",
      phone: "01020374526",
      id: '1234',
      gender: 'male',
      userPhoto: 'test.png',
      role: 'user',
      wishList: const [],
      addresses: const [],
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    );

    authEntity = AuthEntity(message: "Success", user: user);

    provideDummy<Result<AuthEntity>>(Success<AuthEntity>(data: authEntity));

    provideDummy<Result<bool>>(Success<bool>(data: true));
  });

  setUp(() {
    mockEditProfileUseCase = MockEditProfileUseCase();

    mockUploadPhotoUseCase = MockUploadPhotoUseCase();

    editProfileCubit = EditProfileCubit(
      mockEditProfileUseCase,
      mockUploadPhotoUseCase,
    );
  });

  group("Edit Profile Cubit Test Group", () {
    test("initial state should be EditProfileState", () {
      expect(editProfileCubit.state, const EditProfileState());
    });

    blocTest<EditProfileCubit, EditProfileState>(
      "should emit changed true when fields are changed",

      build: () => editProfileCubit,

      act: (cubit) {
        cubit.doEvent(
          CheckChangesEvent(
            firstName: "Ahmed",
            lastName: "Ali",
            email: "mohamed@gmail.com",
            phone: "01020374526",
            user: user,
          ),
        );
      },

      expect: () => [const EditProfileState().copyWith(isChangedParam: true)],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "should emit loading then success when edit profile succeeds",

      setUp: () {
        when(
          mockEditProfileUseCase(params: anyNamed('params')),
        ).thenAnswer((_) async => Success<AuthEntity>(data: authEntity));
      },

      build: () => editProfileCubit,

      act: (cubit) {
        cubit.doEvent(
          EditProfileEvent(
            firstName: "Mohamed",
            lastName: "Ali",
            email: "mohamed@gmail.com",
            phone: "01020374526",
          ),
        );
      },

      expect: () => [
        const EditProfileState().copyWith(
          editProfileStateParam: const EditProfileState().editProfileState
              .copyWith(
                isLoadingParam: true,
                isSuccessParam: false,
                errorMessageParam: null,
              ),
        ),

        const EditProfileState().copyWith(
          editProfileStateParam: const EditProfileState().editProfileState
              .copyWith(
                isLoadingParam: false,
                isSuccessParam: true,
                dataParam: authEntity,
              ),
          isChangedParam: false,
        ),
      ],

      verify: (_) {
        verify(mockEditProfileUseCase(params: anyNamed('params'))).called(1);

        verifyNoMoreInteractions(mockEditProfileUseCase);
      },
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "should emit loading then failure when edit profile fails",

      setUp: () {
        when(mockEditProfileUseCase(params: anyNamed('params'))).thenAnswer(
          (_) async => Failure<AuthEntity>(errorMessage: errorMessage),
        );
      },

      build: () => editProfileCubit,

      act: (cubit) {
        cubit.doEvent(
          EditProfileEvent(
            firstName: "Mohamed",
            lastName: "Ali",
            email: "mohamed@gmail.com",
            phone: "01020374526",
          ),
        );
      },

      expect: () => [
        const EditProfileState().copyWith(
          editProfileStateParam: const EditProfileState().editProfileState
              .copyWith(
                isLoadingParam: true,
                isSuccessParam: false,
                errorMessageParam: null,
              ),
        ),

        const EditProfileState().copyWith(
          editProfileStateParam: const EditProfileState().editProfileState
              .copyWith(
                isLoadingParam: false,
                isSuccessParam: false,
                errorMessageParam: errorMessage,
              ),
        ),
      ],

      verify: (_) {
        verify(mockEditProfileUseCase(params: anyNamed('params'))).called(1);

        verifyNoMoreInteractions(mockEditProfileUseCase);
      },
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "should emit loading then success when upload image succeeds",

      setUp: () {
        when(
          mockUploadPhotoUseCase(image: anyNamed('image')),
        ).thenAnswer((_) async => Success<bool>(data: true));
      },

      build: () => editProfileCubit,

      act: (cubit) {
        cubit.doEvent(UploadProfileImageEvent(image: image));
      },

      expect: () => [
        const EditProfileState().copyWith(
          uploadProfileImageStateParam: const EditProfileState()
              .uploadProfileImageState
              .copyWith(
                isLoadingParam: true,
                isSuccessParam: false,
                errorMessageParam: null,
              ),
        ),

        const EditProfileState().copyWith(
          uploadProfileImageStateParam: const EditProfileState()
              .uploadProfileImageState
              .copyWith(
                isLoadingParam: false,
                isSuccessParam: true,
                dataParam: true,
              ),
        ),
      ],

      verify: (_) {
        verify(mockUploadPhotoUseCase(image: anyNamed('image'))).called(1);

        verifyNoMoreInteractions(mockUploadPhotoUseCase);
      },
    );

    blocTest<EditProfileCubit, EditProfileState>(
      "should emit loading then failure when upload image fails",

      setUp: () {
        when(
          mockUploadPhotoUseCase(image: anyNamed('image')),
        ).thenAnswer((_) async => Failure<bool>(errorMessage: errorMessage));
      },

      build: () => editProfileCubit,

      act: (cubit) {
        cubit.doEvent(UploadProfileImageEvent(image: image));
      },

      expect: () => [
        const EditProfileState().copyWith(
          uploadProfileImageStateParam: const EditProfileState()
              .uploadProfileImageState
              .copyWith(
                isLoadingParam: true,
                isSuccessParam: false,
                errorMessageParam: null,
              ),
        ),

        const EditProfileState().copyWith(
          uploadProfileImageStateParam: const EditProfileState()
              .uploadProfileImageState
              .copyWith(
                isLoadingParam: false,
                isSuccessParam: false,
                errorMessageParam: errorMessage,
              ),
        ),
      ],

      verify: (_) {
        verify(mockUploadPhotoUseCase(image: anyNamed('image'))).called(1);

        verifyNoMoreInteractions(mockUploadPhotoUseCase);
      },
    );
  });
}
