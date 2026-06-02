import 'package:flower_app/config/error_handling/result.dart';

import 'package:flower_app/features/user_address/data/models/address_dto.dart';
import 'package:flower_app/features/user_address/data/models/user_address_dto.dart';
import 'package:flower_app/features/user_address/domain/repositories/user_address_repo_contract.dart';
import 'package:flower_app/features/user_address/domain/use_cases/get_logged_user_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_user_address_use_case_test.mocks.dart';

@GenerateMocks([UserAddressRepoContract])
main() {
  late GetLoggedUserAddressUseCase useCase;
  late MockUserAddressRepoContract mockRepo;
  late AddressDto addAddress;
  late List<AddressDto> mockCurrentServerAddresses;
  String successMessage = "success";
  String errorMessage = "error";
  setUpAll(() {
    provideDummy<Result<UserAddressDto>>(
      Success<UserAddressDto>(data: UserAddressDto()),
    );
    mockRepo = MockUserAddressRepoContract();
    useCase = GetLoggedUserAddressUseCase(mockRepo);
    mockCurrentServerAddresses = [
      AddressDto(
        street: "initial 12 Nile Street",
        phone: "initial 01012345678",
        city: "initial Cairo",
        lat: "initial 30.0444",
        long: "initial 31.2357",
        username: "initial Mark Raouf",
        id: "000000000000000000000000",
      ),
    ];
    addAddress = AddressDto(
      street: "add 12 Nile Street",
      phone: "add 01012345678",
      city: "add Cairo",
      lat: "add 30.0444",
      long: "add 31.2357",
      username: "add Mark Raouf",
    );
  });

  group("test repo on calling getLoggedUserAddress", () {
    test(
      "case dataSource return Success<UserAddressDto> list of addresses when getLoggedUserAddress is  called",
          () async {
        //arrange
        when(mockRepo.getLoggedUserAddress()).thenAnswer(
              (_) async => Success<UserAddressDto>(
            data: UserAddressDto(
              message: successMessage,
              address: mockCurrentServerAddresses,
            ),
          ),
        );
        //act
        var response = await useCase();
        //assert
        expect(response, isA<Success<UserAddressDto>>());
        expect(
          (response as Success<UserAddressDto>).data.message,
          successMessage,
        );
        expect(response.data.address, isNotNull);
        expect(response.data.address, isNotEmpty);
        expect(response.data.address, equals(mockCurrentServerAddresses));
        verify(mockRepo.getLoggedUserAddress()).called(1);
      },
    );

    test(
      "case dataSource return Failure<UserAddressDto> when Exception when getLoggedUserAddress called",
          () async {
        //arrange
        when(
          mockRepo.getLoggedUserAddress(),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
        // act
        var response = await useCase();
        //assert
        expect(response, isA<Failure<UserAddressDto>>());
        expect((response as Failure<UserAddressDto>).errorMessage, isNotNull);
        expect(response.errorMessage, isNotEmpty);
      },
    );
  });
}
