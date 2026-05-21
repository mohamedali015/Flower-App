import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/user/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/edit_profile/domain/params/edit_profile_params.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:flower_app/features/edit_profile/domain/use_case/edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late EditProfileUseCase editProfileUseCase;

  late MockEditProfileRepo mockEditProfileRepo;

  late EditProfileParams params;

  late AuthEntity authEntity;

  late String errorMessage;

  setUpAll(() {
    params = const EditProfileParams(
      firstName: "Mohamed",
      lastName: "Ali",
      email: "mohamed@gmail.com",
      phone: "01020374526",
    );

    authEntity = AuthEntity(message: "Success", user: UserEntity.empty());

    errorMessage = "Something went wrong";

    provideDummy<Result<AuthEntity>>(Success<AuthEntity>(data: authEntity));
  });

  setUp(() {
    mockEditProfileRepo = MockEditProfileRepo();

    editProfileUseCase = EditProfileUseCase(mockEditProfileRepo);
  });

  group("Edit Profile UseCase Test Group", () {
    test("should return success auth entity", () async {
      when(
        mockEditProfileRepo.editProfile(params: anyNamed('params')),
      ).thenAnswer((_) async => Success<AuthEntity>(data: authEntity));

      final result = await editProfileUseCase(params: params);

      expect(result, isA<Success<AuthEntity>>());

      verify(
        mockEditProfileRepo.editProfile(params: anyNamed('params')),
      ).called(1);
    });

    test("should return failure", () async {
      when(
        mockEditProfileRepo.editProfile(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Failure<AuthEntity>(errorMessage: errorMessage),
      );

      final result = await editProfileUseCase(params: params);

      expect(result, isA<Failure<AuthEntity>>());

      verify(
        mockEditProfileRepo.editProfile(params: anyNamed('params')),
      ).called(1);
    });
  });
}
