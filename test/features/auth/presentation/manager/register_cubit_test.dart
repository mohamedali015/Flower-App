import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:flower_app/features/auth/presentation/manager/register_cubit.dart';
import 'package:flower_app/features/auth/presentation/manager/register_events.dart';
import 'package:flower_app/features/auth/presentation/manager/register_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_cubit_test.mocks.dart';

@GenerateMocks([RegisterUseCase])
void main() {
  late RegisterCubit registerCubit;

  late MockRegisterUseCase mockRegisterUseCase;

  late AuthEntity authEntity;

  late String errorMessage;

  setUpAll(() {
    authEntity = AuthEntity(message: "Success", user: UserEntity.empty());

    errorMessage = "Something went wrong. Please try again later.";

    provideDummy<Result<AuthEntity>>(Success<AuthEntity>(data: authEntity));
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    registerCubit = RegisterCubit(mockRegisterUseCase);
  });

  group("Register Cubit Test Group", () {
    test("initial state should be RegisterState", () {
      expect(registerCubit.state, RegisterState());
    });

    blocTest<RegisterCubit, RegisterState>(
      "should emit updated gender when SelectGenderEvent is added",

      build: () => registerCubit,

      act: (cubit) {
        cubit.doEvents(SelectGenderEvent(gender: UserGender.male));
      },

      expect: () => [RegisterState().copyWith(genderParam: UserGender.male)],
    );

    blocTest<RegisterCubit, RegisterState>(
      "should emit submitted state when SubmitPressedEvent is added",

      build: () => registerCubit,

      act: (cubit) {
        cubit.doEvents(SubmitPressedEvent());
      },

      expect: () => [RegisterState().copyWith(isSubmittedParam: true)],
    );

    blocTest<RegisterCubit, RegisterState>(
      "should emit loading then success state when register succeeds",

      setUp: () {
        when(
          mockRegisterUseCase(params: anyNamed('params')),
        ).thenAnswer((_) async => Success<AuthEntity>(data: authEntity));
      },

      build: () => registerCubit,

      act: (cubit) {
        cubit.doEvents(
          SubmitRegisterEvent(
            firstName: "Mohamed",
            lastName: "Ali",
            email: "mohamed@gmail.com",
            password: "123456",
            confirmPassword: "123456",
            phone: "01020374526",
            gender: "male",
          ),
        );
      },

      expect: () => [
        RegisterState().copyWith(
          registerStateParam: RegisterState().registerState.copyWith(
            isLoadingParam: true,
          ),
        ),

        RegisterState().copyWith(
          registerStateParam: RegisterState().registerState.copyWith(
            isLoadingParam: false,
            isSuccessParam: true,
            dataParam: authEntity,
          ),
        ),
      ],

      verify: (_) {
        verify(mockRegisterUseCase(params: anyNamed('params'))).called(1);

        verifyNoMoreInteractions(mockRegisterUseCase);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      "should emit loading then failure state when register fails",

      setUp: () {
        when(mockRegisterUseCase(params: anyNamed('params'))).thenAnswer(
          (_) async => Failure<AuthEntity>(errorMessage: errorMessage),
        );
      },

      build: () => registerCubit,

      act: (cubit) {
        cubit.doEvents(
          SubmitRegisterEvent(
            firstName: "Mohamed",
            lastName: "Ali",
            email: "mohamed@gmail.com",
            password: "123456",
            confirmPassword: "123456",
            phone: "01020374526",
            gender: "male",
          ),
        );
      },

      expect: () => [
        RegisterState().copyWith(
          registerStateParam: RegisterState().registerState.copyWith(
            isLoadingParam: true,
          ),
        ),

        RegisterState().copyWith(
          registerStateParam: RegisterState().registerState.copyWith(
            isLoadingParam: false,
            isSuccessParam: false,
            errorMessageParam: errorMessage,
          ),
        ),
      ],

      verify: (_) {
        verify(mockRegisterUseCase(params: anyNamed('params'))).called(1);

        verifyNoMoreInteractions(mockRegisterUseCase);
      },
    );
  });
}
